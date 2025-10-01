# File Format Speculation

XEX is the executable file format used by the Xbox 360 operating system.
It seems to be a crypto and packing container for PPC PE executable
files, comparable to [UPX](https://upx.github.io/) or TEEE Burneye.
It's likely the 360 knows how to grab the section it needs into memory
and decrypt/decompress on demand, instead of traditional all at once
extraction.

# Cryptography

The executable code seems to be crypted, though, there exists some
uncrypted XEX files in the wild.

The following program dumps what is supposed to be a hash table.
Actually it has been reported to work with the first official "Backward
Compatibility" .XEX File from Microsoft. It takes the XEX file as
argument.

```c
// default.xex table dumper
// only works with the default.xex from the xbox360 emulator update package.
// - th0mas, th0mas.sixbit.org@gmail.com

#include <stdio.h>
#include <string.h>

#define TABLE_START 0x288

struct table {
   unsigned int unknown[6];
};

unsigned int ByteSwap (unsigned int nInt)
{
   union u { unsigned int vi; unsigned char c[sizeof(unsigned int)]; };
   union v { unsigned int ni; unsigned char d[sizeof(unsigned int)]; };
   union u un;
   union v vn;
   un.vi = nInt;
   vn.d[0]=un.c[3];
   vn.d[1]=un.c[2];
   vn.d[2]=un.c[1];
   vn.d[3]=un.c[0];
   return (vn.ni);`
}

void printTable(struct table *t)
{
   int i;
   for (i = 0; i < 6; i++) {
      int j = ByteSwap(t->unknown[i]);
      printf("0x%08x ", j);
   }
   printf("\n");
}

