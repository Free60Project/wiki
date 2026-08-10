# NAND Image

Reccomended Reading:

* [NAND Hardware](../../Hardware/Console/NAND.md)
* [NAND Spare Data](./Spare_Data.md)
* [NAND File System](./File_System.md)
* [Bootloaders](../Bootloaders.md)

## Introduction

The Xbox 360 NAND uses a proprietary format created by Microsoft. The
format is used to store console-specific data (keyvault, config blocks,
etc) and system data (bootloaders, kernel/hypervisor, dashboard files).
The NAND is split into two sections - one for storing the keyvault,
bootloaders and config blocks and one for storing the dashboard files.
The file are stored using a format which is designed to be transactional
(each change can be reverted).

## NAND Header

The NAND Header is stored at the beginning and sets key values for reading / executing the image.

xconfig_offset is never used by the Xbox 360 system, despite being set..

| Offset | Size | Description       | Common Value |
| ------ | ---- | ----------------- | ------------ |
| 0x0    | 0x1  | magic             | 0xFF         |
| 0x2    | 0x2  | version           | 1888         |
| 0x4    | 0x2  | pairing           |              |
| 0x6    | 0x2  | flags             |              |
| 0x8    | 0x4  | entrypoint        | 0x00008000   |
| 0xC    | 0x4  | size              |              |
| 0x10   | 0x40 | reserved          |              |
| 0x50   | 0x4  | payload_indicator |              |
| 0x54   | 0xC  | reserved          |              |
| 0x60   | 0x4  | kv_size           | 0x00004000   |
| 0x64   | 0x4  | cf1_offset        |              |
| 0x68   | 0x2  | patch_slots       |              |
| 0x6A   | 0x2  | kv_version        |              |
| 0x6C   | 0x4  | kv_offset         | 0x00004000   |
| 0x70   | 0x4  | fs_offset         | 0x00008000   |
| 0x74   | 0x4  | xconfig_offset    | 0x00000400   |
| 0x78   | 0x4  | smc_size          | 0x00003000   |
| 0x7C   | 0x4  | smc_offset        | 0x00001000   |

## Image Layout

All NAND images use the same initial layout and design:

| Offset | Size   | Description        |
| ------ | ------ | ------------------ |
| 0x0    | 0x80   | Header             |
| 0x1000 | 0x3000 | SMC                |
| 0x4000 | 0x4000 | Keyvault           |
| 0x8000 |        | Initial BL Chain   |
|        |        | Late BL Chain      |
|        |        | [NAND FlashFS](./File_System.md)       |

## Initial Bootloader Chain

The initial bootloader chain can change greatly between motherboard types, versions, and retail vs developer hardware.

**Phat consoles <= Kernel 14699**

| Slot  | Bootloader |
| ----  | ---------- |
| 2BL   | CB         |
| 3BL   | N/A        |
| 4BL   | CD         |

**Phat consoles > Kernel 14699, **
**All slim consoles**

| Slot  | Bootloader |
| ----  | ---------- |
| 2BL_A | CB_A       |
| 2BL_B | CB_B       |
| 3BL   | N/A        |
| 4BL   | CD         |

**Devkit consoles**

| Slot  | Bootloader |
| ----  | ---------- |
| 2BL   | SB         |
| 3BL   | SC         |
| 4BL   | SD         |

## Late Bootloader Chain

The late bootloader chain mostly stays the same between hardware but changes based on the image type.

**Retail Flash Image**

| Slot  | Bootloader |
| ----  | ---------- |
| 5BL   | CE         |
| 6BL_A | CF 0       |
| 7BL_A | CG 0       |
| 6BL_B | CF 1       |
| 7BL_B | CG 1       |

**Retail XeLL Image**

| Slot  | Bootloader |
| ----  | ---------- |
| 5BL   | XeLL       |

**Devkit Flash Image**

| Slot  | Bootloader |
| ----  | ---------- |
| 5BL   | SE         |

### JTAG XeLL Image Layout

The whole XeLL Image is pretty small with 1,3 MB compared to an original
Xbox360 NAND-Image which is normally 16 MB or 64 MB.

0x00000000..0x000001ff (0x00000200 bytes) Header
0x00000200..0x000003ff (0x00000200 bytes) Exploit
0x00000400..0x00000fff (0x00000c00 bytes) Padding
0x00001000..0x00003fff (0x00003000 bytes) SMC
0x00004000..0x00007fff (0x00004000 bytes) Keyvault
0x00008000..0x000117ff (0x00009800 bytes) CB 1921
0x00011800..0x00016ebf (0x000056c0 bytes) CD 1921
0x00016ec0..0x0006cf2f (0x00056070 bytes) CE 1888
0x0006cf30..0x0006ffff (0x000030d0 bytes) Padding
0x00070000..0x000744bf (0x000044c0 bytes) CF 4532
0x000744c0..0x000a33ff (0x0002ef40 bytes) CG 4532
0x000a3400..0x000bffff (0x0001cc00 bytes) Padding
0x000c0000..0x000fffff (0x00040000 bytes) Xell (backup)
0x00100000..0x0013ffff (0x00040000 bytes) Xell (main)

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


