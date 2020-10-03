Since there seems to be little to none documentation about this so I've
decided to write up a guide to help all the up-and-coming hackers in the
scene.

# Requirements

  + IDA Pro (This costs money, it's recommended you buy a license)
  + PPC Altivec plugin (ver. 1.8 is recommended)
  + Decrypted loader (1BL/CB(_A)/CB_B/CD/CF)
  + Kernel with symbols, find this at usual places (Also, match these up

    by the date modified and put the pdb in same folder as exe)

# Reversing

## Finding the entrypoint

The entrypoint of the loader is located at offset 0x8-0xC in the [loader
header](Bootloaders "wikilink"), once you've found the entrypoint the
reversing can begin.

## Analyzing the loader

Open the loader in IDA Pro and make sure it's loading as a binary file
with the processor type set to PowerPC: ppc. Once you've done that a
dialog should appear asking if you want it to be mapped to ROM or RAM, 
leave this screen as it is and just press OK.
IDA will then notify you that since it's a binary file the entrypoint is
unknown, so press G to show the go to address screen and put in the
entrypoint you found earlier.
Press C to turn this entrypoint into code and start IDA's analysis. This
should only take a few seconds and then the entire bootloader should be
fully analyzed.

## Finding functions

I wasn't going to post this publicly for fear of MS updating their
bootloaders to use different code, but I realized that keeping info back
is for kids.
Thankfully Microsoft use the same code for the most of the functions in
the bootloaders as they do in the kernel, if you have a copy of the
kernel and symbols (available in certain private SDKs..) you can just
find the functions in the kernel, copy the hex code for them (make sure
none of the branch instructions are in the code, as these use static
offsets) and search for that hex in the bootloader. If you've done it
correctly you should come across code in the bootloader which looks near
identical to the code in the kernel. Just rename the sub to what it's
called in the kernel and you've successfully "reversed" a section of the
bootloader : D

(also, before anyone complains to me about this I know this is the
"noob" way of doing it, but its much easier then having to trawl through
code)

### Functions used by the bootloaders

Note, this list is incomplete, I've only included functions used for
authentication/decompression here, also some loaders don't include all
these functions.

  + LDICreateDecompression
  + LDIDecompress
  + LZX_Decode
  + LZX_DecodeInit
  + LZX_DecodeNewGroup
  + XeCryptBnDw_Copy
  + XeCryptBnQwBeSigDifference
  + XeCryptBnQwBeSigFormat
  + XeCryptBnQwNeCompare
  + XeCryptBnQwNeModInv
  + XeCryptBnQwNeModMul
  + XeCryptBnQw_Copy
  + XeCryptHmacSha
  + XeCryptHmacShaFinal
  + XeCryptHmacShaInit
  + XeCryptMemDiff
  + XeCryptRc4Ecb
  + XeCryptRc4Key
  + XeCryptRotSum
  + XeCryptRotSumSha
  + XeCryptShaFinal
  + XeCryptShaInit
  + XeCryptShaTransform
  + XeCryptShaUpdate

## Finding authentication procedures

Almost all the authentication subs in the bootloaders use
XeCryptRotSumSha, once you've managed to find that function you can just
do "Jump to xref to operand..." to find them. The bootloader decryption
routines all use XeCryptRc4Ecb, if you find that you can find the
decryption routines quite easily.

### Tips

  + If you see the value 0x3C0030 in the function, this is used during

    CF decryption/authentication. You've just found the function used to
    decrypt/auth CF.

  + li r3, 0 is used to return that the decryption/auth failed, if

    theres any branches to code which has this then that means the
    branch is only used if a check fails, if you want to make it so you
    can run the next bootloader unauthenticated you could just nop (60
    00 00 00) out all the branches to this code.

  + Patching the call to XeCryptRc4Ecb with nop will disable encryption

    for the next loader, this is what the glitch hack build.py does to
    the CB_B of slims, along with patching out the branch to the panic
    function.

  + All of the bootloaders have a function to handle post output during

    boot. If you find that function, you can follow its references and
    use the post codes from [POST](POST "wikilink") to step through each
    bootloader and figure out what each one is doing.

  + Please keep in mind that the newest versions of the bootloaders had

    their post codes removed due to the RGH hack relying on them.

## Code Snippets

### panic

    panic:
         li    r0, 0         # Load Immediate
         mtspr CTRL, r0      # Move to sprg,
         b     panic         # Branch

### post output

    #Sends the lowest byte of r4 to the post buffer
    post:
        sldi    r4, r4, 56
        std r4, 0(r3)
        blr

# Reversed Bootloaders

The following bootloaders have already been reversed and posted:

  + [1bl Code](1bl_Code "wikilink")
  + [CB Code](CB_Code "wikilink")
