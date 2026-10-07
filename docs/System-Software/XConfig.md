# XConfig

## Categories

| Category                              | Value |
| ------------------------------------- | ----- |
| XCONFIG_STATIC_CATEGORY               | 0x0   |
| XCONFIG_STATISTIC_CATEGORY            | 0x1   |
| XCONFIG_SECURED_CATEGORY              | 0x2   |
| XCONFIG_USER_CATEGORY                 | 0x3   |
| XCONFIG_XNET_MACHINE_ACCOUNT_CATEGORY | 0x4   |
| XCONFIG_XNET_PARAMETERS_CATEGORY      | 0x5   |
| XCONFIG_MEDIA_CENTER_CATEGORY         | 0x6   |
| XCONFIG_CONSOLE_CATEGORY              | 0x7   |
| XCONFIG_DVD_CATEGORY                  | 0x8   |
| XCONFIG_IPTV_CATEGORY                 | 0x9   |
| XCONFIG_SYSTEM_CATEGORY               | 0xA   |

## XCONFIG_STATIC_SETTINGS

FirstPowerOnDate: key 0x1 5 bytes

| Field Name       | Type            | Field Size | Offset |
| ---------------- | --------------- | ---------- | ------ |
| CheckSum         | unsigned long   | 4          | 0x00   |
| Version          | unsigned long   | 4          | 0x04   |
| FirstPowerOnDate | char[]          | 5          | 0x08   |
| Reserved         | char            | 1          | 0x0D   |
| SMCBlock         | union_SMC_BLOCK | 256        | 0x0E   |

## SMC_BLOCK

RadioEnable: This is the "bit field" at offset 6; 1 byte total for this bitfield

| Field Name               | Type                          | Field Size | Offset | Bit Position | Bit Length |
| ------------------------ | ----------------------------- | ---------- | ------ | ------------ | ---------- |
| StuctureVersion          | unsigned char                 | 1          | 0x0E   |              |            |
| ConfigSource             | unsigned char                 | 1          | 0x0F   |              |            |
| ClockSelect              | char                          | 1          | 0x10   |              |            |
| FanOverride              | struct_FAN_OVERRIDE           | 2          | 0x11   |              |            |
| pad1                     | char[]                        | 1          | 0x13   |              |            |
| RadioEnable              | char                          | 1          | 0x14   | 0            | 1          |
| UseTempCalDefaults       | char                          | 1          | 0x14   | 1            | 1          |
| ScreenToolStarted        | char                          | 1          | 0x14   | 2            | 1          |
| ScreenToolFinished       | char                          | 1          | 0x14   | 3            | 1          |
| ScreenToolExecutionCount | char                          | 1          | 0x14   | 4            | 2          |
| pad2                     | char[]                        | 3          | 0x15   |              |            |
| Temperature              | union_TEMPERATURE             | 16         | 0x18   |              |            |
| AnaFuseValue             | char                          | 1          | 0x28   |              |            |
| Thermal                  | struct_Thermal                | 6          | 0x29   |              |            |
| pad3                     | unsigned char[]               | 1          | 0x2F   |              |            |
| Viper vFlags             | struct_VIPER                  | 4          | 0x30   |              |            |
| pad4                     | unsigned char[]               | 190        | 0x34   |              |            |
| BackupThermalCalData     | union_BACKUP_THERMAL_CAL_DATA | 23         | 0xF2   |              |            |
| pad5                     | unsigned char[]               | 3          | 0x109  |              |            |
| DoNotUse                 | unsigned char[]               | 2          | 0x10C  |              |            |

## FAN_OVERRIDE

_Note: 0x7F = disabled. Bit 7 = Enable, Bits 0..6 = Speed._

| Field Name | Type                    | Field Size | Offset |
| ---------- | ----------------------- | ---------- | ------ |
| Cpu        | struct_FAN_OVERRIDE_CPU | 1          | 0x00   |
| Gpu        | struct_FAN_OVERRIDE_GPU | 1          | 0x00   |

## FAN_OVERRIDE_CPU

| Field Name | Type          | Field Size | Offset | Bit Position | Bit Length |
| ---------- | ------------- | ---------- | ------ | ------------ | ---------- |
| Speed      | unsigned char | 1          | 0x00   | 0            | 7          |
| Enable     | unsigned char | 1          | 0x00   | 7            | 1          |

## FAN_OVERRIDE_GPU

| Field Name | Type          | Field Size | Offset | Bit Position | Bit Length |
| ---------- | ------------- | ---------- | ------ | ------------ | ---------- |
| Speed      | unsigned char | 1          | 0x00   | 0            | 7          |
| Enable     | unsigned char | 1          | 0x00   | 7            | 1          |

