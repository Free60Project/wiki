The RF module is believed to be based on DECT
technology:[1](1 "wikilink") (Dutch)

  - Chips on the RF module:

:\*Backside:

::\*ATMEL528 24C04N I2C EEPROM

::\*MS VS55RC

:\*Frontside (Under metal shield):

::\*MS VS55RB

The RF Module also contains 4 red/green leds, 1 green led in the middle
of the power button, 1 switch. The multi color leds are connected to the
MS V55RC via resistors. The switch and the center led are connected to
D8, a 1x2mm 6pin device (diode?).

The VS55RB probably also performs some power management functions. It is
possible to switch the box on via the wireless controllers, so the
wireless part will need to be powered when the Xbox is switched off.

The layout of the connectors is as follows:

`    3.3v   usb    usb    gnd`
`pon     fb1   fb2    gnd    TP17`

The two usb wires are connected to the southbridge. fb1 and fb2 ('front
bus') form a slow serial bus, something like I2C but different: the bit
numbers don't match and the start and stop conditions are different.
These can be used to control the leds: for examble without AV cable,
there is no USB activity on boot, but there is on this front bus.
Whether the leds can be controlled by USB as well is unsure.

Pon is a active low signal which goes low by pressing the power button.
Perhaps also controlled by pressing the on function on wireless
controllers.

TP17 is an unknown signal, connected to test pin TP17 on the RF module
pcb

[Category:Xbox360_Hardware](Category_Xbox360_Hardware.md "wikilink")