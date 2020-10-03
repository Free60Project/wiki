# HvxKeysExecute

HvxKeysExecute is a syscall to execute a payload in privileged mode

  + Microsoft uses it as a back door to xbox 360s
  + On retails: Payloads must be signed
  + On exploited consoles: Signature check must be patched

Because this function has to do with online related services, I have
altered some function names, with the intention to reduce abusing this
for online purposes.

Why is this here if it has to do with online? Because while it is used
in the xbox live auth process, that does not appear to be its main
function. For example I have used it many times to help debug other HV
system calls.

``` cpp
#define KEYS_PARAMETER_FAIL 0xC8000030
#define KEYS_MAGIC_FAIL 0xC8000032
#define KEYS_HVMAGIC_FAIL 0xC8000033
#define KEYS_HEADER_FAIL 0xC8000034
#define KEYS_ENTRYPOINT_FAIL 0xC8000035
#define KEYS_CRYPT_FAIL 0xC8000036

// similar header to a bootloader, without the presets (probably because presets are passed as arguments)
typedef struct _BLHeader
{
    WORD Magic;     // 0 : 2
    WORD Version;       // 2 : 2
    DWORD Flags;        // 4 : 4
    DWORD EntryPoint;   // 8 : 4
    DWORD Size;     // 0xC : 4
    BYTE key[0x10];     // 0x10 : 0x10
    XECRYPT_SIG Sig;    // 0x20 : 0x100
    // Header: 0x120
}BLHeader, *PBLHeader;

BYTE BLKey[0x10] = { <redacted> };
BYTE ExSalt[0xA] = <redacted>; // NOTE: They use the same RSA key and BLKey as 1bl but different signature salt
XECRYPT_RSAPUB_2048 xRSA;
xRSA = <redacted>

typedef QWORD PayloadJump(PBYTE pbPayload, QWORD Arg1, QWORD Arg2, QWORD Arg3, QWORD Arg4);

QWORD HvxKeysExecute(PBYTE pbPayload, DWORD cbPayload, QWORD Arg1, QWORD Arg2, QWORD Arg3, QWORD Arg4)
{
    if(pbPayload & 0x7F // 0x80 byte alignment check
        || cbPayload & 0x7F // 0x80 byte alignment check
        || cbPayload > 0x10000 // size check
        || (((pbPayload + cbPayload) - 1) ^ pbPayload) & 0xFFFF0000)
        return KEYS_PARAMETER_FAIL;

    HvpAquireSpinLock(0x200016460);

    // our payload will be executed in realmode, to maintain security make sure it will be in a secure area
    DWORD origPayload = pbPayload;
    pbPayload = HvpRelocatePhysicalToInternal(pbPayload, cbPayload, 0x3E);

    // from now on if something fails, we need to invalidate the block in protected memory
    QWORD ret = 0;

    PBLHeader phPayload = (PBLHeader)pbPayload;
    if(phPayload->Magic & 0xF0F == 0xD0D) // Payload Magic check
    {
        if((*(WORD*)0 ^ phPayload->Magic) & 0xF000 == 0) // HV & Payload magic check
        {
            if(phPayload->Size >= 0x120 // sanity check
                || (phPayload->Size + 0xF) & 0xFFFFFFF0 >= phPayload->Size // ? dont see the point...?
                || (phPayload->Size + 0xF) & 0xFFFFFFF0 <= cbPayload) // sanity check
            {
                if(!phPayload->EntryPoint & 3 // 4 byte alignment check
                    || phPayload->EntryPoint >= 0x120 // sanity check
                    || phPayload->EntryPoint <= phPayload->Size & 0xFFFFFFFC) // sanity check
                {
                    BYTE rc4Key[0x10];
                    XeCryptHmacSha(BLKey, 0x10, &phPayload->key, 0x10, 0, 0, 0, 0, rc4Key, 0x10);
                    XECRYPT_RC4_STATE rc4;
                    XeCryptRc4Key(&rc4, rc4Key, 0x10);
                    XeCryptRc4Ecb(&rc4, pbPayload+0x20, phPayload->Size - 0x20);
                    BYTE Hash[0x14];
                    XeCryptRotSumSha(pbPayload, 0x10, pbPayload+0x120, phPayload->Size - 0x120, Hash, 0x14);
                    if(XeCryptBnQwBeSigVerify(phPayload->Sig, Hash, ExSalt, &xRSA))
                    {
                        // key and sig will not be used anymore, null them
                        *(QWORD*)pbPayload+0x10 = 0ull;
                        *(QWORD*)pbPayload+0x18 = 0ull;
                        memset(&phPayload->Sig, 0, 0x100);
                        if(phPayload->Size < cbPayload)
                            memset((pbPayload + phPayload->Size), 0, (cbPayload - phPayload->Size));

                        // jump to our payload
                        PayloadJump* pfPayload = (PayloadJump*)(pbPayload + phPayload->EntryPoint);
                        ret = pfPayload(pbPayload, Arg1, Arg2, Arg3, Arg4);
                    }
                    else ret = KEYS_CRYPT_FAIL;
                }
                else ret = KEYS_ENTRYPOINT_FAIL;
            }
            else ret = KEYS_HEADER_FAIL;
        }
        else ret = KEYS_HVMAGIC_FAIL;
    }
    else ret = KEYS_MAGIC_FAIL;

    BYTE retBuf[0x100];
    if(ret == 0) // assumed as success (payload return can change this)
        memcpy(retBuf, pbPayload+0x20, 0x100);
    else // assumed something failed, null retBuf (NOTE: if you want to use retBuf as a return buffer, payload must return 0)
        for(int i = 0;i < 0x20;i++)
            retBuf[i*8] = 0ull;

    // clean up
    HvpInvalidateCachelines(pbPayload, cbPayload);
    pbPayload = HvpPhysicalToReal(origPayload, cbPayload);
    HvpZeroCacheLines(pbPayload, cbPayload >> 7);
    memcpy(pbPayload + 0x20, retBuf, 0x100);

    HvpReleaseSpinLock(0x200016460);

    return ret;
}
```
