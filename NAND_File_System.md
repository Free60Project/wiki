## General

The Xbox 360 NAND uses a proprietary format created by Microsoft. The
format is used to store console-specific data (keyvault, config blocks,
etc) and system data (bootloaders, kernel/hypervisor, dashboard files).
The NAND is split into two sections - one for storing the keyvault,
bootloaders and config blocks and one for storing the dashboard files.
The file are stored using a format which is designed to be transactional
(each change can be reverted).

# NAND Basic Format

The NAND uses a series of pages to combine into blocks, which are small
snippets of data (usually 512 bytes) which each have an EDC tag at the
end (an extra 16 bytes or 64 in bigblock). These pages are each part of
a specific block (which can be identified with the EDC), which is
usually made with 16 pages (or 32 for bigblock NANDs)

# Metadata

All (non-eMMC) NANDs have specific Spare-/Metadata for each page inside
the NAND. Sometimes it will not be dumped with the NAND, so it has to
either be added back or redumped. The Metadata contains the pages block
number, a series of flags and a checksum. Those differ slightly,
depending on the
blocksize.

## Small Block

`unsigned char BlockID1; // lba/id = (((BlockID0&0xF)<<8)+(BlockID1))`
`unsigned char BlockID0 : 4;`
`unsigned char FsUnused0 : 4;`
`unsigned char FsSequence0; // Not reversed`
`unsigned char FsSequence1;`
`unsigned char FsSequence2;`
`unsigned char BadBlock;`
`unsigned char FsSequence3;`
`unsigned char FsSize1; // ((FsSize0<<8)+FsSize1) = cert size`
`unsigned char FsSize0;`
`unsigned char FsPageCount; // free pages left in block (ie: if 3 pages are used by cert then this would be 29:0x1d)`
`unsigned char FsUnused1[0x2];`
`unsigned char FsBlockType : 6;`
`unsigned char ECC3 : 2;`
`unsigned char ECC2; // 14 bit ECD`
`unsigned char ECC1;`
`unsigned char ECC0;`

## Big Block on Small NAND

`unsigned char FsSequence0;`
`unsigned char BlockID1; // lba/id = (((BlockID0<<8)&0xF)+(BlockID1&0xFF))`
`unsigned char BlockID0 : 4; `
`unsigned char FsUnused0 : 4;`
`unsigned char FsSequence1;`
`unsigned char FsSequence2;`
`unsigned char BadBlock;`
`unsigned char FsSequence3;`
`unsigned char FsSize1; // (((FsSize0<<8)&0xFF)+(FsSize1&0xFF)) = cert size`
`unsigned char FsSize0;`
`unsigned char FsPageCount; // free pages left in block (ie: if 3 pages are used by cert then this would be 29:0x1d)`
`unsigned char FsUnused1[2];`
`unsigned char FsBlockType : 6;`
`unsigned char ECC3 : 2;`
`unsigned char ECC2; // 14 bit ECD`
`unsigned char ECC1;`
`unsigned char ECC0;`

## Big Block

`unsigned char BadBlock;`
`unsigned char BlockID1; // lba/id = (((BlockID0&0xF)<<8)+(BlockID1&0xFF))`
`unsigned char BlockID0 : 4;`
`unsigned char FsUnused0 : 4;`
`unsigned char FsSequence2; // oddly, compared to before these are reversed...?`
`unsigned char FsSequence1;`
`unsigned char FsSequence0;`
`unsigned char FsUnused1;`
`unsigned char FsSize1; // FS: 06 ((FsSize0<<16)+(FsSize1<<8)+FsSize2) = cert size`
`unsigned char FsSize0; // FS: 20`
`unsigned char FsPageCount; // FS: 04 free pages left in block (multiples of 4 pages, ie if 3f then 3f*4 pages are free after)`
`unsigned char FsUnused2[0x2];`
`unsigned char FsBlockType : 6; // FS: 2a bitmap: 2c (both use FS: vals for size), mobiles`
`unsigned char ECC3 : 2;`
`unsigned char ECC2; // 14 bit ECD`
`unsigned char ECC1;`
`unsigned char ECC0;`

# Error Detection/Correction Code

