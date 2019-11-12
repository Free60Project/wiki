# General Information

Development kits have an undocumented, internal feature called 'shadow
booting' which allows them to enter an alternate boot chain during the
[boot process](Boot_Process "wikilink"). By placing a specially crafted
file titled 'xboxromw2d.bin' on the root of the system's hard disk, on
bootup the system will start, begin the process, then reboot again,
finally completing the boot sequence having loaded from the bootloaders
from the file on disk. Shadowbooting allows you to apply patches to any
part of the system software stack from the 2BL up without reflashing the
NAND.

Once booted from shadowboot, the alternate bootloaders are loaded into
memory just the same as a normal boot sequence: analyzing a NAND dump
from a live shadow booted system (the flash dumped while the system is
running) shows the SB, SD, and SE bootloaders on the system.

Shadow booting has long been held a closely guarded secret within the
community, where only recently have its existence become widely known
due to their use with Xbox Live challenge bypass services.

## Test Kits

Unlike full development kits, test kits are limited in their ability to
do kernel debugging among other restrictions. Test kits run on a
different software stack than dev kits, and as such require their own
shadowboot during updates. ISO recoveries contain two shadowboot ROMs,
'xboxromw2d.bin' and 'xboxromtw2d.bin', which will initiate shadowboot
on dev and test kits, respectively.

## Obtaining a shadowboot ROM

Shadowbooting is used in the recovery process.

### ISO Recoveries

Open an ISO recovery with an archiver and you will find the
xboxromw2.bin and xboxromtw2.bin files. These are the "clean" shadowboot
sources from which we base our modifications.

### Remote Recoveries

Remote recoveries also contain many shadowboot files (60 files) of
varying sizes.

# File Structure

Found in recovery images, shadowboot files are binaries titled
'xboxromw2d.bin' and 'xboxromtw2d.bin'. Full development kits will find
and boot from xboxromw2d.bin and test kits xboxromtw2d.bin. Shadowboot
files are always 832KB (851,968 bytes).

Structurally, shadowboot files are nearly identical to [flash
dumps](NAND_File_System "wikilink"), but for obvious reasons they do not
contain mobiles or filesystems.

| File Structure |
| -------------- |
| Section        |
| File Header    |
| SMC            |
| Keyvault       |
| 2BL            |
| 3BL            |
| 4BL            |
| 5BL            |

## File Header

| File Header                                     |
| ----------------------------------------------- |
| Section                                         |
| Magic bytes                                     |
| Major Build                                     |
| QFE?                                            |
| Flags                                           |
| SB offset                                       |
| CF1 offset/Size?                                |
| Microsoft copyright                             |
| Padding                                         |
| KV size?                                        |
| CF1 offset?                                     |
| Patch slots                                     |
| KV version                                      |
| KV offset                                       |
| Patch slot size? Metadata style? (360FlashTool) |
| SMC config offset                               |
| SMC length                                      |
| SMC offset                                      |

On shadowboot ROMs the build number will be the major XDK flash version
(ie. 21250). On the hacked 16547 shadowboot ROM it is 16547 On a cold
flash dump, the build number will always be 1888.

On xboxromtw2 shadowboot ROMs, the SB offset is 0xc0000 whereas on both
normal ROMs and NAND dumps it is 0x8000

On NAND dumps the CF1 offset is 0x080000 while on shadowboot ROMs it is
0x0d000

The Microsoft copyright notice is as follows (ASCII) followed by a null
byte terminator (0x00)

`© 2004-2011 Microsoft Corporation. All rights reserved.`

Note that later NAND dumps may have updated the years in this string.

The unknown flag at 0x70 reads 0x0002(0000) on the NAND dump and
0x0001(0000) on the shadowboot ROMs

The 360FlashTool changelog notes the value at offset 0x71 as the
'metadata style,' where "0 = Original, 1 = New 16MB, 2 = Large Block"

  - I am unsure about the size of all of the data after the copyright
    notice, and especially unsure of everything near 0x70.

## Keyvault

