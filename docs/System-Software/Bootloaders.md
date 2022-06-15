# Bootloaders

The Xbox 360 system uses a series of bootloaders to load the hv/kernel
and dashboard. These loaders are explained at [Boot Process](../Boot_Process).

## Header

The header is at the start of the bootloader and is usually 0x20 bytes
long.

| Offset | Length | Type             | Information                                |
| ------ | ------ | ---------------- | ------------------------------------------ |
| 0x0    | 0x2    | ASCII characters | Loader name                                |
| 0x2    | 0x2    | unsigned short   | Loader build number                        |
| 0x4    | 0x2    | unsigned short   | Loader pairing data                        |
| 0x6    | 0x2    | unsigned short   | Loader flags                               |
| 0x8    | 0x4    | unsigned integer | Loader entrypoint                          |
| 0xC    | 0x4    | unsigned integer | Loader length (including header)           |
| 0x10   | 0x10   | bytes            | HMAC salt (used for decrypting the loader) |

[System Software](/System-Software)
