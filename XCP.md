## General Info

It's been found \[1\] that Xbox360 Live Arcade downloads files with the
extension .xcp over unencrypted http on port 3074 for content
distribution.

  - XCP stands for Xbox Content Package \(from
    [http://forums.xbox-scene.com/index.php?s=&showtopic=462911&view=findpost&p=3067263](https://web.archive.org/web/20141027135122/http://forums.xbox-scene.com/index.php?/topic/462911-xbox-marketplace-packages/#entry3067263)\)
  - XCP files are (in-order) encrypted and compressed (with zlib). Underneath, they are STFS containers.
    - XCP files from some categories ("Full Game Demos" being one of them) are *not encrypted*
  - It may be possible to use the avatar downloads to glean more info
    about the file format.
  - The communication is pure http and you can redirect traffic to a
    local webserver, however it does checksum the file
  - Content downloaded with licenses are locked to a 360 at purchase
      - Box A downloads trial
      - Box B can run the same downloaded trial
      - Box A upgrades trial to full
      - Box B can only run in trial mode (if available)
  - Content is downloaded and extracted into place
  - When upgrading to full license the 360 dials home and then some
    modification is made to lock content to the particular box

## First Generation Xbox

xcp files are not new to the Xbox 360.

  - Are encrypted Cabinet files
  - Encrypted with a public and symmetric key.
  - Keys needed for extraction.
  - Need tools to create our own without the Xbox SDK

[Category:Xbox360 System Software](Category_Xbox360_System_Software.md "wikilink")