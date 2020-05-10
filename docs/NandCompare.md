# NANDCompare

### NFO

```
nand compare (v1.4):
--------------------

  i made 6 reads of my nand with no matches (one of them was good but of course i
  didn't know that at the time), but diffing them i could see that the differences
  where spread all throughout the file, so i wrote this tool to reconstruct it

  then i also discovered the usefulness of the compare function in verification of
  the write, so hopefully this tool will be of use to other people

  please send feedback, bugs, etc. to rab (richardaburton@gmail.com) or post in
  the thread on xbox-scene or xboxhacker


the tool has two functions:
---------------------------

- compare 2 nand images
  better than simply using md5 as it tells you which blocks are mismatched, which
  allows you to reread only those that are in error rather than the entire chip
  (speeding up the process)

  one use of this is when verifying a write by reading back the nand and comparing
  it against the original you wrote, if you get a bad block just reread that
  individual block, patch it into the full read and compare again (files are
  reread each time you click compare, no need to reselect the same files in the
  gui)

  e.g. nandpro lpt: -w16 XBR.bin (write image as normal)
        nandpro lpt: -r16 verify.bin (read back image)
        (do comparison, shows block 2e mismatches)
        nandpro lpt: -r16 2e.bin 2e 1 (read block 2e)
        nandpro verify.bin: -w16 2e.bin 2e 1 (patch this new read into verify image)
        (do comparison again, if still bad rewrite just this block and read it back again as above)


- reconstruct image from 3 bad reads
  assumes that read errors don't occur in same place each time, which is true for
  some read errors (e.g. lpt timing problems), if there is a good reason why you
  can't read something then this may not be true

  this tool cannot recreate a nand out of nothing, if you give it 3 files full of
  zeros you'll get a recreated nand full of zeros, always look at a dump to make
  sure it looks correct (e.g. has a microsoft copyright at the top, once you've
  reconstructed a nand open it in 360 flash tool and make sure it reads ok there)

  the tool works by comparing blocks between the 3 files, any block found matching
  in 2 (or 3) of the files will be considered good, you will be warned if not all
  blocks can be recovered, in which case you'll need to get more reads or look for
  a good reason why your reads are so bad


version history:
----------------
  1.4 (2010/01/23) - support any size image (any number of blocks at 0x4000 + ecc)
                      for partial dumps of large nands, 2mb xell backups, etc.
  1.3 (2009/12/18) - reduce block size for 256/512mb nands (to 0x4000 + ecc) based
                      on user feedback (nandpro uses small block numbering so our
                      output didn't match up with nandpro)
                    - make gui more responsive when operating on large nands
  1.2 (2009/12/15) - support for 256mb nand
                    - use correct block size for 256/512mb nand (0x20000 + ecc)
                    - added progress bar
  1.1 (2009/12/13) - support for 512mb nand (assumes same block size as 16mb)
  1.0 (2009/12/12) - first release
```


[Category:Xbox360_Homebrew_Software](../Category_Xbox360_Homebrew_Software)