**FMIM** files are used by the Xbox 360 "System Music Player" to store music ripped from a CD. They are stereo WMA 9.1 files, with one pass CBR (constant bitrate) at 192kbps/44.1kHz.

# FMIM

## Header

| Offset | Length                               | Type                         | Information                                       |
| ------ | ------------------------------------ | ---------------------------- | ------------------------------------------------- |
| 0x0    | 0x4                                  | ascii string                 | magic "FMIM" / 0x464D494D                         |
| 0x4    | 0x8                                  | bytes                        | magic (?) unknown purpose but always 0x100010001  |
| 0xC    | 0x200                                | unicode string               | Track Title                                       |
| 0x20C  | 0x200                                | unicode string               | Album Name                                        |
| 0x40C  | 0x200                                | unicode string               | Artist #1                                         |
| 0x60C  | 0x200                                | unicode string               | Artist #2 (reason for duplicate unknown, locale?) |
| 0x80C  | 0x200                                | unicode string               | Genre #1                                          |
| 0xA0C  | 0x200                                | unicode string               | Genre #2 (reason for duplicate unknown, locale?)  |
| 0xC0C  | 0x4                                  | unsigned int                 | Track Length (milliseconds, to nearest second)    |
| 0xC10  | 0x4                                  | unsigned int                 | Track Number on Album (starts from 0x1)           |
| 0xC14  | 0xF4                                 | bytes                        | Unknown, sometimes contains readable text         |
| 0xD08  | ... (rest of the file)               | bytes                        | WMA 9.1 file containing audio as described above  |
