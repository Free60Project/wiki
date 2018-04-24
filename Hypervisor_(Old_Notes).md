hypervisor

no booting details known changes between beta hardware and final: alpha
hardware = macintosh beta = ? looks like retail, but no encryption
second beta =\! retail

tried to dump RAM could only dump virtual memory ram is at 8000_0000
southbridge: pci config space, mapped to VM, accessible by user apps
memory at bottom looks random/encrypted, might be hypervisor 256 KB

8040_0000 xbox kernel starts, MZ header

read memory using debug interface: everything is in plaintext, you can
read kernel + app (dashboard etc.), i.e. virtual memory is not encrypted

kernel interesting to disassemble communication with hypervisor using
syscalls

hypervisor does
interrupts/exceptions

syscalls:

_________________________________________

final:

SC 00: GetVersionCode (e.g. r3=072F8002)

SC 01: KeStartupProcessors

SC 02: unknown KiQuiesce

SC 03: KeFlushEntireTb

SC 04: called in FlushMultipleTb

SC 05: ??

SC 06: KeGetSpecialPurposeRegister (r3=0x3F5)

SC 07: KeSetSpecialPurposeRegister

SC 08: KeGetSocRegister(r3=???)/KeGetPWMRegister(r3=60000)/
KeGetPRVRegister(r3=61000)

SC 09: KeSetSocRegister

SC 0A: KeStartupProcessors

SC 0B: called in ReserveKernelPtes

SC 0C: called from MmAllocatePhysicalMemoryEx

SC 0D: setAD16

SC 0E: KeEnablePPUPerformanceMonitor

SC 0F: called from MmGetPhysicalAddress

SC 10: called from MmDbgReleaseAddress

SC 11: XexpLoadFile calls it, seems to get privkey

r4 = phys addr (of header?) offset: +8

r5 = region

r6 = ?? offset: +4

r7 = ?? size?

SC 12: called from MmAllocateImageMemory

SC 13: called from MmAllocateImageMemory

SC 14: called in XexpLoadFile

SC 15: called in XexpLoadFile

SC 16: called in XexpCompleteImageLoad

SC 17: called in XexpCompleteImageLoad

SC 18: called in XexpLoadFile, XexpCompleteImageLoad

SC 19: unload?

SC 1A: unload?

SC 1B: unload?

SC 1c: called on XexpTitleTerminateNotification

SC 1d: KeCreateUserMode

SC 1e: KeDeleteUserMode

SC 1f: Flush TLB

SC 20: set power

SC 21: shadow boot

SC 22: f\*\*\* fuses

SC 23: FSB interrupt related

SC 24: KeLockL2

SC 25:

SC 26

SC 27

SC 28

SC 29

SC 2A

SC 2B

SC 2C: SataCdRomHvVerifyLBA

SC 2D

SC 2E: XeKeysInitialize (r3, r4 = address)

SC 2F: XeKeysGetKeyProperties

SC 30: XeKeysGetStatus

SC 31: XeKeysGenerateRandomKey

SC 32: XeKeysGetFactoryChallenge

SC 33: XeKeysSetFactoryResponse

SC 34: XeKeysSaveBootLoader

SC 35: XeKeysSaveKeyVault

SC 36: XeKeysSetKey

SC 37: XeKeysGetKey

SC 38: XeKeysGetDigest

SC 39: XeKeysQwNeRsaPrvCrypt

SC 3D: XeKeysDesCbc. r6: address, r5: context

SC 3F: XeKeysSaveSystemUpdate

SC 40:
XeKeysExecute

___________________________________________________

SC 22 =

tested on 2 kernels

first: SC "access fuses"

second: "burn fuses"

(rumour has it that this is used to make retail boxes out of debug
boxes)

memory management 0F/10: perhaps page table access code in hypervisor,
all high level code in kernel

you can't map memory as you like

network adapter in the southbridge

debug code dumps registers with names

it is possible to dump physical memory using network adapter DMA
accesses

not perfect dump

reading physical memory = encrypted

data segments are not encrypted, but nearly all code segments

older recovery cd (early 2005), worked on first beta developer kits,
without security enabled:

cd included kernel which included stuff that is encrypted in retail
version

includes hypervisor code\! it is old, but...

getspr: SC 6

setspr: SC 7 -\> possible to see implementation of basic syscall
handling

function in hypervisor to chain-run a new kernel from the old kernel

hypervisor: sign with private key etc.

hypervisor can only do physical memory

hashing: load into register base address, length, destination of hash
buffer, call syscode, hypervisor will hash -\> attack: hash 1 byte,
\*itself\*, -\> hangs

hypervisor lies at 0 in VM and physical mem