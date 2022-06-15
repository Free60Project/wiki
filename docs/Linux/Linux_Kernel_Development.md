# Linux kernel development

Currently we have the following patches working against 2.6.33 kernel:

- PCI: adding PCI_VENDOR_ID_MICROSOFT (trivial)
- Xenon CPU: adding Xenon into cputable
- Xenon Platform: adding Interrupt controller, SMP support, setup
- Xenon SATA: adding the sata_xenon libata driver
- Xenon SMC: adding support for the SMC , including RTC and
  communication with Ana.
- Xenon FB (ugly): adding support for tiled framebuffer
- Sound Support
- Pad Support

User:Bertl is currently working on them. Please contact him you want to
help on the [IRC](IRC).

Currently missing are:

- A sane way for framebuffer support.
- Better graphics support (changing resolutions etc.). We need to add
  the GPU to the Xell OF tree so Linux detects it correctly. We can
  probably reuse great part of the ATI/AMD open source drivers
  available.
- IR remote support

[Category: Linux](/Linux)
