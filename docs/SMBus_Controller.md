# Overview

All non-PC components of the Xbox console are connected through an
I²C/SMbus interface. I²C/SMBus is a slow low-cost serial bus with each
device having a unique 7-bit ID. (Wikipedia has informative articles
about I²C (http://en.wikipedia.org/wiki/I2c) and SMBus
(http://en.wikipedia.org/wiki/SMBus), you might want to check them out.)

There are only two operations of an SMBus controller: write and read.
Writing means that an 8 bit command code and an 8 or 16 bit operand are
sent to an SMBus device. Reading means that an 8 bit command code is
sent to the device and an 8 or 16 bit answer is expected.

The controller for the SMBus interface in the Xbox is a PCI device with
the DevID 01B4 and it is built into MPCX southbridge.

# SMBus Controller Port Layout

<table>
<thead>
<tr class="header">
<th><p>Port</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>0xc000</p></td>
<td><p>Status bit 0: abort<br />
bit 1: collision<br />
bit 2: protocol error<br />
bit 3: busy<br />
bit 4: cycle complete<br />
bit 5: timeout</p></td>
</tr>
<tr class="even">
<td><p>0xc002</p></td>
<td><p>Control bit 2-0: cycle type<br />
bit 3: start<br />
bit 4: enable interrupt<br />
bit 5: abort</p></td>
</tr>
<tr class="odd">
<td><p>0xc004</p></td>
<td><p>Address</p></td>
</tr>
<tr class="even">
<td><p>0xc006</p></td>
<td><p>Data</p></td>
</tr>
<tr class="odd">
<td><p>0xc008</p></td>
<td><p>Command</p></td>
</tr>
</tbody>
</table>

This is very similar (but not identical) to the AMD756/AMD766/AMD768
SMBus controllers. The [lm_sensors project](https://web.archive.org/web/20150627102528/http://www.lm-sensors.org/)
includes GPLed Linux kernel code for it since version 2.6.4
(kernel/busses/i2c-amd756.c).

# SMBus Controller Programming

The following two routines illustrate how to read and write data from
and to an SMBus
device:

 `int SMBusWriteCommand(unsigned char slave, unsigned char command, int isWord, unsigned short data) {`
 `again:`
 `    _outp(0xc004, (slave<<1)&0xfe);`
 `    _outp(0xc008, command);`
 `    _outpw(0xc006, data);`
 `    _outpw(0xc000, _inpw(0xc000));`
 `    _outp(0xc002, (isWord) ? 0x0b : 0x0a);`
 `    while ((_inp(0xc000) & 8)); /* wait while busy */`
 `    if (_inp(0xc000) & 0x02) goto again; /* retry transmission */`
 `    if (_inp(0xc000) & 0x34) return 0;  /* fatal error */`
 `    return 1;`
 `}`
 `int SMBusReadCommand(unsigned char slave, unsigned char command, int isWord, unsigned short *data) {`
 `again:`
 `    _outp(0xc004, (slave<<1)|0x01);`
 `    _outp(0xc008, command);`
 `    _outpw(0xc000, _inpw(0xc000));`
 `    _outp(0xc002, (isWord) ? 0x0b : 0x0a);`
 `    while ((_inp(0xc000) & 8)); /* wait while busy */`
 `    if (_inp(0xc000) & 0x02) goto again; /* retry transmission */`
 `    if (_inp(0xc000) & 0x34) return 0;  /* fatal error */`
 `    *data = _inpw(0xc006);`
 `    return 1;`
 `}`
To avoid busy waiting of the CPU, the SMBus controller can also issue an
interrupt when the operation is complete, by setting bit \#4 in the
control port when initiating the transfer.

# Xbox SMBus Devices

The following four devices are connected to the Xbox SMBus:

Device Hardware Address Software Address PIC16LC 0x10 0x20 Conexant
CX25871 Video Encoder 0x45 0x8a ADM1032 System Temperature Monitor 0x4c
0x98 Serial EEPROM 0x54 0xa8 Do not confuse the hardware with the
software addresses: The software ID is the hardware ID shifted by one
bit left. The code above expects the hardware ID.

Actually, these addresses are not literally accurate; you find that the
hardware address is 0x54 for the EEPROM: the actual address of the
EEPROM on the i2c bus is 1010 (0xa), however, you will also notice that
0x54 is 1010100 in binary, and it seems that this 100 is also appended
onto the other devices as well (although their software address is
naturally read as say 10101000 - obviously because of the left shifting, 
however, it could be speculated that it would be possible to communicate
with devices over the SMBus that are connected via i2c, so long as you
knew their base address.

Retrieved from "<http://www.xbox-linux.org/wiki/SMBus_Controller>"

[Category: Xbox_Hardware](Category: Xbox_Hardware "wikilink")
