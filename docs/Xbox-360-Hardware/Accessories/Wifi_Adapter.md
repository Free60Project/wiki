# Introduction

![Back of the Wireless LAN adapter](/images/Noimage.png) <!-- Needs a new photo -->

FCC ID:C3K-WKS168
IC: 3048A-WKS168

The [Wireless Network Adapter](https://web.archive.org/web/20150226023206/http://www.xbox.com:80/en-US/xbox-360/accessories/cablesnetworking/Xbox360WirelessNNetworkingAdapter)
is a dual-band (2.4/5GHz) 802.11a/b/g interface for the Xbox 360.

This is a standard USB 2.0 device, and although it is designed to clamp
onto the back of the console, it works when plugged into a standard USB
port, given your operating system has accompanying device drivers. See
below.

# Disassembly

[All Pieces of the Wifi Adapter Laid out](/images/Noimage.png) <!-- Needs a new photo -->

Disassembled; bottom and top covers, PCB, USB cable and antenna

[Wireless LAN Adapter Opened (Back)](/images/Noimage.png) <!-- Needs a new photo -->

PCB underside, with [Hannstar Board Corp.](http://www.hannstarboard.com/wps/wcm/connect/english/tw) inscription.

# Integrated Circuits

[Wireless LAN Adapter Opened (Front)](/images/Noimage.png) <!-- Needs a new photo -->

PCB upper-side, showing the major ICs

## Marvell MVPG16

`MG16R`
`00A2R`
`521AC`

The MVPG16 is an integrated DC-DC synchronous step-down switching
regulator. Input voltage ranges from 3.0V-5.5V. Output voltage ranges
from 0.72V-3.63V and is user-programmable via a single external
resistor.

There's no readily available datasheet for this particular IC, however,
one for it's modular *MDx-G16* counterpart is, for
[download](https://web.archive.org/web/20071005220740/http://www.marvell.com/products/power/dspswitchermodule/MV-S101948-00C.pdf).
There's a two-page
[brochure](https://web.archive.org/web/20070415092855/http://www.marvell.com/products/power/dspswitcher/DSPSwitcher_MVPG15_16_30_31.pdf)
as well, but is rather lacking in the more technical details.

Product information page at
[http://www.marvell.com/products/power/dspswitcher/index.jsp](https://web.archive.org/web/20090603221217/http://www.marvell.com/products/power/dspswitcher/index.jsp)



## Marvell 88W8388-BDK1

`88W8388-BDK1`
`AGW1P .2`
`0530 A2P`
`TW`

The 88W8388 is an 802.11a/b/g WLAN SoC from Marvell. Embedded are an
[ARM946E-S](https://web.archive.org/web/20100408074133/http://www.arm.com/products/processors/classic/arm9/arm946.php) core (as per
the ARM [Networking.pdf Networking](http://www.arm.com/pdfs/116-4)
brochure) and on-chip memory. Together with an integrated TCP/IP stack,
this allows for off-loading the host processor of protocol processing.
This SoC is targeted at small-footprint devices, eg. cellular/VoIP
phones, PDAs, video game consoles, etc.

The 88W8388 is 88W88305-derived, as indicated below (table reproduced
from
[http://www.clv.macnica.co.jp/product/marvell/sub1.html](https://web.archive.org/web/20070624073712/http://www.clv.macnica.co.jp/product/marvell/sub1.html)\):

| Part no. | b/g/a | Package option                                        | CLK Type                                              | Interface                 | Feature/Advantage                                             |
| -------- | ----- | ----------------------------------------------------- | ----------------------------------------------------- | ------------------------- | ------------------------------------------------------------- |
| 88W8305  | b     | TQFP 128pin 14x14x1.2 TBGA no option Flip chip Yes    | 20, 40, 44 CMOS only                                  | CF SDIO (SPI)             | TKIP (firmware) AES (hardware) WPA (firmware) Power Save      |
| 88W8381  | b     | TQFP 128pin 14x14x1.2 TBGA 132pin 8x8x1 Flip chip Yes | 19.2, 20, 26, 38.4, 40, 44 COMS & Low swing sine wave | CF SDIO (SPI)             | 8305 TKIP (hardware) 802.11e (QoS) 802.11i (Security) BT coex |
| 88W8385  | a/b/g | TQFP 128pin 14x14x1.2 TBGA 132pin 8x8x1 Flip chip Yes | 19.2, 20, 26, 38.4, 40, 44 COMS & Low swing sine wave | CF SDIO (SPI) Generic SPI | 8381 a/g                                                      |
| 88W8388  | a/b/g | TQFP No TBGA 132pin 8x8x1 Flip chip Yes               | 19.2, 20, 26, 38.4, 40, 44 COMS & Low swing sine wave | SDIO (SPI) USB 2.0        | 8385 TCP/IP termination NAND Flash I/F Audio Codec I/F        |

*Baseband Processor Product Selection table*

[Category: Xbox 360 Hardware](../Category_Xbox360_Hardware)
[Category: Pages That Need Updates](/!Pages-That-Need-Updates)
