# NAND reading

This tutorial explains how to read the Xbox360's
[NAND](NAND "wikilink")/Flash via a PC's parallel/"printer" port in as
clean and easy as possible a way. The same method is used to dump all
models of the Xbox 360 ([Xenon](Xenon "wikilink"),
[Zephyr](Zephyr "wikilink"), [Falcon](Falcon "wikilink"),
[Opus](Opus "wikilink"), [Jasper](Jasper "wikilink")).

Please keep quick & dirty setups and speculation out or, in case some
guesswork is really needed, flag them, so this article and the whole
wiki can develop as trustworthy sources.

There are guides to dump via USB, but compared to this it's quite
expensive and easily found with a search. Maybe someone will add one
later on.

If you're facing any problems, feel free to ask in \#free60 on OFTC. :)

Moreover thanks to tmbinc, Tiros, Redline and all else involved (feel
free to add their names) for their great work\! :)

## Requirements

First of all, you'll need soldering skills—if you've never used a
soldering iron before, you should train on a less expensive object. This
skill level is similar to adding a modchip to a console.

You'll need the following:

  - Prerequisites:

:\*LPT (parallel) port (preferably supporting SPP)

  - Components:

:\*1 × diode BAT41 - There are several diodes you can use. People on
xboxhacker.net had the best experiences with BAT41, others used N4148. I
(kote) used PH4148.

:\*5 × 100–120 Ω resistors - not a must-have, but it'll protect your box

:\*LPT cable - Hollow connector housings will make your life easier.
Alternatively, use a bare DB25 male connector and wire.

  - Tools:

:\*Multimeter - (Voltmeter/Continuity)

:\*Soldering Iron

:\*A lot of patience and spare time ;) - A third hand will make your
life easier, too

  - Software

:\***32-bit OS/PC** - The necessary PortIO(?-Guessing) driver is
available for 32-bit systems only. There is a 64-bit port, however
NandPro2 compatibility is unknown (22/08/2009). Since many 64-bit
systems don't have a parallel port, this shouldn't affect many people.

:\***64-bit Update:** Go here. Download 'Binaries only - x86 & x64 DLLs
and libs'. Extract inpout32.dll from Win32 folder to nandpro folder.
Rename inpout32.dll to DLPortIO.dll (credit)

:\*NandPro - NandPro (by User:Tiros Tiros on xboxhacker.net - for
reading out the NAND image.) seems to work with Windows Vista 32-bit and
Windows 7 32-bit. Windows XP Compatibility Mode or running with
administrator rights may be necessary. XP or earlier is preferred.

:\*Verifying NAND Dumps:

::\*File comparison Utility - MD5SUM, SHA1SUM, (Total Commander)

::\*360 Flash Tool - (there are different versions\! The latest is
V0.88a CD FIXED \[22/08/2009\])

::\*NAND Compare and Reconstruction Tool - (compare 2 nand images or
reconstruct image from 3 bad reads)

## Photos