The ECC/EDC checksum uses a custom algorithm - here is C code for
that:

`int checkEcc(u8* datc, u8* spare)`
`{`
`unsigned int i=0, val=0;`
`unsigned char edc[4] = {0,0,0,0};`
`unsigned long * data = (unsigned long*) datc;`

`unsigned int v=0;`
`// printf("original ECC  : %02x %02x %02x %02x ", (spare[0xC] & 0xC0), spare[0xD],spare[0xE],spare[0xF]);`

`for (i = 0; i < 0x1066; i++)`
`{`
`   if (!(i & 31))`
`   {`
`       if (i == 0x1000)`
`       data = (unsigned long*)spare;`
`       v = ~*data++; // byte order: LE `
`   }`
`       val ^= v & 1;`
`       v>>=1;`
`       if (val & 1)`
`           val ^= 0x6954559;`
`   val >>= 1;`
`}`

`val = ~val;`

`edc[0] = (val << 6) & 0xC0;`
`edc[1] = (val >> 2) & 0xFF;`
`edc[2] = (val >> 10) & 0xFF;`
`edc[3] = (val >> 18) & 0xFF;`

`if(((spare[0xC] & 0xC0) != edc[0])||(spare[0xD] != edc[1])||(spare[0xE] != edc[2])||(spare[0xF] != edc[3]))`
`   return ECC_FAILED;`

`return ECC_CORRECT;`
`}`

# NAND Format

The first byte of a NAND image should always be 0xFF. If it isn't 0xFF
this isn't a valid image. Another thing which should be checked is the
copyright header, which is located at 0x10 in the NAND. This string
should be read in two parts (skipping the year out, as it changes
depending when that xbox was made) and then checked against a control
string (although some valid images have this string changed to
zeropair).

At 0x2 in the NAND the version of the flash is stored (2bytes). Further
on at 0x8 the offset of the CB is stored, followed by the CF1 offset
(4bytes each).

At 0x6C the offset to the keyvault is located (4bytes). Up from that at
0x78 the length of the SMC and offset to the SMC are stored (4bytes
each).

## System Management Controller

finish later

## XeLL Image Layout

The whole XeLL Image is pretty small with 1,3 MB compared to an original
Xbox360 NAND-Image which is normally 16 MB or 64 MB.

`0x00000000..0x000001ff (0x00000200 bytes) Header`
`0x00000200..0x000003ff (0x00000200 bytes) Exploit`
`0x00000400..0x00000fff (0x00000c00 bytes) Padding`
`0x00001000..0x00003fff (0x00003000 bytes) SMC`
`0x00004000..0x00007fff (0x00004000 bytes) Keyvault`
`0x00008000..0x000117ff (0x00009800 bytes) CB 1921`
`0x00011800..0x00016ebf (0x000056c0 bytes) CD 1921`
`0x00016ec0..0x0006cf2f (0x00056070 bytes) CE 1888`
`0x0006cf30..0x0006ffff (0x000030d0 bytes) Padding`
`0x00070000..0x000744bf (0x000044c0 bytes) CF 4532`
`0x000744c0..0x000a33ff (0x0002ef40 bytes) CG 4532`
`0x000a3400..0x000bffff (0x0001cc00 bytes) Padding`
`0x000c0000..0x000fffff (0x00040000 bytes) Xell (backup)`
`0x00100000..0x0013ffff (0x00040000 bytes) Xell (main)`

  - The (hacked) SMC Code is usually seen as Header + Exploit + Padding
    + the actual SMC, so 0x0000 - 0x3FFF.
  - The Keyvault is the unique "System Information" which holds stuff
    like DVDKey, Console Region, Console Serial and other things. Whole
    keyvault is crypted with CPUKey.
  - After that exploitable CB (2BL) and CD (4BL), matching the console
    revision, follows.
  - After padding CB/CD theres CE (Base-Kernel 1888) followed by
    exploitable Patchslots CF/CG (4532 or 4548) and again some padding.
  - At the end of the Image theres a Backup-XeLL, which gets executed if
    the original XeLL fails (Bad Update maybe) followed by the original
    XeLL.

[Category:Xbox360 System Software](Category_Xbox360_System_Software.md "wikilink")