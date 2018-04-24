To aid in analysis of the large ROM, a histogrammer was written that
takes blocks of size N and reports basic statistics on the histogram.
From this, one can infer the presence of ciphertext or plaintext. The
following is the histogram report for the ROM divided into 64-kbyte
blocks. One can see several plaintext regions dispersed among large
blocks of ciphertext.

Plaintext regions appear as high-standard deviation regions with a large
range. Blank regions appear as single value-only regions (0xFF).
Ciphertext regions have a low standard deviation and a small range,
since a good cipher effectively removes all spectral information from
the data
stream.

`0x00000000 - 0x00010000:`
` Min count:     C6 Max count:   10AD Avg cnt:     F9 Stddev:  FB Range: FE7`
` Min val: 0xC5     Max val: 0x00`
`0x00010000 - 0x00020000:`
` Min count:     DA Max count:    132 Avg cnt:    102 Stddev:  10 Range:  58`
` Min val: 0x9F     Max val: 0xBF`
`0x00020000 - 0x00030000:`
` Min count:     D6 Max count:    12D Avg cnt:     FC Stddev:   F Range:  57`
` Min val: 0x32     Max val: 0xA9`
`0x00030000 - 0x00040000:`
` Min count:     D7 Max count:    125 Avg cnt:     F7 Stddev:  11 Range:  4E`
` Min val: 0x7B     Max val: 0x1A`
`0x00040000 - 0x00050000:`
` Min count:     D5 Max count:    138 Avg cnt:     FE Stddev:  10 Range:  63`
` Min val: 0x79     Max val: 0x1E`
`0x00050000 - 0x00060000:`
` Min count:     D6 Max count:    132 Avg cnt:    102 Stddev:   F Range:  5C`
` Min val: 0x90     Max val: 0x3A`
`0x00060000 - 0x00070000:`
` Min count:     B1 Max count:   2795 Avg cnt:     DD Stddev: 26B Range: 26E4`
` Min val: 0x12     Max val: 0x00`
`0x00070000 - 0x00080000:`
` Min count:     77 Max count:   408E Avg cnt:   2096 Stddev: 1FF6 Range: 4017`
` Min val: 0x0A     Max val: 0xFF`
`0x00080000 - 0x00090000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00090000 - 0x000A0000:`
` Min count:      2 Max count:   C027 Avg cnt:   607D Stddev: 604B Range: C025`
` Min val: 0x05     Max val: 0xFF`
`0x000A0000 - 0x000B0000:`
` Min count:     8C Max count:   30B6 Avg cnt:   18B2 Stddev: 17F1 Range: 302A`
` Min val: 0x37     Max val: 0xFF`
`0x000B0000 - 0x000C0000:`
` Min count:     D7 Max count:    13A Avg cnt:    105 Stddev:  10 Range:  63`
` Min val: 0x84     Max val: 0x1A`
`0x000C0000 - 0x000D0000:`
` Min count:     DE Max count:    127 Avg cnt:     F9 Stddev:   F Range:  49`
` Min val: 0xBF     Max val: 0x9E`
`0x000D0000 - 0x000E0000:`
` Min count:     D3 Max count:    134 Avg cnt:     FE Stddev:  11 Range:  61`
` Min val: 0x1D     Max val: 0xBF`
`0x000E0000 - 0x000F0000:`
` Min count:     DC Max count:    134 Avg cnt:     FE Stddev:   F Range:  58`
` Min val: 0xCF     Max val: 0x41`
`0x000F0000 - 0x00100000:`
` Min count:     C4 Max count:    131 Avg cnt:    101 Stddev:  10 Range:  6D`
` Min val: 0x50     Max val: 0x8D`
`0x00100000 - 0x00110000:`
` Min count:     D4 Max count:    129 Avg cnt:    10B Stddev:  13 Range:  55`
` Min val: 0x82     Max val: 0xBF`
`0x00110000 - 0x00120000:`
` Min count:     D5 Max count:    12F Avg cnt:     FA Stddev:  10 Range:  5A`
` Min val: 0xD0     Max val: 0xC9`
`0x00120000 - 0x00130000:`
` Min count:     D9 Max count:    128 Avg cnt:     F8 Stddev:  12 Range:  4F`
` Min val: 0xF1     Max val: 0x68`
`0x00130000 - 0x00140000:`
` Min count:     D2 Max count:    12A Avg cnt:     EE Stddev:  17 Range:  58`
` Min val: 0xE0     Max val: 0x34`
`0x00140000 - 0x00150000:`
` Min count:     D9 Max count:    12F Avg cnt:     F3 Stddev:  14 Range:  56`
` Min val: 0x0B     Max val: 0x63`
`0x00150000 - 0x00160000:`
` Min count:     CD Max count:    12E Avg cnt:    101 Stddev:  10 Range:  61`
` Min val: 0xCF     Max val: 0x3D`
`0x00160000 - 0x00170000:`
` Min count:     D1 Max count:    122 Avg cnt:    10F Stddev:  15 Range:  51`
` Min val: 0xB4     Max val: 0xB9`
`0x00170000 - 0x00180000:`
` Min count:     DE Max count:    125 Avg cnt:     F6 Stddev:  11 Range:  47`
` Min val: 0x73     Max val: 0x3F`
`0x00180000 - 0x00190000:`
` Min count:     D7 Max count:    12D Avg cnt:     FD Stddev:  10 Range:  56`
` Min val: 0x19     Max val: 0x78`
`0x00190000 - 0x001A0000:`
` Min count:     D0 Max count:    12A Avg cnt:    103 Stddev:   F Range:  5A`
` Min val: 0xA3     Max val: 0x45`
`0x001A0000 - 0x001B0000:`
` Min count:     CC Max count:    131 Avg cnt:    10F Stddev:  16 Range:  65`
` Min val: 0xA9     Max val: 0x80`
`0x001B0000 - 0x001C0000:`
` Min count:     D9 Max count:    127 Avg cnt:    110 Stddev:  16 Range:  4E`
` Min val: 0xC1     Max val: 0xE0`
`0x001C0000 - 0x001D0000:`
` Min count:     D6 Max count:    12C Avg cnt:     FE Stddev:  10 Range:  56`
` Min val: 0x9B     Max val: 0x6B`
`0x001D0000 - 0x001E0000:`
` Min count:     B1 Max count:   20E1 Avg cnt:   10DA Stddev: FFE Range: 2030`
` Min val: 0xA4     Max val: 0xFF`
`0x001E0000 - 0x001F0000:`
` Min count:     D4 Max count:    12B Avg cnt:     F6 Stddev:  12 Range:  57`
` Min val: 0x0D     Max val: 0x47`
`0x001F0000 - 0x00200000:`
` Min count:     D3 Max count:    132 Avg cnt:    119 Stddev:  1E Range:  5F`
` Min val: 0xA0     Max val: 0x53`
`0x00200000 - 0x00210000:`
` Min count:     D5 Max count:    12F Avg cnt:     F8 Stddev:  11 Range:  5A`
` Min val: 0x7B     Max val: 0x9C`
`0x00210000 - 0x00220000:`
` Min count:     CF Max count:    134 Avg cnt:     FE Stddev:   F Range:  65`
` Min val: 0x4D     Max val: 0xFD`
`0x00220000 - 0x00230000:`
` Min count:     CD Max count:    129 Avg cnt:    10E Stddev:  15 Range:  5C`
` Min val: 0x1B     Max val: 0x47`
`0x00230000 - 0x00240000:`
` Min count:     9C Max count:   30D3 Avg cnt:   18CB Stddev: 17FD Range: 3037`
` Min val: 0x56     Max val: 0xFF`
`0x00240000 - 0x00250000:`
` Min count:     DA Max count:    12A Avg cnt:     FB Stddev:  10 Range:  50`
` Min val: 0x2B     Max val: 0xAD`
`0x00250000 - 0x00260000:`
` Min count:     B3 Max count:   132B Avg cnt:    8D9 Stddev: 7FE Range: 1278`
` Min val: 0x7A     Max val: 0x00`
`0x00260000 - 0x00270000:`
` Min count:     C5 Max count:   1120 Avg cnt:     EB Stddev: 104 Range: 105B`
` Min val: 0x74     Max val: 0x00`
`0x00270000 - 0x00280000:`
` Min count:     CB Max count:    128 Avg cnt:     F3 Stddev:  14 Range:  5D`
` Min val: 0x4C     Max val: 0xE0`
`0x00280000 - 0x00290000:`
` Min count:     A7 Max count:   1334 Avg cnt:    8D5 Stddev: 7FA Range: 128D`
` Min val: 0xE7     Max val: 0x00`
`0x00290000 - 0x002A0000:`
` Min count:     D6 Max count:    8F9 Avg cnt:     F1 Stddev:  81 Range: 823`
` Min val: 0x1D     Max val: 0x00`
`0x002A0000 - 0x002B0000:`
` Min count:     92 Max count:   30AF Avg cnt:   18B2 Stddev: 17EC Range: 301D`
` Min val: 0x4B     Max val: 0xFF`
`0x002B0000 - 0x002C0000:`
` Min count:     93 Max count:   30D7 Avg cnt:   18CA Stddev: 17FD Range: 3044`
` Min val: 0x3D     Max val: 0xFF`
`0x002C0000 - 0x002D0000:`
` Min count:     8F Max count:   30C3 Avg cnt:   18C3 Stddev: 17FB Range: 3034`
` Min val: 0x8D     Max val: 0xFF`
`0x002D0000 - 0x002E0000:`
` Min count:     8E Max count:   30A6 Avg cnt:   18B0 Stddev: 17E7 Range: 3018`
` Min val: 0x0D     Max val: 0xFF`
`0x002E0000 - 0x002F0000:`
` Min count:     A1 Max count:   30C5 Avg cnt:   18BC Stddev: 17ED Range: 3024`
` Min val: 0x29     Max val: 0xFF`
`0x002F0000 - 0x00300000:`
` Min count:     D8 Max count:    130 Avg cnt:     F5 Stddev:  13 Range:  58`
` Min val: 0xD5     Max val: 0x6E`
`0x00300000 - 0x00310000:`
` Min count:     BA Max count:   10EA Avg cnt:    8EA Stddev: 802 Range: 1030`
` Min val: 0xDB     Max val: 0xFF`
`0x00310000 - 0x00320000:`
` Min count:     BD Max count:   10E5 Avg cnt:    8E4 Stddev: 7F9 Range: 1028`
` Min val: 0xEC     Max val: 0xFF`
`0x00320000 - 0x00330000:`
` Min count:     A3 Max count:   10DC Avg cnt:    8DA Stddev: 7F1 Range: 1039`
` Min val: 0xBE     Max val: 0xFF`
`0x00330000 - 0x00340000:`
` Min count:     80 Max count:   2111 Avg cnt:   1116 Stddev: 1038 Range: 2091`
` Min val: 0x40     Max val: 0xFF`
`0x00340000 - 0x00350000:`
` Min count:     82 Max count:    168 Avg cnt:    110 Stddev:  32 Range:  E6`
` Min val: 0x40     Max val: 0x00`
`0x00350000 - 0x00360000:`
` Min count:     91 Max count:    140 Avg cnt:    106 Stddev:  16 Range:  AF`
` Min val: 0x00     Max val: 0x7E`
`0x00360000 - 0x00370000:`
` Min count:     88 Max count:    14A Avg cnt:    10F Stddev:  1B Range:  C2`
` Min val: 0x00     Max val: 0xE3`
`0x00370000 - 0x00380000:`
` Min count:     84 Max count:    145 Avg cnt:    10D Stddev:  1A Range:  C1`
` Min val: 0x00     Max val: 0xDE`
`0x00380000 - 0x00390000:`
` Min count:     99 Max count:    132 Avg cnt:    103 Stddev:  13 Range:  99`
` Min val: 0x00     Max val: 0x8A`
`0x00390000 - 0x003A0000:`
` Min count:     7E Max count:    136 Avg cnt:    111 Stddev:  1C Range:  B8`
` Min val: 0x00     Max val: 0xA9`
`0x003A0000 - 0x003B0000:`
` Min count:     81 Max count:    151 Avg cnt:    107 Stddev:  19 Range:  D0`
` Min val: 0x00     Max val: 0x78`
`0x003B0000 - 0x003C0000:`
` Min count:     92 Max count:    12D Avg cnt:     FF Stddev:  14 Range:  9B`
` Min val: 0x00     Max val: 0xC3`
`0x003C0000 - 0x003D0000:`
` Min count:     88 Max count:    136 Avg cnt:     FE Stddev:  14 Range:  AE`
` Min val: 0x00     Max val: 0x3C`
`0x003D0000 - 0x003E0000:`
` Min count:     7C Max count:    13D Avg cnt:    104 Stddev:  15 Range:  C1`
` Min val: 0x00     Max val: 0xF8`
`0x003E0000 - 0x003F0000:`
` Min count:     95 Max count:    134 Avg cnt:     F7 Stddev:  15 Range:  9F`
` Min val: 0x00     Max val: 0xE1`
`0x003F0000 - 0x00400000:`
` Min count:     91 Max count:    141 Avg cnt:    109 Stddev:  16 Range:  B0`
` Min val: 0x00     Max val: 0x78`
`0x00400000 - 0x00410000:`
` Min count:     C0 Max count:    13C Avg cnt:     EE Stddev:  19 Range:  7C`
` Min val: 0x00     Max val: 0xC3`
`0x00410000 - 0x00420000:`
` Min count:     CD Max count:    141 Avg cnt:    10B Stddev:  16 Range:  74`
` Min val: 0x57     Max val: 0x9C`
`0x00420000 - 0x00430000:`
` Min count:     9E Max count:    13E Avg cnt:     F2 Stddev:  18 Range:  A0`
` Min val: 0x00     Max val: 0xF0`
`0x00430000 - 0x00440000:`
` Min count:     78 Max count:    142 Avg cnt:     FE Stddev:  16 Range:  CA`
` Min val: 0x00     Max val: 0xB1`
`0x00440000 - 0x00450000:`
` Min count:     8D Max count:    145 Avg cnt:    103 Stddev:  15 Range:  B8`
` Min val: 0x00     Max val: 0xDE`
`0x00450000 - 0x00460000:`
` Min count:     83 Max count:    133 Avg cnt:    112 Stddev:  1B Range:  B0`
` Min val: 0x00     Max val: 0x6D`
`0x00460000 - 0x00470000:`
` Min count:     B0 Max count:    12F Avg cnt:     F9 Stddev:  13 Range:  7F`
` Min val: 0x00     Max val: 0xA3`
`0x00470000 - 0x00480000:`
` Min count:     BF Max count:    133 Avg cnt:    105 Stddev:  14 Range:  74`
` Min val: 0x00     Max val: 0x88`
`0x00480000 - 0x00490000:`
` Min count:     BB Max count:    130 Avg cnt:     EC Stddev:  1A Range:  75`
` Min val: 0x80     Max val: 0xBE`
`0x00490000 - 0x004A0000:`
` Min count:     82 Max count:    180 Avg cnt:     F7 Stddev:  20 Range:  FE`
` Min val: 0x00     Max val: 0xB0`
`0x004A0000 - 0x004B0000:`
` Min count:     9E Max count:    16E Avg cnt:     FF Stddev:  1D Range:  D0`
` Min val: 0x00     Max val: 0xD8`
`0x004B0000 - 0x004C0000:`
` Min count:     A7 Max count:    154 Avg cnt:     F7 Stddev:  1B Range:  AD`
` Min val: 0x00     Max val: 0xB0`
`0x004C0000 - 0x004D0000:`
` Min count:     A0 Max count:    16A Avg cnt:     FA Stddev:  19 Range:  CA`
` Min val: 0x00     Max val: 0xEC`
`0x004D0000 - 0x004E0000:`
` Min count:     B8 Max count:    758 Avg cnt:    109 Stddev:  69 Range: 6A0`
` Min val: 0xBA     Max val: 0x00`
`0x004E0000 - 0x004F0000:`
` Min count:     AD Max count:    180 Avg cnt:    11B Stddev:  29 Range:  D3`
` Min val: 0x80     Max val: 0x00`
`0x004F0000 - 0x00500000:`
` Min count:     A7 Max count:    135 Avg cnt:     FE Stddev:  13 Range:  8E`
` Min val: 0x00     Max val: 0x58`
`0x00500000 - 0x00510000:`
` Min count:     A2 Max count:    133 Avg cnt:    100 Stddev:  13 Range:  91`
` Min val: 0x00     Max val: 0xFC`
`0x00510000 - 0x00520000:`
` Min count:     CF Max count:    13C Avg cnt:     FE Stddev:  12 Range:  6D`
` Min val: 0x00     Max val: 0xF8`
`0x00520000 - 0x00530000:`
` Min count:     A6 Max count:    133 Avg cnt:    101 Stddev:  14 Range:  8D`
` Min val: 0x00     Max val: 0x22`
`0x00530000 - 0x00540000:`
` Min count:     B7 Max count:    132 Avg cnt:    10E Stddev:  18 Range:  7B`
` Min val: 0x00     Max val: 0xBC`
`0x00540000 - 0x00550000:`
` Min count:     BF Max count:    141 Avg cnt:    100 Stddev:  13 Range:  82`
` Min val: 0x00     Max val: 0x4A`
`0x00550000 - 0x00560000:`
` Min count:     8F Max count:    142 Avg cnt:     F6 Stddev:  16 Range:  B3`
` Min val: 0x00     Max val: 0x27`
`0x00560000 - 0x00570000:`
` Min count:     C2 Max count:    137 Avg cnt:    101 Stddev:  12 Range:  75`
` Min val: 0x00     Max val: 0xE1`
`0x00570000 - 0x00580000:`
` Min count:     A5 Max count:    153 Avg cnt:     F1 Stddev:  19 Range:  AE`
` Min val: 0x00     Max val: 0x78`
`0x00580000 - 0x00590000:`
` Min count:     A6 Max count:    141 Avg cnt:    110 Stddev:  19 Range:  9B`
` Min val: 0x00     Max val: 0x78`
`0x00590000 - 0x005A0000:`
` Min count:     B6 Max count:    136 Avg cnt:    106 Stddev:  15 Range:  80`
` Min val: 0x00     Max val: 0xF0`
`0x005A0000 - 0x005B0000:`
` Min count:     BF Max count:    12F Avg cnt:    105 Stddev:  14 Range:  70`
` Min val: 0x00     Max val: 0xA5`
`0x005B0000 - 0x005C0000:`
` Min count:     AD Max count:    143 Avg cnt:     FA Stddev:  15 Range:  96`
` Min val: 0x00     Max val: 0x8D`
`0x005C0000 - 0x005D0000:`
` Min count:     98 Max count:    130 Avg cnt:    100 Stddev:  13 Range:  98`
` Min val: 0x00     Max val: 0x71`
`0x005D0000 - 0x005E0000:`
` Min count:     A7 Max count:    133 Avg cnt:    10E Stddev:  17 Range:  8C`
` Min val: 0x00     Max val: 0xE3`
`0x005E0000 - 0x005F0000:`
` Min count:     AF Max count:    137 Avg cnt:    10E Stddev:  17 Range:  88`
` Min val: 0x00     Max val: 0x5E`
`0x005F0000 - 0x00600000:`
` Min count:     BC Max count:   12CD Avg cnt:    8E0 Stddev: 804 Range: 1211`
` Min val: 0xE6     Max val: 0x00`
`0x00600000 - 0x00610000:`
` Min count:     D4 Max count:    12F Avg cnt:    105 Stddev:  12 Range:  5B`
` Min val: 0x90     Max val: 0x11`
`0x00610000 - 0x00620000:`
` Min count:     D8 Max count:    138 Avg cnt:     F3 Stddev:  14 Range:  60`
` Min val: 0xD4     Max val: 0x1B`
`0x00620000 - 0x00630000:`
` Min count:     D4 Max count:    12B Avg cnt:    105 Stddev:  10 Range:  57`
` Min val: 0x2C     Max val: 0xEB`
`0x00630000 - 0x00640000:`
` Min count:     DE Max count:    129 Avg cnt:     F1 Stddev:  14 Range:  4B`
` Min val: 0x12     Max val: 0xF5`
`0x00640000 - 0x00650000:`
` Min count:     D4 Max count:    133 Avg cnt:    107 Stddev:  11 Range:  5F`
` Min val: 0x38     Max val: 0xF4`
`0x00650000 - 0x00660000:`
` Min count:     D7 Max count:    131 Avg cnt:     FB Stddev:  10 Range:  5A`
` Min val: 0xBA     Max val: 0x1A`
`0x00660000 - 0x00670000:`
` Min count:     CF Max count:    12E Avg cnt:    109 Stddev:  12 Range:  5F`
` Min val: 0x1A     Max val: 0x7E`
`0x00670000 - 0x00680000:`
` Min count:     D0 Max count:    135 Avg cnt:     F4 Stddev:  13 Range:  65`
` Min val: 0x3D     Max val: 0x38`
`0x00680000 - 0x00690000:`
` Min count:     B2 Max count:   1745 Avg cnt:     CE Stddev: 16D Range: 1693`
` Min val: 0x66     Max val: 0x00`
`0x00690000 - 0x006A0000:`
` Min count:     D7 Max count:    12E Avg cnt:     FC Stddev:  10 Range:  57`
` Min val: 0x28     Max val: 0xE2`
`0x006A0000 - 0x006B0000:`
` Min count:     C9 Max count:    12F Avg cnt:    108 Stddev:  11 Range:  66`
` Min val: 0xA7     Max val: 0x09`
`0x006B0000 - 0x006C0000:`
` Min count:     DF Max count:    123 Avg cnt:    107 Stddev:   F Range:  44`
` Min val: 0xD6     Max val: 0x0E`
`0x006C0000 - 0x006D0000:`
` Min count:     D3 Max count:    128 Avg cnt:     FF Stddev:   E Range:  55`
` Min val: 0xCB     Max val: 0x45`
`0x006D0000 - 0x006E0000:`
` Min count:     D5 Max count:    12B Avg cnt:    102 Stddev:   F Range:  56`
` Min val: 0x7F     Max val: 0xAE`
`0x006E0000 - 0x006F0000:`
` Min count:     DD Max count:    12C Avg cnt:    101 Stddev:  10 Range:  4F`
` Min val: 0x7D     Max val: 0x35`
`0x006F0000 - 0x00700000:`
` Min count:     D5 Max count:    13C Avg cnt:     FB Stddev:  11 Range:  67`
` Min val: 0x63     Max val: 0xC9`
`0x00700000 - 0x00710000:`
` Min count:     D0 Max count:    12D Avg cnt:    106 Stddev:   F Range:  5D`
` Min val: 0x74     Max val: 0x48`
`0x00710000 - 0x00720000:`
` Min count:     D9 Max count:    131 Avg cnt:     FC Stddev:  10 Range:  58`
` Min val: 0x89     Max val: 0x22`
`0x00720000 - 0x00730000:`
` Min count:     D5 Max count:    13C Avg cnt:    110 Stddev:  17 Range:  67`
` Min val: 0x5E     Max val: 0xC7`
`0x00730000 - 0x00740000:`
` Min count:     D5 Max count:    133 Avg cnt:     FC Stddev:  10 Range:  5E`
` Min val: 0x12     Max val: 0x06`
`0x00740000 - 0x00750000:`
` Min count:     D5 Max count:    12C Avg cnt:    10C Stddev:  13 Range:  57`
` Min val: 0xA8     Max val: 0xFF`
`0x00750000 - 0x00760000:`
` Min count:     D3 Max count:    132 Avg cnt:     FA Stddev:  11 Range:  5F`
` Min val: 0xC3     Max val: 0x0E`
`0x00760000 - 0x00770000:`
` Min count:     C7 Max count:    134 Avg cnt:    104 Stddev:  10 Range:  6D`
` Min val: 0xA8     Max val: 0x8D`
`0x00770000 - 0x00780000:`
` Min count:     D5 Max count:    12A Avg cnt:     FC Stddev:   F Range:  55`
` Min val: 0x27     Max val: 0x78`
`0x00780000 - 0x00790000:`
` Min count:     C4 Max count:    12F Avg cnt:    117 Stddev:  1D Range:  6B`
` Min val: 0xC5     Max val: 0x15`
`0x00790000 - 0x007A0000:`
` Min count:     D7 Max count:    130 Avg cnt:     F6 Stddev:  12 Range:  59`
` Min val: 0x2A     Max val: 0x01`
`0x007A0000 - 0x007B0000:`
` Min count:     CD Max count:    130 Avg cnt:    109 Stddev:  13 Range:  63`
` Min val: 0xB5     Max val: 0x25`
`0x007B0000 - 0x007C0000:`
` Min count:     DA Max count:    134 Avg cnt:    112 Stddev:  18 Range:  5A`
` Min val: 0x86     Max val: 0x28`
`0x007C0000 - 0x007D0000:`
` Min count:     D5 Max count:    12D Avg cnt:     F2 Stddev:  14 Range:  58`
` Min val: 0xF5     Max val: 0xD4`
`0x007D0000 - 0x007E0000:`
` Min count:     DB Max count:    138 Avg cnt:    10D Stddev:  14 Range:  5D`
` Min val: 0x6E     Max val: 0xA3`
`0x007E0000 - 0x007F0000:`
` Min count:     D4 Max count:    12B Avg cnt:     F8 Stddev:  11 Range:  57`
` Min val: 0xC5     Max val: 0x8F`
`0x007F0000 - 0x00800000:`
` Min count:     D5 Max count:    12F Avg cnt:     FA Stddev:  11 Range:  5A`
` Min val: 0xDD     Max val: 0x37`
`0x00800000 - 0x00810000:`
` Min count:     D2 Max count:    13C Avg cnt:     FC Stddev:  10 Range:  6A`
` Min val: 0x84     Max val: 0x5A`
`0x00810000 - 0x00820000:`
` Min count:     D5 Max count:    12D Avg cnt:    107 Stddev:  11 Range:  58`
` Min val: 0x9F     Max val: 0x24`
`0x00820000 - 0x00830000:`
` Min count:     D6 Max count:    138 Avg cnt:     F2 Stddev:  14 Range:  62`
` Min val: 0xD3     Max val: 0x5C`
`0x00830000 - 0x00840000:`
` Min count:     D8 Max count:    129 Avg cnt:    103 Stddev:  11 Range:  51`
` Min val: 0x18     Max val: 0x1C`
`0x00840000 - 0x00850000:`
` Min count:     D6 Max count:    128 Avg cnt:     FB Stddev:  10 Range:  52`
` Min val: 0x99     Max val: 0xAC`
`0x00850000 - 0x00860000:`
` Min count:     CB Max count:    135 Avg cnt:    100 Stddev:  10 Range:  6A`
` Min val: 0x32     Max val: 0x50`
`0x00860000 - 0x00870000:`
` Min count:     D1 Max count:    12D Avg cnt:     FA Stddev:  10 Range:  5C`
` Min val: 0x26     Max val: 0xC0`
`0x00870000 - 0x00880000:`
` Min count:     D0 Max count:    135 Avg cnt:    102 Stddev:  10 Range:  65`
` Min val: 0xB3     Max val: 0x88`
`0x00880000 - 0x00890000:`
` Min count:     D2 Max count:    134 Avg cnt:    105 Stddev:  11 Range:  62`
` Min val: 0xED     Max val: 0x91`
`0x00890000 - 0x008A0000:`
` Min count:     D5 Max count:    12F Avg cnt:    103 Stddev:  12 Range:  5A`
` Min val: 0xDC     Max val: 0x09`
`0x008A0000 - 0x008B0000:`
` Min count:     D0 Max count:    124 Avg cnt:    101 Stddev:   F Range:  54`
` Min val: 0x88     Max val: 0x9E`
`0x008B0000 - 0x008C0000:`
` Min count:     D7 Max count:    12D Avg cnt:     F4 Stddev:  13 Range:  56`
` Min val: 0xD6     Max val: 0x2A`
`0x008C0000 - 0x008D0000:`
` Min count:     D1 Max count:    121 Avg cnt:    10E Stddev:  15 Range:  50`
` Min val: 0x4E     Max val: 0x3D`
`0x008D0000 - 0x008E0000:`
` Min count:     D1 Max count:    131 Avg cnt:     F9 Stddev:   F Range:  60`
` Min val: 0xE3     Max val: 0x86`
`0x008E0000 - 0x008F0000:`
` Min count:     D8 Max count:    134 Avg cnt:     F8 Stddev:  11 Range:  5C`
` Min val: 0x83     Max val: 0x91`
`0x008F0000 - 0x00900000:`
` Min count:     D9 Max count:    133 Avg cnt:    109 Stddev:  12 Range:  5A`
` Min val: 0x39     Max val: 0x1D`
`0x00900000 - 0x00910000:`
` Min count:     A6 Max count:   20CB Avg cnt:   10C6 Stddev: FF5 Range: 2025`
` Min val: 0xAD     Max val: 0xFF`
`0x00910000 - 0x00920000:`
` Min count:     5B Max count:   4076 Avg cnt:   2084 Stddev: 1FFA Range: 401B`
` Min val: 0x28     Max val: 0xFF`
`0x00920000 - 0x00930000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00930000 - 0x00940000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00940000 - 0x00950000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00950000 - 0x00960000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00960000 - 0x00970000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00970000 - 0x00980000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00980000 - 0x00990000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00990000 - 0x009A0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x009A0000 - 0x009B0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x009B0000 - 0x009C0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x009C0000 - 0x009D0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x009D0000 - 0x009E0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x009E0000 - 0x009F0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x009F0000 - 0x00A00000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A00000 - 0x00A10000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A10000 - 0x00A20000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A20000 - 0x00A30000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A30000 - 0x00A40000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A40000 - 0x00A50000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A50000 - 0x00A60000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A60000 - 0x00A70000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A70000 - 0x00A80000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A80000 - 0x00A90000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00A90000 - 0x00AA0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00AA0000 - 0x00AB0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00AB0000 - 0x00AC0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00AC0000 - 0x00AD0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00AD0000 - 0x00AE0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00AE0000 - 0x00AF0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00AF0000 - 0x00B00000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B00000 - 0x00B10000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B10000 - 0x00B20000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B20000 - 0x00B30000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B30000 - 0x00B40000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B40000 - 0x00B50000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B50000 - 0x00B60000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B60000 - 0x00B70000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B70000 - 0x00B80000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B80000 - 0x00B90000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00B90000 - 0x00BA0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00BA0000 - 0x00BB0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00BB0000 - 0x00BC0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00BC0000 - 0x00BD0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00BD0000 - 0x00BE0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00BE0000 - 0x00BF0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00BF0000 - 0x00C00000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C00000 - 0x00C10000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C10000 - 0x00C20000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C20000 - 0x00C30000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C30000 - 0x00C40000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C40000 - 0x00C50000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C50000 - 0x00C60000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C60000 - 0x00C70000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C70000 - 0x00C80000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C80000 - 0x00C90000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00C90000 - 0x00CA0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00CA0000 - 0x00CB0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00CB0000 - 0x00CC0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00CC0000 - 0x00CD0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00CD0000 - 0x00CE0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00CE0000 - 0x00CF0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00CF0000 - 0x00D00000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D00000 - 0x00D10000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D10000 - 0x00D20000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D20000 - 0x00D30000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D30000 - 0x00D40000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D40000 - 0x00D50000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D50000 - 0x00D60000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D60000 - 0x00D70000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D70000 - 0x00D80000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D80000 - 0x00D90000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00D90000 - 0x00DA0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00DA0000 - 0x00DB0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00DB0000 - 0x00DC0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00DC0000 - 0x00DD0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00DD0000 - 0x00DE0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00DE0000 - 0x00DF0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00DF0000 - 0x00E00000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E00000 - 0x00E10000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E10000 - 0x00E20000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E20000 - 0x00E30000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E30000 - 0x00E40000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E40000 - 0x00E50000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E50000 - 0x00E60000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E60000 - 0x00E70000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E70000 - 0x00E80000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E80000 - 0x00E90000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00E90000 - 0x00EA0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00EA0000 - 0x00EB0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00EB0000 - 0x00EC0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00EC0000 - 0x00ED0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00ED0000 - 0x00EE0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00EE0000 - 0x00EF0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00EF0000 - 0x00F00000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F00000 - 0x00F10000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F10000 - 0x00F20000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F20000 - 0x00F30000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F30000 - 0x00F40000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F40000 - 0x00F50000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F50000 - 0x00F60000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F60000 - 0x00F70000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F70000 - 0x00F80000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F80000 - 0x00F90000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00F90000 - 0x00FA0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00FA0000 - 0x00FB0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00FB0000 - 0x00FC0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00FC0000 - 0x00FD0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00FD0000 - 0x00FE0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00FE0000 - 0x00FF0000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x00FF0000 - 0x01000000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01000000 - 0x01010000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01010000 - 0x01020000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01020000 - 0x01030000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01030000 - 0x01040000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01040000 - 0x01050000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01050000 - 0x01060000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01060000 - 0x01070000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`
`0x01070000 - 0x01080000:`
` Min count:      0 Max count:  10000 Avg cnt:   8000 Stddev: 8000 Range: 10000`
` Min val: 0x00     Max val: 0xFF`

`Last histogram smaller than requested window size.`
`0x01080000 - 0x01090000:`
` Min count:      0 Max count:      0 Avg cnt:      0 Stddev:   0 Range:   0`
` Min val: 0x00     Max val: 0x00`