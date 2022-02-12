# NANDPro

## NFO
```
===============================================================================
            SUPPORTED DEVICE INTERFACES
===============================================================================

USB:
   LPC2148 Olimex USB header board.
   High performance 16MB/2Mins.
   LibUsb driver.

LPT:
   Parallel Printer Port, SPP mode.
   Low performance, 16MB/35mins (cpu dependant).
   Dlportio printer port driver.

XSVF:
   Subset device of USB.
   LPC2148 Olimex USB header board required.
   NOT for nand programming. This command line device type is for flashing
   .xsvf files to a Xilinx cpld.

POST:
   Subset device of USB.
   LPC2148 Olimex USB header board required.
   NOT for nand programming. This command line device type is for monitoring
   Post codes only.

The included .hex file supports both Nand SPI flash, Xilinx Programming,
and Post Monitor all at the same time.
The mode selected ie: Nand Flash/Xsvf/PostMon is determined by the command line.
Previous .hex files as well as the "pic" version of hardware will not work.

The Maximus "NANDFlasher" has an array of plated through holes to break out all
the extra LPC2148 gpio. This product can be flashed with the new ArmV3.hex file
for full comatibility with Nandpro. The wiring coordinates are included here for
those who have this device. The included .jpg file shows the connections
to flash this device with the Philips utility. An RS232 level shifter is also
required for this purpose.

The Team Executor "NAND-X" can also be flashed with the ArmV3.hex, however the
wiring connections may be difficult, and are not listed in this document.

===============================================================================
            DRIVER AND HARDWARE INSTALLATION
===============================================================================

USB Install:
   Flash the .hex file to the LPC2148 using the
   "Philips LPC2000 FlashUtility" or equivalent.
   Connect LPC2148 to computer USB.
   Point "found new hardware" to the "custom.inf"
   Windows reports: "Your new hardware is ready to use"

USB Hardware:
   Connect only wires from EXT connectors to MAINBRD where indicated.
   Connect only wires from EXT connectors to Xilinx jtag connector where indicated.
   No resistors or diodes at all. For sure! Do not add them!

===============================================================================

LPT Install:
   Run the port95nt.exe application to install the DlPortio driver

LPT Hardware:
   Some parallel ports run at 3.3v others at 5v. The MAINBRD is 3.3 volts.

   It is recommend to use 100 ohm series saftey resistors (R)
   for all lpt connections except for DB25.11 and DB25.18 (GND), as shown above.
   Testing with 5 volt lpt and NO resistors didn't burn anything up though. YMMV

   For DB25.11 connect diode exactly as shown. It is highly recommended to
   connect the diode to the MAINBRD end rather than the PC end of the wire.
   Preferred diode is BAT41 or other Schottkey switch diode with low forward voltage drop.
   1N4148/53, 1N914, type switching diodes should be also be ok,
   but are not quite as good. 1N400X are rectifiers and not good at all.

   This solution isn't perfect but you typically dont leave it hooked up forever anyway.
   If someone wants to design and post a buffer circuit go right ahead. I can't be bothered

===============================================================================
            COMMAND LINE USAGE
===============================================================================

NandPro v3.0a by Tiros


Useage:

To invoke Nand SPI flasher use:
NandPro dev: -r# Filename (HexStartBlock HexBlockCount) ->Read
NandPro dev: -w# Filename (HexStartBlock HexBlockCount) ->Write
NandPro dev: -e# (HexStartBlock HexBlockCount)          ->Erase

dev: Is hardware interface usb: or lpt:
dev: Can also be a filename:, to be used as a 'Virtual Nand Device'
   Virtual device config can be forced, by appending :HexConfigValue
# Is nand size (16, 64, 256, 512) in MegaBytes
HexBlocks are optional range limits, default is entire device
-r# Read saving file RAW (with SPARE)
-R# Read saving file without SPARE
!r# Read saving only the SPARE data
-w# Write RAW (with SPARE) file
+w# Write RAW (with SPARE) file, init SPARE, block numbers, ECC
@w# Write RAW (with SPARE) file, init block numbers, ECC
*w# Write RAW (with SPARE) file, init ECC
+W# Write while ADDING SPARE from file without SPARE

To invoke Xilinx xsvf flasher use:
NandPro xsvf: XsvfInputFilename.xsvf

To invoke usb post monitor use:
NandPro post: PostLogFileName.txt


===============================================================================
===============================================================================
            .XSVF CPLD CONNECTIONS AND OPERATION
===============================================================================
===============================================================================
Follow instructions for USB install.
Make the following connections from the LPC2148 to the Xilinx device
Jtag conenctor:

ArmLpc  Jtag            Olimex          Maximus

3.3v    VCC             EXT2.24         M1
GND     GND             EXT2.25         N3
P0.17   TCK             EXT1.18         A2
P0.18   TDO             EXT1.19         B3
P0.19   TDI             EXT1.20         C1
P0.20   TMS             EXT1.21         C2

Xilinx CPLD flashing typical command line:

Flash a .xsvf file, created by Impact, to cpld:
   Nandpro xsvf: filename.xsvf

General XSVF notes:
LPT is not supported for this feature.
Requires additional connections from LPC2148 to the Xilinx jtag connector.
The Xilinx Impact tool is used to create .xsvf files. The Xilinx Impact software
records/redirects cpld operations into a binary file (.xsvf) that can be
processed by Nandpro. IE: Nandpro does not flash .jed files, but .jed files
may be directly converted to .xsvf by Impact.
See the Xilinx Impact tool for more information.

===============================================================================
===============================================================================
            POST MONITOR CONNECTIONS AND OPERATION
===============================================================================
===============================================================================
Follow instructions for USB install.
The post connections require level shifting to 3.3 volts to be monitored.
This will require an external circuit. The cpld can also be used for this purpose.

Flash cpld with nandpro:
   nandpro xsvf: SlimPlusPost.xsvf

The SlimPlusPost.xsvf is fully compatible with the existing released pinout with
the exception of the DBG pin. The DBG pin has been relocated and now
drives via open collector. The LED will remain off, and flash briefly
on each reset attempt.

To connect an LED to the DBG pin:

3.3V---/\/\330/\/\--->|-------DBG 3 (37)


Make the following connections from the LPC2148 to the cpld
level shifter outputs:

ArmLpc  Post    Olimex          Maximus         CPLD Out (CMOD)

P1.16   Post0   EXT2.5          L1                      38 (28)
P1.17   Post1   EXT2.6          J2                      37 (27)
P1.18   Post2   EXT2.7          I1                      36 (26)
P1.19   Post3   EXT2.8          G3                      34 (25)
P1.20   Post4   EXT2.9          A1                      33 (24)
P1.21   Post5   EXT2.10         D3                      32 (23)
P1.22   Post6   EXT2.11         E1                      31 (22)
P1.23   Post7   EXT2.12         G1                      30 (18)


Make the following connections from the main board post outputs to the
cpld level shifter inputs:

Mbrd                    CPLD
Post Out                In (CMOD)

Post0                   39 (29)
Post1                   40 (30)
Post2                   41 (31)
Post3                   42 (32)
Post4                   43 (33)
Post5                   44 (34)
Post6                   1  (35)
Post7                   2  (36)


Post monitor typical command line:
   Nandpro post: PostLog.txt

General post monitoring notes:
LPT is not supported for this feature.
Post changes will be displayed on the command line and logged to the
specified filename as a text file.
The log file will be over written on each run.
Pressing any key will break the post monitor loop.

===============================================================================
===============================================================================
            NAND FLASHING CONNECTIONS AND OPERATION
===============================================================================
===============================================================================
Seven connections must be made from MAINBRD to the HW device interface.
MAINBRD connects as specified to either Olimex board, or a PC printer port.

ArmLpc  Olimex          LPT                             MAINBRD

SS      EXT1-3          DB25.1  --R---  J1D2.2
MISO    EXT1-6          DB25.11 -->|--  J1D2.4  Diode, observe polarity!
P0.28   EXT2-1          DB25.16 --R---  J2B1.6
GND     EXT1-26         DB25.18 ------  J1D2.6  or      J2B1.12
MOSI    EXT1-7          DB25.14 --R---  J1D2.1
SCK     EXT1-5          DB25.2  --R---  J1D2.3
P0.29   EXT2-2          DB25.17 --R---  J2B1.5

   Make connections to MAINBRD and run the app.
   MAINBRD needs to be plugged in to AC power.
   Actually powered on or not does not matter.
   While running NandPro application reset will occur.
   After nand operation is complete, reset will be released.

Nand flashing typical command line:

Read entire 16M flash, including SPARE:
   NandPro dev: -r16 nand.bin

Write entire 16M flash, including SPARE:
   NandPro dev: -w16 nand.bin

Advanced command line examples:

Read encrypted key vault with SPARE:
nandpro dev: -r16 rawkv.bin 1 1

Read encrypted key vault from a "Virtual Nand" dev:, named vnand.bin, with SPARE :
nandpro vnand.bin: -r16 rawkv.bin 1 1

Write encrypted key vault:
nandpro dev: -w16 rawkv.bin 1 1

Flash a xell.bin compiler output (no SPARE) to block 40, adding SPARE while flashing:
nandpro dev: +W16 xell.bin 40

Read config block from a "Virtual Nand", named vnand.bin, without SPARE:
nandpro vnand.bin: -R16 configblk.bin 0x??? 1

Write above config block to dev: adding the SPARE back in:
nandpro dev: +W16 configblk.bin 0x??? 1

Write a "small" python.ECC file to "full size" "Virtual Nand" :
nandpro vnand.bin: -w16 python.ECC

Write to a dev:, from another RAW file, fixing ECC while writing:
nandpro dev: -w16 DumpWithErrors.bin


General nand flashing notes:

SPARE is the 16 bytes following a data block.

ECC is 26 bits located within the spare area.

Block numbers are also contained in spare area.

Reading and writing defaults to the entire device.
The start block argumnet is optional and dictates the starting block to program.
The ending block is also optional, and end if no block is specified, programming will
continue until end of file or end of specified nand size.

Large block nands have different SPARE format than small block nands.
The software uses the detected device's SPARE format for all (+) write operations.
Files written RAW (-) are not translated in any way.

The "nand size" argument only sets the limit of available blocks for device operations.
It is not hardware related, and need not exactly match the true device.

There is no need to erase before programming.

You can hex edit a block, and use Nandpro to fix its ECC when you write it back.

The "Case" of the command generally indicates if I/O file will contain SPARE or not
   Upper Case:     No SPARE
   Lower Case:     RAW (with SPARE)

The "Virtual Nand" file can be read or be programmed, as if it where a device.
The "Virtual Nand" file must be a raw file, containing SPARE.
This can be used to extract or inject data from\to an existing raw dump.
Example: To inject a "small" python image into an existing
"full size" image, or to extract individual blocks from an existing raw dump.

Note:
For the vnand: device the flash config is normally automatically detected.
Some "hybrid" 256/512 images can not be detected properly, to mount these files the config
value must be forced by specifying it as the last argument on the command line, preceeded by a ':'.
Only vnand: device may be forced!

Example:
nandpro vnand.bin: -r64 rawkv.bin 1 1 :AA3020


READING WILL OVER-WRITE AN EXISTING FILE WITHOUT WARNING!
NEW LOG FILE WILL OVERWRITE OLD WITHOUT WARNING!

DO NOT LEAVE LPT CABLE CONNECTED WHEN CONSOLE DOES NOT HAVE AC POWER!

===============================================================================
            HISTORY
===============================================================================
//
//2.0
//Initial Release
//
//2.0a
//Fixed usage for +W, +w
//Fixed problem with payload injection for large block nands
//Fixed miscalc of file blocks togo when injecting !raw
//No ARM code impact
//
//
//2.0b
//Remove "Press Any Key" for unattended batch file processing
//Removed retry on individual sectors, retry entire block instead, including erase
// attempt to program all sectors anyway, then report status
//ARM code update required for above
//Added ARM HW version test, (U32) 0000 0001 required or abort
//Added "Virtual Nand" device
//
//
//2.0c
//Bit settling verify feature added for LPT reading
//Add support for Jasper16a
//Improved detection for virtual nand device, fixes some problems with writing to vnand.
//Allways corrects the ECC bytes (but not SPARE), even in raw mode
// ie: A raw file that has been hex edited can simply be flashed with -w
//
//Added command line swithces
//%r will read SPARE data only, 16 bytes per block
//@w will write RAW file, while correcting block numbers
//Can "force" a flash config on command line by appending :HexFlashConfig
//
//2.0d
//For compatibility purposes -w does not calculate ECC
//Raw files are flashed pure using -w. To correct ECC errors use *w instead
// ie: A raw file that has been hex edited can simply be flashed with *w
//
//2.0e
//Fixed the "forced" flash config on command line for virtual nand device.
//
//3.0a
//Requires new v3 .hex for arm
//Suppport added to flash .xsvf files by jtag
//Support added for post monitoring and logging
//
```

[Category: Xbox 360 Homebrew Software](../Category_Xbox360_Homebrew_Software)
