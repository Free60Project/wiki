# DVD drive

The **DVD Drive** is used by the Xbox 360 for playing games, movies,
running executables, listening to music. The firmware of most **DVD
Drive**s can be modified to play backups, or aid in the running of
unsigned code.

## Models

There are at least four different types of DVD drives used in the 360:

  - Hitachi-LG GDR-3120L (Multiple ROM revisions)
  - Toshiba/Samsung TS-H943 (MS25 / MS28)
  - BenQ VAD6038
  - Lite-On DG16D2S

The model you get depends on where your Xbox was manufactured, when it
was manufactured, what batch it was in and a lot of other factors.

## General Information

![<File:Dvd>](../images/custom power connector.jpg)

Close-up of the custom power connector.

- The Xbox 360 was launched with a standard dual layer DVD-ROM drive
  manufactured by Hitachi-LG.
- The Xbox boots without any error when the DVD-ROM drive's SATA
  connector and power cable are not connected. However, the power
  light flashes rapidly, just like when the tray is ejecting.
- The drive uses the standard 7-pin Serial ATA connectors with a
  non-standard power connector (2×6 pins, roughly 2mm spacing; Molex
  Milli-Grid look similar, and Hirose make them, too).
- Xbox internally calls it `\\Device\\CdRom0\\`
- The raw file system ([XDVDFS](../XDVDFS)) on the disk is
  similar to the file system on the original Xbox disks. Multiple
  tools are out there that will extract raw ISOs.
- Modified firmware exists for every DVD Drive model, to allow playing
  backup games. (Unsigned code still can't be run)
- Two different DVD-ROM versions can be interchanged between Xbox 360s
  if the DVD key (stored in the drive firmware) is changed to match
  that of the target 360's original drive. Some
  [Kernel](../Kernel) versions (\>= 4532?) also require the
  drive to report as the same model as the original drive.

## Confirmed Facts

![<File:Dvdmobo.jpg>](../images/Dvdmobo.jpg)

Close-up of DVD-Drive Motherboard

- The main processor of the LG DVD-ROM drive is an Panasonic
  MN103S94FDA
- Although present on the disc, The BCA is not used as a security
  check.
- The XBOX 360 discs has a fake ToC (Table of Contents), containing
  only the video section. However, using a hotswap method, we can read
  a XBOX 360 disc using regular drive. First of all, we need to put a
  full 8.5GB disc in the drive, then we need to hotswap it by a XBOX
  360 disc (without eject, of course). With the right software, there
  is a way to backup XBOX 360 discs using regular DVD+R DL drive.

## Speculation

- A 12X DVD-ROM drive (DVD+R/RW) Single or dual-layer DVDs. The other
  supported formats are: CD-DA, CD-ROM, CD-R/RW, WMACD, MP3CD, JPEG
  Photo CD and original Xbox games for backwards compatibility.
- The DVD-ROM doesn't work on a standard PC workstation, yet.
- I found a very very thin ring on the underside of my DVD (PGR3).
  It's located at the inner part of the dvd, it's very very thin so
  you have to look very sharp for it\! Maybe this is the reason why
  the DVD laser can't read the data part. It reads the video part and
  then can't "jump" over the thin ring to read the data part.

## On-Disc format

![<File:Bca.jpg>](../images/Bca.jpg)

the 2 different sections and the BCA area of the DVD-ROM are visible
here.360 discs, like Xbox1 discs, have a lower number of sectors encoded
in their dvd structure data. This makes it "impossible" to access the
data after the "leadout" (or at least what is specified as leadout). The
"standard" area has 0xDB0 (~7MB) sectors, and contains DVD-Video data,
telling you that this is a game disc. Game data is stored at sector
offset 0x1FB20 (LBA), so it's "after the leadout". The data itself,
however, is stored dvd-compliant (standard ECC, standard seed, standard
EDC, standard sector layout. How boring.). If you can get your drive to
read past the specified end-of-disc, you can read the game data.

A specific sector region, between the standard-data and the beginning of
the game data can't be read. I guess this is the "ring" which is
visible. It probably contains empty/weak sectors (reading really broken
frames is always a bit difficult. Someone with the proper equipment
might want to check this).

![<File:Bcatest6.jpg>](../images/Bcatest6.jpg)

Evidence that the BCA is not used by the Xbox 360. The tools which can
be used for this are basically the same as for Xbox1, just that the data
offset was different there. There are "scene-tools" which are of course
so top secret that you never heard about them which can do this. They
can be hacked for xbox360 (by just modifiying the read offset), and
there you go.

(Of course the "how to get your drive's firmware to do this" is highly
off-topic here, but it usually boils down to using debug ATAPI command
to write in the drive's memory, then modifiying the drive's idea of the
"end-of-disc", then using normal read commands. Some others say just
opening up the DVD-Rom drive from inside out, Inserting a large DVD,
then lifting it up vertically to do not trigger the eject mode, and then
inserting a Original XBOX disc will also give you access)

[Category:Xbox360_Hardware](../Category_Xbox360_Hardware)
[Category:Pages with missing images](../Category_Pages_with_missing_images)