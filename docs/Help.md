## IRC

Server ⇒ <font color="purple">irc.oftc.net</font>(irc.oftc.net)
Channel ⇒ \#free60 ; \#free60-chat ; \#free60-dev
or if theres nobody replying try:

Server ⇒ <font color="purple">irc.efnet.nl</font>
Channel ⇒ \#libxenon

\== Want to Help? ==

Here is what you can do to help this project:

  - Documentation: We need the individual bits\&pieces, for example from
    xboxhacker.net, nicely assembled into wiki pages, Howtos etc. This
    does not require coding skills\!
  - Head over to
    **[here](../Category:Pages_that_need_to_be_cleaned_up)**
    for a list of pages that need some work done on them.
  - Or you can go
    **[here](../Category:Pages_with_missing_images)** for a
    list of pages that need images uploaded.
  - Take a look at wiibrew.org: They have nice categories for the
    available software, features applications etc.
  - Tell more people about what you can do with Linux on the 360.
  - We need more applications so people have a reason to try out free
    Libxenon based code and Linux on 360.
  - Work to implement End User Requirements
  - Test and improve the Linux live CD images
  - Add useful ideas to this list.

## Seeking Information On

Some documentation must already exist, though perhaps not in the wild.
We are seeking:

  - CPU instruction set reference --\> See VisualStudio 2005 Reference
    (Exact CPU instruction set reference)
  - Verification that the CPUs have a memory management unit (can do
    virtual memory)
  - Details of Multi-processor memory coherency and synchronization
    requirements

## Documentation To Develop

Some documentation will either not exist, or won't be made available

  - Memory usage map for boot code
  - Hypervisor details. What is checked and how it is checked
  - Chain of trust: how execution integrity is designed to work
  - Chinks in the armor: Holes in the chain of trust
  - <s>Hard drive locking (if any) and</s> filesystem details
    ([Harddrive](../HDD))
  - Wireless hardware and software protocol for controllers
  - Xbox1 software emulation details

## XeLL / Libxenon

  - \[Libxenon\]: Improve Libxenon and write apps.
  - <s>\[Libxenon\]/\[XeLL\]: Fix the usb driver so it gets proper speed
    and Power supply does not need to get replugged to get usb mass
    storage recognized</s> DONE
  - \[Libxenon\]/\[XeLL\]: Write a fatx/xtaf driver
  - <s>\[XeLL\]: Implement parsing of a bootconfig + passing
    bootarguments to the linux kernel</s> DONE
  - <s>\[XeLL\]: Fix non-workin XeLL-XeLL implementation (chainload XeLL
    from a "base XeLL")</s> DONE

## Xenon linux kernel

- Needs urgent fixing: Linux Kernel - a hardware CPU bug causes
  powerpc locking primitives to fail between hyper threads unless a
  special register is set properly
- Fix usb driver (random freez under heavy usage)
- Patch RTC driver for hardware clock access
- Xenosfb: add support for mode switching
- Audio driver
- If possible: Modify the ATI 3D driver to work with the Xenos-Chip

## Linux Live CD / Installer

- Open a Boot Menu with the following options:
    - Load \[Linux Kernel\] from HDD (default, 10s timeout? auto
      detection of valid Linux HDD?)
    - Load \[Linux Kernel\] from CD and use root filesystem on HDD
    - Load Rescue/Installer Linux LiveCD
    - Load Linux over TFTP (optionally configuring the network)

The Menu can either be created in XeLL (requiring reading from CD, SATA,
plus interactivity over serial / IR remote or USB controller), or
possibly in a Linux initramfs (which is easier to implement, but locks
the user in to one single kernel)

[Category:Support](../Category_Support)
