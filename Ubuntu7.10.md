Install Ubuntu 7.10 from the Gentoo LiveCD

gnome Issue Resolved

**WARNING: This script will WIPE your Xbox 360 internal harddisk
(/dev/sda) and install Ubuntu 7.10**

**If you have XeXmenu or another dashboard homebrew on that drive, you
will loose it all: Follow these instructions only if you understand what
you are doing.**

I new boot disk that would allow the booting of a USB harddisk would
ease the risk of ruining your 360 harddrive.

ubuntu_gutsy.sh will create two partitions. 1 GB swap on sda0 and the
rest of the disk as a root-filesystem on sda1. Run the script as root
from the Gentoo LiveCD v2. You will need a DHCP-server on your network
for this script.

How do I run it?

Click "Application \> Accessories \> Terminal" and type the following
commands:

`sudo su`
`wget `<http://file.libxenon.org/free60/linux/script/ubuntu_gutsy.sh>
`sh ./ubuntu_gutsy.sh`

Reboot the 360 when you are told. Boot with
<http://file.libxenon.org/latest_kern>, supply correct "root=" parameter
via kboot.conf (\*kboot currently only supported via
xell-reloaded-testing builds), boot the kernel/system and login as root.
You will be asked to set new password. The rest of the installation will
start automatically. The download is about 600Mb. After a while it will
ask you to setup the screen resolution, select 1280x768 with the space
bar. If the display is garbled use 1024x768.

After it has finished installing and has rebooted into gnome open a new
shell by typing Ctrl+Alt+F6 or Ctrl+Alt+F1 and type,

` sudo dpkg-reconfigure xserver-xorg`

Then follow the instructions below.

1\. Attempt to autodetect video hardware? \> No

2\. X Server Driver: Xenonfb

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

(If Java is required, do not install the one in the default repository
as it is broken, to attempt to install it
<http://ubuntuforums.org/showthread.php?t=1116368> , or simply install
this
[http://3dslice.net/downloads/PrimeGen/ibm-j2sdk1.6_1.6.0_powerpc.deb](https://web.archive.org/web/20110810200730/http://3dslice.net/downloads/PrimeGen/ibm-j2sdk1.6_1.6.0_powerpc.deb)
)



ubuntu_gutsy.sh
\#\!/bin/bash

` # set the date to anything except 1/1/1970 since this causes issues`
` # time is now also set after first boot by .bashrc script below`
` date -s 1/1/2009`
` # if /dev/sda is mounted then paritions get wiped by dd but sfdisk fails!`
` swapoff /dev/sda1`
` umount /mnt/ubuntu`
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
` mkdir /mnt/ubuntu`
` mount /dev/sda2 /mnt/ubuntu`
` cd /mnt/ubuntu`
` mkdir /mnt/ubuntu/work`
` cd /mnt/ubuntu/work`
` # download extract and run debootstrap`
` wget `<ftp://old-releases.ubuntu.com/old-images/ubuntu/pool/main/d/debootstrap/debootstrap_1.0.3build1_all.deb>
` ar -xf debootstrap_1.0.3build1_all.deb`
` cd /mnt/ubuntu`
` zcat < /mnt/ubuntu/work/data.tar.gz | tar xv`
` export DEBOOTSTRAP_DIR=/mnt/ubuntu/usr/lib/debootstrap`
` export PATH=$PATH:/mnt/ubuntu/usr/sbin`
` debootstrap --arch powerpc gutsy /mnt/ubuntu `<ftp://old-releases.ubuntu.com/old-images/ubuntu/>
` # create needed files on hdd`
` echo Falcon > /mnt/ubuntu/etc/hostname`
` cat > /mnt/ubuntu/etc/fstab << EOF`
` /dev/sda2     /          ext3     defaults   0   0`
` /dev/sda1     none    swap    sw           0   0`
` proc            /proc    proc    defaults  0   0`
` EOF`
` cat > /mnt/ubuntu/etc/network/interfaces << EOF`
` iface lo inet loopback`
` auto lo`
` auto eth0`
` iface eth0 inet dhcp`
` EOF`
` cat > /mnt/ubuntu/etc/apt/sources.list << EOF`
` deb `<ftp://old-releases.ubuntu.com/old-images/ubuntu/>` gutsy main restricted universe multiverse`
` EOF`
` #Change root-pwd inside chroot`
` chroot /mnt/ubuntu echo "root:xbox" | chroot /mnt/ubuntu /usr/sbin/chpasswd`
` cp /mnt/ubuntu/root/.bashrc /mnt/ubuntu/root/.bashrc.orginal`
` # create .bashrc script on hdd`
` cat >> /mnt/ubuntu/root/.bashrc << EOF`
` date -s 1/1/2009`
` passwd`
` mkdir /lib/modules/2.6.24.3`
` touch /lib/modules/2.6.24.3/modules.dep`
` apt-get update`
` apt-get install ntp wget -y --force-yes`
` apt-get install ubuntu-desktop -y`
` echo "AVAHI_DAEMON_START=0" > /etc/default/avahi-daemon`
` /etc/init.d/networking restart`
` cd /usr/lib/xorg/modules/drivers/`
` wget -O xenosfb_drv.so `<http://file.libxenon.org/free60/linux/xenosfb/xenosfb_drv.so_gutsy>
` cd /etc/X11/`
` wget `<http://file.libxenon.org/free60/linux/xenosfb/xorg.conf>
` mv ubuntu.conf xorg.conf`
` cd /usr/lib/xorg/modules/linux/`
` mv libfbdevhw.so libfbdevhw.so.bk`
` wget -O libfbdevhw.so `<http://file.libxenon.org/free60/linux/xenosfb/libfbdevhw.so_gutsy>
` rm -r -f /work/`
` echo "" > /etc/gdm/gdm.conf-custom`
` sed -i 's/AllowRoot=false/AllowRoot=true/' /etc/gdm/gdm.conf`
` rm /root/.bashrc`
` mv /root/.bashrc.orginal /root/.bashrc`
` /etc/init.d/gdm start`
` EOF`
` # done`
` echo "Base installation completed."`
` echo "To finish the installation: Reboot and load the kernel with correct root= params."`
` echo "The install  may take up to two hours, depending on your internet connection"`

[Category:Xbox360_Linux](Category:Xbox360_Linux "wikilink")