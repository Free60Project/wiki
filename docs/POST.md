During bootup the XBox 360 issues several POST Codes on a special 8-bit
bus for diagnostic purposes.

## Pinout

On Phat consoles the pinout is as follows:

|                          |       |
| ------------------------ | ----- |
| DBG_WN_POST_OUT0/BIT7 | FT6U8 |
| DBG_WN_POST_OUT1/BIT6 | FT6U2 |
| DBG_WN_POST_OUT2/BIT5 | FT6U3 |
| DBG_WN_POST_OUT3/BIT4 | FT6U4 |
| DBG_WN_POST_OUT4/BIT3 | FT6U5 |
| DBG_WN_POST_OUT5/BIT2 | FT6U6 |
| DBG_WN_POST_OUT6/BIT1 | FT6U7 |
| DBG_WN_POST_OUT7/BIT0 | FT6U1 |

**Voltage levels are 1.2-1.8V**

## Reading the POST bus

The POST bus holds the last code's bits all the time. So we can read it
with simple multimeter. To assemble bits to the byte, join them together
like that (BIT ORDER 76543210):

    For Example:
    bit7,bit6,bit5,bit4,bit3,bit2,bit1,bit0

    00111010 = 0x3A = CD auth success

## Writing to the POST Bus

Writing to the POST Bus is easy:

Just write you 8 bit shifted by 56 Bit left to memory location 0x8000
0200 0006 1010:

    ; load address in r7
    li  %r7,0x200
    oris  %r7,%r7,0x8000
    rldicr  %r7,%r7,32,31
    ori %r7,%r7,0x1010
    oris  %r7,%r7,6

    ; write POST code
    li  %r3, 0x12
    rldicr  %r3, %r3, 56, 7
    std %r3, 0(%r7)

The address is given in real mode, so you need to be careful when paging
is
enabled.

## Meaning of different POST Codes

