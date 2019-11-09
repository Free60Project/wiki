![KL_Microsoft_XBOX_380_CPU_ES.jpg‎](KL_Microsoft_XBOX_380_CPU_ES.jpg‎
"KL_Microsoft_XBOX_380_CPU_ES.jpg‎") **Xenon** is the CPU that is used
in the Xbox 360. The processor, internally codenamed *Waternoose* by IBM
and XCPU by Microsoft. "The basic design is a 64-bit *PowerPC*
architecture, with the complete *PowerPC ISA available*."
It is different from the Intel Pentium III in the original Xbox: the
*Xenon* CPU is composed of three symmetrical cores on a single die, each
core has two symmetric hardware threads (SMT), for a total of six
hardware threads available to games. Each individual core also includes
32 KiB of L1 instruction cache and 32 KiB of L1 data cache.

## Specifications

  - The package is a 2-2-2 FC-PBGA, measuring 31mm by 31mm
  - 168 mm2 die size; one cpu core is about 28mm2
  - Support logic for Array and Logic Built in Selftest
  - 165 Million transistors
  - Three symmetrical cores running at 3.2 GHz each = 9.6Ghz throughput.
      - 32 KiB of L1 instruction cache and 32 KiB of L1 data cache per
        core
      - 64 bit CPU cores based on the IBM 970 "G5" design
      - Each core is two way SMT-capable and clocked at 3.2Ghz
      - 2× (128×128 bit) register files for each core
      - Two hardware threads per core; six hardware threads total
      - VMX-128 vector unit per core; three total
      - 128 VMX-128 registers per hardware thread
  - 1 MB L2 cache
      - (lockable by the GPU) running at half-speed (1.6 GHz) with a
        256-bit bus
      - 51.2 gigabytes per second of L2 memory bandwidth (256 bit × 1600
        MHz)
  - 21.6 GB/s front side bus (aggregated 10.8 GB/s upstream and
    downstream)
  - 115 GFLOPS theoretical peak performance
  - CPU Integer Perf (VPR): 1089 (363 each)
  - Dot product performance: 9.6 billion per second
  - IBM eFuse technology
  - IBM's PowerPC instruction set architecture
  - Restricted to In-order code execution
  - Big endian architecture

## Linux Support

  - We have full SMP support, so we can use all three cores.
  - However, we currently need to disable the secondary threads because
    of a yet-to-be analyzed stability issue.
  - The CPU is quite slow on general purpose code. Due to the non
    out-of-order execution core, it heavily relies on the compiler to do
    proper optimizations. GCC currently doesn't know how to do this,
    resulting in running but very inefficient code.
  - The Cell people worked on PPU-GCC, from which the Xenon will benefit
    as well, as the PPC cores is quite similiar to the Cell's PPU. All
    PPU-GCC work have been merged on mainline GCC 4.4

## External Links

  - [Application-customized CPU design: The Microsoft Xbox 360 CPU
    story](https://web.archive.org/web/20081205055833/http://www-128.ibm.com:80/developerworks/power/library/pa-fpfxbox/index.html?ca=drs-)
    Jeffrey Brown, Distinguished Engineer, IBM
  - ["Power" Architecture
    Technology]https://web.archive.org/web/20090213042736/http://www.ibm.com/developerworks/power) at IBM
  - [SoC drawer: The resource
    view](http://www.ibm.com/developerworks/library/pa-soc1/) at IBM
    (mentions Xbox CPU design. Gets nitty gritty on resources and
    scheduling, i/o interconnects, & on chip memory)
  - Just like being there: Papers from the Fall Processor Forum 2005:
   [Application-customized CPU design](https://web.archive.org/web/20090501114949/www.ibm.com/developerworks/power/library/pa-fpfxbox/)
   at IBM (Explore the customized IBM PowerPC processor designed for
   the Microsoft XBox 360)
  - [Xenon hardware overview](https://xbox-scene.xbins.org/forums/index.php?showtopic=231928)
    by Pete Isensee, Development Lead, Xbox Advanced Technology Group,
    written some time before 23 June 2004
  - [Ars Technica explains the Xenon CPU](http://arstechnica.com/old/content/2005/06/xbox360-2.ars)
  - [Xbox360 CPU](http://en.wikipedia.org/wiki/Xenon_(processor)) at
    Wikipedia
  - [PowerPC 970](http://en.wikipedia.org/wiki/PowerPC_G5) at Wikipedia
  - [PowerPC](http://en.wikipedia.org/wiki/PowerPC) at Wikipedia
  - [POWER4](http://en.wikipedia.org/wiki/POWER4) at Wikipedia
  - [CPU Chip for Xbox 360 Manufacturing Overview, FSB, PPC Core, VMX & FPU, & L2 Cache block diagrams](https://web.archive.org/web/20100328024533/http://www.ccw.com.cn/notebook/pczx/sy/htm2005/20051028_16OMI.htm)
    from IBM

[Category:Xbox360_Hardware](Category:Xbox360_Hardware "wikilink")