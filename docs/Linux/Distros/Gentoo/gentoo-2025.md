# gentoo-2025
Following https://github.com/SED4906/xenon-porting-notes/blob/main/README.md
Above incurs necessary background knowledge of Gentoo and cross compilation toolchains.
Reference also: https://wiki.gentoo.org/wiki/Crossdev#Manual_build

To begin a Gentoo host system is needed. It can be a hardware box or a virtual box. QEMU is not really welcome here due to speed and possible issues compiling with what will end up being a custom instruction set. 

Condensed steps from from to back:

On a Gentoo host:
1. `emerge --ask sys-devel/crossdev`
2. `emerge --ask app-eselect/eselect-repository`
3. `eselect repository create crossdev`
4. Copy SED4906's patch as per their instructions.
5. Run `crossdev --target powerpc64-unknown-linux-gnu`
This will take a while to complete the first stage of the build which is the construction of the cross compilation toolchain enabling the 360 platform specific instruction set to be emitted from the gcc compiler.
6. Once that finishes up then it's critical to copy the GCC patch to the destination directory in what will be the base system as per SED's notes. Failure to do this will result in a system that boots but is entirely unoptimized and will be perceivably slow as compared to one built correctly.
7. Edit `/usr/powerpc64-unknown-linux-gnu/etc/portage/make.conf` to add to CFLAGS: `-mcpu=cell -maltivec -mvmx128`.
8. Seed the system with: `USE=build emerge-powerpc64-unknown-linux-gnu -v1 baselayout`.
9. Then build glibc: `emerge-powerpc64-unknown-linux-gnu -v1 sys-libs/glibc`.
10. Run `PORTAGE_CONFIGROOT=/usr/powerpc64-unknown-linux-gnu eselect profile list` and then `set` a profile as needed. Prepending the variable `PORTAGE_CONFIGROOT` with each eselect command makes sure to select the profile within the new system as opposed to the host system.
10. Finally complete the base system compilation with: `emerge-powerpc64-unknown-linux-gnu -v1 @system`
11. Install remaining patches as per SED's notes - and any others you find or figure out along the way.
12. Install the portage tree with `emerge-powerpc64-unknown-linux-gnu --sync`

At this point one can proceed as they wish with configuring the system. In fact it is basically an unpacked stage 3 tarball within `/usr/powerpc64-unknown-linux-gnu`. This is what I have tested so far:
- `emerge-powerpc64-unknown-linux-gnu --ask xorg-server xf86-input-evdev xterm twm`

There is a major caveat: more complicated packages hate being cross compiled but may compile absolutely fine in a native environment. Some packages with cross compilation issues:
- librsvg
    - Goes into everything GTK related.
- rust and company
- qtcore specifically since it relies on a qt-specific bootstrap which fails in a crossdev environment

In cases like these or other annoying packages the options are either:
    - Compile it on the console
        - some packages may be impossible to compile on the console (looking at you, git) even with large swap space and zram due to resource constraints.
    - Compile it in QEMU
        - it's very slow but may be able to get around things that either fail cross compilation, or consume too many resources to be comppiled on the console.
`emerge`ing packages on the console will indeed work but may be extremely slow as compared to modern systems for certain packages. Make sure to set only `-j2 -l1` for `MAKEOPTS`. Although the processor has 6 threads available using any more than 1 I have found actually results in staggeringly worse compile times. The RAM quickly becomes saturated and most of the compile time is spent on swapping.

If using QEMU you want to observe this guide: https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_QEMU_user_chroot
Leaving the QEMU `FEATURES` in place is fine even to boot the system later on and compile packages.

After the system is configured to the heart's content it's not entirely done. A few finishing touches are needed before it can boot and be logged into. Essentially running through the Gentoo Installation Guide: https://wiki.gentoo.org/wiki/Handbook:PPC64/Installation/Base

- Map the necessary DNS config and mount points from host to guest with:
```
cp --dereference /etc/resolv.conf /mnt/nfsroot/etc/
mount --types proc /proc /mnt/nfsroot/proc
mount --rbind /sys /mnt/nfsroot/sys
mount --make-rslave /mnt/nfsroot/sys
mount --rbind /dev /mnt/nfsroot/dev
mount --make-rslave /mnt/nfsroot/dev
mount --bind /run /mnt/nfsroot/run
mount --make-slave /mnt/nfsroot/run

```
- `chroot` into the system 
- set a root password
- add a user
- set a hostname
- set network config
- set the date, time and timezone
    - install an NTP client like chrony
- install kernel modules from kernel build process to `/lib/modules` in the new system
- setup `/etc/fstab`
    - if booting from NFS, blank is fine.
- `rc-update add` any services desired
- Mandatory: setup `/etc/portage/make.conf` as a normal Gentoo system now, since GCC itself with the custom instructions enabled is now installed within the base system, CHOST, ROOT, and CBUILD variables are no longer needed. MAKEOPTS should be no more than 6. Retain the CFLAGS with optimizations enabled.
    - If you plan on compiling anything in the QEMU environment set `MAKEOTPS` as needed for your host system such as `-j20`, but remember to change it back to `-j1` later.

The system can now be booted on the console by any means. A sample kboot.conf for use with XeLL Reloaded and booting via NFS is below. Booting via NFS is advantageous since many packages may need to be rebuilt. The flat filesystem can just be chroot'd into while not mounted by the xbox at any time.

```
#KBOOTCONFIG
; #KBOOTCONFIG (and nothing else) has to stay in FIRST line of the file
; netconfig - only if the ip= is valid and isnt the same as eventually in the previously parsed kboot.conf, the netconfig gets set
; if netconfig values aren't set/set invalid/commented, XeLL will use: Either supplied DHCP address or if no DHCP available, static IP (192.168.1.99/255.255.255.0)
ip=192.168.1.190
netmask=255.255.255.0
gateway=192.168.1.1
; set custom tftp server IP
; incase no tftp_server= is set/set invalid/commented, XeLL will use: Supplied address via DHCP, if no DHCP available it will use 192.168.1.98
tftp_server=192.168.1.254
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
timeout=3
; Kernel / Bootentries
; ! first parameter: kernel path !
; maxcpu=6 is stable nowadays
; coherent_pool=16M recommended by Techflash to get graphical output sanity on 6.12
linux_nfs="/tftpboot/zImage.xenon root=/dev/nfs nfsroot=192.168.1.254:/mnt/nfsroot rw ip=192.168.1.190:192.168.1.254:192.168.1.1:255.255.255.0 console=tty0 maxcpus=6 coherent_pool=16M rootwait zswap.enabled=1 net.ifnames=0 biosdevname=0 video=xenos"
```

# Links

https://wiki.gentoo.org/wiki/Handbook:PPC64 - general install applicable to the console-side crossdev install once booted
https://wiki.gentoo.org/wiki/Crossdev#Manual_build - building the system that the console will boot
https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_QEMU_user_chroot - scamming "native" compiles by emulating the ppc64 processor environment
https://wiki.gentoo.org/wiki/Gentoo_Binary_Host_Quickstart - crossdev comes setup out of the box to build binpkgs, nfs is an easy winner for sharing packages (or SSH)

# Extras

sysctl.conf
vm.swappiness=200 - maximize swap usage
vm.min_free_kbytes=16384 - minimum free real memory
