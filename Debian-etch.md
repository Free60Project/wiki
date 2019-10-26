Install Debian Etch from the Gentoo LiveCD

Warning: This script will WIPE your Xbox 360 harddisk (/dev/sda) and
install Debian Etch

debianinstall.sh will create two partitions. 1 GB swap on sda1 and the
rest of the disk as a root-filesystem on sda2. Run the script as root
from the Gentoo LiveCD v2. You will need a DHCP-server on your network
for this script.

How do I run it?

Click "Application \> Accessories \> Terminal" and type the following
commands:

Note: Do not use this, use the modified bash code posted at the bottom
of this page.

` sudo su`
` wget `<https://web.archive.org/web/20121104151039/http://home.comcast.net/~ssmurf/debianinstall.sh>
` sh ./debianinstall.sh`

Reboot the 360 when you are told. Boot with
[http://home.comcast.net/~ssmurf/XeLL-Bootloader-sda2-v2.6.24.3.tar.gz](https://web.archive.org/web/20141025055552/http://home.comcast.net/~ssmurf/XeLL-Bootloader-sda2-v2.6.24.3.tar.gz)
and login as root. You will be asked for a new password. The rest of the
installation will start automatically. The download is about 600Mb.
Select xenosfb when the script asks for
Xserver-driver.

debianinstall.sh

`   #!/bin/bash`
`   dd if=/dev/zero of=/dev/sda bs=512 count=1`
`   sfdisk /dev/sda << EOF`
`   ,124,S`
`   ,,L`
`   EOF`
`   mkfs.ext3 /dev/sda2`
`   mkswap /dev/sda1`
`   sync; sync; sync`
`   swapon /dev/sda1`
`   mkdir /mnt/debian`
`   mount /dev/sda2 /mnt/debian`
`   cd /mnt/debian`
`   mkdir /mnt/debian/work`
`   cd /mnt/debian/work`
`   wget --no-check-certificate `<https://www.securehost.com/mirror/debian/pool/main/d/debootstrap/debootstrap_0.3.3.2etch1_all.deb>
`   ar -xf debootstrap_0.3.3.2etch1_all.deb`
`   cd /mnt/debian`
`   zcat < /mnt/debian/work/data.tar.gz | tar xv`
`   export DEBOOTSTRAP_DIR=/mnt/debian/usr/lib/debootstrap`
`   export PATH=$PATH:/mnt/debian/usr/sbin`
`   debootstrap --arch powerpc etch /mnt/debian `<ftp://archive.debian.org/debian/>
`   echo Xenon > /mnt/debian/etc/hostname`
`   cat > /mnt/debian/etc/fstab << EOF`
`   /dev/sda2     /          ext3     defaults   0   0`
`   /dev/sda1     none    swap    sw           0   0`
`   proc            /proc    proc    defaults  0   0`
`   EOF`
`   cat > /mnt/debian/etc/network/interfaces << EOF`
`   iface lo inet loopback`
`   auto lo`
`   auto eth0`
`   iface eth0 inet dhcp`
`   EOF`
`   cat > /mnt/debian/etc/apt/sources.list << EOF`
`   deb `<archive.debian.org/debian/>`  etch main contrib non-free`
`   EOF`
`   #Change root-pwd inside chroot`
`   chroot /mnt/debian`
`   echo -e "xbox\nxbox" | (passwd --stdin $USER)`
`   exit`
`   cp /mnt/debian/root/.bashrc /mnt/debian/root/.bashrc.orginal`
`   cat >> /mnt/debian/root/.bashrc << EOF`
`   passwd`
`   apt-get update`
`   apt-get install ntp wget -y --force-yes`
`   apt-get install x-window-system -y --force-yes`
`   aptitude install gnome -y`
`   apt-get install build-essential firefox gftp khexedit console-tools -y --force-yes`
`   echo "AVAHI_DAEMON_START=0" > /etc/default/avahi-daemon`
`   /etc/init.d/networking restart`
`   cd /usr/lib/xorg/modules/drivers/`
`   rm -r -f *`
`   wget `<https://web.archive.org/web/20141026185511/http://home.comcast.net/~ssmurf/xenosfb_drv.so>
`   cd /etc/X11/`
`   rm -r -f xorg.conf`
`   wget `<https://web.archive.org/web/20141026185511/http://home.comcast.net/~ssmurf/xenosfb_drv.so>
`   mkdir /lib/modules/2.6.21.1`
`   touch /lib/modules/2.6.21.1/modules.dep`
`   echo "" > /etc/gdm/gdm.conf-custom`
`   sed -i '/security/ a\AllowRoot=true' /etc/gdm/gdm.conf`
`   sed -i 's/#LEDS=+num/LEDS=+num/' /etc/console-tools/config`
`   update-rc.d -f hwclock.sh remove`
`   update-rc.d -f festival remove`
`   update-rc.d -f portmap remove`
`   update-rc.d -f cupsys remove`
`   update-rc.d -f spamassassin remove`
`   update-rc.d -f alsa-utils remove`
`   rm /root/.bashrc`
`   mv /root/.bashrc.orginal /root/.bashrc`
`   /etc/init.d/gdm start`
`   EOF`
`   echo "Base System Install Complete!"`
`   echo "You may now shutdown the xbox360."`
`   echo "Then continue the install by booting the Xell-Bootloader-sda2."`

[Category:Xbox360_Linux](Category:Xbox360_Linux "wikilink")