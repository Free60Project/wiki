The Xbox 360 motherboard has gone through several changes over the
years. These changes often reduced die sizes of various chips (CPU
(Xenon), GPU (Xenos), [eDRAM](http://en.wikipedia.org/wiki/EDRAM),
etc.), added new features (HDMI, etc.) and patched the SMC/JTAG exploit.
This pages lists off all known motherboard revisions & their changes.

<!--- Not an issue with GitHub PRS - halotroop2288
'''NOTE TO MAINTAINERS: ''' This page is often ripped apart by spam
bots! Please check and revert any unwanted changes regularly!
--->

## Xenon

The original Xbox 360 configuration used in the initial Premium and Core machines released in the end of November 2005. 
These are also known as the RRoD (Red Ring of Death) machines because the majority of these machines are affected with defective GPUs.

  - Consoles: Core, Pro/Premium 20 GB
  - 90 nm IBM CPU (Waternoose DD2, late models used DD3 instead)
  - Y1 GPU
    - 90 nm ATI GPU die (Xenos C1)
    - 90 nm on-chip [eDRAM](http://en.wikipedia.org/wiki/EDRAM) (Edifis)
  - Low-profile GPU cooler (most of the time)
  - Standard CPU cooler
  - **No HDMI** video output
  - 203 Watt output power supply (16.5 A)
  - Shipping with Hitachi46-78, Samsung ms25or ms28, or BenQ DVD Drive. Can
    also come with Lite-On drive if it was refurbished.
  - Highly unlikely to have glue around the CPU but it *is* possible.

### Elpis
Microsoft refurbishments of Xenon motherboards that had an RRoD issue. These replace the old defective GPU with a new one, named after the motherboard's name.

  - Consoles: Core, Pro/Premium 20 GB
  - 90 nm IBM CPU (Waternoose DD2/DD3)
  - Elpis GPU
    - 90 nm ATI GPU die (Xenos C2)
    - 90 nm on-chip [eDRAM](http://en.wikipedia.org/wiki/EDRAM) (Styx-90)
    - Essentially the Rhea GPU, but always comes with the underfill fix, in addition to being internally re-wired to work with the Xenon PCB
  - Zephyr-style GPU cooler (extended heatpipe)
  - Standard CPU cooler
  - 203 Watt output power supply (16.5 A)
  - BenQ or Lite-On DVD drive.
  - Highly unlikely to have glue around the CPU but it *is* possible.

## Zephyr

Zephyr was the first revision with HDMI connector. It was introduced with the Xbox 360 Elite in May 2007.
In July 2007, Xbox 360 Premium machines began appearing with the Zephyr motherboard.

  - Consoles: Arcade, Pro/Premium 20 GB, Elite 120 GB and Halo 3 edition
  - 90 nm IBM XCPU (Waternoose DD3)
  - Multiple GPU revisions
    - Y1 GPU on Zephyr_A (same as Xenon)
    - Y2 GPU on Zephyr_B
      - 90 nm ATI Xenos GPU die (**Xenos C2**, smaller than C1)
      - 90 nm [eDRAM](http://en.wikipedia.org/wiki/EDRAM) (Edifis)
    - Rhea GPU on Zephyr_C (same as Falcon)
      - 90 nm ATI GPU (Xenos C2) 
      - 90 nm on-chip eDRAM **(Styx-65)**
  - 203 Watt PSU (16.5 A)
  - **HDMI** video output
  - Updated motherboard layout
  - Glue around the CPU in some cases
  - 3-pin fan connector
  - New **Extended GPU** heat sink with a heat pipe
  - New Elite model includes 120 GB hard drive
  - Shipping with Hitachi 78 or 79 and **BenQ** DVD Drive. May also have
    Lite-On if it was refurbished.

## Falcon
**Falcon** is the codename used for the third revision to the Xbox 360's motherboard. 
Appearing in September 2007, this revision reduced the CPU die size from 90 nm to 65 nm, and has the same Rhea GPU as the Zephyr_C.
However, unlike any Xenon or Zephyr, later productions of the Falcon also fixed the underlying cause of most RRoD issues with fixed versions of the Rhea GPU on newly manufactured consoles.

- Consoles: Arcade, Pro/Premium 20 GB & 60 GB, Elite 120 GB, and very late Halo 3 edition
- **65 nm** IBM CPU (Loki)
- Rhea GPU
  - 90 nm ATI GPU (Xenos C2) 
  - 90 nm on-chip eDRAM **(Styx-65)**
  - Late models that were either repaired by MS or manufactured **after** May 2008 recieved fixed Rhea GPUs that addressed the low-tg underfill issue, thus not being prone to the RRoD issue.
- HDMI video output
- **175 Watt** PSU (2V rated for 14.2A, new connector)
- New CPU heat sink + the GPU heat sink with heat pipe
- Fewer voltage regulators, capacitors and inductors
- Cheaper CPU cooler made of a single alumnium block rather than using the previous heatpipe + heatfins design
- 3 pin fan connector
- RAM removed from bottom of mainboard on later models
- New warranty sticker on later models
- Shipping with Hitachi 79, BenQ, and new Lite-On 7XXX series DVD Drive


### Opus

**Opus** motherboards started to appear in July 2008, to people who had
sent in their RRoD Xenon consoles.
The Opus motherboard is essentially a Falcon motherboard, but without the
HDMI connector, so that they could fit into the original Xenon cases that were sent-in for repair.
All Opus motherboards also came with fixed GPUs, which means they also have similarly high reliability to Jasper/Tonasket

  - Consoles: Core, Pro/Premium 20 GB
  - Falcon-based board
  - **65 nm** IBM CPU (Loki)
  - Rhea GPU
    - 90 nm ATI GPU (Xenos C2) 
    - 90 nm on-chip eDRAM **(Styx-65)**
  - **No HDMI** video output
  - 175 Watt PSU (2V rated for 14.2A, new connector)
  - Updated heat sinks
      - Falcon CPU cooler (alumnium)
      - Zephyr GPU cooler (extended heatpipe)
  - 3-pin fan connector
  - New warranty sticker.
  - Shipping with BenQ or Lite-On 7XXX series DVD Drive
  - **Opus only available from a Xenon being repaired by MS in 2008**
  - All Opus motherboards have fixed GPUs like late Falcons, so they also have strong reliability. 
  - Very Rare

## Jasper

Jasper introduced the 65 nm GPU to reduce power usage and cost further.
The new power supply is rated for 150 Watt, down from 175 Watt on the Falcon. 
The Amperage on the 12V rail is down to 12.1A (12.1A x 12V = 145.2W).

The on-board flash for motherboards that came with Arcade models has also increased to allow the new NXE (New Xbox
Experience) dashboard update to reside internally, instead of requiring an external memory unit or a hard drive.

The connections required to [dump/flash the NAND](../../../Hacks/NAND_Reading.md) are the **same** as all previous models.

Performing the [SMC Hack](../../../Hacks/SMC_Hack.md) requires the same wiring
as Zephyr, Opus, and Falcon mainboards. This is a slightly different set
of connections than those required for the Xenon mainboard.

  - Consoles: Arcade 256 MB & 512 MB, Pro/Premium 60 GB, Elite 120 GB, &
    250 GB and Resident Evil 5 console
  - 65 nm IBM CPU (Loki)
  - Zeus GPU
    - **65 nm** ATI GPU (Gunga) 
    - 90 nm on-chip eDRAM (Styx-90)
  - **150 Watt** PSU (12V rated for 12.1A, new connector)
  - Arcade Editions have larger internal flash memory (either 256 MB or 512 MB) on-board flash, up from 16 MB flash, to accommodate NXE's (New Xbox Experience) SysExt partition.
  - New [southbridge](../Southbridge.md) chipset (PSB) that enables support for the on-board memory units
  - Ram removed from bottom of mainboard on all models
  - Same heatsinks as Falcon
  - 3-pin fan connector
  - All consoles have the newer warranty sticker
  - Shipping with LiteOn 7XXX/8XXX/V2/9XXX DVD Drives

### Tonasket

Similar to Jasper, other than some minor changes.

  - Consoles: Arcade 512 MB, Elite 120 GB & 250 GB, Modern Warfare 2
    consoles and Final Fantasy 13 consoles
  - Kronos GPU
    - 65 nm GPU (Gunga)
    - **65 nm** eDRAM (Styx-65)  
  - New [southbridge](../Southbridge.md) chipset
  - Arcade Editions only use **512 MB**, unlike Jasper
  - Shipping with Lite-On 8XXXV2/9XXX DVD-Drivers.
  - JTAG Hack / SMC patched on CB level
  - Xenon-style GPU heat sink with Falcon/Jasper style CPU heat sink
  - Special edition consoles: Modern Warfare 2 edition
  - Last of the original style 360 systems

## Trinity \[Xbox 360 S\]
Trinity is the codename of the first motherboard used in the Xbox 360 S, and is the sixth motherboard revision overall. It was originally believed that its codename was Valhalla, but after looking through debug files, it was found that this is not the case. Valhalla was actually the pre-release code name of the XCGPU chip.

It no longer has external Memory Unit ports. It has a special port for connecting the Kinect peripheral, which provides 12V power to the device instead of plugging it in separately. It also features a single chip that contains the CPU, GPU and eDRAM onto one XCGPU chip, and as a result, the motherboard is much smaller than the original. It contains an internal USB port which has a 2.4 GHz 802.11n Wi-Fi card inserted. The HDD port was also changed, making it much smaller and flush against the case.

  - Consoles: 4 GB (Matte black), 250 GB (Glossy black), Halo Reach edition, and Gears of War edition
  - Unified CPU, GPU, and eDRAM on one chip called **Vejle**.
    - CPU and GPU are on one combined die made on the 45 nm process.
    - eDRAM is a seperate daughter die, and it's the same Styx-65 design used on the [Tonasket](Jasper.md#Tonasket)'s Kronos.
  - 16 MB NAND
  - 135 Watt PSU (dual barrel plug)
  - 802.11n Wi-Fi integrated
  - No more external Memory Unit ports
  - Built-in Kinect port
  - HDD is redesigned to connect to the console directly with SATA, unlike the previous fat model.
  - Smaller form factor than previous model
  - On 4 GB consoles, there is a 4 GB Memory Unit on small daughter board
  - No more RROD; major errors will show an RDOD (Red Dot of Death) on the center LED rather than the player LEDs.

## Corona \[Xbox 360 S\]
**Corona** is the codename for the second Xbox 360 S motherboard, and is the eighth revision overall. Its main distinguishing attribute is that it uses a new Southbridge, which integrated the [Ethernet IC](../Ethernet.md) & HANA into it.

  - Consoles: 4 GB (Matte black), 250 GB (Matte black), Gears of War edition, Modern Warfare 3 edition, Star Wars edition, White-colored special edition
  - Same Vejle XCGPU as Trinity
  - No HANA Chip; it's integrated into the Southbridge
  - 115 W PSU (dual barrel plug)
  - Built-in Kinect port
  - 4 GB consoles with this board instead integrated the 4 GB memory onto the motherboard itself, by using a 4 GB TSOP on the bottom of the board controlled with a Phison PS7000.
  - Same SATA port as Trinity
  - Same Red Dot error code as Trinity
  - Some versions of the board disconnected the CPU_POST traces

The interesting thing is that it seems Microsoft knew about the Reset Glitch Hack, so they removed the HANA Chip. 
Thus, it seems Microsoft found the exploit days before GliGli brought it out for the public.

### Waitsburg
Minor revision to the Corona.

  - Consoles: 4 GB (Matte black), 250 GB (Matte black), Star Wars edition, White-colored special edition, and Halo 4 edition
  - Same Vejle XCGPU as Trinity/Corona
  - No HANA Chip; it's integrated into the Southbridge
  - 115 W PSU (dual barrel plug)
  - Built-in Kinect port
  - 4 GB NAND is now an eMMC package instead of a TSOP + PS7000
  - Same SATA port as Trinity
  - Same Red Dot error code as Trinity
  - All versions of the board disconnected the CPU_POST traces

## Stingray \[Xbox 360 E\]
Stingray is the launch motherboard for the Xbox 360 E model, and was essentially just a cut-down version of the Corona/Waitsburg made to fit in the Xbox 360 E chassis.

  - Consoles: 4 GB (Matte/Glossy black), 250 GB (Matte/Glossy black), 500 GB Wal-Mart bundle (Blue, rare)
  - Same Vejle XCGPU as Trinity/Corona
  - No HANA Chip; it's integrated into the Southbridge
  - 115 W PSU (single barrel plug)
  - Built-in Kinect port
  - 4 GB NAND is now an eMMC package instead of a TSOP + PS7000
  - 4 USB ports instead of 5
  - Old AV port connector is removed; replaced with 3.5 mm TRRS composite jack.
  - Front panel audio IC (ISD2130) has been removed
  - Smaller form factor than previous S model
  - Same SATA port as Trinity/Corona
  - Red dot error code is slightly modified from how it's displayed on Trinity/Corona
    - If you get the secondary error code in a Red Dot state by holding Sync and pressing eject, the console shows it by blinking the LED to represent the number, due to this model using different RF boards that don't have player LEDs. 

## Barracuda \[Xbox 360 E\]
Barracuda is the final retail motherboard ever released for the Xbox 360. It is the most cost reduced board to date, and features a unique CPU revision.

  - Consoles: 4 GB (Matte/Glossy black), 250 GB (Matte/Glossy black), 500 GB Wal-Mart bundle (Blue)
  - New **32 nm** XCGPU codenamed **Oban**
    - CPU, GPU, and now eDRAM are all inside one single die. 
    - **Patched Reset Glitch Hack exploit** at a hardware level (PLL, EXT_CLK, & POST, are disabled through the eFuses, and RST is latched)
  - No HANA Chip; it's integrated into the Southbridge
  - 115 W PSU (single barrel plug)
  - Built-in Kinect port
  - 4 GB NAND is now an eMMC package instead of a TSOP + PS7000
  - 4 USB ports instead of 5
  - Old AV port connector is removed; replaced with 3.5 mm TRRS composite jack.
  - Same SATA port as Trinity/Corona
  - Red dot error code is slightly modified from how it's displayed on Trinity/Corona
    - If you get the secondary error code in a Red Dot state by holding Sync and pressing eject, the console shows it by blinking the LED to represent the number, due to this model using different RF boards that don't have player LEDs. 


Sources:
[Source 1](http://en.wikipedia.org/wiki/Xbox_360_technical_specifications#List_of_revisions)
[Source 2](https://web.archive.org/web/20160515071713/http://www.xboxhacker.org/index.php?topic=17143.0)
[Source 3](https://xenonlibrary.com/wikiCorona)

[Category: Hardware](../../index.md)
