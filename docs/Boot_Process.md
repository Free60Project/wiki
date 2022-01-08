# Boot process

This page details the boot process used in the Xbox 360. The process is
slightly different between Devkit/Retail and certain boxes which have a
secondary CB loader (trinity/some jaspers)

## Retail

In Summary:

- Slim: 1BL -> CB_A -> CB_B -> CD -> CF -> CD -> HV -> Kernel -> Dashboard
- Phat (older): 1BL -> CB -> CD -> CF -> CD -> HV -> Kernel -> Dashboard
- Phat (newer): 1BL -> CB_A -> CB_B -> CD -> CF -> CD -> HV -> Kernel -> Dashboard

### 1BL (Inside CPU)

Loads and decrypts CB(_A) into ram, it computes a RotSumSha1 of CB(_A)
and uses it to verify its RSA signature. If the signature is valid, 1BL
jumps to CB(_A).

You can find reversed pseudocode of the 1bl here: [1BL Code](1bl_Code.md)

### CB

**SLIMS ONLY**: CB_A loads and decrypts CB_B into ram, it computes a
RotSumSha1 of CB_B and checks it against the known hash. If it matches
CB_A jumps to CB_B.

CB(_B) starts up a virtual machine, which does:

    - initializes the PCI Bridge
    - disables the GPU PCIE JTAG test port
    - initializes the serial port
    - talks to the SMC to clear the "handshake" bit
    - initializes memory
    - generates RROD if memory init fails

CB(_B) loads and decrypts CD into ram, it computes a RotSumSha1 of CD
and checks it against the known hash. If it matches CB(_B) jumps to CD.

Methods to dump the CB bootloaders and examples of them reversed can be
found here: [CB Code](CB_Code.md)

### CD

Loads and decrypts CE into ram, computes a RotSumSha1 of CE. If it
matches the known hash, it decompresses the LZX compressed base
kernel.
It then checks for patch slots. If it finds one, it will load and
decrypt the corresponding CF bootloader for that patch. It then computes
a RotSumSha1 of CF and uses it to verify the CF loaders signature. If
the signature is valid, CD stays in memory but jumps to CF.

There can be up to 2 CF/CG pairs for patching the kernel.

### CF

Loads CG into memory by reading the CG data in the NAND header and then
reads the rest of the CG data from the CG blocks specified in CF header.
It then decrypts the CG in memory using the key generated from
decrypting CF. To verify it, it computes a RotSumSha1 and checks it
against the known hash. If it matches, it uses LZX delta decompress to
apply the patch to the base kernel in memory. Once its done, it jumps
back to CD and once CD has finished up, it jumps to the reset vector in
the [Hypervisor](Hypervisor.md).

## Devkit

In Summary:

- Phat: 1BL -> SB -> SC -> SD -> HV -> Kernel -> Dashboard

The devkit bootloaders are nearly identical to their retail
counterparts; however instead of hardcoded hash checks, devkits verify
bootloaders SD and SE by signature checks.

The SC bootloader is the hardware initialization virtual machine run by
SB.

Because devkits do not update over the air, they use a pre-patched SE
(HV + kernel) bootloader) without delta patching CF/CG pairs.

### Kernel

Once control is handed off to the kernel, as denoted by the
[POST](POST.md) output, the kernel does the following (on
development systems):

- Initialize memory manager
- Initialize stack(s)
- Initialize object system (?)
- Initialize phase 1 thread (?)
- Phase 1 initialization and processors initialization
- Initialize keyvault
- Initialize [HAL](https://en.wikipedia.org/wiki/HAL_(software)) phase 1
- Initialize SFC driver (?)
- Initialize security (?)
- INIT_KEY_EX_VAULT
- Initialize settings (?)
- Initialize power mode
- Initialize video driver
- Initialize audio driver
- Initialize boot animation
    - Loads bootanim.xex
- Initialize SATA driver
- Initialize [Shadowboot](Shadowboot.md) (not on retail
  systems)
- INIT_DUMP_SYSTEM (?) (not on retail systems)
- INIT_SYSTEM_ROOT (?)
- Initialize other drivers
- Initialize [STFS](STFS.md) driver
- Initialize XAM

## Core OS Executables

After its initialization sequence, the kernel loads the following
executables (in order)

- xam.xex
- xbdm.xex
- xstudio.xex
- ximecore.xex
- Xam.Community.xex (from disk)
- huduiskin.xex
- xshell.xex (devkits) / dash.xex (retail)

It then unloads the following:

- huduiskin.xex
- bootanim.xex

By this time the console will have booted into the dashboard

[Category:Xbox360 System Software](Category_Xbox360_System_Software.md)
