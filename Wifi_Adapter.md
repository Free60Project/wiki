# Introduction

[<File:Wlan>
back.jpg](http://www.free60.org/index.php5?title=Special:Upload&wpDestFile=Wlan_back.jpg)

FCC ID:C3K-WKS168
IC: 3048A-WKS168

The [Wireless Network
Adapter](http://www.xbox.com/en-US/hardware/x/xbox360wirelessnetadapter/)
is a dual-band (2.4/5GHz) 802.11a/b/g interface for the Xbox 360.

This is a standard USB 2.0 device, and although it is designed to clamp
onto the back of the console, it works when plugged into a standard USB
port, given your operating system has accompanying device drivers. See
below.

# Disassembly

[<File:Wlan> all
pieces.jpg](http://www.free60.org/index.php5?title=Special:Upload&wpDestFile=Wlan_all_pieces.jpg)

Disassembled; bottom and top covers, PCB, USB cable and antenna

[<File:Wlan> back
opened.jpg](http://www.free60.org/index.php5?title=Special:Upload&wpDestFile=Wlan_back_opened.jpg)

PCB underside, with [Hannstar Board
Corp.](http://www.hannstarboard.com/index.htm) inscription.

# Integrated Circuits

[<File:Wlan> front
opened.jpg](http://www.free60.org/index.php5?title=Special:Upload&wpDestFile=Wlan_front_opened.jpg)

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
[download](http://www.marvell.com/products/power/dspswitchermodule/MV-S101948-00C.pdf).
There's a two-page
[brochure](http://www.marvell.com/products/power/dspswitcher/DSPSwitcher_MVPG15_16_30_31.pdf)
as well, but is rather lacking in the more technical details.

Product information page at
<http://www.marvell.com/products/power/dspswitcher/index.jsp>



## Marvell 88W8388-BDK1

`88W8388-BDK1`
`AGW1P .2`
`0530 A2P`
`TW`

The 88W8388 is an 802.11a/b/g WLAN SoC from Marvell. Embedded are an
[ARM946E-S](http://arm.com/products/CPUs/ARM946E-S.html) core (as per
the ARM [Networking.pdf Networking](http://www.arm.com/pdfs/116-4)
brochure) and on-chip memory. Together with an integrated TCP/IP stack,
this allows for off-loading the host processor of protocol processing.
This SoC is targeted at small-footprint devices, eg. cellular/VoIP
phones, PDAs, video game consoles, etc.

The 88W8388 is 88W88305-derived, as indicated below (table reproduced
from
<http://www.clv.macnica.co.jp/product/marvell/sub1.html>):

| Part no. | b/g/a | Package option                                        | CLK Type                                              | Interface                 | Feature/Advantage                                             |
| -------- | ----- | ----------------------------------------------------- | ----------------------------------------------------- | ------------------------- | ------------------------------------------------------------- |
| 88W8305  | b     | TQFP 128pin 14x14x1.2 TBGA no option Flip chip Yes    | 20, 40, 44 CMOS only                                  | CF SDIO (SPI)             | TKIP (firmware) AES (hardware) WPA (firmware) Power Save      |
| 88W8381  | b     | TQFP 128pin 14x14x1.2 TBGA 132pin 8x8x1 Flip chip Yes | 19.2, 20, 26, 38.4, 40, 44 COMS & Low swing sine wave | CF SDIO (SPI)             | 8305 TKIP (hardware) 802.11e (QoS) 802.11i (Security) BT coex |
| 88W8385  | a/b/g | TQFP 128pin 14x14x1.2 TBGA 132pin 8x8x1 Flip chip Yes | 19.2, 20, 26, 38.4, 40, 44 COMS & Low swing sine wave | CF SDIO (SPI) Generic SPI | 8381 a/g                                                      |
| 88W8388  | a/b/g | TQFP No TBGA 132pin 8x8x1 Flip chip Yes               | 19.2, 20, 26, 38.4, 40, 44 COMS & Low swing sine wave | SDIO (SPI) USB 2.0        | 8385 TCP/IP termination NAND Flash I/F Audio Codec I/F        |

*Baseband Processor Product Selection table*

[Category:Xbox360_Hardware](Category:Xbox360_Hardware "wikilink")
[Category:Pages with missing
images](Category:Pages_with_missing_images "wikilink")
