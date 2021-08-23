During bootup the XBox 360 issues several POST Codes on a special 8-bit
bus for diagnostic purposes.

POST stands for power on self test. Its a bus created to help debug the xbox boot up process. In the bootloaders there is code that updates the number represented by the bus so it is possible to see at which point the bootloader is executing and where it hangs if an error occured.

The reset glitch hack uses the post codes to track the progress of initialization and know when to assert the reset signal. In RGH1, it waits for when the second bootloader(CB) starts verifying the integrity check of the hash of the fourth bootloder(CD). When the bootloaders were updated starting on 14717, they removed the post codes from the bootloaders and added a few tricks like random delays to prevent glitchers from being able to tell when the xbox is checking the hash.

## Pinout

On Phat consoles the pinout is as follows:

|                       |       |
|-----------------------|-------|
| DBG_WN_POST_OUT0/BIT7 | FT6U8 |
| DBG_WN_POST_OUT1/BIT6 | FT6U2 |
| DBG_WN_POST_OUT2/BIT5 | FT6U3 |
| DBG_WN_POST_OUT3/BIT4 | FT6U4 |
| DBG_WN_POST_OUT4/BIT3 | FT6U5 |
| DBG_WN_POST_OUT5/BIT2 | FT6U6 |
| DBG_WN_POST_OUT6/BIT1 | FT6U7 |
| DBG_WN_POST_OUT7/BIT0 | FT6U1 |

**Voltage levels are 1.2V for PHAT / 1.8V for SLIM**

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

