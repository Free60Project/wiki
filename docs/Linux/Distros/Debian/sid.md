# Debian on the Xbox 360 in 2025 (Sid)

Big thanks to all of the wonderful people working on, with and adjacent to the Free60 Project for making this possible! These are the instructions that I have been following on my adventure running Linux on the 360 in 2025. It is not bulletproof as things are in constant change for now. The result is a Debian system that boots and you can install stuff on but is not optimized **at all**.

Special thanks:
TechFlash
rwf93
SED4906
InvoxiPlaysGames
quarky
tuxuser

## Kernel Compilation

**Note** If using the dockerized toolchain you must `apt install bc` to build the kernel within the container.

1. `git clone https://github.com/free60project/libxenon`
    - Check out the README there and set up the toolchain natively or for Docker as preferred.
2. Download the linux kernel source from: https://kernel.org - get version 6.16.X.
3. Clone the Free60 Linux patch set: `git clone https://github.com/free60project/linux-kernel-xbox360`
4. CD into that directory.
5. `cp linux-kernel-xbox360/xenon-6.16.9-defconfig .config`
6. Patch the kernel with `patch -p1 < ../linux-kernel-xbox360/patch-6.16-xenon.diff`
7. Configure the kernel with `make ARCH=powerpc CROSS_COMPILE=xenon- olddefconfig`
8. Compile the kernel with: `make ARCH=powerpc CROSS_COMPILE=xenon- all`
    - Pass `-j` to `make` to have it use more CPU cores. Such as `make -j6 ...`
9. When finished run `cp arch/powerpc/boot/zImage.xenon .`
10. This guide will focus on Debian. It may be preferable to build all the relevant .deb packages for the kernel, headers, and modules as well. This can be done with an additional command in the kernel source directory `make ARCH=powerpc CROSS_COMPILE=xenon- bindeb-pkg`.

At this point the kernel is compiled.

## XeLL Compilation

XeLL as the bootloader must be recompiled. The v0.993 release from years ago was built with the original toolchain and is
too old to boot any binaries built with newer toolchain. At present it is easiest to build XeLL with the Dockerized toolchain but it can also be done natively with the most up to date libxenon repo.

1. `docker run -it -v $PWD:/app free60/libxenon:latest`
2. `cd /app`
3. `make`

The resulting `.bin` files are the updated XeLL release artifacts. There are a few options now depending on preference:
    - rename xell-2f.bin to `xell.bin` and place it beside a XeLL Launch binary. *JTAG consoles*
    - rename xell-2f.bin to `updxell.bin` and place it on the root of a FAT32 formatted USB drive. Boot via the eject button for XeLL to auto update. *JTAG consoles*
    - rename xell-gggggg.bin to `xell.bin` and place it beside a XeLL Launch binary. *RGH consoles*
    - rename xell-gggggg.bin to `updxell.bin` and place it on the root of a FAT32 formatted USB drive. Boot via the eject button for XeLL to auto update. *RGH consoles*
    - rebuild the NAND with the appropriate xell image as it was done originally as per whatever instructions. *any console*

**Very important note here! Using `updxell` should be considered a last resort and only done if you have the hardware to undo it. In certain older builds of XeLL included with Jrunner this feature can brick the NAND!**

## Linux Installation

The kernel can be set up to boot a root filesystem on the Xbox 360 Xenon platform just like any other. Research the Linux
kernel documentation especially for the `boot=` and `root=` options for the kernel `cmdline`.

Any distro can be chosen that still supports PowerPC architectures. The Xbox 360 is capable of running both 64 and 32 bit operating systems.
It is worth noting however that distros that enable the `altivec` instruction set will not work without a patched GCC and binutils. Some 
distros that are known to work at time of writing:
    - ArchPOWER
        - Already works on Wii
    - Gentoo openrc ppc64
    - Debian sid ppc64

This guide will focus on Debian forky/sid ppc64 with systemd.

### Prerequisites

One must install these packages on their host operating system:
    - qemu
    - qemu-user-static
    - qemu-system-ppc
    - binfmt
    - debootstrap

### USB HDD Installation

