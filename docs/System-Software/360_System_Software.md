The Xbox's **Original Software** is composed of many things, including
the bootloaders, the kernel, the dashboard and more.

# [Bootloaders](./Bootloaders.md)

The Xbox 360 system uses a series of
[bootloaders](./Bootloaders.md) to load the hv/kernel and
dashboard. These loaders are explained at [Boot
Process](./Boot_Process.md).

# [Hypervisor](../Hypervisor.md)

The [Hypervisor](../Hypervisor.md) is the main operating system
being run on the console. It looks after the kernel and stops things
like buffer overflows from happening. It also manages a lot of the
security aspects of the 360, including memory encryption and region
protection. It has code to handle the XeKeys (keyvault + some static
ones) and XEXs. The end-user of an Xbox would never have any knowledge
of the hypervisor, it's only really interesting for hackers.

# [Kernel](./Kernel.md)

The Xbox 360's [Kernel](./Kernel.md) is responsible for low level
hardware communication and more. This is the main part of the 360, the
kernel is where all the user-based stuff happens. The drivers for
accessing most of the hardware is located in the Kernel, along with
certain drivers for other things used by the system (e.g. FATX (File
Allocation Table for Xbox), STFS (Secure Transacted File System), SFCX
(System Flash Controller for Xbox). This is the most interesting part of
the console because of all the functions it performs.

You can check your kernel version in "System -\> Console Settings -\>
System Info". The line at the bottom contains your kernel version in the
format K:2.0.*nnnnn*.0, where *nnnnn* is your kernel version.

# XAM

A lot of fun things are inside XAM. XAM handles gamer profiles and
online interactivity, so as you can guess not a lot of information is
made public about it. XeDevWiki hopes to change that. XAM handles such
things as [XDBF](./Formats/XDBF.md) (**X**box **D**ata**b**ase **F**ile)
files ([GPD](./Formats/GPD.md) (**G**amer **P**rogress
**D**ata)/[SPA](./Formats/SPA.md)) and [PEC](./Formats/PEC.md) (**P**rofile
**E**mbedded **C**ontent) files.

# File Systems

The Xbox 360 uses various File Systems for storing games, user content
and more.

**[FATX](./Systems/FATX.md)** (**F**ile
**A**llocation **T**able for **X**box) is used as the storage
filesystem on hard drives/memory units/USB devices/xlaunch.fdf files.

**[GDFX](./Systems/GDFX.md)**/XSF (**G**ame
**D**isc **F**ormat for **X**box) is the filesystem used on X360
CD/DVD Media.

**[STFS](./Formats/STFS.md)** (**S**ecure
**T**ransacted **F**ile **S**ystem) is used for game saves,
profiles, arcade games, downloadable content and more. STFS is also
referred to as CON/LIVE/PIRS files, as they are all STFS files, just
signed with a different header.

**[(SFCX](./SFCX.md)** **S**ecure
**F**ile **C**ache for **X**box) :is used for cache storage for games.

**[NAND File System](./NAND_File_System.md)** is used to store the
bootloaders, kernel, keyvault and other files on the
[NAND](../Hardware/Console/NAND/index.md).

# File Formats

The Xbox 360 also uses different File Formats
for storage of data, as storage on the Xbox is limited, these files are
usually binary. [XeNTaX.com](http://wiki.XeNTaX.com) is a DataBase of
hundreds of different file formats, which may be of help.

**[PEC](./Formats/PEC.md)** (**P**rofile
**E**mbedded **C**ontent) is used as another layer of security
inside profiles.

**[STFS](./Formats/STFS.md)** (**S**ecure
**T**ransacted **F**ile **S**ystem) is used for secure storage of
files on memory
devices.

**[XDBF](./Formats/XDBF.md)**/**[GPD](./Formats/GPD.md)**/**[SPA](./Formats/SPA.md)**
(**X**box **D**ash**b**oard
**F**ile/**G**amer **P**rofile **D**ata/**S**tatistics, **P**resence and
**A**chievements) is used for profiles
(achievements/settings/titles) and games (achievements/strings/ratings).

**[XEX](./Formats/XEX.md)** (**X**enon
**Ex**ecutable) is the executable format used by the Xbox 360.

**XMI**(**X**enon
**M**usic **I**ndex) is used to index music on the Xbox.


