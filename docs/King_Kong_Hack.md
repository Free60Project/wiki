# King Kong Hack (outdated)

## 1. You need an Xbox with a kernel version of 4532 or 4548

You can check your kernel version in "System -\> Console Settings -\>
System Info". The line at the bottom contains your kernel version in the
format K:2.0.nnnn.0, where nnnn is your four digit kernel version. The
kernel version can be older (lower number) than 4532 or 4548, but not
newer (higher number). If you already have a newer version, there is
nothing you can do right now. If you buy an Xbox, make sure that its
manufacturing date is before 09 January 2007, so that the kernel version
is 4548 or older. You can see the manufacturing date ("MFR Date")
through the carton without opening it. Note, I have just got a new UK
core pack with a MFG date of 19th June 2007, with all the new heatsink
inside and the kernel version was one of the 2000 ones, so very old
kernel on brand new xbox 360s. Note, I have just bought a premium pack
with a MFG date of 16th May 2006, and the kernel version was 5759, so a
new kernel on a 2006's Xbox 360.

Source: [Run_Code](../Run_Code)

## 2. Upgrading the kernel to 4532

If your kernel version is older than 4532 or 4548, you can update to one
of these versions. Do not update to a version newer than 4598\! You
won't be able to downgrade\! If you have a pre-4532 kernel, you need to
get the file HD_DVD_10-2006.zip, check the MD5SUM to be
cd4db8e2c94266ab73513c361dd5b8f6 (important\!), burn it to a CD, and
insert the CD into your Xbox 360. The program will update your machine
to kernel version 4532. This file is an authentic Microsoft update
application, but is not available on Microsoft's servers any more. If
you own an Xbox, it should be legal for you to download and run this
application. IMPORTANT: If you use a HDD and previously canceled a XBOX
Live Update request, then you must remove the HDD to prevent the Kernel
updater using the cached Kernel Updater, which is newer then the Kernel
4532\! If you don't remove the HDD, then the Kernel Updater will use the
cached Kernel Updater from the HDD and not from the CD\!

Source: [Run_Code](../Run_Code)

Download: [Here](http://www.360mods.net/Downloads/details/id=76.html)

## 3. Flashing the DVD-ROM Drive

Different tactics depending on the DVD model in your box. There are some
excellent Firmware Flashing Tutorials on the net, which we won't link
here for site policy reasons. This does mean opening your Xbox 360 as
such warranty is void, Microsoft are known to be working on a way of
checking this and banning any flashed Xbox 360's from Xbox Live.

## 4. Buy King Kong and make an image

There are two versions of King Kong available. The patcher currently
does not work with the newer "classics" version of "King Kong". If in
doubt, buy the oldest version you can get. Backing up won't be covered
here for site policy reasons, but the net is your friend again.

## 5. Patch your King Kong image

There are two King Kong patches available right now. The first was the
one by Crawler360: Launch the modified game, press START on the title
screen, and a very simple loader will be launched that allows uploading
your code through a [serial cable](../Serial_Console). There is
a newer patch in the wild by xorloser, which allows booting directly
from CDROM.

Patch your King Kong ISO with either the windows exe or compile the
source for Linux. If you're using the windows patch, you will need to
download cygwin1.dll and put it into your windows/system32 folder. Then
make sure shader.bin, the exe, and your King Kong ISO are in the same
folder and run: win_patch.exe <name of iso> or ./linux_patch
<name of iso> After your ISO is patched, burn it like a normal game.

Source: Included readme

Download:
[Here](http://www.mydedibox.fr/~free60/get_file.php?file=KK_Shader_Exploit_XELL_READCD.zip)

### 6. Get Linux

”This LiveCD is based on the BETA Gentoo LiveCD. It includes our X.org
framebuffer driver and a Gnome Desktop environment. Download size is
around 600MB.”

Use the BETA v2 release or later in case you have a Samsung drive.
Hitachi drive users do not need to care. You may use re-writeable medias
for the distributions as they may improve now in short distances... :-)

Source: LiveCD

Download:
[Here](http://downloads.sourceforge.net/free60/gentoo-livecd-xenon-beta-v2.iso)

### 7. Get it started

Switch on your Xbox 360, and load up the patched King Kong, and press
**start** on the title screen. Wait until the tray opens. Insert the
Linux CD. Close the tray. A few second later, you should be greeted by
some penguins.

### 8. Install it to Harddisk (optional)

Guide: [Here](https://web.archive.org/web/20100315185435/http://forums.xbox-scene.com/index.php?showtopic=595543

[Debian etch](../Debian-etch) install Script (Recommended)

[Ubuntu 7.10](../Ubuntu7.10) install Script

[Category: Support](../Category_Support)
