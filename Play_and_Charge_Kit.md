The **Play and Charge Kit** is sold separately from the Xbox 360
Wireless Controller. It contains a rechargable battery pack and a USB
cable which connects the controller to the console.

# Battery Pack

The battery pack that comes with the Play amd Charge Kit contains 2
standard rechargable AA batteries soldered to a control circuit board
with a 6-pin header.

The pinout for the header is (left to right): Temp, P-/GND, SCK, SCA, P,
VCC

The SCK, SCA, GND, and VCC pins are connected to an AT24C04M 2-wire
serial EEPROM chip. Presumably the controller checks the EEPROM to
verify that the battery pack has been charged fewer than a factory-set
number of times and stops charging if that number is exceeded.

[Category:Xbox360_Hardware](Category_Xbox360_Hardware.md "wikilink")