# General

The SPI bus (Serial Peripheral Interface) on the Xbox 360 is mainly used
for communicating with the [NAND-Flash Controller
(SFCX)](NAND#Flash_Controllers), a [SPI
Programmer](SPI_Programmer) is needed for this. The bus
consists of the following signals:

| Name | Description          |
| ---- | -------------------- |
| MOSI | Master out, Slave in |
| SS   | Slave Select         |
| SCK  | Serial Clock         |
| MISO | Master in, Slave out |
| XEJ  | Eject                |
| XXX  | ?                    |
|  |

# FAT Motherboard

The Diagram matches following Xbox 360 Motherboard-revisions:
[Xenon](Xenon), [Zephyr](Zephyr),
[Falcon](Falcon), [Opus](Opus),
[Jasper](Jasper).
![Xbox 360 FAT NANDPro Diagram](images/XBOX360_Fat_NandPro_LPCH2148_PIC18F2455_Diagram.jpg)

# SLIM Motherboard

The Diagram can be used for Xbox 360 Motherboard-revision:
[Trinity](Trinity)
![Xbox 360 Slim NANDPro Diagram](images/XBOX360_Slim_NandPro_LPCH2148_PIC18F2455_Diagram.jpg)
