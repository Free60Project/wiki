Xenosfb - Framebuffer Device Driver for Xbox 360 Xenos graphics chipset

This X.org device driver supports the Xenos graphics chipset as it is
built into the Microsoft Xbox 360 gaming console. It is based on the
X.org fbdev generic framebuffer device driver. Thus, it relies on the
fbdevhw driver as well as a working frambuffer device within /dev.

This driver is in a very early stage and does only support graphics
access through the framebuffer kernel device. No 2D or 3D acceleration
is supported and changing resolution at runtime does not work. Currently
the screen resolution is inherited from the settings in the Xbox 360
Dashboard.

Please note that all hardware information that was used to develop this
driver has been gained solely by reverse engineering and trial and
error. No official documentation or SDK has been used.

## Compiling

It has following dependencies:

  - libtool
  - m4
  - automake
  - autoconf
  - pkg-config
  - xorg-dev
  - xutils-dev
  - x11-xserver-utils
  - x11proto-randr-dev
  - libxrandr-dev

Probably some of these packages contain each other.

Extract the sourcecode and make sure autogen.sh has the executable flag
set. Start the compiling process by executing

`./autogen.sh`

After successful Compiling you will find the driver-module in
*\*builddir\*/src/.libs/xenosfb_drv.so* Copy it to
*/usr/lib/xorg/modules/drivers/* Also make sure */etc/X11/xorg.conf*
holds at least the following:

`Section "Device"`
` Identifier    "Generic Video Card"`
` Driver        "xenosfb"`
` Option        "UseFBDev"      "true"`
`EndSection`

[Category:Xbox360_Development](Category:Xbox360_Development "wikilink")
[Category:Xbox360_Linux](Category:Xbox360_Linux "wikilink")