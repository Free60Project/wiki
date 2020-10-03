**XDBF** (**X**box **D**ata **B**ase **F**ile) files are used by the
Xbox 360 as a generic database. It is used as the format for
[GPD](GPD "wikilink") (**G**amer **P**rofile **D**ata) and
[SPA](SPA "wikilink") (**S**tatistics, **P**resence and
**A**chievements) files. SPA files are linked into an Xbox 360
executable during compilation and are used by the dashboard to generate
the GPD, Save Game ([STFS](STFS "wikilink")) Meta-Data and Images. In
the XAM the DataFile class handles all of the operations associated with
these files.

# Header

Total length: 24 bytes (0x18)

Byte ordering: Dependant on magic. If the magic is little endian then
the whole file is and is a GFWL, if it's big endian then it's an Xbox
file.

| Offset | Length | Type         | Information                                    |
| ------ | ------ | ------------ | ---------------------------------------------- |
| 0x0    | 0x4    | ascii string | Magic (0x58444246)                             |
| 0x4    | 0x4    | unsigned int | Version (0x10000)                              |
| 0x8    | 0x4    | unsigned int | Entry Table Length (in number of entries)      |
| 0xC    | 0x4    | unsigned int | Entry Count                                    |
| 0x10   | 0x4    | unsigned int | Free Space Table Length (in number of entries) |
| 0x14   | 0x4    | unsigned int | Free Space Table Entry Count                   |

**Entry Table Length** and **Free Space Table Length** will be a
multiple of 512, this is just Xbox's preferred values, but it will read
the file if you decrease them to make the size of the file smaller, alot
smaller.

# Entry Table

The Entry Table is made up of entries, each one under a different
namespace and ID. The table length will be **Entry Table Length** \* 18, 
but only the first **Entry Count** are used.

## Entry Structure

Total length: 18 bytes (0x12)

| Offset | Length | Type           | Information            |
| ------ | ------ | -------------- | ---------------------- |
| 0x0    | 0x2    | unsigned short | Namespace (see \[\[GPD |
| 0x2    | 0x8    | unsigned long  | ID                     |
| 0xA    | 0x4    | unsigned int   | OffsetSpecifier        |
| 0xE    | 0x4    | unsigned int   | Length                 |

# Free Space Table

The **Free Space Table** is used to map out the unused space within the
file. It is updated whenever n entry changes size. Each entry within the
**Free Space Table** is composed of the OffsetSpecifier and how much
space is unused their (Length). The final entry in the **Free Space
Table** isn't actually free space, but rather is information about the
length of data after the tables. The **OffsetSpecifier** would be the
length (file length - header and tables) and the **Length** would be -1
-**OffsetSpecifier**.

## Free Space Entry Structure

Total length: 8 bytes

| Offset | Length | Type         | Information     |
| ------ | ------ | ------------ | --------------- |
| 0x0    | 0x4    | unsigned int | OffsetSpecifier |
| 0x4    | 0x4    | unsigned int | Length          |

# Entry Data Offset

To work out the real entry data offset, times the **Entry Table Length**
by 0x12, then times the **Free Space Table Length** by 0x8 and add the
result together, and add 0x18 (file header). This is where the beginning
of the entry data begins, then add the OffsetSpecifier by the entry to
get the real offset.

(((**Entry Table Length** \* 18) + (**Free Space Table Length** \* 8)) +
24) + OffsetSpecifier

Just to explain a bit more, 

**Entry Table Length** \* 18, 18 being the length of each entry, this
will workout the actual length of the entry table.

**Free Space Table Length** \* 8, 8 being the length of each free space
entry, workout the actual length of the free space table.

\+ 24, 24 is the length of the
header.

[Category: Xbox360_System_Software](Category_Xbox360_System_Software)
