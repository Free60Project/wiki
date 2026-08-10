# NAND Spare Data

Reccomended Reading:

* [NAND Hardware](../../Hardware/Console/NAND.md)

## NAND Basic Format

The NAND uses a series of pages to combine into blocks, which are small
snippets of data (usually 512 bytes) which each have an EDC tag at the
end (an extra 16 bytes or 64 in bigblock). These pages are each part of
a specific block (which can be identified with the EDC), which is
usually made with 16 pages (or 32 for bigblock NANDs)

## Metadata

All (non-eMMC) NANDs have specific Spare-/Metadata for each page inside
the NAND. Sometimes it will not be dumped with the NAND, so it has to
either be added back or redumped. The Metadata contains the pages block
number, a series of flags and a checksum. Those differ slightly,
depending on the
blocksize.

### Small Block

```c
unsigned char BlockID1; // lba/id = (((BlockID0&0xF)<<8)+(BlockID1))
unsigned char BlockID0 : 4;
unsigned char FsUnused0 : 4;
unsigned char FsSequence0; // Not reversed
unsigned char FsSequence1;
unsigned char FsSequence2;
unsigned char BadBlock;
unsigned char FsSequence3;
unsigned char FsSize1; // ((FsSize0<<8)+FsSize1) = cert size
unsigned char FsSize0;
unsigned char FsPageCount; // free pages left in block (ie: if 3 pages are used by cert then this would be 29:0x1d)
unsigned char FsUnused1[0x2];
unsigned char FsBlockType : 6;
unsigned char ECC3 : 2;
unsigned char ECC2; // 14 bit ECD
unsigned char ECC1;
unsigned char ECC0;
```

### Big Block on Small NAND

```c
unsigned char FsSequence0;
unsigned char BlockID1; // lba/id = (((BlockID0<<8)&0xF)+(BlockID1&0xFF))
unsigned char BlockID0 : 4; 
unsigned char FsUnused0 : 4;
unsigned char FsSequence1;
unsigned char FsSequence2;
unsigned char BadBlock;
unsigned char FsSequence3;
unsigned char FsSize1; // (((FsSize0<<8)&0xFF)+(FsSize1&0xFF)) = cert size
unsigned char FsSize0;
unsigned char FsPageCount; // free pages left in block (ie: if 3 pages are used by cert then this would be 29:0x1d)
unsigned char FsUnused1[2];
unsigned char FsBlockType : 6;
unsigned char ECC3 : 2;
unsigned char ECC2; // 14 bit ECD
unsigned char ECC1;
unsigned char ECC0;
```

### Big Block

```c
unsigned char BadBlock;
unsigned char BlockID1; // lba/id = (((BlockID0&0xF)<<8)+(BlockID1&0xFF))
unsigned char BlockID0 : 4;
unsigned char FsUnused0 : 4;
unsigned char FsSequence2; // oddly, compared to before these are reversed...?
unsigned char FsSequence1;
unsigned char FsSequence0;
unsigned char FsUnused1;
unsigned char FsSize1; // FS: 06 ((FsSize0<<16)+(FsSize1<<8)+FsSize2) = cert size
unsigned char FsSize0; // FS: 20
unsigned char FsPageCount; // FS: 04 free pages left in block (multiples of 4 pages, ie if 3f then 3f*4 pages are free after)
unsigned char FsUnused2[0x2];
unsigned char FsBlockType : 6; // FS: 2a bitmap: 2c (both use FS: vals for size), mobiles
unsigned char ECC3 : 2;
unsigned char ECC2; // 14 bit ECD
unsigned char ECC1;
unsigned char ECC0;
```

## Error Detection/Correction Code

The ECC/EDC checksum uses a custom algorithm - here is C code for
that:

```cpp
int checkEcc(u8* datc, u8* spare)
{
unsigned int i=0, val=0;
unsigned char edc[4] = {0,0,0,0};
unsigned long * data = (unsigned long*) datc;

unsigned int v=0;
// printf("original ECC  : %02x %02x %02x %02x ", (spare[0xC] & 0xC0), spare[0xD],spare[0xE],spare[0xF]);

for (i = 0; i < 0x1066; i++)
{
   if (!(i & 31))
   {
       if (i == 0x1000)
       data = (unsigned long*)spare;
       v = ~*data++; // byte order: LE 
   }
       val ^= v & 1;
       v>>=1;
       if (val & 1)
           val ^= 0x6954559;
   val >>= 1;
}

val = ~val;

edc[0] = (val << 6) & 0xC0;
edc[1] = (val >> 2) & 0xFF;
edc[2] = (val >> 10) & 0xFF;
edc[3] = (val >> 18) & 0xFF;

if(((spare[0xC] & 0xC0) != edc[0])||(spare[0xD] != edc[1])||(spare[0xE] != edc[2])||(spare[0xF] != edc[3]))
   return ECC_FAILED;

return ECC_CORRECT;
}
```