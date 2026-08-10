# General

To communicate with the Flash Controller you need a device which
is capable of the [Xbox 360's SPI Protocol](../../Hardware/Console/SPI.md). There are
ready-to-use devices you can buy or, if you aren't afraid of soldering
your own hardware, DIY homebrew devices. Basically: Get the device
programmed (if needed) and solder it according to the
[Diagram](../../Hardware/Console/SPI.md) to your Xbox's mainboard - you can start
reading/writing to your NAND after installing the needed drivers.

# DIY / Homebrew

## PicoFlasher v4

Needed material:

  - 1x Raspberry Pi Pico
  - 1x Micro-USB to USB-A Cable
  - Wire

Program the Pico with the latest [PicoFlasher](https://codeberg.org/hax360/PicoFlasher) firmware.

| Pico  | Xbox           |
| ----- | -------------- |
| GP16  | SPI_MISO       |
| GP17  | SPI_SS_N       |
| GP18  | SPI_CLK        |
| GP19  | SPI_MOSI       |
| GP20  | SMC_DBG_EN     |
| GP21  | SMC_RST_XDK_N  |
| GND   | GND            |

![Phat PicoFlasher Pinout](images/PhatPicoFlasherWiringDiagram.png)

![Slim PicoFlasher Pinout](images/SlimPicoFlasherWiringDiagram.png)

## SPI Programmer

Needed material:

  - 1x 50X100 PCB
  - 1x 12 MHz Resonator
  - 1x 220nF Capacitor
  - 1x 100nF Capacitor
  - 1x 10 kOhm Resistor
  - 6x 100 Ohm Resistor
  - 1x 1 Row x 10 Pin - 2,54mm Pin Headers (male)
  - 1x 1 Row x 10 Pin - 2,54mm Pin Headers (female)
  - 1x PIC 18F2455-I/SP
  - 1x USB Conector (female)
  - 1x Matching USB Cable
  - Wire

Program the PIC with your favorite PIC Programmer (Can be build or
bought - for building one yourself the "ART2003" is recommended) with
the latest "Picflash" HEX file.
![USB SPI Programmer Diagram](images/USB_SPI_Programmer.png)

# Ready to use

There are several ready-to-use professional products like: xFlasher360, TX NAND-X, and the TX JR-Programmer. They arrive
preprogrammed and can be used directly with Software like [J-Runner with Extras](../../Homebrew/PC-Software/J-Runner-with-Extras.md) and [NANDPro](../../Homebrew/PC-Software/NANDPro.md) to interact with the NAND Flash.
