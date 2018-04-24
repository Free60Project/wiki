This tutorial assumes that you already have [XeLL](XeLL "wikilink") and
[Xenon Toolchain](Xenon_Toolchain "wikilink").

## Install and Setup a NFS Server

To do this you may have to edit your kernel on your host machine to
enable nfs.
For **Gentoo**:
[Instructions](http://en.gentoo-wiki.com/wiki/NFS/Server).
For **Debian/Ubuntu**:
[Instructions](http://www.cyberciti.biz/faq/nfs4-server-debian-ubuntu-linux)
Your **/etc/exports** should look like this:

`/mnt/nfsroot 192.168.1.*(rw,no_root_squash,no_subtree_check,async) `

Change the IP scheme and path to fit your configuration.

Make the **/mnt/nfsroot** directory and copy the **image.squashfs**
(from a LiveCD) into it:

`mkdir /mnt/nfsroot`
`cp image.squashfs /mnt/nfsroot/`

Then extract the squashfs as root by doing:

`unsquashfs image.squashfs`

Now copy everything from the squashfs-root folder to **/mnt/nfsroot** by
typing:

`cd /mnt/nfsroot/squashfs-root && cp * -vaR /mnt/nfsroot`

**Alternative:** [Debootstrap](Debootstrap "wikilink") a fresh powerpc
system (debian/ubuntu) and use it as NFSroot.

Let the nfs-share re-export with:

`exportfs -ra`

## Compile the kernel that you want to use

### Get the kernel sources

You can get them from kernel.org 2.6.38.8 at time of writing (in the
future this might change)

### Get the patches and the kernel config

You can get them from
[here](http://sourceforge.net/projects/free60/files/Linux%20Kernel/).

**NOTE:** At the time of writing v0.11.1 was the latest. Make sure that
your kernel config and your patch are the same version.

### Extract the kernel

With the following command:

`tar -xvjf linux-2.6.38.8.tar.bz2`

### Patch the kernel

With the following
commands:

`cd linux-2.6.38.8`
`# assumes that the patch is in the directory above the kernel folder that you just changed into`
`patch -p1 --dry-run <../patch-2.6.38.8-xbox0.11.1.diff`
`# if the dry-run didn't show any errors do the following:`
`patch -p1 <../patch-2.6.38.8-xbox0.11.1.diff`

### Copy and Edit the kernel config file

Copy the kernel config to the extracted linux-kernel folder:

`# The '.' in front of the filename is there on purpose!`
`cp /path/to/xenon-config /path/to/extracted/linux-2.6.38.8/.config`

Look for a line similar to
this:

`CONFIG_CMDLINE="root=/dev/nfs video=xenonfb nfsroot=192.168.1.100:/mnt/nfsroot rw ip=dhcp panic=60"`

Edit the NFSroot to be your IP address and adjust the path correctly.

Alternative: Use [kboot.conf](kboot.conf "wikilink") to pass a custom
CMDLINE to the Server. If you want to do this you set:

`CONFIG_CMDLINE_BOOL=n`
`CONFIG_CMDLINE=n`

### Build the kernel

Do the following:

`make ARCH=powerpc CROSS_COMPILE=xenon- menuconfig`

Load up your config file that you just edited and then exit and run the
following command:

`make ARCH=powerpc CROSS_COMPILE=xenon- all`

You might get an error if so you might need to edit
arch/powerpc/kernel/pci_64.c line 149 and change the lh to llh both
occurrences.

Rerun the last command and you should have a kernel. It will be in
arch/powerpc/boot/zImage.xenon

## Configure Xell to boot from your computer via tftp

To do this you need to recompile Xell. I assume that you already have a
toolchain, I used the one from libxenon. You will need to edit the Xell
source file network.c changing the default IP address to your IP
address. Then compile Xell.

### Setup tftp

For **Gentoo** and 'atftpd' just type:

`emerge -v atftp `

Then edit the atftp config file:

`nano /etc/conf.d/atftp`

I changed mine to look like this:

`TFTPD_ROOT="/tftpboot" `

just edit this line and leave the rest the way it is as it is already
correct.

For **Debian/Ubuntu** use the following:
[Instructions](http://wiki.debian.org/PXEBootInstall?action=show&redirect=NetworkBooting)
(Sections: **Set up DHCP server** and **Setup a TFTP server**

When done with that make the matching tftp directory (if it doesn't
exist already) and put your linux-kernel into it, rename it **xenon**.

**NOTE**: XeLL assumes a path like **/tftpboot/xenon** in its standard
configuration. If your tftp-daemon has a path like
**/var/lib/tftpboot/** set up you need to make a subdir **tftpboot** in
there. Final path would look like:

`/var/lib/tftpboot/tftpboot/`

Now if everything worked correctly you should be able to boot your 360
via NFS.

**NOTE:** It's recommended that the TFTP-Server is the one who serves
the DHCP Responses and no other DHCP Server is in your network so XeLL
can find the TFTP Server Adress.

**NOTE(2):** it is also possible to do this without a (linux) dhcpd
server setup, using a router <b>if you have a router that supports
it</b> (ddwrt, cisco, possibly some residential grade routers) by
forwarding all tftp requests to your tftp server.

for ddwrt: enable DNSmasq

`    Go to your Web-Interface and log in`
`   Go to Setup->Basic Setup`
`       Make sure that`
`           DHCP Type = DHCP Server`
`           DHCP Server = Enable`
`           Use DNSMasq for DHCP = Checked`
`           Use DNSMasq for DNS = Checked `

Go to Administration-\>Services

`       LAN Domain = `<lan-name>
`       DNSMasq = Enabled`
`       Local DNS = Enabled`

in DNSmasq additional options:

`domain=lan-name-here`
`local=/lan-name-here/`
`expand-hosts`
`dhcp-option=66,"tftp-server-address-here"`

Or edit /tmp/dnsmasq.conf with the correct settings (the above settings)
*adding cisco conf next*