| Domain       | POST Code | Description                                                                         |
| ------------ | --------- | ----------------------------------------------------------------------------------- |
| JTAG payload |           |                                                                                     |
|              | 0x10      | Payload started                                                                     |
|              | 0x11      | Payload has copied XeLL to the RAM from NAND and executed it                        |
| 1BL          |           |                                                                                     |
|              | 0x10      | 1BL started                                                                         |
|              | 0x81-0x8F | Panic codes                                                                         |
|              | 0x91      | Panic                                                                               |
|              | 0x92      | 1BL is executed on wrong CPU thread (panic)                                         |
|              | 0x93      | 1BL is executed on wrong CPU core (panic)                                           |
|              | 0x97      | Panic                                                                               |
|              | 0x98      | Panic                                                                               |
| CB_A slim   |           |                                                                                     |
|              | 0xD0      | CB_A entry point reached                                                           |
|              | 0xD1-0xDB |                                                                                     |
|              | 0xF0-0xF3 | Panic codes                                                                         |
| CB           |           |                                                                                     |
|              | 0x20      | CB entry point reached                                                              |
|              | 0x21      | CB Start (Panics 0x9B - 0xA4 Here)                                                  |
|              | 0x22      | Undocumented Subroutine Start (No panic routines but does crypt stuff)              |
|              | 0x23      | Undocumented Subroutine Start                                                       |
|              | 0x2E      |                                                                                     |
|              | 0x2F      |                                                                                     |
|              | 0x30      | \-                                                                                  |
|              | 0x31      | \- (no panics from here)                                                            |
|              | 0x32      | \-                                                                                  |
|              | 0x33      | \- (no panics from here)                                                            |
|              | 0x34      | Setting registers before HMAC SHA                                                   |
|              | 0x35      | Setting CD RC4 key                                                                  |
|              | 0x36      | Decrypting CD                                                                       |
|              | 0x37      | CD decrypt success                                                                  |
|              | 0x39      | Comparing CD hash                                                                   |
|              | 0x3A      | CD auth success                                                                     |
|              | 0x3B      | CD auth success                                                                     |
|              | 0x9B      | Panic after 0x21                                                                    |
|              | 0x9C      | Panic after 0x21                                                                    |
|              | 0x9D      | Panic after 0x21                                                                    |
|              | 0x9E      | Panic after 0x21                                                                    |
|              | 0x9F      | Panic after 0x21                                                                    |
|              | 0xA0      | CB revocation check failed                                                          |
|              | 0xA1      | Panic after 0x21                                                                    |
|              | 0xA2      | Panic after 0x21                                                                    |
|              | 0xA3      | Panic after 0x21                                                                    |
|              | 0xA4      | Failed SMC HMAC                                                                     |
|              | 0xA9      |                                                                                     |
|              | 0xAA      | Panic after 0x30                                                                    |
|              | 0xAB      | Panic after 0x32                                                                    |
|              | 0xAD      | CD auth failed                                                                      |
|              | 0xAE      | CB exception                                                                        |
|              | 0xB0      | Panic after                                                                         |
| CD           |           |                                                                                     |
|              | 0x40      | Entrypoint of CD reached                                                            |
|              | 0x41      | Paging set up, now in main()                                                        |
|              | 0x42      | Something decrypted successfully, starting copy loop                                |
|              | 0x43      | Finish copy loop, running comparisons                                               |
|              | 0x44      | Passed comparisons, start another copy loop                                         |
|              | 0x45      | Finish copy loop, about to create HMAC SHA                                          |
|              | 0x46      | Finish Crypt stage 1, setting CE RC4 Key                                            |
|              | 0x47      | Finish Crypt stage 2, decrypting CE                                                 |
|              | 0x48      | Finish Crypt stage 3, CE decrypted, computing RotSumSha                             |
|              | 0x49      | Finish Crypt stage 4, RotSumSha calculated, comparing against stored hash           |
|              | 0x4B      | CE auth success, decompressing CE                                                   |
|              | 0x4D      | Running unknown sub (0x910 in CD 8453)                                              |
|              | 0x4E      | CE decompressed                                                                     |
|              | 0x4F      | CF loader init                                                                      |
|              | 0x50/0x51 | 0x50 gets output if a special check is passed, otherwise 0x51, unknown what its for |
|              | 0x52      | CF loading                                                                          |
|              | 0xB1      | CE decryption failed                                                                |
|              | 0xB2      | Failed one of three comparisons after 0x43                                          |
|              | 0xB3      | CE auth failed                                                                      |
|              | 0xB4      | CE decompression failed                                                             |
|              | 0xB5      | Failed checks for 0x4F                                                              |
|              | 0xB6      | Failed after 0x4D                                                                   |
|              | 0xB7      | CF decryption failed                                                                |
|              | 0xB8      | CF auth failed                                                                      |
| CE           |           |                                                                                     |
| CF           |           |                                                                                     |
|              | 0xC1      | LDICreateDecompression failed                                                       |
|              | 0xC2      | ? failed                                                                            |
|              | 0xC3      | ? failed                                                                            |
|              | 0xC4      | ? failed                                                                            |
|              | 0xC5      | ? failed                                                                            |
|              | 0xC6      | LDIDecompress failed                                                                |
|              | 0xC7      | ? failed                                                                            |
|              | 0xC8      | CG auth failed                                                                      |
| Kernel       |           |                                                                                     |
|              | 0x64      | INIT_MEMORY_MANAGER                                                               |
|              | 0x65      | INIT_STACKS                                                                        |
|              | 0x66      | INIT_OBJECT_SYSTEM                                                                |
|              | 0x67      | INIT_PHASE1_THREAD                                                                |
|              | 0x68      | Started phase 1 Initialization + INIT_PROCESSORS                                   |
|              | 0x69      | INIT_KEY_VAULT                                                                    |
|              | 0x6A      | INIT_HAL_PHASE_1                                                                 |
|              | 0x6B      | INIT_SFC_DRIVER                                                                   |
|              | 0x6C      | INIT_SECURITY                                                                      |
|              | 0x6D      | INIT_KEY_EX_VAULT                                                                |
|              | 0x6E      | INIT_SETTINGS                                                                      |
|              | 0x6F      | INIT_POWER_MODE                                                                   |
|              | 0x70      | INIT_VIDEO_DRIVER                                                                 |
|              | 0x71      | INIT_AUDIO_DRIVER                                                                 |
|              | 0x72      | INIT_BOOT_ANIMATION + XMADecoder & XAudioRender Init                              |
|              | 0x73      | INIT_SATA_DRIVER                                                                  |
|              | 0x74      | INIT_SHADOWBOOT                                                                    |
|              | 0x75      | INIT_DUMP_SYSTEM                                                                  |
|              | 0x76      | INIT_SYSTEM_ROOT                                                                  |
|              | 0x77      | INIT_OTHER_DRIVERS                                                                |
|              | 0x78      | INIT_STFS_DRIVER                                                                  |
|              | 0x79      | LOAD_XAM                                                                           |
| Fatal Errors |           |                                                                                     |
|              | 0xA0      | CB revocation check failed                                                          |
|              | 0xA1      | Panic after 0x21                                                                    |
|              | 0xA2      | Panic after 0x21                                                                    |
|              | 0xA3      | Panic after 0x21                                                                    |
|              | 0xA4      | Panic before 0x22                                                                   |
|              | 0xAA      | Panic after 0x30                                                                    |
|              | 0xAB      | Panic after 0x32                                                                    |
|              | 0xAD      | CD auth failed                                                                      |
|              | 0xAE      | CB exception                                                                        |
|              | 0xB0      | General Panic                                                                       |
|              | 0xB1      | CE decryption failed                                                                |
|              | 0xB2      | Failed one of three comparisons after 0x43                                          |
|              | 0xB3      | CE auth failed                                                                      |
|              | 0xB4      | CE decompression failed                                                             |
|              | 0xB5      | Failed checks for 0x4F                                                              |
|              | 0xB6      | Failed after 0x4D                                                                   |
|              | 0xB7      | CF decryption failed                                                                |
|              | 0xB8      | CF auth failed                                                                      |
|              | 0xC1      | LDICreateDecompression failed                                                       |
|              | 0xC2      | ? failed                                                                            |
|              | 0xC3      | ? failed                                                                            |
|              | 0xC4      | ? failed                                                                            |
|              | 0xC5      | ? failed                                                                            |
|              | 0xC6      | LDIDecompress failed                                                                |
|              | 0xC7      | ? failed                                                                            |
|              | 0xC8      | CG auth failed                                                                      |

Please fill in all known POST Codes. (And create a better table if you
can ; ) )
