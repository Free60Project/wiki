# ARCHPower on the 360 in 2025

TechFlash has packaged the Xenon Linux kernel into ARCHPower in 2025. This guide will walk a user setting up ARCHPower for booting via XeLL. The resulting system is powerpc32 big endian. While the Xenon CPU is ppc64 software support for ppc32 is generally a bit better.

## Prerequisites

### Xenon Linux Loader (XeLL / Bootloader)

XeLL as the bootloader must be updated. The v0.993 release from years ago was built with the original toolchain and is
too old to boot any binaries built with newer toolchain. At present it is easiest to build XeLL with the Dockerized toolchain but it can also be done natively with the most up to date libxenon repo with these steps below. For further information about the Xenon Toolchain see https://github.com/Free60Project/libxenon

1. `docker run -it -v $PWD:/app free60/libxenon:latest`
2. `cd /app`
3. `make`

The resulting `.bin` files are the updated XeLL release artifacts. There are a few options now depending on preference:

- rename xell-2f.bin to `xell.bin` and place it beside a XeLL Launch binary. *JTAG consoles*
- rename xell-2f.bin to `updxell.bin` and place it on the root of a FAT32 formatted USB drive. Boot via the eject button for XeLL to auto update. *JTAG consoles*
- rename xell-gggggg.bin to `xell.bin` and place it beside a XeLL Launch binary. *RGH consoles*
- rename xell-gggggg.bin to `updxell.bin` and place it on the root of a FAT32 formatted USB drive. Boot via the eject button for XeLL to auto update. *RGH consoles*
- rebuild the NAND with the appropriate xell image as it was done originally as per whatever instructions. *any console*

**Very important note here!** Using `updxell` should be considered a last resort and only done if you have the hardware to undo it. In certain older builds of XeLL included with Jrunner this feature can brick the NAND! Additionally, users of BadUpdate variants should avoid ever writing the NAND in general.

## USB HDD Installation

Using a partition manager of choice plug in a USB HDD and wipe the entire disk. No need to zero it. Then set up the partition scheme as MBR and create three partitions on the disk.
1. A 4GB primary partition at the beginning of the disk.
2. An 8GB primary partition after that.
3. The rest should be a primary partition.

Format the partitions like this:
1. First partition = fat32
2. Second partition = swap
3. Final partition is ext4

Identify and mount the ext4 block device to a mountpoint such as `sudo mount /dev/sdb3 /mnt/archpower`.

Get the pacman.conf file here to your disk: https://cdn.discordapp.com/attachments/1415992252940947509/1450595617146408960/pacman.conf?ex=694861f1&is=69471071&hm=aed030ad30d16ea88d06252ca3815398938a69ce8d1ad23debfdbe8aefb0805c&

Follow these steps to install ARCHPower to the external disk that will be booted by the 360. These steps assume Arch Linux is being used as the host operating system or otherwise your environemnt is set up to bootstrap Arch Linux.
1. `pacstrap -KMC /PATH/TO/PACMAN.CONF /PATH/TO/TARGET_DISK_PARTITION base archpower-keyring linux-xenon networkmanager vim nano less wget openssh`
2. `arch-chroot /PATH/TO/TARGET_DISK_PARTITION`
3. `pacman-key --init`
4. `pacman-key`
5. `passwd` -> set a root password.
6. `echo 'hostname-for-console' > /etc/hostname`
7. `systemctl enable NetworkManager`
8. `systemctl enable systemd-timesyncd`
9. `systemctl enable getty@tty1.service`
10. `sed  -i 's/ENCRYPT_METHOD YESCRYPT/ENCRYPT_METHOD SHA256/' /etc/login.defs` -> optional but recommended for speeding up logins.
11. `exit` -> return to your host OS.

Before booting you will need copy the kernel from the Arch system on the USB disk ext4 partition to the fat32 partition.
```
cp /usr/lib/modules/{version}/zImage.xenon /mnt/{name}/vmlinuz-linux-xenon
```

## Booting on the console

On the fat32 partition created earlier, make a file named `kboot.conf` with at least these contents to instruct XeLL how and where to boot the install:
```
#KBOOTCONFIG
; That is important! Else XeLL will not like it (reference kboot.c).
timeout=100        ; In seconds
speedup=1          ; Full speed CPU
linux_hdd="uda1:/vmlinuz-linux-xenon root=/dev/sda1 rw console=tty0 console=ttyS0,115200n8 panic=60 coherent_pool=16M" ; Linux kernel entry
```
**NOTE**: the final line will take some tuning unless you supply `root=PARTUUID=partuuid-02` as an example to definitively boot the detected device with this UUID. Identify the PARTUUID of your boot disk (NOT the filesystem UUID) using the `mount` command while the 360 boot drive is still plugged into the host OS. Otherwise if you are using the 360 SATA bay it is pretty good about being `sda`, but each *hard* power cycle of the 360 may vary.

Boot your console to XeLL via any means available and enjoy ARCHPower! The rest of normal Arch Linux system setup and config can take place on the console itself with an attached keyboard.

## If there are boot issues

Most likely the root partition was not found. The kernel will try to help state what devices are plugged in with which UUIDs and detected partition formats. Use this to configure your kboot.conf and `/etc/fstab` file within the image as necessary. Generally this configuration will now hold until power is completely removed from the console. Each time the motherboard gets power USB devices are detected at random device IDs.

Power cycling the console fully by unplugging the power supply for a minute or so can help.

Checking the kernel output can also help.