[1](http://www.abload.de/img/exsamplewek4.jpg)
[2](http://www.abload.de/img/example2sf3m.jpg)
[3](http://www.abload.de/img/example3kdbk.jpg)

## Steps:

### Preparing the cable

First of all, there are different kinds of LPT cables out there. If you
got one with at least one male DB25 connector, you will be fine. There
are also cables with two DB25 connectors and possibilites to do it
without any DB25 connector. However, this tutorial is supposed to be as
universal as possible, so we will behave like there are only cables with
one connector.

Well, whatever is on the other end of your cable, cut it off. So you
will get a cable with a DB25 connector at one side and loose wires on
the other side.

Now you need to trace the wires in the cable. If you've got a cable with
openable plug housings, you're in luck: just open the housings and
compare single wires with those on the loose end. Otherwise it's time
for your continuity tester. You will need to know which wire goes to
which pin at the end. Write down the colour of the wire attached to each
pin. Since there are only seven needed wires, you don't have to trace
every wire. The following pins need to be connected: 1, 2, 11, 14, 16,
17, 18. In case a pin isn't connected, just resolder a wire from an
unneeded pin (e.g., 15) to the needed one (e.g., 14).

I (some11) bought a LPT Cable (Nikkai LPT Parallel Printer Cable
\[L79BT\]) from Maplins.

<http://i45.tinypic.com/29lhggk.jpg>

Here is the wire color map output:

<table border="1">

<tr>

<td>

Pin

</td>

<td>

Color (Main/Second)

</td>

<td>

Pin

</td>

<td>

Color (Main/Second)

</td>

</tr>

<tr>

<td>

<b>Pin 1</b>

</td>

<td>

Yellow

</td>

<td>

Pin 13

</td>

<td>

Black

</td>

</tr>

<tr>

<td>

<b>Pin 2</b>

</td>

<td>

Pink Black

</td>

<td>

<b>Pin 14</b>

</td>

<td>

White

</td>

</tr>

<tr>

<td>

Pin 3

</td>

<td>

Pink

</td>

<td>

Pin 15

</td>

<td>

Grey Black

</td>

</tr>

<tr>

<td>

Pin 4

</td>

<td>

Orange Black

</td>

<td>

<b>Pin 16</b>

</td>

<td>

Grey

</td>

</tr>

<tr>

<td>

Pin 5

</td>

<td>

Orange White

</td>

<td>

<b>Pin 17</b>

</td>

<td>

Purple White

</td>

</tr>

<tr>

<td>

Pin 6

</td>

<td>

Orange

</td>

<td>

<b>Pin 18</b>

</td>

<td>

Purple

</td>

</tr>

<tr>

<td>

Pin 7

</td>

<td>

Red Black

</td>

<td>

Pin 19

</td>

<td>

Blue White

</td>

</tr>

<tr>

<td>

Pin 8

</td>

<td>

Red White

</td>

<td>

Pin 20

</td>

<td>

Blue

</td>

</tr>

<tr>

<td>

Pin 9

</td>

<td>

Red

</td>

<td>

Pin 21

</td>

<td>

Green (Different)

</td>

</tr>

<tr>

<td>

Pin 10

</td>

<td>

Brown White

</td>

<td>

Pin 22

</td>

<td>

Green Black

</td>

</tr>

<tr>

<td>

<b>Pin 11</b>

</td>

<td>

Brown

</td>

<td>

Pin 23

</td>

<td>

Green White

</td>

</tr>

<tr>

<td>

Pin 12

</td>

<td>

Black White

</td>

<td>

Pin 24

</td>

<td>

Green

</td>

</tr>

<tr>

<td>

</td>

<td>

</td>

<td>

Pin 25

</td>

<td>

Yellow Black

</td>

</tr>

</table>

After you've done that, you can cut the unneeded wires at the loose end
so they won't bother you while soldering. Strip a small amount of
insulation (5 mm should be plenty) from the end of each of the other
wires, and twist the loose strands inside together. Tin each wire, so
that you get nice and sweet clean wires.

### Opening the Xbox 360

<http://www.anandtech.com/printarticle.aspx?i=2610>

### Preparing and Soldering

Once you have a clear view of the board, it's time to locate the solder
pads of J1D2 (red) and J2B1 (blue).

<http://www.abload.de/img/locationnoqa.jpg>

You will have to establish the following connections:

<table border="1">

<tr>

<td>

LPT(DB25)

</td>

<td>

Component

</td>

<td>

Xbox 360

</td>

</tr>

<tr style="background-color: rgb(255, 128, 128);">

<td>

DB25.1

</td>

<td style="color: rgb(0, 0, 128);">

resistor

</td>

<td>

J1D2.2

</td>

</tr>

<tr style="background-color: rgb(255, 128, 128);">

<td>

DB25.2

</td>

<td style="color: rgb(0, 0, 128);">

resistor

</td>

<td>

J1D2.3

</td>

</tr>

<tr style="background-color: rgb(255, 128, 128);">

<td>

DB25.11

</td>

<td style="color: rgb(0, 128, 0);">

diode

</td>

<td>

J1D2.4

</td>

</tr>

<tr style="background-color: rgb(255, 128, 128);">

<td>

DB25.14

</td>

<td style="color: rgb(0, 0, 128);">

resistor

</td>

<td>

J1D2.1

</td>

</tr>

<tr style="background-color: rgb(128, 128, 255);">

<td>

DB25.16

</td>

<td style="color: rgb(0, 0, 128);">

resistor

</td>

<td>

J2B1.6

</td>

</tr>

<tr style="background-color: rgb(128, 128, 255);">

<td>

DB25.17

</td>

<td style="color: rgb(0, 0, 128);">

resistor

</td>

<td>

J2B1.5

</td>

</tr>

<tr style="background-color: rgb(128, 255, 128);">

<td>

DB25.18

</td>

<td>

nothing

</td>

<td>

J1D2.6, J2B1.12, or a screwhole

</td>

</tr>

</table>

<http://www.abload.de/img/connectiontableaolh.jpg>

This is how you count on a board:
<http://www.abload.de/img/howtocount5y02.jpg>

The square is always 1, in this case J2B1.1. Also, notice the white dot
near pin 1 and the labels near pins 2, 12, and 13.

"Component" means that you will have to add the resistor or diode
between those two points. I suggest that you first solder the component
on the board and after that the wire to the component. **The diode's
black ring has to be in the direction of the Xbox board.** By
"screwhole", we mean a screwhole. (The ground (or "earth") connection
we're using is also present on J1D2.6 and J2B1.12, but those are
difficult to solder.) Solder the wire from DB25.18 to one of those big
reddish rings (where the long screws go through the DVD-ROM drive legs),
and fix it with insulation tape (NOT DUCT TAPE\! Otherwise you will
damage your Xbox). '''It is important that you solder the diode directly
to the board. It won't work if it's in the plug housing\! ''' LPT
(parallel port) connections are the same for Xenon, Zephyr, Falcon,
Opus, and Jasper (but JTAG connections are different between Xenon
motherboards and the other ones).

New Xenon exploit diagram: <http://i.imgur.com/Fdjmi.png>

Diagram (including LPT & JTAG connections):
<https://web.archive.org/web/20111202124409/http://img710.imageshack.us/img710/31/spidiagramsandungas.png>

Another diagram (including LPT & JTAG connections):
<https://web.archive.org/web/20111202142124/http://img12.imageshack.us/img12/4983/xenondiagram.jpg>

Slim diagram: <http://imageshack.us/photo/my-images/32/lptslim.png/>

### Checklist

  - Is every wire connected to the correct pin?
  - Are there any short circuits or doubly connected wires? (Watch out
    for sprawling solder\!)
  - Have you taken everything out of the box that doesn't belong in
    there?

When you've checked that, plug the parallel cable into your turned-off
computer, the power supply into your Xbox, and the power cable into the
power outlet.

### Setting up your PC

Turn on your PC. It's possible that your Xbox will turn on, too. Don't
worry, just leave it turned on. As long as it doesn't start to smoke,
smell, or anything else weird it will be fine. Later on, it should turn
off the fans on its own, but the LEDs will remain blinking. If it
doesn't turn on: don't worry, it doesn't have to be turned on while
reading the NAND.

Go to the BIOS settings and search for LPT mode settings. Tiros
recommends SPP/Normal mode in his help file (Nandpro.txt), but the mode
doesn't actually appear to matter. If you're having trouble in the next
step, give a different mode a try. After you have done that, save
settings and leave BIOS. Boot up Windows.

Now the time has come to unpack NandPro2. In the archive you'll find
port95nt.exe (driver) and some other files (e.g. NandPro.exe). Install
the driver. If you're using Vista or higher, you might have to turn on
XP Compatibility Mode, as already mentioned. To install it, just
double-click on it and walk through the setup. There shouldn't be any
error messages. Then: reboot.

### Reading/Dumping the nand twice and drinking coffee.

`Prepare the coffee. ;) `

Windows should have booted up now. Open up Windows Command Prompt (press
Windows Key + R to open up Run. Type cmd and press Enter).

Navigate to NandPro's installation directory by using common commands
(cd, dir, and the TAB key for auto-completion). Then type nandpro.exe
lpt: -r16 nand1.bin and press enter. If everything's fine, it should
output
this:

`Testing LPT device address:0378   // address can differ`
`Using LPT device at address:0378  // address can differ`
`FlashConfig:01198010              // must be the same (except Jasper boards, see next block)`
`Starting Block:0x000000           // Starting and ending should be as shown here if you want`
`Ending   Block:0x0003FF           // to read the whole flash [you want! :p]`

If you get FlashConfig: 0012000 try soldering the diode directly to the
motherboard instead on having it on the conector side. It worked for
iD4rK, and others.

The Flashconfig is dependant on the mainboard version, other valid
values are:

`FlashConfig - System Types`
`01198010 - Xenon, Zephyr, Opus, Falcon`
`00023010 - Jasper 16mb`
`008A3020 - Jasper 256mb`
`00AA3020 - Jasper 512mb`

Press any key to continue. It should start to count up addresses. If it
starts to output stuff like "Error 0 .. blah blah" something's wrong.
Recheck wiring, change LPT mode, or try a different computer. It is
possible that there are one or two bad blocks on your NAND (error 25x),
so don't worry if you get that error once or twice.

Well, the reading (dumping) process will take about half an hour. So
head to your coffee machine. ;) Unfortunately, we will need at least two
dumps to check whether there are really no failures in your dump. So
once NandPro has finished dumping, press the up arrow key (or retype the
command), CHANGE THE FILENAME TO NAND2.BIN, press Enter, and dump it a
second time. Get another coffee. Or turn on the TV. Maybe you have got a
girlfriend?

When NandPro2 has finished the second dump without errors close the
command-line.

## Checking for errors

First, open up both files with 360 Flash Tool. If it looks like in the
picture beneath this, everything should be fine. If an error message
"Couldn't open file" pops up, something went wrong.

:\*<http://www.abload.de/img/360flashtool4ld2.jpg> Second, start up
Total Commander. Choose File -\> Compare by content. A new window will
open. Select both files and click on compare. If they are identical:
congratulations\! You are done with this. =)

If not, search for errors in wiring etc. or try a different PC.

:\*<http://www.abload.de/img/totalcommander6zw7.jpg> While 360 Flash
Tool will show you the content of the NAND, it's not a conclusive check
whether the integrity is good: it's possible to get a "thumbs up" from
the utility even if you have corrupted (and more importantly, vital)
blocks. A much better check is to run the resulted image through
Degraded v1.1, which will highlight any errors.

A NAND with bad blocks usually looks like
this:

:\*<https://web.archive.org/web/20111202132655/http://www.infectus.biz/INFECTUS-BOOK/Tutorial_Eng/Xbox360/Timing_Attack_Infectus/File/Bad_Block_DUMP.jpg>

Note in this example that the bad block information has been located
elsewhere, so you \*should\* be okay. Even so, it's advisable to run a
second dump through the utility and see whether this has a bad block
(and relocated) in the exact same address. If this is the case, you
should be good to go.

A good NAND dump might look like
this:

:\*<https://web.archive.org/web/20111202140910/http://www.infectus.biz/INFECTUS-BOOK/Tutorial_Eng/Xbox360/Timing_Attack_Infectus/File/Degraded_1.jpg>

If you get this, great :) Your NAND dump is about as good as it's gonna
be\!

