**Free60** is a project towards porting GNU/Linux, BSD, Darwin and related open-source operating systems to the Microsoft Xbox 360 video game console.
	- 3-core **PowerPC**, **3.2** GHz
	- **512 MB** of RAM
	- **ATI** graphics
	- (optional) **20 GB** hard drive
	- **DVD** drive
	- 3x **USB** 2.0
	- 100 MBit **Ethernet**
	- **TV/VGA** support
## Status
### Run Code
You can run your own code on Xbox 360 systems with kernel versions 4532 and 4548. If you own a box manufactured before 2007, upgrade to one of these versions, but to no later one.

### Linux Bootloader
A preliminary second-stage boot loader exists.

### Linux Kernel
Patches for the Linux kernel to support a large part of the Xbox 360 hardware exist. As long as you're waiting for a convenient way to boot, you can set up your cross compiler environment.

#### Linux Distributions
Several [LiveCD](LiveCD.md) variants and installation howtos for [Debian-etch](Debian-etch.md), [Ubuntu7.04](Ubuntu7.04) and [Ubuntu7.10](Ubuntu7.10) are available.

## Documentation

### First Steps
Try it out now

How to test out linux (almost) without altering your system.

#### Hardware
- [CPU](CPU.md)
- [GPU](GPU.md)
- [R6T3](R6T3.md)

#### Software
- [Kernel](Kernel.md)
- [Hypervisor](Hypervisor.md)

#### Misc
- [Videos](Videos.md)
- [FAQ](FAQ.md)

## Communication
There are several ways for you to get in touch with the people behind Free60 and for sharing information between users. We are an open project and therefore explicitly invite anybody to contact us and to [help](Help.md).

### IRC
29 Sep 2007: 3D Acceleration work has started: tmbinc has released an initial version of his ['gpu' library](https://web.archive.org/web/20130224191548/http://debugmo.de/2007/09/fear-triangles/). It does not yet follow a standard API (like OpenGL), but allows you to play with the 3D GPU.

8 May 2007: Updated LiveCD ready: Stonersmurf mastered the updated [LiveCD](LiveCD.md) including the latest kernel patches. The [Download](http://downloads.sourceforge.net/free60/gentoo-livecd-xenon-beta-v2.iso) is 621MB in size. See the [Release Notes](http://sourceforge.net/project/shownotes.php?group_id=139616&amp;release_id=506402) for details. Here is the [Press Release](Press_Release_2007-05-08)

**1 May 2007: We now have a fix for Samsung users** We will soon release an updated [LiveCD](LiveCD.md). If you want to build your own kernel, see [Linux Kernel Development](Linux_Kernel_Development.md) for patches against linux-2.6.21.

**1 Apr 2007: X.org driver and a new LiveCD** No April Fools' Day joke. We have released a preliminary [X.org driver](http://sourceforge.net/project/showfiles.php?group_id=139616&amp;package_id=227107) and Cpasjuste has built a new [LiveCD](LiveCD.md) which makes use of it. Unfortunately, support for Samsung drives and sound drivers are still missing.

**30 Mar 2007: Gentoo Minimal LiveCD** Cpasjuste has combined the Kernel patches and latest Xell into a LiveCD. The [download](http://sourceforge.net/project/showfiles.php?group_id=139616) is about 90MB in size and since it uses the *readcd* boot method, you may soon be able to boot it without soldering a serial connection to your Xbox 360 mainboard.

**20 Mar 2007: Linux Bootloader available** tmbinc has come up with a [Linux Bootloader](Linux_Bootlader.md), which handles CPU initialization and loads the [Linux Kernel](Linux_Kernel.md) either from network or CDROM.

**8 Mar 2007: First Linux patchset available** Felix Domke posted a patchset for the [Linux Kernel 2.6.20 Kernel](Linux_Kernel.md) to the Linux-PPC mailing list.

**1 Mar 2007: Hypervisor privilege-escalation vulnerability** Some "Anonymous Hacker"; published a [security advisory](http://www.securityfocus.com/archive/1/461489) that will make it possible to run alternative operating systems on the Xbox 360.

**30 Dec 2006: Homebrew mock-up at 23C3** An "Anonymous Hacker" showed a Xbox 360 running unsigned code at 23C3 conference. See more in the [Videos](Videos.md) section.

**7 Mar 2006: CPU Datasheet** More great work from [Speedy22] this time he has created a datasheet for the Xbox 360's [CPU](CPU.md). It can be found [here](https://web.archive.org/web/20061022203457/http://www.dave-bell.co.uk/~speedy22/XBOX360cpu15data.pdf).

-----

Microsoft, Xbox, Xbox360 (and probably some more) are registered
trademarks by Microsoft Corp. No affiliation between the Free60 Project
and Microsoft Corp. exists or is implied. All other trademarks and
copyrights are property of their respective owners.

Please note that all information on this website is for informational
purpose only and is provided *AS IS*. Everything you do with this
information is on your own risk.

If you believe anything on this site violates any law or any of your
rights, please contact us so that we can find a quick solution.

*Everything done on this project is for the sole purpose of writing
interoperable software under Sect. 1201 (f) Reverse Engineering
exception of the DMCA.*

[Category:Template documentation](Category_Template_documentation.md "wikilink")
