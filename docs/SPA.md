**SPA** files are contained inside [XEX](XEX "wikilink") files or within
Updates or DLC. They are just a [XDBF](XDBF "wikilink") file, they are
used by the dashboard for [GPD](GPD "wikilink") creation and [Xbox
LIVE](Xbox_LIVE "wikilink") information.

# Record Table

## Record Namespaces

| Value | Description   |
| ----- | ------------- |
| 1     | Metadata      |
| 2     | Images        |
| 3     | String Tables |

# Record Structures

## Metadata

Each record here is set out differently depending on there magic.

### XACH

This is just a table of
Achievements.

| Offset | Length                             | Type                              | Information              |
| ------ | ---------------------------------- | --------------------------------- | ------------------------ |
| 0      | 4                                  | string                            | Magic (XACH)             |
| 0x4    | 0x4                                | unsigned int                      | Structure Version        |
| 0x8    | 0x4                                | unsigned int                      | Structure Size (- Magic) |
| 0xC    | 0x2                                | unsigned short                    | Achievement Count        |
| 0xE    | **Achievement Count** \* 36 (0x24) | achievement structure (see below) | Achievements             |

#### Achievement Structure

| Offset | Length | Type           | Information             |
| ------ | ------ | -------------- | ----------------------- |
| 0x0    | 0x2    | unsigned short | Achievement ID          |
| 0x2    | 0x2    | unsigned short | Title String ID         |
| 0x4    | 0x2    | unsigned short | Unlocked Description ID |
| 0x6    | 0x2    | unsigned short | Locked Description ID   |
| 0x8    | 0x4    | unsigned int   | Image ID                |
| 0xC    | 0x2    | unsigned short | Gamerscore              |
| 0xE    | 0x2    | unsigned short | Unused                  |
| 0x10   | 0x4    | unsigned int   | Flags                   |
| 0x14   | 0x4    | unsigned int   | Unused                  |
| 0x18   | 0x4    | unsigned int   | Unused                  |
| 0x1C   | 0x4    | unsigned int   | Unused                  |
| 0x20   | 0x4    | unsigned int   | Unused                  |

### XCXT

TODO: what this
stores

| Offset | Length                 | Type                         | Information              |
| ------ | ---------------------- | ---------------------------- | ------------------------ |
| 0      | 4                      | string                       | Magic (XCXT)             |
| 4      | 4                      | UInt32                       | Version                  |
| 8      | 4                      | UInt32                       | Structure Size (- Magic) |
| 12     | 4                      | UInt32                       | Record Count             |
| 16     | **Record Count** \* 16 | Record structure (see below) | Records                  |

#### Record Structure

| Offset | Length | Type   | Information |
| ------ | ------ | ------ | ----------- |
| 0      | 4      | UInt32 | Unknown     |
| 4      | 4      | UInt32 | Unknown     |
| 8      | 4      | UInt32 | Unknown     |
| 12     | 4      | UInt32 | Unknown     |

TODO: Unknown

### XITB

This record just stores the ImagePath +
ID's.

| Offset | Length                | Type                        | Information              |
| ------ | --------------------- | --------------------------- | ------------------------ |
| 0      | 4                     | string                      | Magic (XITB)             |
| 4      | 4                     | UInt32                      | Version                  |
| 8      | 4                     | UInt32                      | Structure Size (- Magic) |
| 12     | 4                     | UInt32                      | Image Count              |
| 16     | **Image Count** \* 16 | Image structure (see below) | Images                   |

#### Image Structure

| Offset | Length      | Type   | Information |
| ------ | ----------- | ------ | ----------- |
| 0      | 4           | UInt32 | ImageID     |
| 4      | 4           | UInt32 | Name Length |
| 8      | Name Length | String | Image Path  |

### XMAT

TODO: What this
stores

| Offset | Length                 | Type     | Information              |
| ------ | ---------------------- | -------- | ------------------------ |
| 0      | 4                      | string   | Magic (XMAT)             |
| 4      | 4                      | UInt32   | Version                  |
| 8      | 4                      | UInt32   | Structure Size (- Magic) |
| 12     | **Structure Size** - 8 | Byte\[\] | Unknown                  |

TODO: Unknown

### XPBM

TODO: What this
stores

| Offset | Length                 | Type     | Information              |
| ------ | ---------------------- | -------- | ------------------------ |
| 0      | 4                      | string   | Magic (XPBM)             |
| 4      | 4                      | UInt32   | Version                  |
| 8      | 4                      | UInt32   | Structure Size (- Magic) |
| 12     | **Structure Size** - 8 | Byte\[\] | Unknown                  |

TODO: Unknown

### XPRP

TODO: what this
stores