**NAND Compare and Reconstruction Tool** A nice tool to check/verify
your Xbox 360 NAND dumps and potentially even repair them if you have at
least 3 'bad' dumps.

\- *compare 2 nand images*

better than simply using md5 as it tells you which blocks are
mismatched, which allows you to reread only those that are in error
rather than the entire chip (speeding up the process) one use of this is
when verifying a write by reading back the nand and comparing it against
the original you wrote, if you get a bad block just reread that
individual block, patch it into the full read and compare again (files
are reread each time you click compare, no need to reselect the same
files in the gui)

\- *reconstruct image from 3 bad reads*

assumes that read errors don't occur in same place each time, which is
true for some read errors (e.g. lpt timing problems), if there is a good
reason why you can't read something then this may not be true this tool
cannot recreate a nand out of nothing, if you give it 3 files full of
zeros you'll get a recreated nand full of zeros, always look at a dump
to make sure it looks correct (e.g. has a microsoft copyright at the
top, once you've reconstructed a nand open it in 360 flash tool and make
sure it reads ok there) the tool works by comparing blocks between the 3
files, any block found matching in 2 (or 3) of the files will be
considered good, you will be warned if not all blocks can be recovered,
in which case you'll need to get more reads or look for a good reason
why your reads are so bad

Official Site: [http://www.xboxhacker.net/index.php?topic=13208.0](https://web.archive.org/web/20160307182008/http://www.xboxhacker.net/index.php?topic=13208.0)

Download:
[http://dwl.xbox-scene.com/xbox360pc/nandtools/NandCompare-v1.3.rar](https://web.archive.org/web/20141025002121/http://dwl.xbox-scene.com/xbox360pc/nandtools/NandCompare-v1.3.rar)

(images taken from
[http://www.infectus.biz/INFECTUS-BOOK/Tutorial_Eng/Xbox360/Timing_Attack_Infectus/pag3.htm](https://web.archive.org/web/20111202155156/http://www.infectus.biz/INFECTUS-BOOK/Tutorial_Eng/Xbox360/Timing_Attack_Infectus/pag3.htm)\)