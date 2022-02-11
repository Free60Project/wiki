# HvxExpansionInstall

A system call for "installing" code under [Hypervisor](../Hypervisor) context.
Registers an HvxExpansion structure in the expansion table

## Reversed Pseudocode

```cpp
// r0 is 0x70
// Parameters are taken in r3 and r4, respectively
// r2, r5 - r9 are 0

typedef struct _EXP_HEADER
{
    DWORD Magic;        // "SIGM" or "SIGC"
    DWORD Flags;        // Used in verifcation Flags = 1, 2
    DWORD Size;         // Should be <= size used to install
    BYTE ShaHash[0x14]; // SHA-1 digest of everything after header
    BYTE AESFeed[0x10];
    XECRYPT_SIG Sig;    // RSA sig of the first 0x30 bytes of the header ; 0x100 length ; encrypted
    //DWORD ExpID;
} EXP_HEADER, *PEXP_HEADER

typedef struct _HV_EXPANSION_SECTION_INFO {
    DWORD Size1;   // Length of some kind
    DWORD Size2;   // Length of code data
    DWORD Size3;   // Length of some kind
    DWORD Padding; // 0x10 Align
} EXP_SECTION_INFO;

typedef struct _HV_EXPANSION_INFO {
    DWORD ExpansionId;       // Id to be used when called after install
    DWORD ExpansionFlags;    // Compared with something in HV
    DWORD ExpansionVersion;  // Used to lock to a hv version
    DWORD ExpansionVersion2; // Used to lock to a hv version
    QWORD Reserved;          // Havent seen this used
    QWORD Unknown;           // Compared with something in HV
    DWORD ExpansionDataPos1; // Position of expansion data/info
    DWORD ExpansionDataLen1; // Length
    DWORD ExpansionDataPos2; // Position of expansion data/info
    DWORD ExpansionDataLen2; // Length
} EXP_INFO;

typedef struct _HV_EXPANSION {
    EXP_HEADER       Header;           // Expansion Header
    EXP_INFO         ExpansionInfo;    // Expansion Info
    EXP_SECTION_INFO SectionInfo;      // Sections pointed to by ExInfo
    DWORD            ExpansionCode[1]; // 0x10 Align
} EXP;

QWORD HvxExpansionInstall(PVOID pExpAddy, DWORD cExpSize)
{
    // Check 0x80 byte alignment on payload address
    if(pExpAddy & 0x7F)
        return 0xC8007000;
    // Check 0x80 byte alignment on payload size
    if(cExpSize & 0x7F)
        return 0xC8007001;
    // Unknown check, if I had to guess its checking if you requested too much memory or if the address is out of range
    // Similar check is found in similar operations
    if(((((pExpAddy + cExpSize) - 1) ^ pExpAddy) & 0xFFFF0000) != 0)
        return 0xC8007001;

    // relocates exp data to an internal location, replaces pExpAddy with new address
    HvpAquireSpinLock(0x200016918);
    pExpAddy = HvpRelocatePhysicalToProtected(pExpAddy, cExpSize, 0x3A);

    BYTE Hash1[0x14] = 0;
    PBYTE AESKey = 0;
    XECRYPT_RSA xRsa;
    PEXP_HEADER pExpHeader = (PEXP_HEADER)pExpAddy;
    DWORD MagicVersion = pExpHeader->Magic;

    // Check what type of expansion we're dealing with
    if(MagicVersion == 0x48585052) // "HVPR"
    {
        if(pExpHeader->Flags & 3) //bits 1 and 2 in flags must be cleared for this type
            return 0xC8007003;
        xRsa = *(XECRYPT_RSA*)0x0000000200016280; // public RSA key
        AESKey = (PBYTE)0x0000000200016270; // 1BL Key
        XeCryptRotSumSha(pExpAddy, 0x30, 0, 0, Hash1, 0x14); // hash the header minus the sig
    }
    else if(MagicVersion == 0x48585043) // "HVPC"
    {
        // RSA Key check? Data its checking is null on RGH and XDK. Possible variable key?
        #ifdef DEVKIT
        xRsa = *(XECRYPT_RSA*)(*(QWORD*)0x0000000200016A00)+0x200;
        #else
        xRsa = *(XECRYPT_RSA*)(*(QWORD*)0x0000000200016950)+0x200;
        #endif
        if(xRsa.cqw != 0x20)
        return 0xC8007002;
        if((pExpHeader->Flags & 3) != 3) // flags 1 and 2 must be set for this type
        return 0xC8007003;
        #ifdef DEVKIT
        if(!(pExpHeader->Flags & 2)) // if bit 2 is cleared, data is not encrypted
        AESKey = 0; // data is decrypted, do not decrypt
        else
        #endif
        AESKey = (PBYTE)0x20; // CPU Key
        XeCryptHmacSha(0x20, 0x10, pExpAddy, 0x30, 0, 0, 0, 0, Hash1, 0x14);
    }
    else
        return 0xC8007002; // invalid expansion type

    // check if the header has been tampered with
    if(!XeCryptBnQwBeSigVerify(pExpHeader->Sig, Hash1, (PBYTE)0x0000000200016664, xRsa))
        return 0xC8007003;
    if(pExpHeader->Size > cExpSize) // size in header must be <= size requested
        return 0xC8007003;
    if(AESKey != 0) // check if the key has been set. if not, skip decryption
    {
        XECRYPT_AES_STATE aes;
        XeCryptAesKey(&aes, AESKey);
        XeCryptAesCbc(&aes, pExpAddy+0x130, (pExpHeader->Size)-0x130, pExpAddy+0x130, &(pExpHeader->AESFeed), 0);
    }

    // check if the expansion has been tampered with
    XeCryptSha(pExpAddy+0x130, (pExpHeader->Size)-0x130, 0, 0, 0, 0, Hash1, 0x14);
    if(XeCryptMemDiff(pExpHeader->ShaHash, Hash1, 0x14))
        return 0xC8007003;

    // go to the install function
    QWORD ret = InstallExpansion(pExpAddy);

    HvpZeroCacheLines(pExpAddy, cExpSize >> 7);
    HvpRelocateProtectedToPhysical(pExpAddy, cExpSize, 0x3A);
    HvpReleaseSpinLock(0x200016918);

    return ret;
}
```
