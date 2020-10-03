**XeLL** is the Xenon Linux Loader. It's a second-stage bootloader which
is loaded by a [loader](Run_Code "wikilink").

XeLL catches CPU threads, sets them up, loads an ELF file from either
network (tftp) or CDROM (ISO9660), and launches it. It's made to boot
linux. Thus it also contains a flat device tree for linux. However, it
should be able to load other ELF files as well, like apps based on
[libXenon](libXenon "wikilink").

[lwIP](https://en.wikipedia.org/wiki/LwIP) is used for networking. Network
config is currently hardcoded in network.c (and main.c), and probably
needs to be modified if you want to use it.

XeLL is in a very early stage, but is (most of the time) fully working.

XeLL is available at <https://github.com/Free60Project/xell>. There are
currently no binary releases of original XeLL.

**XeLLous** is an available modification of XeLL made by Redline99. It
support flashing full nand images (updflash.bin) and patchslots for
rebooter images (updpatch.bin) and includes a HTTP Server where you can
get your CPUKey and DVDKey (if KV is in place) and dump your nand.
XeLLous is availabe on xbins.

**XeLL Reloaded** (Codename: **2Stages**) is the recent branch of XeLL.
It consists of 2 stages: Stage 1 does the main low level hw init, loads
Stage 2 into memory and executes it. Stage 2 is built with libxenon -
ensures the latest codebase.
For all new features check the
README[1](https://github.com/Free60Project/xell/blob/2stages/README) You
can get the sourcecode of XeLL Reloaded from Free60 Sourceforge's GIT
aswell - branch: 2stages (which is the standard branch)
[2](https://github.com/Free60Project/xell)

### Building and running

0\. **Make sure** that you have a working [Cross
Compiler](Cross_Compiler "wikilink") toolchain and
[LibXenon](LibXenon "wikilink").

1\. **Grab** the sources from the git repository:

`   git clone ` <git://github.com/Free60Project/xell.git>

2\. **Compile it** using your cross compiler (depending on the name of
your cross compiler, you may have to adjust the name after CROSS=):

 `   cd xell`
If you want to build XeLL NON-2stages sourcecode:

 `   git checkout master`
Now compile it

 `   make CROSS=powerpc64-unknown-linux-gnu-`
3a. Use the [JTAG Hack](JTAG_Hack "wikilink") or [Reset Glitch
Hack](Reset_Glitch_Hack "wikilink")- you can even upgrade XeLL via USB.

3b. Deprecated: load **xell-readcd.bin** using the
[readcd](readcd "wikilink") method and a patched King Kong game.

3c. Deprecated: **use the serial loader** from Crawler360 to download
**xell-serial.bin** to your Xbox360 and run
it.

[Category: Xbox360_Homebrew_Software‏](Category_Xbox360_Homebrew_Software.md‏ "wikilink")
