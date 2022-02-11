---
hide:
    - toc
---

# 1BL - Pseudocode

Have not reversed all of the hardware error subroutines.

```c
// version 0x583

#define STACK 0x800002000001F700 // r1
#define TOCP 0x8000020000000000 // r2
#define SRAM 0x8000020000010000
#define NAND 0x80000200C8000000
#define PCI 0x80000200D0000000

#define _HW_REG_POST 0x8000020000061010
#define _HW_REG_61008 0x8000020000061008
#define HW_REG_POST (*((volatile QWORD *)_HW_REG_POST))
#define HW_REG_61008 (*((volatile QWORD *)_HW_REG_61008))

#define BITMASK32(n) ((~0ul) >> 32-bits)
#define BITMASK32_L(n) ~((~0ul) >> bits) // left justified bitmask, assumes the hardware makes bits shifted in 0
#define BITMASK64(n) ((~0ull) >> 64-bits)
#define BITMASK64_L(n) ~((~0ull) >> bits) // left justified bitmask, assumes the hardware makes bits shifted in 0
#define ROTL32(data, bits) ((data << bits) | data >> 32-bits) & ~0ul
#define ROTR32(data, bits) ((data >> bits) | data << 32-bits) & ~0ul
#define ROTL64(data, bits) ((data << bits) | data >> 64-bits) & ~0ull
#define ROTR64(data, bits) ((data >> bits) | data << 64-bits) & ~0ull

BYTE Salt[0xB] = <redacted>;
BYTE BLKey[0x10] = { <redacted> };
XECRYPT_RSAPUB_2048 xRSA;
xRSA = <redacted>

typedef struct _BLHeader
{
    WORD Magic;         // 0 : 2
    WORD Version;       // 2 : 2
    DWORD Flags;        // 4 : 4
    DWORD EntryPoint;   // 8 : 4
    DWORD Size;         // 0xC : 4
    BYTE key[0x10];     // 0x10 : 0x10
    QWORD Pad[4];       // 0x20 : 0x20
    XECRYPT_SIG Sig;    // 0x40 : 0x100
    // Header: 0x140
}BLHeader, *PBLHeader;

// write to the post bus
void POST(QWORD postCode)
{
    HW_REG_POST = (postCode << 56);
}

// outputs a given byte, then the same byte OR'ed with 0x80
// probably for their internal post sniffer
void POST_DATA(BYTE outPost)
{
    POST(outPost);
    POST(outPost | 0x80);
}

// outputs a given amount of bytes from a given address in high-low format
void POST_ADDRESS(QWORD pqwAddy, DWORD cbAddy)
{
    for(int i = 0;i < cbAddy;i++)
    {
        BYTE bData = *(BYTE*)pqwAddy+i;
        POST(data >> 4); // output high
        POST(data & 0xF); // output low
    }
}

void PanicGen()
{
    while(1)
        continue;
}

void Panic(QWORD postCode)
{
    POST(postCode);
    PanicGen();
}

QWORD ReadHighestByte(QWORD Address)
{
    return ((*(QWORD*)Address) >> 56);
}

DWORD sub_36A8()
{
    DWORD ret = ReadHighestByte(HW_REG_61008);
    if((ret & 0x80) != 0)
        ret = (~ret) & 0xFF;
    return = ret & 0xF8;
}

// rough translation for the cntlzw instruction
DWORD countLeadingZeros(DWORD data)
{
    DWORD count = 0;
    for(int i = 0;i < 31;i++)
    {
        if(data >> 31-i)
            return count;
        count++;
    }
}

/*
Basically this happens when its detected that the
SOC doesn't carry correct values, it goes into a loop
and starts outputting data from a certain SOC register
(0x8000020000061008) - possibly error register?

It doesn't repeat it's output unless the SOC register changes
*/
void HARDWARE_ERROR_PRINT(DWORD dwUnk1)
{
    while(1)
    {
        BYTE bUnk1_p = ROTL32(dwUnk1, 3) & 0x1F;
        POST_DATA(bUnk1_p | 0x60);

        BYTE tmp = 0;
        BYTE bUnk1 = dwUnk1 & FF;

        if(bUnk1 == 0x78)
            tmp = 1;
        else
        {
            if(bUnk1 == 0)
                sub_3878(tmp);
            else if(bUnk1 == 8)
                sub_38B8(tmp);
            else if(bUnk1 == 0x10)
                sub_3AE0(tmp);
            else if(bUnk1 == 0x18)
                sub_3B30(tmp);
            else if(bUnk1 == 0x20)
                sub_3BB0(tmp);
            else if(bUnk1 == 0x28)
                sub_39C8(tmp);
            else if(bUnk1 == 0x30)
                sub_3F88(tmp, PCI + 0x8000);
            else if(bUnk1 == 0x38)
                sub_3C78(tmp);
            else if(bUnk1 == 0x40)
                sub_3D08(tmp);
            else if(bUnk1 == 0x48)
                sub_3DE0(tmp);
            else if(bUnk1 == 0x50)
                POST_ADDRESS(TOCP+2, 2);
            else if(bUnk1 == 0x58)
                sub_3F88(tmp, PCI);
            else if(bUnk1 == 0x60)
                sub_4008(tmp);
            tmp = 0;
        }

        POST_DATA(bUnk1_p | 0x70);

        DWORD r30 = (countLeadingZeros(bUnk1-0x50) >> 27) & 1;
        do
        {
            for(int i = 1;i < 6;i++)
            {
                DWORD dwUnk2 = sub_36A8();
                if(dwUnk1 & 0xFF != dwUnk2 & 0xFF)
                {
                    dwUnk1 = dwUnk2;
                    i = 0;
                }
            }
        } while(((countLeadingZeros((dwUnk1 & 0xFF) - 0x50) >> 27) & 1) == r30);
    }
}

bool CB_VerifyOffset(DWORD offset, DWORD arg2)
{
    if(offset != (offset + 0xF) & 0xFFFFFFF0)
        return false;
    if(offset - 0x80 > 0x7FFFF7F)
        return false;
    if((arg2 + 0xF) & 0xFFFFFFF0 >= offset - 0x8000000)
        return false;
    return true;
}

// Copies by 0x10 byte blocks
// cBlocks: how many 0x10 byte blocks to copy
void CB_Copy(QWORD dest, QWORD src, DWORD cBlocks)
{
    for(int i = 0; i < cBlocks; i++)
    {
        *(QWORD*)dest+(i*0x10) = *(QWORD*)src+(i*0x10);
        *(QWORD*)dest+(i*0x10)+8 = *(QWORD*)src+(i*0x10)+8;
    }
}

void CB_Jump(QWORD address, QWORD arg2)
{
    // grabs data from the CB before nulling the area
    QWORD r27 = *(QWORD*)SRAM+0x20;
    QWORD r28 = *(QWORD*)SRAM+0x28;
    QWORD r29 = *(QWORD*)SRAM+0x30;
    QWORD r30 = *(QWORD*)SRAM+0x38;
    // nulls 0x20-0x140(?)
    QWORD tmp = SRAM+0x20;
    for(int i = 0; i < 0x12; i++)
    {
        *tmp+(i*0x10) = 0ULL;
        *tmp+(i*0x10)+8 = 0ULL;
    }

    // check the size
    tmp = (((*(DWORD*)SRAM+0xC) + 0xF) & 0xFFFFFFF0);
    if(tmp >= 0x10000)
        Panic(0x98);

    // nulls the area after the CB
    QWORD addy = tmp + SRAM;
    for(int i = 0; i < (tmp - 0x10000) >> 4; i++)
    {
        *addy+(i*0x10) = 0ULL;
        *addy+(i*0x10)+8 = 0ULL;
    }

    // sets up tlb page
    // sets registers r0-r26 to 0
    // jump to CB
    goto (address & 0xFFFF) + 0x2000000;
    return;
}

void CB_Load()
{
    POST(0x11);
    FSB1(); // sub_3450

    POST(0x12);
    FSB2(); // sub_34D0

    POST(0x13);
    FSB3(); // sub_35A8

    POST(0x14);
    FSB4(); // sub_3658

    POST(0x15);
    DWORD cbOffset = *(DWORD*)NAND+8; // r25
    if(!CB_VerifyOffset(cbOffset, 0x10))
        Panic(0x94);

    POST(0x16);
    QWORD cbNAddy = NAND+cbOffset; // r26
    CB_Copy(SRAM, cbNAddy, 1);

    POST(0x17);
    PBLHeader cbHeader = (PBLHeader)SRAM;
    if((cbHeader->Size - 0x264) > 0xBD9C
        || (cbHeader->Magic & 0xFFF) != 0x342
        || (cbHeader->EntryPoint & 0x3)
        || (cbHeader->EntryPoint) < 0x264 // on slim its < 0x3B8
        || (cbHeader->Size & 0xFFFFFFFC) >= (cbHeader->EntryPoint & 0x3) // doesn't make sense, check later offset 0x4340 - On slim it makes sense: if(entrypoint >= size & 0xFFFFFFFC) panic
        || !CB_VerifyOffset(cbOffset, cbHeader->Size))
        Panic(0x95);

    POST(0x18);
    QWORD tmp = ((cbHeader->Size + 0xF) & 0xFFFFFFF0);
    CB_Copy(SRAM+0x10, cbNAddy+0x10, (tmp - 0x10) >> 4);

    POST(0x19);
    // overwrites the old key with the new one
    XeCryptHmacSha(BLKey, 0x10, &cbHeader->key, 0x10, 0, 0, 0, 0, &cbHeader->key, tmp);

    POST(0x1A);
    XECRYPT_RC4_STATE rc4;
    XeCryptRc4Key(&rc4, cbHeader->key, 0x10); // key = HmacSha(1BLKey, cbKey, 0x10)

    POST(0x1B);
    XeCryptRc4Ecb(&rc4, SRAM+0x20, tmp - 0x20); // Decrypts everything after the header

    POST(0x1C);
    BYTE Hash[0x14] = { 0 };
    XeCryptRotSumSha(SRAM, 0x10, SRAM+0x140, tmp - 0x140, Hash, 0x14); // hashes everything after the sig

    POST(0x1D);
    if(XeCryptBnQwBeSigDifference(&cbHeader->Sig, Hash, Salt, &xRSA)) // checks sig against hash with public rsa key
        Panic(0x96);

    POST(0x1E);
    CB_Jump(cbHeader->EntryPoint, tmp+cbOffset); // sets up tbl page and loads some registers before jumping to cb
    return;
}

void BL_1()
{
    // thread check?

    POST(0x10); // entered 1bl

    // null the sram area
    for(int i = 0; i < 0x1000; i++)
    {
        *(QWORD*)SRAM+(i*0x10) = 0ULL;
        *(QWORD*)SRAM+((i*0x10)+8) = 0ULL;
    }

    DWORD tmp = sub_36A8();
    if((tmp & 0xFF) == 0x50)
        HARDWARE_ERROR_PRINT(tmp); // look into later

    // load and execute the CB
    CB_Load();

    // CB_Load shouldn't return...
    PanicGen();

    return;
}
```
