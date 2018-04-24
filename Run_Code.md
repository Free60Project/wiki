**This is outdated\! Use [JTAG Hack](JTAG_Hack "wikilink") or [Reset
Glitch Hack](Reset_Glitch_Hack "wikilink")\!**

Thanks to the work of "Anonymous Hacker" and "Crawler360", it is now
possible to run your own code on an Xbox 360 with full (hypervisor)
privileges.

This page describes what you need in order to run your own code on your
Xbox 360.

## Kernel Version

`You need an Xbox with a kernel version of 4532 or 4548. `

You can check your kernel version in "System -\> Console Settings -\>
System Info". The line at the bottom contains your kernel version in the
format K:2.0.nnnn.0, where nnnn is your four digit kernel version.

If your kernel version is older, you can update to one of these
versions. Do not update to a version newer than 4548\! You won't be able
to downgrade\! If you already have a newer version, there is nothing you
can do right now.

If you buy an Xbox, make sure that its manufacturing date is before 09
January 2007, so that the kernel version is 4548 or older. You can see
the manufacturing date ("MFR Date") through the carton without opening
it.

If you have a pre-4532 kernel, you need to get the file
HD_DVD_10-2006.zip from somewhere, check the MD5SUM to be
cd4db8e2c94266ab73513c361dd5b8f6 (important\!), burn it to a CD, and
insert the CD into your Xbox 360. The program will update your machine
to kernel version 4532. This file is an authentic Microsoft update
application, but is not available on Microsoft's servers any more. If
you own an Xbox, it should be legal for you to download and run this
application. We are not linking to it here, but it is very easy to get.

In any case, you should remove the resistor R6T3 on the mainboard, to
prevent the efuse to be blown, which once blown is making downgrades to
\<4552 impossible.

## Modified Drive

The DVD drive in your Xbox 360 needs to be modified to report non-game
media as if it were game media. As this is the same modification that is
needed for running copied games, it won't be reproduced here. A lot of
good information on this is to be found elsewhere.

Please note that besides the potential illegal (check your country's
law\!) modification of the drive's firmware, you can also hotswap the
game disc after it has been authenticated.

## King Kong

You need a modified version of the game "King Kong" (either PAL or NTSC
version) on a DVD. Obviously, for legal reasons, you need to own the
game. Fortunately, the game has been one of the launch games, and used
copies are easily available and very affordable.

Since the information on how to dump a game can be used for piracy, it
won't be described here, but it is easily available elsewhere.

There are two King Kong patches available right now. The first was the
one by Crawler360: Launch the modified game, press START on the title
screen, and a very simple loader will be launched that allows uploading
your code through a serial cable. There is a newer patch in the wild by
xorloser, which allows booting directly from CDROM.

The patcher currently does not work with the newer "classics" version of
"King Kong" (barcode number 3 307210 240156), as it has a somewhat
different structure but the patcher looks at "hardcoded" positions in
the ISO - so it results in an "ID error" (you can check using a XDVDFS
dump - the new one includes e.g. a file called "GammaAdjust.raw" which
is not on the first and original DVD with barcode number 3 307210 206695
for the PAL version).

## Serial Cable

The loader from Crawler360 requires a serial cable as described in
Speedy22's docs. Note that the Xbox 360 serial port works with 3V levels
and cannot be attached to a PC serial port directly. Even if you are
working with xorloser's loader, a serial cable can be very useful for
debugging purposes.

[Category:Xbox360_Development](Category:Xbox360_Development "wikilink")
[Category:Xbox360_Homebrew_Software](Category:Xbox360_Homebrew_Software "wikilink")
[Category:Xbox360_Hardware](Category:Xbox360_Hardware "wikilink")
[Category:Support](Category:Support "wikilink")