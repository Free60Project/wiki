libhomebrew is the idea to create an abstract homebrew library, unifying
access to different hardware, making it easy to port homebrew from one
console to another. Please help making this idea real\!

(Some more background about the idea can be found
[here](http://op-co.de/blog/posts/libhomebrew/))

## <span class="mw-headline"> libhomebrew: Basic Idea </span>

For every (hacked) hardware, there is a homebrew lib / toolchain:

  - [Libxenon](http://www.free60.org/LibXenon) for guess what ;)
  - [libogc](http://www.devkitpro.org/category/libogc/) for Wii,
    GameCube
  - [OpenXDK](https://sourceforge.net/projects/openxdk/) for Xbox 1
  - [devkitPro](http://www.devkitpro.org/) is a toolchain for GameBoy
    Advance, GP32, Playstation Portable and GameCube.
  - [SDL](http://www.libsdl.org/) is not technically a homebrew lib, but
    has been ported to many many platforms.
  - many others I forgot here

The point is: Every community is hacking their own homebrew library,
reinventing/forking functionality for libc, *peripherals* (USB, SD/SDHC,
NAND, ..), *functionality* (libz, libmad, ..), *storage* (FAT32),
*networking* (lwip, TCP/IP, DHCP, ...), etc.

**It would be really great to have a generic homebrew lib\!** Such a lib
would contain backends / modules / hardware abstraction layers, which
are specific to the hardware you want to deploy, and plentiful
functionality on top of these modules.

All it would take to support homebrew on a new device would be writing
some HAL code, et voila: all the homebrew apps based on libhomebrew run
on your new shiny device.

## <span class="mw-headline"> Scope </span>

Homebrew libraries tend to cover these common areas:

  - Input (joystick, buttons)
  - Graphics (2d, 3d -- framebuffer?)
  - Sound -- waveform, synthesized, mp3/ogg, etc
  - Storage -- FAT, SD
  - Networking -- TCP/IP, UDP
  - USB?

These would be good areas to start with.

## <span class="mw-headline"> What has to be done? </span>

First, we need some coders from different homebrew scenes to sit
together and find similarities in their projects.

Then we need them to write the codeÂ ;-)

Ok ok, all that needs to be done is an abstract interface *on top of the
existing homebrew libraries*. Thats not so much to do after all. Then we
can merge the different forks of generic functionality code together and
remove it from the backends. Easy, eh?

## <span class="mw-headline"> Why not taking Linux? </span>

That might actually be an option, however the Linux kernel is rather
bloated with its lengthy boot-up times, drivers for things you don't
quite need for homebrew and other aspects.

Plus, sometimes you want a base which is not locking you in on GPL.

However, you could add Linux as a HAL backend to libhomebrew instead\!

Linux advantage is there is already a lot of software available. So
getting the little stuff missing in Linux working -decent video driver
to get HDMI output and 1920x1080 support, initializing CPUs to
fullspeed, perhaps a nice, easy installer- will be a nice middle step
while we get better homebrew. XBox 360 Linux XMBC DVBT HD Tuner can be a
sexy combination that will take too much effort doing from scratch, for
example.

## <span class="mw-headline"> Why not taking L4? </span>

It has been suggested to use the [L4
Microkernel](http://en.wikipedia.org/wiki/L4_microkernel_family) for
aspects like multi-threading / scheduling / task switching. It has to be
evaluated if it is possible to add L4 as a library without building the
whole system on top of it.

## Why not taking Libpayload?

[Libpayload](http://www.coreboot.org/Libpayload) is part of the coreboot
project. It is an abstraction library meant for easy deployment of code
in boot-loader-comparable environments. It is focused mainly on x86, but
looks like a promising ground. It contains its own libc implementation,
whereas most homebrew projects are using newlib
instead.

[Category:Xbox360_Homebrew_Software](Category:Xbox360_Homebrew_Software "wikilink")
[Category:Xbox360_Development](Category:Xbox360_Development "wikilink")