Using a partition manager of choice plug in a USB HDD and wipe the entire disk. No need to zero it. Then set up the partition scheme as MBR and create three partitions on the disk.
    1. A 4GB primary partition at the beginning of the disk.
    2. An 8GB primary partition after that.
    3. The rest should be a primary partition.

Format the partitions like this:
    1. First partition = fat32
    2. Second partition = swap
    3. Final partition is ext4

Identify and mount the ext4 block device to a mountpoint such as `sudo mount /dev/sdb3 /mnt/debian360`.

1. Bootstrap the latest debian ppc system to that mount dir: `debootstrap --no-check-sig --arch ppc64 unstable /mnt/debian360 http://ftp.ports.debian.org/debian-ports/`
2. Run all this as one command to setup the chroot environment:
``` 
cp --dereference /etc/resolv.conf /mnt/debian360/etc/
mount --types proc /proc /mnt/debian360/proc
mount --rbind /sys /mnt/debian360/sys
mount --make-rslave /mnt/debian360/sys
mount --rbind /dev /mnt/debian360/dev
mount --make-rslave /mnt/debian360/dev
mount --bind /run /mnt/debian360/run
mount --make-slave /mnt/debian360/run
```
3. Chroot into the debian system with `chroot /mnt/debian360 /bin/bash`
4. Make sure the date is correct with `date -s`, then `source /etc/profile`.
5. Run `apt update` - you will get a keyring warning.
6. Run `apt install debian-ports-archive-keyring` to install the necessary keyring for gpg authentication of apt packages.
7. Run `apt update` again. The warning should be gone and apt packages able to be securely verified.
8. Set the system locale by `apt install locales` and then `dpkg-reconfigure locales` 
9. Edit `/etc/fstab` such as below - find your disk UUID with `blkid`:
```
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# BUP 1TB rootfs
UUID=b756a0b6-c31c-451c-9aa7-c026641edb47 /               ext4    errors=remount-ro 0       1
# BUP 1TB swap
UUID=d1faa05a-3975-43ae-8da1-31c30c2d966f none            swap    sw                0       0
```
10. `nano /etc/hostname` -> set a fun hostname.
11. `nano /etc/network/interfaces` -> set dhcp or set a static IP as desired.
```
# DHCP setup
auto eth0
iface eth0 inet dhcp
```
12. Set a root password with `passwd`.

Before exiting the chroot environment you can do anything you want - add packages, users, set up an SSH server, etc. Anything done in the chroot QEMU environment will not need to be done on the console itself. It is up to personal preference how to set up the system but steps 1-10 yield a basic bootable system suitable for initial testing.

An example `/etc/apt/sources.list` file:
```
deb [trusted=yes] http://deb.debian.org/debian-ports unstable main
deb [trusted=yes] http://deb.debian.org/debian-ports unreleased main
deb-src [trusted=yes] http://ftp.debian.org/debian sid main
```
13. Set up network time sync and timezone since the console clock is often unreliable.
```
apt install systemd-timesyncd
systemctl enable systemd-timesyncd
timedatectl set-timezone UTC
```

14. Exit the chroot environment and reboot the host operating system to undo all bind mounts. The rest of the configuration can be done on console. 
```
umount -l /mnt/debian360/dev{/shm,/pts}
umount -R /mnt/debian360
```

## KBoot configuration

