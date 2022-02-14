# Motherboard

(This page is riddled with speculation and extrapolation of information
from dodgy sources, so take it with a grain of salt.)

The Xbox 360 motherboard (or motherboard) has undergone a few revisions,
as Microsoft has corrected mistakes or added/improved existing features.

- Known revisions include:

:\*[Xenon](../Xenon_(Motherboard)) (Launch hardware)

:\*[Zephyr](../Zephyr) (Elite)

:\*[Falcon](../Falcon) (65nm Chipset revision)

:\*[Opus](../Opus)

:\*[Jasper](../Jasper) (Onboard Memory Unit)

:\*[Trinity](../Trinity) (Slim)

## Details

The motherboard PCB has four layers (sources:
[1](https://web.archive.org/web/20100328024533/http://www.ccw.com.cn/notebook/pczx/sy/htm2005/20051028_16OMI.htm),
[2](http://www.anandtech.com/video/showdoc.aspx?i=2414)), implying that
the top and bottom layers (the ones we can see and probe) contain most
of the signals. This is a good thing :)

## CPU, GPU, & Front side bus

According to
[these](https://web.archive.org/web/20100328024533/http://www.ccw.com.cn/notebook/pczx/sy/htm2005/20051028_16OMI.htm)
[three](http://www.cdrinfo.com/images/uploaded/Xbox_Architecture_large.gif)
[sources](http://en.wikipedia.org/wiki/Xbox_360#Hardware_specifications)
the FSB is a serial bus with 16 differential pairs in each direction,
and each pair runs at 5.4Gbit/s. This agrees with Microsoft's published
bandwidth specification of 21.6 Gbyte/sec (10.8 Gbyte/sec each way, 16
bits/2 bytes at a time, 5.4 Gbit/sec per pair).

Looking at photos of the motherboard, we can see 40 pairs of carefully
routed tracks between the CPU and GPU. 32 pairs (16 each way) + 8
clock/handshake/parity? pairs = 40 pairs.

This very high frequency interface will make probing and snooping on the
bus extremely difficult, which is unfortunate because the Xbox1 security
was compromised in part by a FSB bus snoop done by bunnie. At this
frequency, the (relatively) simple task of attaching probe wires to the
FSB will change the impedance seen on the bus by the FSB PHYs and cause
the bus to fail to work correctly (look at eye diagram...). It might
still be possible to probe the FSB with very expensive gear though.

It's not very likely that they made the mistake of sending sensitive
information on an exposed bus again though.

## Photos

  - <http://arstechnica.com/articles/paedia/cpu/xbox360-1.ars>
  - [http://g-prime.net/x360/open/](https://web.archive.org/web/20090110154123/http://www.g-prime.net/x360/open/) \(archive.org mirror\)
  - [http://www.darkmoon.org/xbox360_photos.htm](https://web.archive.org/web/20150609103520/http://www.darkmoon.org/xbox360_photos.htm) \(archive.org mirror\)

[Category: Hardware](/Hardware)
