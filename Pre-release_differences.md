# Hardware

## Motherboard

Extra unnamed header used for TITAN board, near ROL board connector.
\==TITAN Board== Some board used for CPU debugging (?)
Has DIP switches which have unknown functions
LED lights for indicating something
DIP switches are set to 4 down, 3 up, 2 down, 1 down (from a china
xedk), although this can be random.

# Flash

## Pre-1839

CPU key and 1BL key set to 00...00 (16 bytes of 00's)
\==Pre-1838== 1640 seems to include some strings to do with xshell
"\\Device\\Harddisk0\\Partition1\\dashboard.xbx",
"\\Device\\Harddisk0\\Partition1\\xshell.xex", 1746 doesn't have a
single mention
Bootloader names are different, instead of SB/SC/SD/SE/SF/SG it's
S2/S3/S4/S5/S6/S7
Kernel seems to have version field blanked out in the SE section, and
different magic bytes on decompression.
ECC data is different:
\*2 bytes to indicate block number, but second byte has 0xF0 added to
it, XOR that byte with 0xF0 to get true number

  - Doesn't indicate where the FS blocks are
  - Doesn't seem to have bad block management... probably does though

Uses a whole different file system for storing the dashboard files,
instead of [SFCX](NAND_File_System "wikilink") it uses
[FATX](FATX "wikilink")
Loads more files inside FATX NANDs:
\*drivers.xex
\*xnet.xex
\*xlivebase.xex
\*xgi.xex
\*uvbase.xex
\*musicplayer.xex (not sure if this is there normally)
\*gamercard.xex
\*gamercard.xzp
\*livecommon.xzp
\*spa.bin
\*common.xzp
\*huduiskin.xzp
\*processdump.xex
\*rrbkgnd.bmp
\*saferec.bmp
\*recovery.ttf
\=File Formats=

## Pre-1861

XEX1 format for xex files instead of XEX2... xorloser where are you?

## Pre-1839

Keyvault is different (e.g. console serial is 0x18 bytes?\!)
Keyvault also has different device keys, which stops wireless
controllers from working
Also, console security certificate is incomplete-ish:
\*Part number set to 12345678901
\*No manufacturing date?
\*Console type is weird, 0x80000002, normally when it ends in 02 it's
retail :S

[Category:Xbox360_Hardware](Category_Xbox360_Hardware)
[Category:Xbox360 System Software](Category_Xbox360_System_Software)