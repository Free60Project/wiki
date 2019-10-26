There is a set of 7 patches available sent to the linuxppc mailing list
on 08 March 2007, which have to be applied to Linux 2.6.20. If you're
interested in kernel development and/or adding new features, please take
a look at [Linux Kernel
Development](Linux_Kernel_Development "wikilink").

  - [(patch 1/7) xenon: add PCI Vendor ID:
    Microsoft](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032705.html)
  - [(patch 2/7) xenon: add platform
    support](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032704.html)
  - [(patch 3/7) xenon: udbg support
    (ugly)](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032701.html)
  - [(patch 4/7) xenon: add southbridge ethernet
    support](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032703.html)
  - [(patch 5/7) xenon: add SATA
    support](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032702.html)
  - [(patch 6/7) xenon: add SMC
    support](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032707.html)
  - [(patch 7/7) xenon: add framebuffer support
    (ugly)](http://ozlabs.org/pipermail/linuxppc-dev/2007-March/032708.html)

To run linux, you need to use the [Linux
Bootloader](Linux_Bootloader "wikilink") available right now. To compile
the kernel, you need to set up a \[cross compiler\] toolchain (unless
you already have another PowerPC Linux machine).

## Prerequisites

The minimal requirements for successfully cross compiling the Linux
Kernel for your Xbox are (unverified):

  - A machine running a Linux based OS (most likely your PC)
  - Sources for the [Linux Kernel](http://www.kernel.org)
  - The Xenon patch or patchset
  - Binutils (targeting the powerpc architecture)
  - GCC (targeting the powerpc architecture)

## Configuring and Compiling the Kernel

1.  Get the source for the Kernel from
    [kernel.org](http://www.kernel.org) and unpack
it.

<code>

`   cd`
`   wget `<http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.21.tar.bz2>
`   tar -xvjf linux-2.6.21.tar.bz2`

</code>

2.  Download and apply the Xenon patch/patchset matching your
kernel.

<code>

`   cd linux-2.6.21/`
`   for patch in pci_ids.h.diff linux-2.6.21-xenon-cpu.diff linux-2.6.21-xenon.diff \`
`                linux-2.6.21-xenon-enet.diff linux-2.6.21-xenon-platform.diff \`
`                linux-2.6.21-xenon-sata.diff linux-2.6.21-xenon-smc.diff \`
`                linux-2.6.21-xenon-ugly-fb.diff linux-2.6.21-xenon-ugly-udbg.diff \`
`                interlace.diff ; do`
`           wget `<http://op-co.de/xbox360/2.6.21/$patch>
`           patch -p1 < $patch`
`   done`

</code>

3.  Configure the Kernel. You can manually fetch a configuration file
    from the internet (e.g. here) and
type:

<code>

`   make ARCH=powerpc CROSS_COMPILE=powerpc64-unknown-linux-gnu- oldconfig`

</code>

  -
    Of course, you can fine-tune your Kernel configuration to fit your
    needs
using

<code>

`   make ARCH=powerpc CROSS_COMPILE=powerpc64-unknown-linux-gnu- menuconfig`

</code>

4.  Build the Kernel by typing:

<code>

`   make ARCH=powerpc CROSS_COMPILE=powerpc64-unknown-linux-gnu- all`

</code> If everything goes well, you will end up with a file
arch/powerpc/boot/zImage.xenon containing the kernel which can be loaded
by the [XeLL](XeLL "wikilink").

## Configuring and Compiling the 2.6.38.8 Kernel (experimental)

[Patches for recent
kernels](http://sourceforge.net/projects/free60/files/Linux%20Kernel)
are available now, but considered highly experimental.

1.  Get the source for the Linux 2.6.38.8 Kernel from kernel.org and
    unpack
it.

<code>

`   wget `<http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.38.8.tar.bz2>
`   tar -xvjf linux-2.6.38.8.tar.bz2`

</code>

2.  Download and apply the experimental Xenon patch & kernel
config.

<code>

`   wget -O xenon_config `<http://sourceforge.net/projects/free60/files/Linux%20Kernel/xenon_config/download>
`   wget -O patch-2.6.38.8-xbox0.11.1.diff `<http://sourceforge.net/projects/free60/files/Linux%20Kernel/v2.6.38/patch-2.6.38.8-xbox0.11.1.diff/download>
`   cd linux-2.6.38.8/`
`   patch -p1 < ../patch-2.6.38.8-xbox0.11.1.diff`
`   cp ../xenon_config .config`

</code>

3.  Configure the
Kernel.

<code>

`    make ARCH=powerpc CROSS_COMPILE=powerpc64-unknown-linux-gnu- menuconfig`

</code>

4.  Build the Kernel by typing:

<code>

`   make ARCH=powerpc CROSS_COMPILE=powerpc64-unknown-linux-gnu- all`

</code>

If everything goes well, you will end up with a file
arch/powerpc/boot/zImage.xenon containing the kernel which can be loaded
by the XeLL.

Remember, these patches are Experimental\!

## Rootfilesystem via NFS

1.  Configure the kernel (CONFIG_CMDLINE in .config) for NFS (see
    [NFS-Tutorial](NFS_Root "wikilink") for details) to match your local
    setup.
      -
        *example:* CONFIG_CMDLINE="root=nfs video=xenonfb console=tty0
        nfsroot=192.168.1.1:/mnt/nfsroot/xbox rw ip=dhcp"
2.  Make sure that the IP Plug and Play (CONFIG_IP_PNP\* in .config)
    options match your ip setup method.

## Pre-compiled Kernels

[http://home.comcast.net/~ssmurf/XeLL-Bootloader-sda2-v2.6.24.3.tar.gz](https://web.archive.org/web/20141025055552/http://home.comcast.net/~ssmurf/XeLL-Bootloader-sda2-v2.6.24.3.tar.gz) \(archive.org)

[Category:Xbox360_Linux](Category:Xbox360_Linux "wikilink")