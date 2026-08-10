# NAND Flash Filesystem

Recommended Reading:

* [NAND Hardware](../../Hardware/Console/NAND.md)
* [NAND Spare Data](./Spare_Data.md)

The Xbox 360 NAND FlashFS is a custom proprietary format, very similar to FAT12 / FAT16.

## Internal Structure

Inside a 16 KB FlashFS block, pages use a 50/50 interleaved page layout:

- Even Pages -> Blockmap / File Allocation Table
- Odd Pages -> Directory Entries


### Blockmap / File Allocation Table

An array of big-endian 16-bit unsigned integers, 256 entries per 512-byte page. Maps every 16 KB block in the NAND filesystem area to the next block in a file's cluster chain.

Special Blockmap Values:

| Value           | Alias           | Description                                |
| -------------   | --------------- | ------------------------------------------ |
| 0x0000 – 0x1FFA |                 | Next block index in the file cluster chain |
| 0x1FFB          | FS_RESERVED     | Reserved block marker                      |
| 0x1FFE          | FS_FREE         | Free/unallocated block.                    |
| 0x1FFF          | FS_END_OF_CHAIN | End-of-file chain marker.                  |


### Directory Entries

Fixed 32 bytes (0x20), yielding 16 file entries per 512-byte page.

| Offset | Size | Description                                     |
|--------|------| ----------------------------------------------- |
| 0x00   | 0x16 | Filename (ASCII, null-terminated, max 22 chars) |
| 0x16   | 0x02 | Start Block Index (uint16_be)                   |
| 0x18   | 0x04 | File Length in bytes (uint32_be)                |
| 0x1C   | 0x04 | Timestamp (DOS DateTime format, uint32_be)      |

Deletion Flag: If filename[0] == 0x05, the file is flagged as deleted (conventionally displayed with an underscore _ prefix).


## Handling Small vs Big Block

Big-block NANDs (2048+64 per page) are actually viewed by the SFC as 4x 512+16 per page. Most modern NAND readers (2026) already split the BB pages into SB pages, and reconstruct them on reflashing. This makes dealing with small and big block nands mostly the same.


## Small / Big Block Metadata

On Small / Big Block NANDs, the FlashFS metadata is stored in the spare data.

| Spare byte(s) | Meaning |
|---|---|
| `[0]` or `[5]` | Bad block marker (0xFF = good) |
| `[1..2]` | Block index in blockmap chain |
| `[0..4,6]` | Sequence number (packed, varies by type) |
| `[7..8]` | FlashFS size field |
| `[9]` | Page count |
| `[C]` | Block type (`0x30`=FlashFS root, `0x31-0x39`=mobile data, etc.) |
| `[C..F]` | ECC (26-bit computed CRC) |

The FlashFS root block is identified by scanning spare data for blocks with
`block_type == 0x30` and a non-zero sequence number, the highest sequence wins.

The FlashFS block chain is linked purely through the **blockmap** stored in the root block's
data pages (even pages = blockmap, odd pages = file entries). Each `uint16_t` entry in the
blockmap is a forward pointer to the next block in a chain, with `0x1fff` = end, `0x1ffe` = free,
`0x1ffb` = reserved.


## eMMC Metadata

On eMMC NANDs, there is no spare data, and the eMMC controller does not support out-of-band storage.

Considering Small and Big block NANDs store the FlashFS metadata in the spare data, you obviously have to change the methodology when parsing and building eMMC images.

### The config block

As deffective / dead / bad blocks dont exist on eMMC NANDs, part of the reserve area is repurposed as a FlashFS config block.

```c
Offset  Size  Field
0x00    0x14  section_digest         (SHA1 hash of all data in this struct)
0x14    0x04  unknown1
0x18    0x04  fs_version             (FlashFS sequence number → replaces spare seq)
0x1C    0x02  fs_block_idx           (FlashFS root block index → replaces spare detection)
0x1E    0x02  unknown2
0x20    0x02  mobile1_block_idx      (first mobile data block)
0x22    0x02  mobile1_length         (mobile data 1 length)
0x24    0x08  unknown3
0x2C    0x02  mobile2_block_idx
0x2E    0x02  mobile2_length
0x30    0x1D0 reserved
```
