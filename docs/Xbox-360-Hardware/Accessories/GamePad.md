# Gamepad

## Speculation

  - ~~Rumors that both the wired gamepad and wireless dongle share the
    same interface, but probably won't have the same USB device IDs.~~
  - The last six bytes of the input descriptor are for analog face
    buttons. The information on the web is contradictory. I know that
    the controller did have pressure sensitive face buttons originally.
    Some web sites now say that it does not, so they must have been
    scrapped. Others say that it still does have them. If it does not
    the bytes are just a relic, but if the controler does have the
    analog buttons then there must be some form of toggle mechanism.

## Pinouts

### Headset Connector

The headset connector is a usual 2.5 mm TRS-Jack and is totally
compatible with the old Xbox headset. The pinout is shown below:

```
  ___   S  R T
 |   '----,-,-.
 |   ,----'-'-'
 \   /
  | |
```

  - S (Shield): Ground, common for Speaker (-) and Microphone (-)
  - R (Ring): Speaker (+), can be left open
  - T (Tip): Microphone (+), feeds elctret mic, shorten to ground for
    muting

### Xbox 360 Wireless Controller

**Wire Connector (Play'n'Charge Cable)**

```
    | LT |         _______,__,______         | RT |
    ________       \ ------------- /      _________
         LB         ___,__,__,___/        RB
    --------         1 2 3 4 5 6 7        ---------
```

(View on Controller when turning 90 degrees towards user)

Pin Functions:

- 1 GND (Ground, black wire of USB)
- 2 Data A (unknown function but likely paired with pin 7)
- 3 VCC (Supply Voltage, works good with 3.3V, *see note!*)
- 4 Unknown (charge option?)
- 5 USB D+ (Data Line, greeen wire of USB)
- 6 USB D- (Data Line, white wire of USB)
- 7 Data B (unknown, see pin 2)

*Note:* The supply voltage for Memory Units and other Accessories is
always 3.3 Volts. The front side USB socket of the Xbox has a supply of
5V as required by standard USB devices like memory sticks or legacy
keyboards. Experiments have proven that the Controller works good on
Xbox USB port when wired up according to the pinout above and by
inserting a 3.3 Volts positive regulator between VUSB (red) and VCC on
(pin 3). As written inside the battery slot the Controller might be
rated for 5V - if anyone has a spare trash controller he could try it
without fear of frying the pad...

[Category: Xbox 360 Hardware](../Category_Xbox360_Hardware)
