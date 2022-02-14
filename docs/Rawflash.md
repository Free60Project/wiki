# Rawflash

### NFO

    place "nandflash.bin" on the root of a usb device
    start 2stage xell and shut off when prompted (replug power if you changed SMC)
    - by default it checks blocks before writing, and will NOT overwrite or erase any block with ecc/other issues (perfect for *** images with auto remaps)

    small change to libxenon was required to silence non-error messages

    tested on falcon, trinity and jasper 256

    v4: fix page offsets for bad block checks on big blocks (fixes problems when nandmu is present)
    v3: re-re-refix bad block skipping so it skips it in both the dump and flash instead of just in the dump
    v2: add big block support
    v1: initial version

[Category: Homebrew Software](/Homebrew)