| Domain    | Code | Enum                           | Description                                                                  |
|-----------|------|--------------------------------|------------------------------------------------------------------------------|
| JTAG &    | 0x10 |                                | Payload started                                                              |
| RGH       | 0x11 |                                | Payload has copied XeLL to the RAM from NAND and executed it                 |
|           |      |                                |                                                                              |
| 1BL       | 0x10 | -                              | 1BL started                                                                  |
|           | 0x11 | FSB_CONFIG_PHY_CONTROL         | Execute FSB function1                                                        |
|           | 0x12 | FSB_CONFIG_RX_STATE            | Execute FSB function2                                                        |
|           | 0x13 | FSB_CONFIG_TX_STATE            | Execute FSB function3                                                        |
|           | 0x14 | FSB_CONFIG_TX_CREDITS          | Execute FSB function4                                                        |
|           | 0x15 | FETCH_OFFSET                   | Verify CB offset                                                             |
|           | 0x16 | FETCH_HEADER                   | Copy CB header from NAND                                                     |
|           | 0x17 | VERIFY_HEADER                  | Verify CB header                                                             |
|           | 0x18 | FETCH_CONTENTS                 | Copy CB into protected SRAM                                                  |
|           | 0x19 | HMACSHA_COMPUTE                | Generate CB HMAC key                                                         |
|           | 0x1A | RC4_INITIALIZE                 | Initialize CB RC4 decryption key                                             |
|           | 0x1B | RC4_DECRYPT                    | RC4 decrypt CB                                                               |
|           | 0x1C | SHA_COMPUTE                    | Generate hash of CB for verification                                         |
|           | 0x1D | SIG_VERIFY                     | RSA signature check of CB hash                                               |
|           | 0x1E | BRANCH                         | Jump to CB                                                                   |
|           |      |                                |                                                                              |
| 1BL       | 0x81 | PANIC - MACHINE_CHECK          |                                                                              |
| Panics    | 0x82 | PANIC - DATA_STORAGE           |                                                                              |
|           | 0x83 | PANIC - DATA_SEGMENT           |                                                                              |
|           | 0x84 | PANIC - INSTRUCTION_STORAGE    |                                                                              |
|           | 0x85 | PANIC - INSTRUCTION_SEGMENT    |                                                                              |
|           | 0x86 | PANIC - EXTERNAL               |                                                                              |
|           | 0x87 | PANIC - ALIGNMENT              |                                                                              |
|           | 0x88 | PANIC - PROGRAM                |                                                                              |
|           | 0x89 | PANIC - FPU_UNAVAILABLE        |                                                                              |
|           | 0x8A | PANIC - DECREMENTER            |                                                                              |
|           | 0x8B | PANIC - HYPERVISOR_DECREMENTER |                                                                              |
|           | 0x8C | PANIC - SYSTEM_CALL            |                                                                              |
|           | 0x8D | PANIC - TRACE                  |                                                                              |
|           | 0x8E | PANIC - VPU_UNAVAILABLE        |                                                                              |
|           | 0x8F | PANIC - MAINTENANCE            |                                                                              |
|           | 0x90 | PANIC - VMX_ASSIST             |                                                                              |
|           | 0x91 | PANIC - THERMAL_MANAGEMENT     |                                                                              |
|           | 0x92 | -                              | 1BL is executed on wrong CPU thread (panic)                                  |
|           | 0x93 | PANIC - TOO_MANY_CORES         | 1BL is executed on wrong CPU core (panic)                                    |
|           | 0x94 | PANIC - VERIFY_OFFSET          | CB offset verification failed                                                |
|           | 0x95 | PANIC - VERIFY_HEADER          | CB header verification failed                                                |
|           | 0x96 | PANIC - SIG_VERIFY             | CB RSA signature verification failed                                         |
|           | 0x97 | PANIC - NONHOST_RESUME_STATUS  |                                                                              |
|           | 0x98 | PANIC - NEXT_STAGE_SIZE        | Size of next stage is out-of-bounds                                          |
|           |      |                                |                                                                              |
| CB_A/2BL  | 0xD0 |                                | CB_A entry point, copy self to 0x8000.0200.0001.C000 and continue from there |
| (Slim     | 0xD1 | READ_FUSES                     | Copy fuses from SoC for CB_B decryption                                      |
| excl.)    | 0xD2 | VERIFY_OFFSET_CB_B             | Verify CB_B offset                                                           |
|           | 0xD3 | FETCH_HEADER_CB_B              | Copy CB_B header from NAND for verification                                  |
|           | 0xD4 | VERIFY_HEADER_CB_B             | Verify CB_B header                                                           |
|           | 0xD5 | FETCH_CONTENTS_CB_B            | Copy CBB into memory at 0x8000.0200.0001.0000 (old location of CB_A)         |
|           | 0xD6 | HMACSHA_COMPUTE_CB_B           | Create HMAC key for CD decryption                                            |
|           | 0xD7 | RC4_INITIALIZE_CB_B            | Initialize CD RC4 key using HMAC key                                         |
|           | 0xD8 | RC4_DECRYPT_CB_B               | RC4 decrypt CD                                                               |
|           | 0xD9 | SHA_COMPUTE_CB_B               | Compute hash of CD for verification                                          |
|           | 0xDA | SHA_VERIFY_CB_B                | MemCmp computed hash with expected one (where rgh2 glitches)                 |
|           | 0xDB | BRANCH_CB_B                    | Jump to CB_B                                                                 |
|           |      |                                |                                                                              |
| CB_A      | 0xF0 | PANIC - VERIFY_OFFSET_CB_B     | CBB offset verification fail                                                 |
| Panics    | 0xF1 | PANIC - VERIFY_HEADER_CB_B     | CBB header verification fail                                                 |
|           | 0xF2 | PANIC - SHA_VERIFY_CB_B        | CBB security hash comparison fail                                            |
|           | 0xF3 | PANIC - ENTRY_SIZE_INVALID_CB_B| CBB size check fail (must be less than 0xC000)                               |
|           |      |                                |                                                                              |
| CB/2BL    | 0x20 | -                              | CB entry point, initialize SoC                                               |
|           | 0x21 | INIT_SECOTP                    | Initialize secopt, verify lockdown fuses                                     |
|           | 0x22 | INIT_SECENG                    | Initialize security engine                                                   |
|           | 0x23 | INIT_SYSRAM                    | Initialize EDRAM                                                             |
|           | 0x24 | VERIFY_OFFSET_3BL_CC           |                                                                              |
|           | 0x25 | LOCATE_3BL_CC                  |                                                                              |
|           | 0x26 | FETCH_HEADER_3BL_CC            |                                                                              |
|           | 0x27 | VERIFY_HEADER_3BL_CC           |                                                                              |
|           | 0x28 | FETCH_CONTENTS_3BL_CC          |                                                                              |
|           | 0x29 | HMACSHA_COMPUTE_3BL_CC         |                                                                              |
|           | 0x2A | RC4_INITIALIZE_3BL_CC          |                                                                              |
|           | 0x2B | RC4_DECRYPT_3BL_CC             |                                                                              |
|           | 0x2C | SHA_COMPUTE_3BL_CC             |                                                                              |
|           | 0x2D | SIG_VERIFY_3BL_CC              |                                                                              |
|           | 0x2E | HWINIT                         | Hardware initialization                                                      |
|           | 0x2F | RELOCATE                       | Setup tlb entries, relocate to ram                                           |
|           | 0x30 | VERIFY_OFFSET_4BL_CD           | Verify CD offset                                                             |
|           | 0x31 | FETCH_HEADER_4BL_CD            | Copy CD header from NAND for verification                                    |
|           | 0x32 | VERIFY_HEADER_4BL_CD           | Verify CD header                                                             |
|           | 0x33 | FETCH_CONTENTS_4BL_CD          | Copy CD from nand                                                            |
|           | 0x34 | HMACSHA_COMPUTE_4BL_CD         | Create HMAC key for CD decryption                                            |
|           | 0x35 | RC4_INITIALIZE_4BL_CD          | Initialize CD RC4 key using HMAC key                                         |
|           | 0x36 | RC4_DECRYPT_4BL_CD             | RC4 decrypt CD with key                                                      |
|           | 0x37 | SHA_COMPUTE_4BL_CD             | Compute hash of CD for verification                                          |
|           | 0x38 | SIG_VERIFY_4BL_CD              | RSA signature check of CD hash                                               |
|           | 0x39 | SHA_VERIFY_4BL_CD              | MemCmp computed hash with expected one                                       |
|           | 0x3A | BRANCH                         | Setup memory encryption and jump to CD                                       |
|           | 0x3B | PCI_INIT                       | Initialize PCI                                                               |
|           |      |                                |                                                                              |
| CB        | 0x9B | PANIC - VERIFY_SECOTP_1        | Secopt fuse verification fail                                                |
| Panics    | 0x9C | PANIC - VERIFY_SECOTP_2        | Secopt fuse verification fail2                                               |
|           | 0x9D | PANIC - VERIFY_SECOTP_3        | Secopt fuse verification console type? fail                                  |
|           | 0x9E | PANIC - VERIFY_SECOTP_4        | Secopt fuse verification console type? fail                                  |
|           | 0x9F | PANIC - VERIFY_SECOTP_5        | Secopt fuse verification console type? fail                                  |
|           | 0xA0 | PANIC - VERIFY_SECOTP_6        | CB revocation check failed                                                   |
|           | 0xA1 | PANIC - VERIFY_SECOTP_7        | Panic after 0x21                                                             |
|           | 0xA2 | PANIC - VERIFY_SECOTP_8        | Panic after 0x21                                                             |
|           | 0xA3 | PANIC - VERIFY_SECOTP_9        | Panic after 0x21                                                             |
|           | 0xA4 | PANIC - VERIFY_SECOTP_10       | Failed SMC HMAC                                                              |
|           | 0xA5 | PANIC - VERIFY_OFFSET_3BL_CC   |                                                                              |
|           | 0xA6 | PANIC - LOCATE_3BL_CC          |                                                                              |
|           | 0xA7 | PANIC - VERIFY_HEADER_3BL_CC   |                                                                              |
|           | 0xA8 | PANIC - SIG_VERIFY_3BL_CC      |                                                                              |
|           | 0xA9 | PANIC - HWINIT                 | Hardware initialization failed                                               |
|           | 0xAA | PANIC - VERIFY_OFFSET_4BL_CD   | Failed to verify CD offset                                                   |
|           | 0xAB | PANIC - VERIFY_HEADER_4BL_CD   | Failed to verify CD header                                                   |
|           | 0xAC | PANIC - SIG_VERIFY_4BL_CD      |                                                                              |
|           | 0xAD | PANIC - SHA_VERIFY_4BL_CD      | CD security hash comparison fail                                             |
|           | 0xAE | PANIC - UNEXPECTED_INTERRUPT   | CB exception, unknown interrupt vector                                       |
|           | 0xAF | PANIC - UNSUPPORTED_RAM_SIZE   |                                                                              |
|           | 0xB0 | PANIC - VERIFY_CONSOLE_TYPE    | Secopt fuse verification console type? fail                                  |
|           |      |                                |                                                                              |
| CD/4BL    | 0x40 | -                              | Entrypoint of CD, setup memory paging                                        |
|           | 0x41 | VERIFY_OFFSET                  | Verify offset to CE                                                          |
|           | 0x42 | FETCH_HEADER                   | Copy CE header from NAND for verification                                    |
|           | 0x43 | VERIFY_HEADER                  | Verify CE Header                                                             |
|           | 0x44 | FETCH_CONTENTS                 | Read CE from nand into memory                                                |
|           | 0x45 | HMACSHA_COMPUTE                | Create HMAC key for CE decryption                                            |
|           | 0x46 | RC4_INITIALIZE                 | Initialize CE RC4 key using HMAC key                                         |
|           | 0x47 | RC4_DECRYPT                    | RC4 decrypt CE                                                               |
|           | 0x48 | SHA_COMPUTE                    | Compute hash of CE for verification                                          |
|           | 0x49 | SHA_VERIFY                     | MemCmp computed hash with expected one (where rgh1 glitches)                 |
|           | 0x4A | LOAD_6BL_CF                    |                                                                              |
|           | 0x4B | LZX_EXPAND                     | LZX Decompress CE                                                            |
|           | 0x4C | SWEEP_CACHES                   |                                                                              |
|           | 0x4D | DECODE_FUSES                   | Decode fuses                                                                 |
|           | 0x4E | FETCH_OFFSET_6BL_CF            | Load CF (kernel patches) offset                                              |
|           | 0x4F | VERIFY_OFFSET_6BL_CF           | Verify CF offset                                                             |
|           | 0x50 | LOAD_UPDATE_1                  | Load CF1/CG1 (patch slot 1) if version & header checks pass                  |
|           | 0x51 | LOAD_UPDATE_2                  | Load CF2/CG2 (patch slot 2) if version & header checks pass                  |
|           | 0x52 | BRANCH                         | Startup kernel/Hypervisor                                                    |
|           | 0x53 | DECRYT_VERIFY_HV_CERT          | Decrypt and verify hypervisor certificate                                    |
|           |      |                                |                                                                              |
| CD        | 0xB1 | PANIC - VERIFY_OFFSET          | CE decryption failed                                                         |
| Panics    | 0xB2 | PANIC - VERIFY_HEADER          | Failed to verify CE header                                                   |
|           | 0xB3 | PANIC - SHA_VERIFY             | CE hash comparison fail                                                      |
|           | 0xB4 | PANIC - LZX_EXPAND             | CE LZX decompression failed                                                  |
|           | 0xB5 | PANIC - VERIFY_OFFSET_6BL      | CF verification failed                                                       |
|           | 0xB6 | PANIC - DECODE_FUSES           | Fuse decryption/check failed                                                 |
|           | 0xB7 | PANIC - UPDATE_MISSING         | CF decryption failed, patches missing.                                       |
|           | 0xB8 | PANIC -                        | CF hash auth failed                                                          |
|           |      |                                |                                                                              |
| CE        | 0xC1 | LZX_EXPAND_1                   | LDICreateDecompression failed                                                |
| CF        | 0xC2 | LZX_EXPAND_2                   | CG size verification failed                                                  |
| Panics    | 0xC3 | LZX_EXPAND_3                   | Header / patch fragment info check failed                                    |
|           | 0xC4 | LZX_EXPAND_4                   | Unexpected LDI fragment type                                                 |
|           | 0xC5 | LZX_EXPAND_5                   | LDISetWindowData failed                                                      |
|           | 0xC6 | LZX_EXPAND_6                   | LDIDecompress failed                                                         |
|           | 0xC7 | LZX_EXPAND_7                   | LDIResetDecompression failed                                                 |
|           | 0xC8 | SHA_VERIFY                     | CG auth failed                                                               |
|           |      |                                |                                                                              |
| Hypervisor| 0x58 | INIT_HYPERVISOR                | Hypervisor Initialization begin                                              |
| /HV       | 0x59 | INIT_SOC_MMIO                  | Initialize SoC MMIO                                                          |
|           | 0x5A | INIT_XEX_TRAINING              | Initialize XEX training                                                      |
|           | 0x5B | INIT_KEYRING                   | Initialize key ring                                                          |
|           | 0x5C | INIT_KEYS                      | Initialize keys                                                              |
|           | 0x5D | INIT_SOC_INT                   | Initialize SoC Interrupts                                                    |
|           | 0x5E | INIT_SOC_INT_COMPLETE          | Initialization complete                                                      |
|           |      |                                |                                                                              |
| HV Panics | 0xFF | PANIC - FATAL                  | Fatal error                                                                  |
|           |      |                                |                                                                              |
| Kernel    | 0x60 | INIT_KERNEL                    | Initialize kernel                                                            |
|           | 0x61 | INIT_HAL_PHASE_0               | Initialize hardware abstraction layer (phase 0)                              |
|           | 0x62 | INIT_PROCESS_OBJECTS           | Initialize process objects                                                   |
|           | 0x63 | INIT_KERNEL_DEBUGGER           | Initialize kernel debugger                                                   |
|           | 0x64 | INIT_MEMORY_MANAGER            | Initialize memory manager                                                    |
|           | 0x65 | INIT_STACKS                    | Initialize stacks                                                            |
|           | 0x66 | INIT_OBJECT_SYSTEM             | Initialize object system                                                     |
|           | 0x67 | INIT_PHASE1_THREAD             | Initialize phase 1 thread                                                    |
|           | 0x68 | INIT_PROCESSORS                | Initialize processors                                                        |
|           | 0x69 | INIT_KEY_VAULT                 | Initialize keyvault                                                          |
|           | 0x6A | INIT_HAL_PHASE_1               | Initialize hardware abstraction layer (phase 1)                              |
|           | 0x6B | INIT_SFC_DRIVER                | Initialize SFC (Flash controller)                                            |
|           | 0x6C | INIT_SECURITY                  | Initialize security                                                          |
|           | 0x6D | INIT_KEY_EX_VAULT              | Initialize keyvault (extended portion)                                       |
|           | 0x6E | INIT_SETTINGS                  | Initialize settings                                                          |
|           | 0x6F | INIT_POWER_MODE                | Initialize power mode                                                        |
|           | 0x70 | INIT_VIDEO_DRIVER              | Initialize video driver                                                      |
|           | 0x71 | INIT_AUDIO_DRIVER              | Initialize audio driver                                                      |
|           | 0x72 | INIT_BOOT_ANIMATION            | Initialize boot animation + XMADecoder & XAudioRender Init                   |
|           | 0x73 | INIT_SATA_DRIVER               | Initialize SATA driver                                                       |
|           | 0x74 | INIT_SHADOWBOOT                | Initialize shadowboot                                                        |
|           | 0x75 | INIT_DUMP_SYSTEM               | Initialize dump system                                                       |
|           | 0x76 | INIT_SYSTEM_ROOT               | Initialize system root                                                       |
|           | 0x77 | INIT_OTHER_DRIVERS             | Initialize other drivers                                                     |
|           | 0x78 | INIT_STFS_DRIVER               | Initialize STFS driver                                                       |
|           | 0x79 | LOAD_XAM                       | Load XAM                                                                     |

### Credits

Retrieved from (https://www.xdevwiki.tk/index.php?title=POST_Codes&oldid=156)
