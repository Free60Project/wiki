# Memory map

## Physical Mapping

| Address    | Size      | Description                                                          |
| ---------- | --------- | -------------------------------------------------------------------- |
| `c000xxxx` | 0x10000   | Initial "Kernel" (bootloader, not real kernel), mapped L2-Cache?     |
| `c8xxxxxx` | 0x1000000 | memory mapped NAND flash (RO, 1:1, no OoB(ECC))                      |
| `c9xxxxxx` | 0x1000000 | ???                                                                  |
| `d0xxxxxx` | 0x1000000 | PCI config space. Device number etc. is encoded in address, as usual |
| `e0000000` | ???       | Host-Bridge                                                          |
| `e1000000` | ???       | BIU                                                                  |
| `ea000000` | 0x10000   | PCI Bridge                                                           |
| `ec800000` | 0x10000   | GPU                                                                  |

## PCI/Device Mapping

| Address           | Size   | Description                  |
| ----------------- | ------ | ---------------------------- |
| `0x(200)ea001000` | 0x100  | System Management Controller |
| `0x(200)ea001200` | 0x30   | SATA Controller CDRom        |
| `0x(200)ea001300` | 0x30   | SATA Controller HDD          |
| `0x(200)ea001400` | 0x80   | Fast Ethernet Adapter        |
| `0x(200)ea001600` | 0x40   | Audio Controller             |
| `0x(200)ea001800` | 0x400  | XMA Decoder                  |
| `0x(200)ea002000` | 0x1000 | OHCI Controller 0            |
| `0x(200)ea003000` | 0x1000 | EHCI Controller 0            |
| `0x(200)ea004000` | 0x1000 | OHCI Controller 1            |
| `0x(200)ea005000` | 0x1000 | EHCI Controller 1            |
| `0x(200)ea00c000` | 0x400  | Secure Flash Controller      |

## SMC Area

| Address           | Size | Description  |
| ----------------- | ---- | ------------ |
| `0x(200)ea001000` | 0x10 | Bus Control  |
| `0x(200)ea001010` | 0x10 | UART         |
| `0x(200)ea001020` | 0x10 | GPIO Port ?? |
| `0x(200)ea001030` | 0x10 | GPIO Port ?? |
| `0x(200)ea001040` | 0x10 | GPIO Port ?? |
| `0x(200)ea001050` | 0x10 | SMI ???      |
|  |

## Encryption

Dumps of physical memory

Changed 1 byte in software, dumped again, 16 bytes changed again.

Might be ~1 cache line

(0, 1, 2, ...)

log:

```
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 6e bb c5 d1 62 9e 29 8f e9 3a 6b 7b 4d d0 44 24 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 03 58 f6 c0 f0 13 d5 02 4f 57 a1 d0 50 d3 46 6a 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 1b d6 a6 3b 3c 6e 68 4f da 75 7f a7 8a 02 e4 53 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 38 03 ff f0 61 99 e6 8c b0 3b 2f bb b6 70 06 53 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 0f 55 01 b1 61 9b 35 34 4d ce f4 e8 bb eb cc 4a 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 fc ce 87 2c 30 c0 1c 4f e7 65 da d4 e4 df f6 2b 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 e5 5d f3 38 d9 05 c0 8e 7a a9 b5 a2 fe 11 4c b3 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 84 83 5d 34 55 9b e4 06 26 03 1b f3 0b e9 0f b8 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
f0 35 64 03 de 02 5b 09 b5 7b 81 49 21 e9 d9 77 ba 4d 72 2b cd 0b e9 0c 2b aa ed 53 ea b0 63 49 15 d4 61 28 e0 e2 ea da e3 b8 34 2e cf bb af 0e
```
