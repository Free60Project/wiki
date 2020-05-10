# Accessing the EEPROM

Accessing the EEPROM data is quite straightforward: The address of the
value is passed as the SMBus command, and the data (either 8 or 16 bits
wide) as the SMbus data.

Two routines that read bytes from and write bytes to the serial EEPROM
and do no error handling are shown below:

`void EepromWrite8(unsigned char address, unsigned char value) {`
`    SMBusWriteCommand(0x54, address, false, value);`
`}`
`void EepromRead8(unsigned char address, unsigned char value) {`
`    SMBusReadCommand(0x54, address, false, &value);`
`}`

The article SMBus Controller explains how to access SMBus
devices.

# EEPROM Contents Reference

`typedef struct _EEPROMDATA {`
`   u8           HMAC_SHA1_Hash[20];                     // 0x00 - 0x13 HMAC_SHA1 Hash`
`   u8           Confounder[8];                          // 0x14 - 0x1B RC4 Encrypted Confounder ??`
`   u8           HDDKkey[16];                            // 0x1C - 0x2B RC4 Encrypted HDD key`
`   u8           XBERegion[4];                           // 0x2C - 0x2F RC4 Encrypted Region code (0x01 North America, 0x02 Japan, 0x04 Europe)`
`   u8           Checksum2[4];                           // 0x30 - 0x33 Checksum of next 44 bytes`
`   u8           SerialNumber[12];                       // 0x34 - 0x3F Xbox serial number`
`   u8           MACAddress[6];                          // 0x40 - 0x45 Ethernet MAC address`
`   u8           UNKNOWN2[2];                            // 0x46 - 0x47 Unknown Padding ?`

`   u8           OnlineKey[16];                          // 0x48 - 0x57 Online Key ?`

`   u8           VideoStandard[4];                       // 0x58 - 0x5B  0x00800300 = PAL, 0x00400100 = NTSC, 0x00400200=NTSC_J `

`   u8           UNKNOWN3[4];                            // 0x5C - 0x5F  Unknown Padding ?`

`   //Comes configured up to here from factory..  everything after this can be zero'd out...`
`   //To reset XBOX to Factory settings, Make checksum3 0xFFFFFFFF and zero all data below (0x64-0xFF)`
`   //Doing this will Reset XBOX and upon startup will get Language & Setup screen...`
`   u8           Checksum3[4];                           // 0x60 - 0x63  other Checksum of next`

`   u8           TimeZoneBias[4];                        // 0x64 - 0x67 Zone Bias?`
`   u8           TimeZoneStdName[4];                     // 0x68 - 0x6B Standard timezone`
`   u8           TimeZoneDltName[4];                     // 0x5C - 0x6F Daylight timezone`
`   u8           UNKNOWN4[8];                            // 0x70 - 0x77 Unknown Padding ?`
`   u8           TimeZoneStdDate[4];                     // 0x78 - 0x7B 10-05-00-02 (Month-Day-DayOfWeek-Hour)`
`   u8           TimeZoneDltDate[4];                     // 0x7C - 0x7F 04-01-00-02 (Month-Day-DayOfWeek-Hour)`
`   u8           UNKNOWN5[8];                            // 0x80 - 0x87 Unknown Padding ?`
`   u8           TimeZoneStdBias[4];                     // 0x88 - 0x8B Standard Bias?`
`   u8           TimeZoneDltBias[4];                     // 0x8C - 0x8F Daylight Bias?`

`   u8           LanguageID[4];                          // 0x90 - 0x93 Language ID`

`   u8           VideoFlags[4];                          // 0x94 - 0x97 Video Settings - 0x96 b0==widescreen 0x96 b4 == letterbox`
`   u8           AudioFlags[4];                          // 0x98 - 0x9B Audio Settings`

