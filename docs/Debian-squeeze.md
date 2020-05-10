# Install Debian 6 "Squeeze" from a Linux LiveCD

**WARNING: This script will WIPE your Xbox 360 internal harddisk
(/dev/sda) and install Debian 6**

**If you have XeXmenu or another dashboard homebrew on that drive, you
will loose it all: Follow these instructions only if you understand what
you are doing.**

debian_squeeze.sh will create two partitions. 1 GB swap on sda1 and the
rest of the disk as a root-filesystem on sda2. Run the script as root
from the a Linux LiveCD. You will need a DHCP-server on your network for
this script.

How do I run it?

Click "Application \> Accessories \> Terminal" and type the following
commands:

`sudo su`
`wget `<http://file.libxenon.org/free60/linux/script/debian_squeeze.sh>
`sh ./debian_squeeze.sh`

Reboot the 360 when you are told. Boot with
<http://file.libxenon.org/latest_kern>, supply correct "root=" parameter
via kboot.conf (\*kboot currently only supported via
xell-reloaded-testing builds), boot the kernel/system and login as user:
xbox, password: xbox. Have fun :) (If you are not having fun, let us
know about the errors you are
experiencing.)

## debootstrapping script


debian_squeeze.sh
\#\!/bin/bash

` # set the date to anything except 1/1/1970 since this causes issues`
` # time is now also set after first boot by .bashrc script below`
` date -s 1/1/2009`
` # if /dev/sda is mounted then paritions get wiped by dd but sfdisk fails!`
` swapoff /dev/sda1`
` umount /mnt/debian`
` # partition and mkfs hdd (all data is lost!)`
` dd if=/dev/zero of=/dev/sda bs=512 count=1`
` sfdisk /dev/sda << EOF`
` ,124,S`
` ,,L`
` EOF`
` dd if=/dev/zero of=/dev/sda2 bs=512 count=1`
` mkfs.ext3 /dev/sda2`
` mkswap /dev/sda1`
` sync; sync; sync`
` swapon /dev/sda1`
` # setup paths`
` mkdir /mnt/debian`
` mount /dev/sda2 /mnt/debian`
` cd /mnt/debian`
` mkdir /mnt/debian/work`
` cd /mnt/debian/work`
` # download extract and run debootstrap`
` wget `<http://ftp.nl.debian.org/debian/pool/main/d/debootstrap/debootstrap_1.0.38_all.deb>
` ar -xf debootstrap_1.0.38_all.deb`
` cd /mnt/debian`
` zcat < /mnt/debian/work/data.tar.gz | tar xv`
` export DEBOOTSTRAP_DIR=/mnt/debian/usr/share/debootstrap`
` export PATH=$PATH:/mnt/debian/usr/sbin`
` debootstrap --arch powerpc squeeze /mnt/debian `<ftp://mirrors.kernel.org/debian/>
` # create needed files on hdd`
` echo Xenon > /mnt/debian/etc/hostname`
` cat > /mnt/debian/etc/fstab << EOF`
` /dev/sda2     /          ext3     defaults   0   0`
` /dev/sda1     none    swap    sw           0   0`
` proc            /proc    proc    defaults  0   0`
` EOF`
` cat > /mnt/debian/etc/network/interfaces << EOF`
` iface lo inet loopback`
` auto lo`
` auto eth0`
` iface eth0 inet dhcp`
` EOF`
` cat > /mnt/debian/etc/apt/sources.list << EOF`
` deb `<ftp://mirrors.kernel.org/debian/>` squeeze main contrib non-free`
` EOF`
` #Change root-pwd to "xbox" inside chroot`
` chroot /mnt/debian echo "root:xbox" | chroot /mnt/debian /usr/sbin/chpasswd`
` # Add user: xbox with password: xbox`
` chroot /mnt/debian /usr/sbin/useradd -m -d /home/xbox -p paRRy2CC47LXY xbox`
` # create .second_stage script on hdd`
` cat >> /mnt/debian/root/.second_stage << EOF`
` #!/bin/bash`
` date -s 1/1/2009`
` apt-get update`
` apt-get install ntp wget openssh-server locales -y --force-yes`
` dpkg-reconfigure locales`
` apt-get install gnome -y`
` echo "AVAHI_DAEMON_START=0" > /etc/default/avahi-daemon`
` /etc/init.d/networking restart`
` cd /usr/lib/xorg/modules/drivers/`
` wget -O xenosfb_drv.so `<http://file.libxenon.org/free60/linux/xenosfb/xenosfb_drv.so_squeeze>
` cd /etc/X11/`
` wget `<http://file.libxenon.org/free60/linux/xenosfb/xorg.conf>
` rm -r -f /work/`
` echo "Installation completed."`
` echo "To boot the system: Reboot and load the kernel with correct root= params."`
` echo "You should be greeted by a fresh install of Debian 6 Squeeze"`
` EOF`
` chmod a+x /mnt/debian/root/.second_stage`
` # Execute second part of installation in the chroot environment`
` mount -t proc none /mnt/debian/proc`
` mount --rbind /dev /mnt/debian/dev`
` cp -L /etc/resolv.conf /mnt/debian/etc/resolv.conf`
` chroot /mnt/debian /root/.second_stage`
` umount /mnt/debian/dev /mnt/debian/proc /mnt/debian`

## Fix possible xorg fail

After it has finished installing and has rebooted into gnome open a new
shell by typing Ctrl+Alt+F6 or Ctrl+Alt+F1 and type,

` sudo dpkg-reconfigure xserver-xorg`

Then follow the instructions below.

1\. Attempt to autodetect video hardware? \> No

2\. X Server Driver: Xenosfb

3\. Generic Video Card \> Enter

4\. Video card’s bus identifier: Press enter for default

5\. Amount of memory: Press enter for default

6\. Use kernel framebuffer device interface? \> Yes

7\. Autodetect keyboard layout? \> Yes

8\. Keyboard layout: us

9\. XKB rule set to use: xorg

10\. Keyboard model: choose your rule set based on the options

11\. Keyboard variant: leave blank if you’re in the U.S.

12\. Keyboard options: Leave as default

13\. Mouse Protocol: ImPS/2

14\. Emulate a 3 button mouse? \> Your choice

15\. Xorg server modules: Default

16\. Write default Files section to configuration file? \> Yes

17\. Attempt monitor detection? \> Yes

18\. Use generic monitor if it doesn’t detect it.

19\. Video modes to be used by the X server: 1280x768 (1024x768 if
garbled)

20\. Method for selecting the monitor characteristics: Medium

21\. Monitors best video mode: Choose what’s best for your monitor.

22\. Write monitor sync ranges to the configuration file? \> Yes

23\. Desired default color depth in bits: 24.

After that go back to gnome by typing Ctrl+Alt+F7.

Reboot X by typing Ctrl+Alt+Backspace.

[Category:Xbox360_Linux](Category_Xbox360_Linux)