## TEMPERATURE

| Field Name  | Type                        | Field Size | Offset |
| ----------- | --------------------------- | ---------- | ------ |
| TempCalData | unsigned short[]            | 16         | 0x00   |
| Constant    | struct_TEMPERATURE_CONSTANT | 16         | 0x00   |

## TEMPERATURE_CONSTANT

| Field Name | Type                              | Field Size | Offset |
| ---------- | --------------------------------- | ---------- | ------ |
| Cpu        | struct_TEMPERATURE_CONSTANT_CPU   | 4          | 0x00   |
| Gpu        | struct_TEMPERATURE_CONSTANT_GPU   | 4          | 0x04   |
| Edram      | struct_TEMPERATURE_CONSTANT_EDRAM | 4          | 0x08   |
| Board      | struct_TEMPERATURE_CONSTANT_BOARD | 4          | 0x0C   |

## TEMPERATURE_CONSTANT_BOARD

| Field Name | Type           | Field Size | Offset |
| ---------- | -------------- | ---------- | ------ |
| Gain       | unsigned short | 2          | 0x00   |
| Offset     | unsigned short | 2          | 0x02   |

## TEMPERATURE_CONSTANT_CPU

| Field Name | Type           | Field Size | Offset |
| ---------- | -------------- | ---------- | ------ |
| Gain       | unsigned short | 2          | 0x00   |
| Offset     | unsigned short | 2          | 0x02   |

## TEMPERATURE_CONSTANT_GPU

| Field Name | Type           | Field Size | Offset |
| ---------- | -------------- | ---------- | ------ |
| Gain       | unsigned short | 2          | 0x00   |
| Offset     | unsigned short | 2          | 0x02   |

## TEMPERATURE_CONSTANT_EDRAM

| Field Name | Type           | Field Size | Offset |
| ---------- | -------------- | ---------- | ------ |
| Gain       | unsigned short | 2          | 0x00   |
| Offset     | unsigned short | 2          | 0x02   |

## THERMAL

| Field Name | Type                     | Field Size | Offset |
| ---------- | ------------------------ | ---------- | ------ |
| SetPoint   | struct_THERMAL_SET_POINT | 3          | 0x00   |
| Overload   | struct_THERMAL_OVERLOAD  | 3          | 0x03   |

## THERMAL_SET_POINT

| Field Name | Type          | Field Size | Offset |
| ---------- | ------------- | ---------- | ------ |
| Cpu        | Unsigned char | 1          | 0x00   |
| Gpu        | Unsigned char | 1          | 0x01   |
| Edram      | Unsigned char | 1          | 0x02   |

## THERMAL_OVERLOAD

| Field Name | Type          | Field Size | Offset |
| ---------- | ------------- | ---------- | ------ |
| Cpu        | Unsigned char | 1          | 0x00   |
| Gpu        | Unsigned char | 1          | 0x01   |
| Edram      | Unsigned char | 1          | 0x02   |

## VIPER

| Field Name   | Type              | Field Size | Offset |
| ------------ | ----------------- | ---------- | ------ |
| Flags        | union_VIPER_FLAGS | 1          | 0x00   |
| GpuTarget    | unsigned char     | 1          | 0x01   |
| MemoryTarget | unsigned char     | 1          | 0x02   |
| Checksum     | unsigned char     | 1          | 0x03   |

## VIPER_FLAGS

| Field Name | Type                  | Field Size | Offset |
| ---------- | --------------------- | ---------- | ------ |
| AsUCHAR    | Unsigned char         | 1          | 0x00   |
| AsFlags    | struct_VIPER_AS_FLAGS | 1          | 0x00   |

## VIPER_AS_FLAGS

| Field Name              | Type          | Field Size | Offset | Bit Position | Bit Length |
| ----------------------- | ------------- | ---------- | ------ | ------------ | ---------- |
| MemoryVoltageNotSetting | Unsigned char | 1          | 0x00   | 6            | 1          |
| GpuVoltageNotSetting    | unsigned char | 1          | 0x00   | 7            | 1          |

## BACKUP_THERMAL_CALS

| Field Name   | Type              | Field Size | Offset |
| ------------ | ----------------- | ---------- | ------ |
| Temperature  | union_TEMPERATURE | 16         | 0x00   |
| AnaFuseValue | char              | 1          | 0x10   |
| Thermal      | struct_THERMAL    | 6          | 0x11   |

## XCONFIG_STATISTIC_SETTINGS 0x1