The keyvault data section is entirely zeroed through, meaning that there
is no keyvault. The KV data is probably loaded into RAM on the first
startup sequence using the console's native bootloader's and may remain
untouched by the shadowboot bootloader.

# Boot Process

Development kernels contain a series of subroutines to find, validate
and execute shadowboot ROMs found on various media. The first subroutine
in this shadowboot process is
[ExpTryToShadowBoot](ExpTryToShadowBoot "wikilink"), followed by
[ExpTryToBootMediaKernel](ExpTryToBootMediaKernel "wikilink"),
[KiShadowBoot](KiShadowBoot "wikilink"),
[KiQuiesce](KiQuiesce "wikilink"), and finally
[HvxShadowBoot](HvxShadowBoot "wikilink").

The fact that these subroutines cannot be find in bootloaders prior to
SE implies that the system must fully reach the kernel before rebooting
into the shadow kernel.

## Media

The shadowboot process will attempt to boot from media in the following
order

1.  Remote - ExpMediaKernelKdRemoteBuffer - "host:\\\\xboxromw2d.bin"
2.  CDRROM - ExpMediaKernelCdRom0Buffer
    "\\\\Device\\\\CdRom0\\\\xboxromw2d.bin"
3.  Flash - Flash media kernelExpMediaKernelFlashBuffer
    "\\\\Device\\\\FlashFs\\\\xboxromw2d.bin"
4.  Hard disk - ExpMediaKernelHd0Buffer
    "\\\\Device\\\\Harddisk0\\\\Partition1\\\\xboxromw2d.bin"

# Security Measures

## Encryption Schema

Shadowboot bootloaders use a very similar encryption schema to retails
with CB \<=1920 but for the presence of SC. Beginning with CB 1920, the
retail CD bootloader encryption key also uses the CPU key, whereas SD on
shadowboot ROMs does not.

### RC4 Key

Each bootloader holds a random 'salt' value that is used in the
calculation of its RC4 key.

The key is derived from a 'secret' from the previous bootloader's key,
originating from the hardcoded key in the 1BL. The key is the 16 (0x10)
byte truncated HMAC-SHA1 digest of the secret appended with a random
salt.

`key = HMAC-SHA(previous_key + salt)[0:0x10]`

The bootloader's 'payload' (everything after 0x20 for SB/CB,
SC,SD/CD,SE/CE,CG everything after 0x30 for CF) is encrypted with RC4.
The decryption process looks like:

`decrypted = encrypted[0:0x10] + key + decrypt_RC4(key,
encrypted[0x20:]`

#### 2BL Key

As an example, you calculate the 2BL RC4 key by reading out its salt
from 0x10 to 0x20. Calculate the HMAC SHA of this salt using the 1BL key
as the secret. The RC4 key is the first 0x10 bytes of this digest.

#### 3BL Key

The 3BL (SC) is the exception to the rule. Its key is not generated
using the RC4 key from the 2BL, but its secret is instead 0x10 null
bytes.

#### 4BL Key

Calculate the 4BL RC4 key by reading out its salt from 0x10 to 0x20.
Calculate the HMAC SHA of this salt using the 3BL RC4 key as the secret.
The 4BL RC4 key is the first 0x10 bytes of this digest.

#### 5BL Key

Calculate the 5BL RC4 key by reading out its salt from 0x10 to 0x20.
Calculate the HMAC SHA of this salt using the 4BL RC4 key as the secret.
The 5BL RC4 key is the first 0x10 bytes of this digest.

## Signature

There is a common misconception to shadowbooting where we are able to
replace everything from the 2BL onward. While shadowboot ROMs contain a
nearly complete NAND image, the 2BL (and subsequently the 3BL) are still
protected by signature checks with the 2BL private key.

The fundamental difference in bootloader security between retail and
devkit is the replacement of precomputed hashes in retail bootloaders,
where the only signature checks occur on 2BL, CB, and the 6BL, CF; on
devkits, most of these hash checks are instead replaced with signature
checks. On both the cold boot as well as shadowboot, the 2BL is verified
with a signature check, which subsequently verifies SD with a signature
check.

[Category:Xbox360 System Software](Category_Xbox360_System_Software)