---
hide:
    - toc
---

# 360 Flash Tool

## NFO

```sh
This tool will allow you to decrypt and extract various parts of a Xbox 360 flash dump.
This tool will allow you to decrypt/encrypt and extract various parts of a Xbox 360 flash dump and much more!!
The flash is devided into 2 major parts

1) The Cx sections (CB,CD,CE & 0,1 or 2 CF & CG sections).
CB, CPU bootup
CD, unpacker for CE
CE, contains the HV and Kernel in a .cab archive
CF&CG are upgrade patches
The tool will extract and decrypt sections CB, CD, CE. Additionally it will extract the .cab file in section CE. This can be opened with winrar and the content (xboxkrnl.img) extracted. The first 256K of xboxkrnl.img is the Hypervisor, the remainder is the 2.0.1888 Kernel.

2) The Flash File System.
The tool expects a dump to contain the data (512 bytes) followed by the ECC (16 bytes). The ECC bytes are used to locate FS entries & identify the version.
The tool consists of the exe and CxKey.txt. CxKey.txt is delivered with 32 '0's and they should be replaced with the key obtained from the 1BL. After all the fuss about AACS keys recently it seems risky to put the key in the exe Wink The Cx sections extracted from a dump will only decrypt correctly if the correct hex digits are inserted in the CxKey.txt file

Version History
-----------------

(v0.97)
- Improved Nand Image detection
- Added support for small XeLL Images (1,3MB)
- Added ability to extract/import Slot0/Slot1 of ZeroPaired Images [XBR/freeBOOT/small XeLL]
- Added ability to detect/convert raw Images (made with external programmer) to proper read format
- Added ability to detect/convert Images without ECC data (made with Infectus device)
- Added ability to extract/import new 'dae.bin' file [DvdAuthEx]
- Added support for "Alternate KeyVault" decrypting/extracting
- Added option to rebuild an opened Nand Image with different CPU-Key (Bootloaders/HV and generic files)
- Added option in Settings to allow randomized encryption
- Added option in Settings to allow cut short BigBlock Nand Images (64MB)
- Fixed bug, regarding to saving config block checksum at wrong offset (in rare cases)
- Changed, more accurate file extraction, automatically create subfolders
- A lot of improvements and bug fixes

(v0.95)
- Added support for Trinity (XBOX360 Slim) dumps
- Added ability to extract new 'fcrt.bin' file (encrypted only atm)
- Added ability to display SMC Code Version
- Added ability to view Advanced KeyVault Info
- Fixed bug, patching KeyVault works again
- Fixed bug, no longer crashes if Bootloaders are small in size (in rare cases)
- Fixed bug, regarding to re-encrypting the SMC when the image is Zero Paired Image

(v0.94)
- Added static SMC Config editing [change CPU/GPU Fan Speed, Calibration Data, MAC Address, ....] (Thanks to q36)
- Added support for single file "config.bin" editing/converting via Drag'n'Drop
- Added ability to convert Xellous/NandPro raw SMC Config to different Styles and vice versa, e.g. for ibuild (Thanks to foouser)
// FreeBOOT SmallBlock Style 16Kb
// FreeBOOT BigBlock Style 128Kb
// FlashTool SmallBlock Style 64Kb
// FlashTool BigBlock Style 512Kb
// BinCrypt2 Style 32Kb
- Added checksum calculation for static SMC Config Block (Thanks to cory1492)
- Added ability to extract/import encrypted KeyVault without known CPU Key [For Advanced Users]
- Added ability to extract ibuild compatible files (..\freeBOOT\Data)
- Added ability to open 70MB images (dumped with nandpro "-r70")
- Added Option menu to enable/disable several features
- Added Tooltips and Glass Effect
- Bugfix in Multiple CPU Key handling
- Fixed a lot small bugs

(v0.93)
- Fixed CPU-Key detection/correction in Multiple Keys section
- Added ability to save KeyVault to file
- Added ability to export a registry file from all added Keys
- Added support to extract the Console Revocation List to a readable format 'dynamic_list.txt'
- Improved state indication via Progress Bar
- Minor changes

(v0.92)
- Added Support for Large Block nands (Jasper 256MB and 512MB nands)
- Added Support for DevKit images + region for DevKit
- Added Support for XBR/ZeroPaired images (still in development)
- Added Single CPU Key or Multiple CPU Key handling (max. 25 Keys)
- Added simple state indication via Progress Bar
- Added ability to display Bad Blocks with true image offsets
- Fixed bug in reading 7BL (CG) that have more blocks than specified in 6BL (CF)
- Fixed bug in reading bootloaders that are smaller than 1 block
- Fixed bug in kernel extract log with double slashes, more accurate extract log
- Fixed multiple memory leaks
- Fixed application can now start without Administrator Rights or UAC enabled
- Updated config block logic with new info
- Changed appearance for more read comfort

(v0.91) 2009-12-06
* Added, support for Jasper 16MB nands, Block ID and Block Version in a different location. Uses offset 0x71 to determine metadata style, 0 = Original, 1 = New 16MB, 2 = Large Block.
* Added ability to open ZeroPaired images, but WARNING this should be treated as read only. I suspect it will destroy the nand image if used to modify the file.

(v0.90)
- Bugfix, regarding to CD decryption. If you have a 1920+ CD version it doesn't decrypt CD properly. (by arnezami)
- Bugfix, if a CPU key starts with 00 then the program crashed. (by arnezami)
- Added, separate extract option for all important stuff (Security Data, Extended Key Vault, Console Revocation List, AP25 Challenge Database, Config Blocks)
- Added, console ID generation method (source from xorloser)
- Added, detection and correction of 1 wrong byte in the CPU-Key (by MODFREAKz)
- Added, XValue decryption (by Redline99)
- Added, support when raw extracting a file that it sets the Date/Time stamps as per original in Nand
- Fixed, decryption for "Console Revocation List" (Thanks to xorloser and Redline99)
- Fixed, "Kernels not extracted (CPU Key required, CD Ver == 1920)"
- Changed, full KV.bin extract and patch
- Added new OSIG types and unspoof possibility
- Added/Changed new regions
- 1BL, XEX1 and XEX2 are set as standard
- Improved exception handling
- Added Drag and Drop
- Changed Icon
- Code cleanup
- Fixed a lot of other small bugs


(v0.88B)
- Fixed the Region bug (HK/Asia <=> EU and AUS)
- Redesigned (XP style)


(v0.88A)
- A small upgrade allowing the secdata.bin file to be decrypted.
(You need the XEX and CPU keys then extract the filesystem and you will get a decrypted secdata.bin as well as a bunch of other stuff.)


(v0.88)
- The flash image can now be patched with modified SMC code and the 2BL hash is fixed up to allow the 360 to boot.
- You can also modify the Pairing Data and LDV in the headers.


(v0.87)
- Added, KV editting (change region, DVD-Key, OSIG type or import a new KV)


(v0.86B)
- Fixed bug (patching KV works again)
- 5787 contains a modified CF, this build of the tool will now extract the HV & Kernel correctly
(It doesn't change the way the extractor/patcher works but the change in CFs size broke my code)


(v0.86A)
- Fixes bug introduced in v0.85 when patching CB LDV
- Changed file filter to '*.bin'


(v0.86)
- Adds support for bad blocks (no more crashes if you have a bad block in you dump)


(v0.85)
- Added option to patch CB LDV
- Extract using new v1920 CD decryption
- Extracts SMC code


(v0.81)
- Adds the possibility to dump just the flash in 3 parts:
1) Cx Sections
2) KV
3) File System

Note: If you have bad flash blocks that prevent you dumping a particular area this will is a work around while I write some bad block handling code.


(v0.80)
- Fixed bug that ment xexp files were not applied correctly
- Updated to prefix the XEX2 header on the front of the decrypted/patched binary for compatibility with the IDA Pro XEX loader.
- Added the ability to re-encrypt and insert a KeyVault (by SeventhSon)


(v0.72)
- Fixed stupid no CPU key crash bug
- Applies the patches (xexp files) it finds to the xex.
(So, for a flash dump that contains: dash.xex (v1888), dash.xexp1 (v2241), dash.xexp2 (v2868))


(v0.70)
- There are upto 4 keys required by the tool, you can enter these by clicking the Keys button.
1) 1BL Key
2) CPU Key
3) XEX 1 the Key used by the HV when the an XEXs certificate flag has bit 2 set
4) XEX 2 the Key used by the HV when the an XEXs certificate flag has bit 2 clear

- The Extract button will cause the tool to extract as much as possible from the Flash dump to a directory you select. During the extraction process a log file (log.txt) is generated containing "Useful Stuff To Know":
If 1BL is known - CB,CD,CE,CF(s),CG(s), xboxkrnl.1888.exe and xboxkrnl.XXXX.exe(s) as before
If 1BL & CPU Key is known - KeyVault.bin
If XEX1 & XEX2 & ECC data are known the tool will extract and decrypt & decompress the XEXs in the flash dump. The decrypted XEX is named xxxx.xex.bin. More info about the xex (and its patches) is contained in the log file.

- Possibility to zero the pairing data in the CB section (tmbinc thought this caused the mfgbootlauncher.xex plus v1888 Kernel to be loaded) by clicking the Zero PD button. You do need the 1BL key but you DO NOT need your CPU key for this patch.
- The Patch button allows you to change the Lockdown Counter(s) in the CF sections, as before, you DO need your CPU key


(v0.61)
- Fixed bug, the decryption of CG works again so now you can extract the different HV/Kernel versions from CE
- Fixed bug, no longer crashes if it finds an invalid CG section
- Added, load dumps (with or without ECC data). A non ECC dump must be exactly 16MB, all the Cx sections, Kernels, Key Vault will decrypt but you don't get access to the Flash File System.
Note: (you cant dump a map of the ECC bytes and you cant save an image with a modified Lock Down Counter in CF.


(v0.60)
- Supports downgrading if you know your CPU key.
- The CG decryption is broken in this version.


(v0.51)
- Added, Flash Map option


(v0.50)
- Now decrypts and extracts the Key Vault (DVD Key, Serialnumber & Date of Manufacture). You will need your CPU Fuses as dumped by Xell.
- The CxKey.txt file has changed, you need to add a ',' and your CPU Fuse data.

Example:
XXXXXXXXXXXXXXXX,YYYYYYYYZZZZZZZZ
XXXXXXXXXXXXXXXX is the 1BL key
YYYYYYYYZZZZZZZZ is the fuse data (CPU Key)


(v0.40)
- Extraction of CE section is now working, you may now right click and select 'Extract' and get just the raw, decrypted CE Section or Kernel(s). (Thanks TheSpecialist)
- Selecting Kernel(s) causes the application to extract the base (typically 1888) HV and Kernel as an uncompressed file - "xboxkrnl.1888.exe".
- The option to extract them as a .cab file has now been removed. If 1 or both of the patch (CF/CG) slots are occupied they will be applied to the base kernel and the result is also written as a file - xboxkrnl.XXXX.exe.

For example, if you have a base kernel (1888) and 2 patches (2858 and 4552) in your flash dump, load into the tool, right click on CE and choose kernel(s) you will get 3 files
xboxkrnl.1888.exe The base HV & kernel, no patches
xboxkrnl.2858.exe The base HV & kernel, patched to 2858
xboxkrnl.4552.exe The base HV & kernel, patched to 4552


(v0.30)
- Fixed CG extraction (see NAND Layout thread for info)
- Reverted CE.cab to single file (Thanks Takires)
- Patch pairing data in CF and re-encrypt


(v0.20)
- Decrypts CF & CG (Thanks again tmbinc)
- The .cab file extracted from CE now contains 2 files, Hypervisor.bin and xboxkrnl.exe
- Exported sections now include version number in the name


(v0.10)
- Initial Release
```

[Category: Homebrew Software](/Homebrew)