| Field Name      | Type            | Field Size | Offset |
| --------------- | --------------- | ---------- | ------ |
| CheckSum        | unsigned long   | 4          | 0x00   |
| Version         | unsigned long   | 4          | 0x04   |
| XUIDMACAddress  | char[]          | 6          | 0x08   |
| Reserved        | char[]          | 2          | 0x0E   |
| XUIDCount       | unsigned long   | 4          | 0x10   |
| ODDFailures     | unsigned char[] | 32         | 0x14   |
| BugCheckData    | unsigned char[] | 101        | 0x34   |
| TemperatureData | unsigned char[] | 200        | 0x99   |
| Unused          | char[]          | 467        | 0x161  |
| HDDSmartData    | char[]          | 512        | 0x334  |
| UEMErrors       | char[]          | 100        | 0x534  |
| FPMErrors       | char[]          | 56         | 0x598  |
| LastReportTime  | unsigned int    | 8          | 0x5D0  |

## XCONFIG_SECURED_SETTINGS 0x2

This is the static settings block positioned right after `SMCBlock`.

| Field Name      | Type                             | Field Size | Offset |
| --------------- | -------------------------------- | ---------- | ------ |
| CheckSum        | Unsigned Long                    | 4          | 0x00   |
| Version         | Unsigned Long                    | 4          | 0x04   |
| OnlineNetworkID | char[]                           | 4          | 0x08   |
| Reserved1       | char[]                           | 8          | 0x0C   |
| Reserved2       | char[]                           | 12         | 0x14   |
| MACAddress      | unsigned char[]                  | 6          | 0x20   |
| Reserved3       | char[]                           | 2          | 0x26   |
| AVRegion        | unsigned long                    | 4          | 0x28   |
| GameRegion      | unsigned short                   | 2          | 0x2C   |
| Reserved4       | char[]                           | 6          | 0x2E   |
| DVDRegion       | unsigned long                    | 4          | 0x34   |
| ResetKey        | unsigned long                    | 4          | 0x38   |
| SystemFlags     | unsigned long                    | 4          | 0x3C   |
| PowerMode       | struct_XCONFIG_POWER_MODE        | 2          | 0x40   |
| PowerVcsControl | struct_XCONFIG_POWER_VCS_CONTROL | 2          | 0x42   |
| ReservedRegion  | char[]                           | 444        | 0x44   |

## POWER_MODE

| Field Name | Type          | Field Size | Offset |
| ---------- | ------------- | ---------- | ------ |
| VIDDelta   | unsigned char | 1          | 0x00   |
| Reserved   | unsigned char | 1          | 0x01   |

## POWER_VCS_CONTROL

| Field Name | Type           | Field Size | Offset | Bit Position | Bit Length |
| ---------- | -------------- | ---------- | ------ | ------------ | ---------- |
| Configured | unsigned short | 2          | 0x00   | 15           | 1          |
| Reserved   | unsigned short | 2          | 0x00   | 12           | 3          |
| Full       | unsigned short | 2          | 0x00   | 8            | 4          |
| Quiet      | unsigned short | 2          | 0x00   | 4            | 4          |
| Fuse       | unsigned short | 2          | 0x00   | 0            | 4          |

## XCONFIG_USER_SETTINGS 0x3

