# General

To communicate with the Flash Controller you need a device which
is capable of the [Xbox 360's SPI Protocol](../../Hardware/Console/SPI.md). There are
ready-to-use devices you can buy or, if you aren't afraid of soldering
your own hardware, DIY homebrew devices. Basically: Get the device
programmed (if needed) and solder it according to the
[Diagram](../../Hardware/Console/SPI.md) to your Xbox's mainboard - you can start
reading/writing to your NAND after installing the needed drivers.


# [PicoFlasher](./PicoFlasher.md)

Recommended SPI Programmer in 2026. Only requires a Pi Pico and soldering skills.
Fast reads and writes.

# [DIY SPI Programmer](./SPI_Programmer.md)

Legacy method to build your own SPI Programmer. Slow reads and writes.

# [LPT Programmer](./LPT_Programmer.md)

Legacy method to read the NAND flash directly using a Parallel Port.
Extremely slow reads and writes.


# Other Methods

Many pre-built pre-flashed existing programmers exist. can be used directly with Software like **J-Runner with Extras** and [NANDPro](../../Homebrew/PC-Software/NANDPro.md) to interact with the NAND Flash.

In order of most recommended to least recommended, they are:

## [xFlasher360](https://github.com/Element18592/xFlasher-360) (Open Source)

- NAND and eMMC, Fast
- ISD Flashing
- CPLD Timing Flashing

## TX JR-Programmer (Proprietary)

- NAND, no eMMC, Slow
- ISD Flashing
- CPLD Timing Flashing

## TX NAND-X (Proprietary)

- NAND, no eMMC, Slow
- CPLD Timing Flashing