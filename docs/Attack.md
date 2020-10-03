# Attack

## From Free60

This page was created when knowledge was low, everything on here is
impossible, due to the 360s hypervisor The only exploit there is and
ever will be is the king kong/jtag(smc)/whatever hypervisor bug found in
kernel 4532 -slasherking823

Actually, upon further examination, this page was created by someone
with no knowlage even when public knowlage existed.

Bad Ideas are as follows:

**Please reply and comment each attack and tell us if such attacks are possible or not**

**Please do not erase wrong things but reply instead**

## Ideas

### Software

  + Old XBOX games
      - Known bugs on the old games
      - Maybe it works (small probability that it has not been fixed)
      - Its been noted that few of the XBOX1 games whose GameSavs were

        exploitable appear on the X360 backwards list. However it's also
        worth knowing that games in addition to 007AUF, MA, and SC1
        contain similar flaws - but their exploitation was not felt
        necessary.

      - This probably does not work, since the XBOX360 emulates the old

        XBOX (with an emulator that is customized for each game). Using
        a bug in an old game would just "break out" into the emulated
        old XBOX. Of course, if the emulator design is sufficiently
        sloppy, it might be possible to have a second step that then
        compromises the actual XBOX360 security.

  + Patched games
      - [Patching

        (French)](https://web.archive.org/web/20100201124753/http://www.presence-pc.com/actualite/kong-ubi-13474/)

      - (early versions?) king kong will need a patch in order to be

        playable under some screens

      - The patch needs a hdd
  + Manipulated media files
      - Images, Music Files, Video
          - Windows Media Center, after authenticating with the server,

            uses a client compiled for the 360 to access all Media
            Center functionality. the software is very buggy. would be a
            prime target for attack.

      - Start by trying out some exploits that are already known and see

        how the XBox360 reacts to them

          - There is potential to use a .tiff overflow(?) Certainly if

            the Hypervisor behaves as suggested, it will catch the
            buffer overflow, but it might provide insight as to how it
            works.

              - I emailed the team that did the .tiff overflow with the

                PSP (for anyone who knows about their work), and asked
                for info regarding how they went about .tiff exploit.
                They had some interesting things to say (I can email
                anyone their response if they want), and recommended
                [this](http://www-cse.ucsd.edu/classes/sp05/cse127/Smash.htm).
                I'm sure its old business for alot of people, but its
                oer my head; I'm not able enough to get alot of it. If
                someone wants to work in conjunction with me to try this
                exploit out, my email is GBW88@comcast.net.

          - Maybe the recent WMF bug (escape function) will work too.
              - WMF Files don't play on the 360.
  + Save game attack
      - Will require another hack first to be able to hijack a game's

        save game signing

  + Network compromise
      - Fuzzing services/network connections
  + File system drivers
      - Manipulating entries like the partition table, etc [Hard Drive

        Mod.htm \[1](https://web.archive.org/web/20141105161019/http://llamma.com:80/xbox360/mods/USB%20Hard%20Drive%20Mod.htm)\]

  + Decompression routines
      - Cause a buffer overflow

#### Hardware

  + DMA attack
      - Someone has developed an exploit for Firewire DMA [FireWire -

        all your memory belongs to
        us](https://web.archive.org/web/20130216101933/http://md.hudora.de/presentations#firewire-cansecwest)

      - Firewire can copy data between two firewire hdd without using

        the cpu at all (no irq gestion ...)

      - Maybe retrieve some data that can't be retrieved
      - USB and IDE that have DMA
          - Maybe it doesn't work with non-Firewire devices
      - Video: [\[2](https://web.archive.org/web/20060427215314/http://lufgi4.informatik.rwth-aachen.de/movies/)\]

        [for linux](http://libquicktime.sourceforge.net/)

  + Manipulated USB

    device

      - Webcam
      - IPod

#### Torx and Solder

  + [Boot](http://www.free60.org/index.php5?title=Boot&action=edit&redlink=1)

    suggests various CPU parameters including Hypervisor mode and boot
    vector are set by I2C/SPI bus on start up. If the I2C/SPI bus is
    accessible and modifiable then security features could be disabled
    allowing another vector to succeed.

  + Theories are floating around some forums as to the validity of

    hacking DVD drive firmware to authenticate all discs as OK. Firmware
    has some basic bitswapping and xor-ing which was defeated quickly,
    maybe potential to change it?

      - Good technical thread

        [here]https://web.archive.org/web/20060820135835/http://www.xboxhacker.net:80/forums/index.php?topic=76.0) at
        xboxhacker.net. Unfortunately, it starts in the name of backups,
        but it contains large amounts of insight as to how the DVD
        system functions. Signing code would still be a problem, but
        bypassing mediachecks could help at least.

          - (Offtopic) If it is possible to modify the firmware, would

            it then not also be possible to read the 'hidden' security
            areas on (for example) audio-dvd?

  + Buses
      - If some bus are accessible but at too much high speed(don't

        remember well the design of the 360 i must re-read the
        documentation and websites) maybe use of highspeed DAC or
        professionals osciloscope for electronic design or
        aviation(maybe some people have access to such devices) or
        home-made ones (using some dac of some
        cards(video-cards,tv-cards))

      - Easiest way to do DAQ is to use an NI DAQ system of allmost any

        kind (w/ fast enough DAC, something like FLASH-DAC)
        [\[3](http://www.ni.com/dataacquisition/)\]

      - Develop program for a snatching data from the bus. with high

        input impendances, megaohm range. If somebody is able to get
        those DAQ systems, i'm going to write a program for snatching
        data.

## Failed Vectors

To save people revisiting old ground please list any attempts that have
failed here

### Discussion

#### Page design

this is a stub or whatever you call this kind of page...

it's as a "brouillon(french)"

this page has not been reviewed by skilled persons...(mabe they haven't
got the time) this page could be reviewed by someone that is not a
developer(precious time) but is a press expert and know what is possible
and what isn't

so put evrything on the main page and discuss it on the main page it's
ment for this

and if something cleen and verified can be produced we will make another
"stable" page that developers should read

### IDEAS 

Xbox 360's OS has its root in the OS of the original Xbox (which is
derivate from Windows 2000). I think that some bug and exploit in Xbox 1
(or even 2000) still work on the 360, we have to try every
bug/fuzzing/hole knowed to find exploits.

Ideas :

* file format fuzzing (there are some tools in sourceforge), exampleÂ :

  image format like wmf (recent exploit in Win 2000 and XP plateform due
  to implementation of the fct escape() and not a BO\!\!\!\!\!)

* XMA is a very good way to find some holes, and Sounds aren't signed

  (Demo DVD) Someone has Doc about XMAÂ ? maybe in XACTÂ ?

* by network UPnP (use XML), it's seems that the norm think about

  security like not permit to send XML break char, or limit ACL hack, but
  if there are an XML implementation (lib XML) there are chance to find an
  exploit.

  We all know Microsoft's security in their implementation of norms (like
  IP stack or other).

* by DMA, using USB (security hole in Win 2000\&XP ohcpi) other way :

  IDE (sata), we can try to access to DMA with a PC connected to the
  Xbox...by SATA ; -) the idea is to use the PC like an IDE device for the
  Xbox 360. i'm reading the DMA-API and IDE doc for linux (if you have
  linux, interessting stuffs are in /include/Documentation/DMA-API.txt &
  DMA-mapping.txt and in /include/Drivers/ide/ )

* by threads, if we can use the GPU to access to RAM and acces to the

  same area as the CPU we can do some buggy things (in fact thread is not
  necessary)

resources :

* metasploit, a huge DB for exloits and shellcodes <https://metasploit.com/>

* milw0rm, exploits [milw0rm.com](https://web.archive.org/web/20100528133654/http://www.milw0rm.com/)

* fuzzing file and network [http://rtos.trinux.org/secwiki/FuzzingTools](https://web.archive.org/web/20060715225715/http://rtos.trinux.org:80/secwiki/FuzzingTools)

### XEX executables

What security problems are known about the XEX files. They can be burned
to DVD/CD and used to install the backwards compatability emulator, so
attacking them would be a good idea. Since the OS for the 360 is based
on Windows, is the .xex file in any way related to .exe? .xex files
renamed to end in .exe do not do anything in Windows. I would like
further documentation on what happens when the emulation software is
executed via CD/DVD. --Monsuco 19:29, 9 Mar 2006 (CET)

The XBOX360 CPU is based on the PowerPC architecture, not on Intel like
PC CPUs. For that simple reason, an XBOX360 executable will never run
under a PC version of Windows.--Silence 10:59, 10 Mar 2006 (CET)

First guy is absolutly retarded \>_\> -Thilo

### XNA

* The XNA libraries are . Net wrappers around various DirectX libraries

  (XACT, XInput, Direct3D, etc), and runs on the . NET Compact Framework.
  Both frameworks are fairly large and complex and it could be a possible
  candy store for exploits.

[Category: Support](Category_Support)