int main(int argc, char **argv)
{
   FILE *fp = fopen(argv[1], "rb");
   struct table tmp;
   int numEntries = 0;
   int i;

   fseek(fp, TABLE_START, SEEK_SET);
   fread(&numEntries, sizeof(unsigned int), 1, fp);
   numEntries = ByteSwap(numEntries);
   for (i = 0; i < numEntries; i++) {
        fread(&tmp, sizeof(struct table), 1, fp);
        printTable(&tmp);
   }
}
```

# Structure of the XEX File

A XEX file is composed of the following:

  - A 24 bytes XEX Header
  - Variable-length program/section headers
  - Program/Section content

## XEX Header

Total length: 24 bytes.

Byte ordering: [Big Endian](http://en.wikipedia.org/wiki/Big_Endian).

| Offset | Length | Type                     | Information           |
| ------ | ------ | ------------------------ | --------------------- |
| 0x0    | 0x4    | ascii string             | "XEX2" magic          |
| 0x4    | 0x4    | module flags (see below) | Flags                 |
| 0x8    | 0x4    | unsigned int             | PE data offset        |
| 0xC    | 0x4    | unsigned int             | Reserved              |
| 0x10   | 0x4    | unsigned int             | Security Info Offset  |
| 0x14   | 0x4    | unsigned int             | Optional Header Count |

The Flags field is a bitfield, as shown below:

`bit 0 - Title Module`
`bit 1 - Exports To Title`
`bit 2 - System Debugger`
`bit 3 - DLL Module`
`bit 4 - Module Patch`
`bit 5 - Patch Full`
`bit 6 - Patch Delta`
`bit 7 - User Mode`

## Optional Headers

Following the XEX header is a list of the optional headers within the
file. Use the Optional Header Count field to determine how many there
are.

Each Optional Header is composed of the
following:

| Offset | Length | Type         | Information                              |
| ------ | ------ | ------------ | ---------------------------------------- |
| 0x0    | 0x4    | unsigned int | Header ID (see below)                    |
| 0x4    | 0x8    | unsigned int | Header Data / Offset to data (see below) |

To handle the data you would first check to see what its size is, to do
this you need to AND the Header ID by 0xFF.

If ID & 0xFF == 0x01 then the Header Data field is used to store the
headers data, otherwise it's used to store the data's offset.
if ID & 0xFF == 0xFF then the Header's data will contain its size
if ID & 0xFF == (Anything else) the value of this is the size of the
entry in number of DWORDS (times by 4 to get real size)

### Header IDs

| Value    | Description                   |
| -------- | ----------------------------- |
| 0x2FF    | Resource Info                 |
| 0x3FF    | Base File Format              |
| 0x405    | Base Reference                |
| 0x5FF    | Delta Patch Descriptor        |
| 0x80FF   | Bounding Path                 |
| 0x8105   | Device ID                     |
| 0x10001  | Original Base Address         |
| 0x10100  | Entry Point                   |
| 0x10201  | Image Base Address            |
| 0x103FF  | Import Libraries              |
| 0x18002  | Checksum Timestamp            |
| 0x18102  | Enabled For Callcap           |
| 0x18200  | Enabled For Fastcap           |
| 0x183FF  | Original PE Name              |
| 0x200FF  | Static Libraries              |
| 0x20104  | TLS Info                      |
| 0x20200  | Default Stack Size            |
| 0x20301  | Default Filesystem Cache Size |
| 0x20401  | Default Heap Size             |
| 0x28002  | Page Heap Size and Flags      |
| 0x30000  | System Flags                  |
| 0x40006  | Execution ID                  |
| 0x401FF  | Service ID List               |
| 0x40201  | Title Workspace Size          |
| 0x40310  | Game Ratings                  |
| 0x40404  | LAN Key                       |
| 0x405FF  | Xbox 360 Logo                 |
| 0x406FF  | Multidisc Media IDs           |
| 0x407FF  | Alternate Title IDs           |
| 0x40801  | Additional Title Memory       |
| 0xE10402 | Exports by Name               |

## Program / Section content

The program holds a PE file which is crypted/packed, usually starting at
offset 0x2000 (described in the XEX header). It's possible to have this
PE uncrypted/unpacked on debug XEX files. Section contents are encrypted
with CBC AES, with the key changing for each file. It's probably derived
from the RSA(?) block at the beginning and a "secret" public key in the
box. Contents are compressed with microsoft's proprietary LDIC
compression (hello, xbox1!).

# Miscellaneous

## Strings found in some XEX Files

These appear to be important strings found in the update file

  - Directories?
      - XAdu
      - $UPDATES
      - MEDIA

  - \\Device\\CdRom0\\default.xex

  - installupdate.exe

  - The xboxkrnl is updated using the updates.

  - xam.xex

  - xboxkrnl.exe

  - Library includes:
      - XUIRNDR
      - XAUD
      - XGRAPHC
      - XRTLLIB
      - XAPILIB
      - LIBCMT
      - XBOXKRNL
      - D3D9
      - XUIRUN
      - XUIRNDR

## Availability of XEX files

There are currently at least four XEX files freely available on the net:

  - [Original Xbox Game Support November 2005 update](https://web.archive.org/web/20070311061307/http://assets.xbox.com/en-us/backwardcompatibility/default.zip) found on [http://www.xbox.com/en-US/games/backwardscompatibility.htm](https://web.archive.org/web/20090906002445/http://www.xbox.com/en-US/games/backwardscompatibility.htm).

  - [Original Xbox Game Support December 2005 update](https://web.archive.org/web/20070315222633/http://download.microsoft.com/download/5/8/a/58a10dbc-9445-4eed-83d5-22f8ad8ee855/default.zip) found on [http://www.xbox.com/en-US/games/backwardscompatibility.htm](https://web.archive.org/web/20090906002445/http://www.xbox.com/en-US/games/backwardscompatibility.htm).

  - [Windows XP Media Center Edition Update Rollup 2](https://web.archive.org/web/20070312113401/http://download.microsoft.com/download/2/8/5/28521E1E-120E-4D05-8310-3E43F2734431/XboxMCELite-ENU.exe) from [http://www.xbox.com/en-US/pcsetup/alldownloads.htm](https://web.archive.org/web/20091029113316/http://www.xbox.com/en-US/pcsetup/alldownloads.htm). Use [cabextract](https://www.cabextract.org.uk/) to extract the executable file, then do the same on mcrdinstaller/ehd.cab inside the archive. This cabinet file contains XboxMcx.xex.

  - [XBOX 360 HD DVD Update](https://web.archive.org/web/20090422010822/http://www.xbox.com/en-US/hardware/x/xbox360hddvdplayer/downloadredirect.htm) found on [http://www.xbox.com/en-us/hardware/x/xbox360hddvdplayer/download.htm#disc](https://web.archive.org/web/20090805081318/http://www.xbox.com/en-us/hardware/x/xbox360hddvdplayer/download.htm)

## Programs

  - [xextools](https://web.archive.org/web/20070808071312/http://www.neotokyo.phear.org/misc/xextools-0.2.tar.bz2)
    -- A library and tools for manipulating xex files (xexread
    replacement).
  - [xexdump](https://web.archive.org/web/20060629000929/http://oskarsapps.mine.nu/xexdump) -- Dumps information
    about xex files (perl)
  - [xexdump](http://www.chaosorder.org/xexdump.zip) -- Dumps
    information about xex files (windows)

## Executable Format

XEX files are the default executable format.

    <nowiki>
    File-offset Description
    0       "XEX2"
    0x4     (module flags?)
    0x10        File header offset
    0x14        Definition count (see below)
    0x18        Definition[]

    Definition  Description
    0x2FF       Module Sections
    0x3FF
    0x5FF       Delta patch descriptor
    0x4004
    0x4104
    0x42FF
    0x80FF      Binding path(s)
    0x8105
    0x10001     Load Address
    0x10100     Entry Point
    0x10201     Base Address
    0x103FF     Import Libraries
    0x18002     Checksum[4], Filetime[4]
    0x18102     (something debug related)
    0x183FF     PE Name

    0x200FF     Static Libraries
            UINT32 Total size
            entries[total size / 0x10]
    0x20104     TLS
            UINT32 Number of Slots
            UINT32 Raw Data Address
            UINT32 Data Size
            UINT32 Raw Data Size
    0x20200     Get Stack Size
    0x20301     Cache Element Count
    0x30000
    0x40006     MediaID[4], Version[4], Baseversion[4], TitleID[4]
    0x40310     Game Ratings
            UINT8 ESRB
            UINT8 PEGI
            UINT8 PEGI-FI
            UINT8 PEGI-PT
            UINT8 PEGI_BBFC
            UINT8 CERO
            UINT8 USK
            UINT8 OFLCAU
            UINT8 OFLCNZ
            UINT8 KMRB
            UINT8 BRASIL
            UINT8 FPB

    0x40404     Lan Key (16 Bytes)
    0x406FF     Multidisc, accepted Media IDs
    0x40801

    FileHeaderOffset    Description
    0           HeaderSize[4]
    0x4         Image Size[4]
    0x8         RSA Signature
    0x10C           (resulting Image size?)[4]
    0x110           LoadAddress
    0x140           MediaID[16]
    0x150           (AES key seed?)[16]
    0x164           (Input to SHA)[0x14]
    0x178           Region[4]
    0x17C           SHA Hash[0x14]
    0x180           ImageDataCount[4]
    0x184...0x184+(IDC*24)  ImageData0[8], ImageData1[8], ImageData2[8]
    </nowiki>


