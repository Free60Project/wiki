Install Debian Lenny from the Gentoo LiveCD

Warning: This script will WIPE your Xbox 360 harddisk (/dev/sda) and
install Debian Lenny

lennyinstall.sh will create two partitions. 1 GB swap on sda1 and the
rest of the disk as a root-filesystem on sda2. Run the script as root
from the Gentoo LiveCD v2. You will need a DHCP-server on your network
for this script.

How do I run it?

Click "Application \> Accessories \> Terminal" and type the following
commands:

` sudo su`
` wget `<https://web.archive.org/web/20141025060051/http://home.comcast.net/~ssmurf/lennyinstall.sh>
` sh ./lennyinstall.sh`

Reboot the 360 when you are told. Boot with
[http://home.comcast.net/~ssmurf/XeLL-Bootloader-sda2-v2.6.24.3.tar.gz](https://web.archive.org/web/20141025055552/http://home.comcast.net/~ssmurf/XeLL-Bootloader-sda2-v2.6.24.3.tar.gz)
and login as root. You will be asked for a new password. The rest of the
installation will start automatically. The download is about 600Mb.
Select xenosfb when the script asks for Xserver-driver.

Note: Currently unstable, resulted in xorg crashing and there is no
network activity. Debian Etch works, same with Ubuntu
7.10.
lennyinstall.sh

`   #!/bin/bash`
`   # set the date to anything except 1/1/1970 since this causes issues`
`   # time is now also set after first boot by .bashrc script below`
`   date -s 1/1/2009`
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
`   wget `<http://ftp.us.debian.org/debian/pool/main/d/debootstrap/debootstrap_1.0.23_all.deb>
`   ar -xf debootstrap_1.0.23_all.deb`
`   cd /mnt/debian`
`   zcat < /mnt/debian/work/data.tar.gz | tar xv`
`   cp /mnt/debian/usr/sbin/debootstrap /mnt/debian/usr/share/debootstrap     `
`   export DEBOOTSTRAP_DIR=/mnt/debian/usr/share/debootstrap`
`   export PATH=$PATH:/mnt/debian/usr/share/debootstrap`
`   debootstrap --arch powerpc lenny /mnt/debian `<ftp://mirrors.kernel.org/debian/>
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
`   deb `<ftp://mirrors.kernel.org/debian/>` lenny main contrib non-free`
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
`   cd /usr/lib/xorg/modules/drivers/`
`   rm -r -f *`
`   wget `<http://lilstevie.com/assets/xbox360/xenosfb_drv.so>
`   cd /etc/X11/`
`   rm -r -f xorg.conf`
`   wget `<https://web.archive.org/web/20141026190741/http://home.comcast.net/~ssmurf/xorg.conf>
`   mkdir /lib/modules/2.6.21.1`
`   touch /lib/modules/2.6.21.1/modules.dep`
`   echo "" > /etc/gdm/gdm.conf-custom`
`   sed -i '/security/ a\AllowRoot=true' /etc/gdm/gdm.conf`
`   sed -i 's/#LEDS=+num/LEDS=+num/' /etc/console-tools/config`
`   rm /root/.bashrc`
`   mv /root/.bashrc.orginal /root/.bashrc`
`   /etc/init.d/gdm start`
`   EOF`
`   echo "Base System Install Complete!"`
`   echo "You may now shutdown the xbox360."`
`   echo "Then continue the install by booting the Xell-Bootloader-sda2."`

[Category:Xbox360_Linux](Category_Xbox360_Linux)