On each console the detected devices will be different. You can however set KBoot up so that it boots the partuuid of a connected disk:
```
#KBOOTCONFIG
; #KBOOTCONFIG (and nothing else) has to stay in FIRST line of the file
; netconfig - only if the ip= is valid and isnt the same as eventually in the previously parsed kboot.conf, the netconfig gets set
; if netconfig values aren't set/set invalid/commented, XeLL will use: Either supplied DHCP address or if no DHCP available, static IP (192.168.1.99/255.255.255.0)
;ip=
;netmask=
;gateway=
; set custom tftp server IP
; incase no tftp_server= is set/set invalid/commented, XeLL will use: Supplied address via DHCP, if no DHCP available it will use 192.168.1.98
;tftp_server=
; XeLL's videomode - valid modes:
;  0: VIDEO_MODE_VGA_640x480
;  1: VIDEO_MODE_VGA_1024x768
;  2: VIDEO_MODE_PAL60
;  3: VIDEO_MODE_YUV_480P
;  4: VIDEO_MODE_PAL50
;  5: VIDEO_MODE_VGA_1280x768
;  6: VIDEO_MODE_VGA_1360x768
;  7: VIDEO_MODE_VGA_1280x720
;  8: VIDEO_MODE_VGA_1440x900
;  9: VIDEO_MODE_VGA_1280x1024
; 10: VIDEO_MODE_HDMI_720P
; 11: VIDEO_MODE_YUV_720P
; 12: VIDEO_MODE_NTSC
; If no value is set/set invalid/commented, XeLL will continue using the autodetected value
;videomode=
; speed up cpu - valid modes:
; 1: XENON_SPEED_FULL
; 2: XENON_SPEED_3_2
; 3: XENON_SPEED_1_2
; 4: XENON_SPEED_1_3
; If no value is set/set invalid/commented, XeLL won't change CPU Speed
speedup=1
; timeout of the bootmenu in seconds - timeout=0 skips user input completely!
timeout=30
; Kernel / Bootentries
; ! first parameter: kernel path !
; coherent_pool=16M recommended by Techflash to get graphical output sanity on 5.X and greater kernels
linux_usb_616_maxcpu="uda0:/vmlinux616 root=/dev/sdb3 rootfstype=ext4 console=tty0 panic=60 maxcpus=6 coherent_pool=16M rootwait video=xenosfb noplymouth"
```

## Boot and enjoy!

1. Place the kboot.conf file on the first partition of the USB HDD which is fat32. Place also the custom kernel with it's custom naming.
2. Boot from XeLL by a method of choice. Select the boot entry or let it time out.
3. That's it! Plug in a USB keyboard and enjoy! You're in Linux with a modern kernel and userland at this stage and the possiblities are endless. The base Gentoo install is only a shell with basic system tools and no GUI which can make the Xbox effective as a server.

### If there are boot issues

Most likely the root partition was not found. The kernel will try to help state what devices are plugged in with which UUIDs and detected partition formats. Use this to configure your kboot.conf and `/etc/fstab` file within the image as necessary. Generally this configuration will now hold until power is completely removed from the console. Each time the motherboard gets power USB devices are detected at random device IDs.

Power cycling the console fully by unplugging the power supply for a minute or so can help.

Checking the kernel output can also help.

## Further notes

https://wiki.debian.org/ZRam - Set up ZRAM in userland to maximize RAM usage. The 360 only has 512mb of RAM for retail, 1GB for X/eDK.
- Requires Linux kernel support for ZRAM built in. Simple edit to .config file. Also incurs needing to load the driver for it.
- RAM usage under load (compiling kernel with `make -j3`) memory usage is nearly max. OOM killer engages sometimes but things run OK. System is very sluggish feeling in general.

Compiling things on console from source with `make` usually benefits most from `-j2` in general. It's a balance. Higher jobs are more performant with ZRAM enabled.

Something at the 360 hardware level does not manage USB devices well. If you're not seeing a device reported by Linux, power cycle the console fully
for 30 seconds by unplugging the PSU.

libpixman-1-0 ships with altivec enabled, which doesn't work due to the 360s special flavor of the instruction set. Installing it from git after `./configure --disable-vmx` works fine after. 
    - `apt-src` is a good friend to have. Most packages can be entirely rebuilt as desired from source using this tool.
    - `grep -Ri altivec` for example in a Debian package source directory format will tell one how that particular package's build system wants a variable declared, how and where.

https://docs.mesa3d.org/install.html
This may be a lead on how to finally get some kind of acceleration working on 360 Linux.
Since the GPU accel already works in Libxenon in general, albeit requiring compiled shaders. Perhaps a rudimentary shader can be loaded and applied to all of Xorg to allow some GPU acceleration to happen broadly?'

Todo 
add to kboot PARTUUID of root = d7d4b5ef-02