| Field Name                         | Type                         | Field Size | Offset |
| ---------------------------------- | ---------------------------- | ---------- | ------ |
| CheckSum                           | unsigned long                | 4          | 0x00   |
| Version                            | unsigned long                | 4          | 0x04   |
| TimeZoneBias                       | unsigned long                | 4          | 0x08   |
| TimeZoneStdName                    | char[]                       | 4          | 0x0C   |
| TimeZoneDltName                    | char[]                       | 4          | 0x10   |
| TimeZoneStdDate                    | struct_XCONFIG_TIMEZONE_DATE | 4          | 0x14   |
| TimeZoneDltDate                    | struct_XCONFIG_TIMEZONE_DATE | 4          | 0x18   |
| TimeZoneStdBias                    | unsigned long                | 4          | 0x1C   |
| TimeZoneDltBias                    | unsigned long                | 4          | 0x20   |
| DefaultProfile                     | unsigned int                 | 8          | 0x24   |
| Language                           | unsigned long                | 4          | 0x2C   |
| VideoFlags                         | unsigned long                | 4          | 0x30   |
| AudioFlags                         | unsigned long                | 4          | 0x34   |
| RetailFlags                        | unsigned long                | 4          | 0x38   |
| DevkitFlags                        | unsigned long                | 4          | 0x3C   |
| Country                            | char                         | 1          | 0x40   |
| ParentalControlFlags               | char                         | 1          | 0x41   |
| ReservedFlag                       | unsigned char[]              | 2          | 0x42   |
| SMBConfig                          | char[]                       | 256        | 0x44   |
| LivePUID                           | unsigned int                 | 8          | 0x144  |
| LiveCredentials                    | char[]                       | 16         | 0x14C  |
| AVPackHDMIScreenSz                 | signed short[]               | 4          | 0x15C  |
| AVPackComponentScreenSz            | signed short[]               | 4          | 0x160  |
| AVPackVGAScreenSz                  | signed short[]               | 4          | 0x164  |
| ParentalControlGame                | unsigned long                | 4          | 0x168  |
| ParentalControlPassword            | unsigned long                | 4          | 0x16C  |
| ParentalControlMovie               | unsigned long                | 4          | 0x170  |
| ParentalControlGameRating          | unsigned long                | 4          | 0x174  |
| ParentalControlMovieRating         | unsigned long                | 4          | 0x178  |
| ParentalControlHint                | char                         | 1          | 0x17C  |
| ParentalControlHintAnswer          | char[]                       | 32         | 0x17D  |
| ParentalControlOverride            | char[]                       | 32         | 0x19D  |
| MusicPlaybackMode                  | unsigned long                | 4          | 0x1BD  |
| MusicVolume                        | float                        | 4          | 0x1C1  |
| MusicFlags                         | unsigned long                | 4          | 0x1C5  |
| ArcadeFlags                        | unsigned long                | 4          | 0x1C9  |
| ParentalControlVersion             | unsigned long                | 4          | 0x1CD  |
| ParentalControlTv                  | unsigned long                | 4          | 0x1D1  |
| ParentalControlTvRating            | unsigned long                | 4          | 0x1D5  |
| ParentalControlExplicitVideo       | unsigned long                | 4          | 0x1D9  |
| ParentalControlExplicitVideoRating | unsigned long                | 4          | 0x1DD  |
| ParentalControlUnratedVideo        | unsigned long                | 4          | 0x1E1  |
| ParentalControlUnratedVideoRating  | unsigned long                | 4          | 0x1E5  |
| VideoOutputBlackLevels             | unsigned long                | 4          | 0x1E9  |
| VideoPlayerDisplayMode             | unsigned char                | 1          | 0x1ED  |
| AlternativeVideoTimingIDs          | unsigned long                | 4          | 0x1EE  |
| VideoDriverOptions                 | unsigned long                | 4          | 0x1F2  |
| MusicUIFlags                       | unsigned long                | 4          | 0x1F6  |
| VideoMediaSourceType               | char                         | 1          | 0x1FA  |
| MusicMediaSourceType               | char                         | 1          | 0x1FB  |
| PhotoMediaSourceType               | char                         | 1          | 0x1FC  |

## XCONFIG_TIMEZONE_DATE

| Field Name | Type          | Field Size | Offset |
| ---------- | ------------- | ---------- | ------ |
| Month      | unsigned char | 1          | 0x00   |
| Day        | unsigned char | 1          | 0x01   |
| DayOfWeek  | unsigned char | 1          | 0x02   |
| Hour       | unsigned char | 1          | 0x03   |

## XCONFIG_XNET_MACHINE_ACCOUNT 0x4

| Field Name | Type            | Field Size | Offset |
| ---------- | --------------- | ---------- | ------ |
| Version    | unsigned long   | 4          | 0x00   |
| Data       | unsigned char[] | 492        | 0x04   |

## XCONFIG_XNET_PARAMETERS 0x5

XNetStartupParams configuration parameters retrieved at socket initialization in XAM.

| Field Name                        | Type          | Field Size | Offset |
| --------------------------------- | ------------- | ---------- | ------ |
| cfgSizeOfStruct                   | unsigned char | 1          | 0x00   |
| cfgFlags                          | unsigned char | 1          | 0x01   |
| cfgSockMaxDgramSockets            | unsigned char | 1          | 0x02   |
| cfgSockMaxStreamSockets           | unsigned char | 1          | 0x03   |
| cfgSockDefaultRecvBufsizeInK      | unsigned char | 1          | 0x04   |
| cfgSockDefaultSendBufsizeInK      | unsigned char | 1          | 0x05   |
| cfgKeyRegMax                      | unsigned char | 1          | 0x06   |
| cfgSecRegMax                      | unsigned char | 1          | 0x07   |
| cfgQosDataLimitDiv4               | unsigned char | 1          | 0x08   |
| cfgQosProbleTimeoutInSeconds      | unsigned char | 1          | 0x09   |
| cfgQosProbeEntries                | unsigned char | 1          | 0x0A   |
| cfgQosSrvMaxSimultaneousResponses | unsigned char | 1          | 0x0B   |
| cfgQosPairWaitTimeInSeconds       | unsigned char | 1          | 0x0C   |

