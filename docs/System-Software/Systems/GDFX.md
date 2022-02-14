# GDFX

Used in Disks and SVOD devices, except when in SVOD format it seems to
have extra sectors containing a hash of 2 segments(4098 bytes).
Each segment is 2048 bytes.

The first segment starts with 440816472(Little endian).

The 32nd segment seems to be a descriptor.

| Offset | Length | Type     | Information              |
| ------ | ------ | -------- | ------------------------ |
| 0      |     20 | string   | "MICROSOFT\*XBOX\*MEDIA" |
| 20     |      4 | int      |              Root Sector |
| 24     |      4 | int      |                Root Size |
| 28     |      8 | FileTime |            Creation Time |

## Directory

| Offset | Length     | Type   | Information |
| ------ | ---------- | ------ | ----------- |
| 0      | 2          | int    | unk         |
| 2      | 2          | int    | unk         |
| 4      | 4          | int    | Sector      |
| 8      | 4          | int    | Size        |
| 12     | 1          | int    | Flags?      |
| 13     | 1          | int    | namelength  |
| 14     | namelength | string | name        |

## Dirent Attributes

| Flag      | Bitmask    |
| --------- | ---------- |
| READONLY  | 0x00000001 |
| HIDDEN    | 0x00000002 |
| SYSTEM    | 0x00000004 |
| DIRECTORY | 0x00000010 |
| ARCHIVE   | 0x00000020 |
| DEVICE    | 0x00000040 |
| NORMAL    | 0x00000080 |
| TEMPORARY | 0x00000100 |


[System Software](System_Software)