`   u8           ParentalControlGames[4];                // 0x9C - 0x9F 0=MAX rating`
`   u8           ParentalControlPwd[4];                  // 0xA0 - 0xA3 7=X, 8=Y, B=LTrigger, C=RTrigger`
`   u8           ParentalControlMovies[4];               // 0xA4 - 0xA7 0=Max rating`

`   u8           XBOXLiveIPAddress[4];                   // 0xA8 - 0xAB XBOX Live IP Address..`
`   u8           XBOXLiveDNS[4];                         // 0xAC - 0xAF XBOX Live DNS Server..`
`   u8           XBOXLiveGateWay[4];                     // 0xB0 - 0xB3 XBOX Live Gateway Address..`
`   u8           XBOXLiveSubNetMask[4];                  // 0xB4 - 0xB7 XBOX Live Subnet Mask..`
`   u8           OtherSettings[4];                       // 0xA8 - 0xBB Other XBLive settings ?`

`   u8           DVDPlaybackKitZone[4];                  // 0xBC - 0xBF DVD Playback Kit Zone`

`   u8           UNKNOWN6[64];                           // 0xC0 - 0xFF Unknown Codes / Memory timing table?`
`} EEPROMDATA`

# The HMAC HDD Key

The HMAC HDD Key is generated out of the first 48 bytes. This section
has been identified clearly.

# The Region Code

This DWORD is encrypted. It corresponds to the region code in the XBE
header:

|            |                     |
| ---------- | ------------------- |
| 1          | North America       |
| 2          | Japan               |
| 4          | Europe/Australia    |
| 0x80000000 | Manufacturing plant |

# The Serial Number

`    1166356 20903`
`    ||    | |||||__`
`    ||    | ||||___ factory number`
`    ||    | |||____`
`    ||    | ||_____ week of year (starting Mondays)`
`    ||    | |______ last digit of year`
`    ||    |________`
`    ||_____________ number of Xbox within week and factory`
`    |______________ production line within factory `
`  `

# The MAC address

This is the MAC address of the Ethernet hardware, which has been issued
by the IEEE (http://standards-oui.ieee.org/oui/oui.txt).

# DVD Region

This DWORD corresponds to the region code for playback of DVD movies:

|      |          |
| ---- | -------- |
| 0x00 | None     |
| 0x01 | Region 1 |
| ...  | ...      |
| 0x06 | Region 6 |

# Checksum Algorithm

Checksum2 and Checksum3 values can be calculated by running the
following code snippet over the area the checksum
covers:

`/* The EepromCRC algorithm was obtained from the XKUtils 0.2 source released by`
` * TeamAssembly under the GNU GPL.`
` * Specifically, from XKCRC.cpp`
` *`
` * Rewritten to ANSI C by David Pye (dmp@davidmpye.dyndns.org)`
` *`
` * Thanks! */`
`void EepromCRC(unsigned char *crc, unsigned char *data, long dataLen) {`
`        unsigned char* CRC_Data = (unsigned char *)malloc(dataLen+4);`
`        int pos=0;`
`        memset(crc,0x00,4);`

`        memset(CRC_Data,0x00, dataLen+4);`
`        //Circle shift input data one byte right`
`        memcpy(CRC_Data + 0x01 , data, dataLen-1);`
`        memcpy(CRC_Data, data + dataLen-1, 0x01);`

`        for (pos=0; pos<4; ++pos) {`
`                unsigned short CRCPosVal = 0xFFFF;`
`                unsigned long l;`
`                for (l=pos; l<dataLen; l+=4) {`
`                        CRCPosVal -= *(unsigned short*)(&CRC_Data[l]);`
`                }`
`                CRCPosVal &= 0xFF00;`
`                crc[pos] = (unsigned char) (CRCPosVal >> 8);`
`        }`
`        free(CRC_Data);`
`}`

Retrieved from "<http://www.xbox-linux.org/wiki/Xbox_Serial_EEPROM>"

[Category:Xbox_Hardware](Category:Xbox_Hardware "wikilink")