## XCONFIG_MEDIA_CENTER_SETTINGS 0x6

| Field Name           | Type            | Field Size | Offset |
| -------------------- | --------------- | ---------- | ------ |
| CheckSum             | unsigned long   | 4          | 0x00   |
| Version              | unsigned long   | 4          | 0x04   |
| MediaPlayer          | char[]          | 20         | 0x08   |
| xeSledVersion        | unsigned char[] | 10         | 0x1C   |
| xeSledTrustSecret    | unsigned char[] | 20         | 0x26   |
| xeSledTrustCode      | unsigned char[] | 8          | 0x3A   |
| xeSledHostID         | unsigned char[] | 20         | 0x42   |
| xeSledKey            | unsigned char[] | 1628       | 0x56   |
| xeSledHostMACAddress | unsigned char[] | 6          | 0x6B2  |
| ServerUUID           | char[]          | 16         | 0x6B8  |
| ServerName           | char[]          | 128        | 0x6C8  |
| ServerFlags          | char[]          | 4          | 0x748  |

## XCONFIG_CONSOLE_SETTINGS 0x7

| Field Name             | Type                           | Field Size | Offset |
| ---------------------- | ------------------------------ | ---------- | ------ |
| CheckSum               | unsigned long                  | 4          | 0x00   |
| Version                | unsigned long                  | 4          | 0x04   |
| ScreenSaver            | signed short                   | 2          | 0x08   |
| AutoShutOff            | signed short                   | 2          | 0x0A   |
| WirelessSettings       | unsigned char[]                | 256        | 0x0C   |
| CameraSettings         | unsigned long                  | 4          | 0x10C  |
| CameraSettingsReserved | unsigned char[]                | 28         | 0x110  |
| PlayTimerData          | struct_XCONFIG_PLAY_TIMER_DATA | 20         | 0x12C  |
| MediaDisableAutoLaunch | signed short                   | 2          | 0x140  |
| KeyboardLayout         | signed short                   | 2          | 0x142  |

## PLAY_TIMER_DATA

| Field Name           | Type                 | Field Size | Offset |
| -------------------- | -------------------- | ---------- | ------ |
| uliResetDate         | union_ULARGE_INTEGER | 8          | 0x00   |
| dwPlayTimerFrequency | unsigned long        | 4          | 0x08   |
| dwTotalPlayTime      | unsigned long        | 4          | 0x0C   |
| dwRemainingPlayTime  | unsigned long        | 4          | 0x10   |

## union_ULARGE_INTEGER

| Field Name | Type                   | Field Size | Offset |
| ---------- | ---------------------- | ---------- | ------ |
| HighPart   | unsigned long          | 4          | 0x00   |
| LowPart    | unsigned long          | 4          | 0x04   |
| u          | unnamed_ULARGE_INTEGER | 8          | 0x00   |
| QuadPart   | unsigned int           | 8          | 0x00   |

## unnamed_ULARGE_INTEGER

| Field Name | Type          | Field Size | Offset |
| ---------- | ------------- | ---------- | ------ |
| HighPart   | unsigned long | 4          | 0x00   |
| LowPart    | unsigned long | 4          | 0x00   |

## XCONFIG_DVD_SETTINGS 0x8

| Field Name | Type            | Field Size | Offset |
| ---------- | --------------- | ---------- | ------ |
| Version    | unsigned long   | 4          | 0x00   |
| VolumeID   | unsigned char[] | 20         | 0x04   |
| Data       | unsigned char[] | 640        | 0x18   |

## XCONFIG_IPTV_SETTINGS 0x9

| Field Name            | Type          | Field Size | Offset |
| --------------------- | ------------- | ---------- | ------ |
| CheckSum              | unsigned long | 4          | 0x00   |
| Version               | unsigned long | 4          | 0x04   |
| ServiceProviderName   | wchar_t[]     | 120        | 0x08   |
| ProvisioningServerURL | wchar_t[]     | 128        | 0x80   |
| SupportInfo           | wchar_t[]     | 128        | 0x100  |
| BootstrapServerURL    | wchar_t[]     | 128        | 0x180  |

## XCONFIG_SYSTEM_SETTINGS 0xA

| Field Name           | Type                | Field Size | Offset |
| -------------------- | ------------------- | ---------- | ------ |
| Version              | unsigned long       | 4          | 0x00   |
| AlarmTime            | union_LARGE_INTEGER | 8          | 0x04   |
| PreviousFlashVersion | unsigned long       | 4          | 0x0C   |
