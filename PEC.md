**PEC** (Profile Embedded Content) files are used by the Xbox 360 as an
additional layer of security on profiles. Certain [GPD](GPD "wikilink")
files are relocated inside the PEC file. The PEC file stores information
on avatar clothes/items, and is just another STFS package. With this
said you must properly rehash and resign the PEC file to avoid the Xbox
detecting corruption of the package. Rehashing is the same as all STFS
packages (besides the starting block), but resigning is different (view
below).

# Header

| Offset | Length | Type                               | Information                      |
| ------ | ------ | ---------------------------------- | -------------------------------- |
| 0x0    | 0x228  | \[\[Console_Security_Certificate | Console Security Certificate\]\] |
| 0x228  | 0x14   | bytes                              | SHA1 hash from 0x23C-0x1000      |
| 0x23C  | 0x8    | signed long                        | Unknown                          |
| 0x244  | 0x24   | \[\[STFS\#Volume_Descriptor       | Structure\]\]                    |
| 0x268  | 0x4    | signed int                         | Unknown                          |
| 0x26C  | 0x8    | bytes                              | Profile ID                       |
| 0x274  | 0x1    | byte                               | Unknown                          |
| 0x275  | 0x5    | bytes                              | Console ID                       |

# Notes

The Console ID at 0x275 must match the Console ID located in the
[Console Security Certificate](Console_Security_Certificate "wikilink"),
otherwise the Xbox360 will see it as a corrupted file.

The signature located in the [Console Security
Certificate](Console_Security_Certificate "wikilink") is signed using
the hash at location 0x228. (SHA1 hash from 0x23C - 0x1000)

From 0x1000 the rest of the file is the standard block portion of
[STFS](STFS "wikilink"), with data block 0 starting at 0x3000, and hash
table 0 at 0x1000/0x2000. The PEC file always has 2 hash tables (type 1
package).

[Category:Xbox360_System_Software](Category:Xbox360_System_Software "wikilink")