| Offset | Length                | Type                         | Information              |
| ------ | --------------------- | ---------------------------- | ------------------------ |
| 0      | 4                     | string                       | Magic (XPRP)             |
| 4      | 4                     | UInt32                       | Version                  |
| 8      | 4                     | UInt32                       | Structure Size (- Magic) |
| 12     | 4                     | UInt32                       | Record Count             |
| 16     | **Record Count** \* 8 | Record structure (see below) | Records                  |

#### Record Structure

| Offset | Length | Type     | Information |
| ------ | ------ | -------- | ----------- |
| 0      | 8      | Byte\[\] | Unknown     |

TODO: Unknown, (2 int32's?)

### XRPT

This record just stores a series of XPMB files.

| Offset | Length | Type               | Information    |
| ------ | ------ | ------------------ | -------------- |
| 0      | 4      | string             | Magic (XRPT)   |
| 4      | 4      | UInt32             | Version        |
| 8      | 4      | UInt32             | Structure Size |
| 12     |        | **XPMB**           | XPBM           |
|        | 2      | UInt16             | XPBM Count     |
|        |        | XPBM\[XPBM Count\] | Sub XPBMs      |

### XSRC

This file is something todo with xlast, (a source
file?)

| Offset          | Length             | Type     | Information          |
| --------------- | ------------------ | -------- | -------------------- |
| 0               | 4                  | string   | Magic (XSRC)         |
| 4               | 4                  | UInt32   | Version              |
| 8               | 4                  | UInt32   | Structure Size       |
| 12              | 4                  | UInt32   | NameLength           |
| 16              | NameLength         | String   | (original?)filename  |
| 16 + NameLength | Structure Size - 8 | Byte\[\] | Unknown(compressed?) |

TODO: Unknown

### XSTC

TODO: What this stores

| Offset | Length | Type   | Information              |
| ------ | ------ | ------ | ------------------------ |
| 0      | 4      | string | Magic (XSTC)             |
| 4      | 4      | UInt32 | Version                  |
| 8      | 4      | UInt32 | Structure Size (- Magic) |
| 12     | 4      | UInt32 | Unknown                  |

TODO:
Unknown

### XTHD

| Offset | Length | Type           | Information                                               |
| ------ | ------ | -------------- | --------------------------------------------------------- |
| 0      | 4      | unsigned int   | Magic (XTHD)                                              |
| 0x4    | 0x4    | unsigned int   | Structure Version                                         |
| 0x8    | 0x4    | unsigned int   | Structure Size                                            |
| 0xC    | 0x4    | unsigned int   | Title ID                                                  |
| 0x10   | 0x4    | unsigned int   | Title Type (0 = system, 1 = full, 2 = demo, 3 = download) |
| 0x14   | 0x2    | unsigned short | Project Version Major                                     |
| 0x16   | 0x2    | unsigned short | Project Version Minor                                     |
| 0x18   | 0x2    | unsigned short | Project Version Build                                     |
| 0x1A   | 0x2    | unsigned short | Project Version Revision                                  |
| 0x1C   | 0x4    | unsigned int   | Unused                                                    |
| 0x20   | 0x4    | unsigned int   | Unused                                                    |
| 0x24   | 0x4    | unsigned int   | Unused                                                    |
| 0x28   | 0x4    | unsigned int   | Unused                                                    |

Is StructureSize null for anyone else? only in this record.

### XVC2

This record just stores a series of XPBM files, and (TODO: Unknown).

| Offset | Length | Type     | Information              |
| ------ | ------ | -------- | ------------------------ |
| 0      | 4      | string   | Magic (XVC2)             |
| 4      | 4      | UInt32   | Version                  |
| 8      | 4      | UInt32   | Structure Size (- Magic) |
| 12     | 2      | UInt16   | XPBM Count               |
| 14     | 204    | Byte\[\] | Unknown                  |
| 208    |        | XPBM\[\] | XPBM's                   |

TODO: Unknown

## Images

Image entries are composed of a PNG image.

## String Tables

### XSTR

All these records are set out the same however some have a unknown
byte\[\] after the
string.

| Offset | Length | Type                         | Information              |
| ------ | ------ | ---------------------------- | ------------------------ |
| 0      | 4      | string                       | Magic (XSTR)             |
| 4      | 4      | UInt32                       | Version                  |
| 8      | 4      | UInt32                       | Structure Size (- Magic) |
| 12     | 4      | UInt16                       | String Count             |
| 16     |        | String structure (see below) | Strings                  |

#### String Structure

| Offset | Length            | Type   | Information   |
| ------ | ----------------- | ------ | ------------- |
| 0      | 2                 | UInt16 | String ID     |
| 2      | 2                 | UInt16 | String Length |
| 4      | **String Length** | String | String        |

[Category: Xbox360_System_Software](Category_Xbox360_System_Software)
