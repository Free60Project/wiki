# Categories

    XCONFIG_STATIC_CATEGORY = 0x0
    XCONFIG_STATISTIC_CATEGORY = 0x1
    XCONFIG_SECURED_CATEGORY = 0x2
    XCONFIG_USER_CATEGORY = 0x3
    XCONFIG_XNET_MACHINE_ACCOUNT_CATEGORY = 0x4
    XCONFIG_XNET_PARAMETERS_CATEGORY = 0x5
    XCONFIG_MEDIA_CENTER_CATEGORY = 0x6
    XCONFIG_CONSOLE_CATEGORY = 0x7
    XCONFIG_DVD_CATEGORY = 0x8
    XCONFIG_IPTV_CATEGORY = 0x9
    XCONFIG_SYSTEM_CATEGORY = 0xa

# Notes

    XCONFIG_STATIC_SETTINGS 0x0
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                      unsigned long               4           0x00
    Version                       unsigned long               4           0x04
    FirstPowerOnDate                 char[]                   5           0x08      // key 0x1 5 bytes
    Reserved                         char                     1           0x0D
    SMCBlock                      union <unnamed-tag>         256         0x0E

    -----------------------------------------------------------------------------------------------------------


    SMCBlock
    ~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    StuctureVersion               unsigned char               1           0x0E
    ConfigSource                  unsigned char               1           0x0F
    ClockSelect                      char                     1           0x10
    FanOverride           Struct_XCONFIG_STATIC_SETTINGS      2           0x11
    pad1                             char[]                   1           0x13

    RadioEnable                      char                     1           0x14            0                1       //This is the "bit field" at offset 6   ;// 1 byte total for this bitfield
    UseTempCalDefaults               char                     1           0x14            1                1
    ScreenToolStarted                char                     1           0x14            2                1
    ScreenToolFinished               char                     1           0x14            3                1
    ScreenToolExecutionCount         char                     1           0x14            4                2

    pad2                             char[]                   3           0x15
    Temperature           union_XCONFIG_STATIC_SETTINGS       16          0x18
    AnaFuseValue                     char                     1           0x28
    Thermal               Struct_XCONFIG_STATIC_SETTINGS      6           0x29
    pad3                         unsigned char[]              1           0x2F
    Viper vFlags          Struct_XCONFIG_STATIC_SETTINGS      4           0x30

    pad4                         unsigned char[]              190         0x34

    BackupThermalCalData  union_XCONFIG_STATIC_SETTINGS       23          0xF2
    pad5                         unsigned char[]              3           0x109
    DoNotUse                     unsigned char[]              2           0x10C



    FanOverride
    ~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    Cpu                    Struct_XCONFIG_STATIC_SETTINGS     1           0
    Gpu                    Struct_XCONFIG_STATIC_SETTINGS     1           0

    // 01111111 <- normally disabled as 0x7F
    Enable : 1; // says 7 is bit 0
    Speed  : 7; // says 0 bit 7

    FanOverrideCpu
    --------------
    Speed                        unsigned char                1           0              0                7
    Enable                       unsigned char                1           0              7                1

    FanOverrideGpu
    --------------
    Speed                        unsigned char                1           0              0                7
    Enable                       unsigned char                1           0              7                1
    -----------------------------------------------------------------------------------------------------------





    Temperature
    ~~~~~~~~~~~

    -------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    TempCalData                  unsigned short[]             16          0
    Constant               Struct_XCONFIG_STATIC_SETTINGS     16          0


    TemperatureConstant
    -------------------
    Cpu                    Struct_XCONFIG_STATIC_SETTINGS     4           0
    Gpu                    Struct_XCONFIG_STATIC_SETTINGS     4           4
    Edram                  Struct_XCONFIG_STATIC_SETTINGS     4           8
    Board                  Struct_XCONFIG_STATIC_SETTINGS     4           12


    TemperatureConstantBoard
    ------------------------
    Gain                         unsigned short               2           0
    Offset                       unsigned short               2           2


    TemperatureConstantCpu
    ------------------------
    Gain                         unsigned short               2           0
    Offset                       unsigned short               2           2


    TemperatureConstantGpu
    ------------------------
    Gain                         unsigned short               2           0
    Offset                       unsigned short               2           2


    TemperatureConstantEdram
    ------------------------
    Gain                         unsigned short               2           0
    Offset                       unsigned short               2           2
    -----------------------------------------------------------------------------------------------------------



    Thermal
    ~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    SetPoint               Struct_XCONFIG_STATIC_SETTINGS     3           0
    Overload               Struct_XCONFIG_STATIC_SETTINGS     3           3


    ThermalSetPoint
    ---------------
    Cpu                          Unsigned char                1           0
    Gpu                          Unsigned char                1           1
    Edram                        Unsigned char                1           2


    ThermalOverload
    ---------------
    Cpu                          Unsigned char                1           0
    Gpu                          Unsigned char                1           1
    Edram                        Unsigned char                1           2
    -----------------------------------------------------------------------------------------------------------



    Viper
    ~~~~~

    ------------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    Flags                 union_XCONFIG_STATIC_SETTINGS       1           0
    GpuTarget                    unsigned char                1           1
    MemoryTarget                 unsigned char                1           2
    Checksum                     unsigned char                1           3


    ViperFlags
    -----------
    AsUCHAR                      Unsigned char                1           0
    AsFlags               Struct_XCONFIG_STATIC_SETTINGS      1           0


    ViperAsFlags
    ------------
    MemoryVoltageNotSetting      Unsigned char                1           0              6                1
    : 1; // bit 6 (bit 5 thru 0 unused
    GpuVoltageNotSetting         unsigned char                1           0              7                1
    : 1; // bit 7

    //u8 unknown : 6; // 1 byte
        u8 GpuTarget;
        u8 MemoryTarget;
        u8 CheckSum;
    -----------------------------------------------------------------------------------------------------------



    BackupThermalCalData
    ~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    Temperature           union_XCONFIG_STATIC_SETTINGS       16          0                                     // Same as other info
    AnaFuseValue                     char                     1           16
    Thermal               Struct_XCONFIG_STATIC_SETTINGS      6           17
    -----------------------------------------------------------------------------------------------------------






    XCONFIG_STATISTIC_SETTINGS 0x1
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                     unsigned long                4           0
    Version                      unsigned long                4           4
    XUIDMACAddress                  char[]                    6           8
    Reserved                        char[]                    2           14
    XUIDCount                    unsigned long                4           16
    ODDFailures                 unsigned char[]               32          20
    BugCheckData                unsigned char[]               101         52
    TemperatureData             unsigned char[]               200         153
    Unused                          char[]                    467         353
    HDDSmartData                    char[]                    512         820
    UEMErrors                       char[]                    100         1332
    FPMErrors                       char[]                    56          1432
    LastReportTime               unsigned int                 8           1488
    -----------------------------------------------------------------------------------------------------------




    XCONFIG_SECURED_SETTINGS 0x2   // This is the other static one right after the SMCBlock
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                     Unsigned Long                4           0
    Version                      Unsigned Long                4           4
    OnlineNetworkID                  char[]                   4           8
    Reserved1                        char[]                   8           12
    Reserved2                        char[]                   12          20
    MACAddress                  unsigned char[]               6           32
    Reserved3                        char[]                   2           38
    AVRegion                     unsigned long                4           40
    GameRegion                   unsigned short               2           44
    Reserved4                        char[]                   6           46
    DVDRegion                    unsigned long                4           52
    ResetKey                     unsigned long                4           56
    SystemFlags                  unsigned long                4           60
    PowerMode               Struct_XCONFIG_POWER_MODE         2           64
    PowerVcsControl      Struct_XCONFIG_POWER_VCS_CONTROL     2           66
    ReservedRegion                   char[]                   444         68



    PowerMode
    ---------
    VIDDelta                     unsigned char                1           0
    Reserved                     unsigned char                1           1



    PowerVCSControl
    ---------------
    Configured                   unsigned short               2           0              15               1
    Reserved                     unsigned short               2           0              12               3
    Full                         unsigned short               2           0              8                4
    Quiet                        unsigned short               2           0              4                4
    Fuse                         unsigned short               2           0              0                4
    -----------------------------------------------------------------------------------------------------------




    XCONFIG_USER_SETTINGS 0x3
    ~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                     unsigned long                4           0
    Version                      unsigned long                4           4
    TimeZoneBias                 unsigned long                4           8
    TimeZoneStdName                 char[]                    4           12
    TimeZoneDltName                 char[]                    4           16
    TimeZoneStdDate        struct_XCONFIG_TIMEZONE_DATE       4           20
    TimeZoneDltDate        struct_XCONFIG_TIMEZONE_DATE       4           24
    TimeZoneStdBias              unsigned long                4           28
    TimeZoneDltBias              unsigned long                4           32
    DefaultProfile               unsigned int                 8           36
    Language                     unsigned long                4           44
    VideoFlags                   unsigned long                4           48
    AudioFlags                   unsigned long                4           52
    RetailFlags                  unsigned long                4           56
    DevkitFlags                  unsigned long                4           60
    Country                          char                     1           64
    ParentalControlFlags             char                     1           65
    ReservedFlag                unsigned char[]               2           66
    SMBConfig                       char[]                    256         68
    LivePUID                     unsigned int                 8           324
    LiveCredentials                 char[]                    16          332
    AVPackHDMIScreenSz           signed short[]               4           348
    AVPackComponentScreenSz      signed short[]               4           352
    AVPackVGAScreenSz            signed short[]               4           356
    ParentalControlGame          unsigned long                4           360
    ParentalControlPassword      unsigned long                4           364
    ParentalControlMovie         unsigned long                4           368
    ParentalControlGameRating    unsigned long                4           372
    ParentalControlMovieRating   unsigned long                4           376
    ParentalControlHint              char                     1           380
    ParentalControlHintAnswer       char[]                    32          381
    ParentalControlOverride         char[]                    32          413
    MusicPlaybackMode            unsigned long                4           445
    MusicVolume                    double                     4           449
    MusicFlags                   unsigned long                4           453
    ArcadeFlags                  unsigned long                4           457
    ParentalControlVersion             unsigned long          4           461
    ParentalControlTv                   unsigned long         4           465
    ParentalControlTvRating             unsigned long         4           469
    ParentalControlExplicitVideo        unsigned long         4           473
    ParentalControlExplicitVideoRating  unsigned long         4           477
    ParentalControlUnratedVideo         unsigned long         4           481
    ParentalControlUnratedVideoRating   unsigned long         4           485
    VideoOutputBlackLevels              unsigned long         4           489
    VideoPlayerDisplayMode              unsigned char         1           493
    AlternativeVideoTimingIDs    unsigned long                4           494
    VideoDriverOptions           unsigned long                4           498
    MusicUIFlags                 unsigned long                4           502
    VideoMediaSourceType             char                     1           506
    MusicMediaSourceType             char                     1           507
    PhotoMediaSourceType             char                     1           508




    XCONFIG_TIMEZONE_DATE
    ---------------------
    Month                        unsigned char                1           0
    Day                          unsigned char                1           1
    DayOfWeek                    unsigned char                1           2
    Hour                         unsigned char                1           3
    -----------------------------------------------------------------------------------------------------------




    XCONFIG_XNET_MACHINE_ACCOUNT 0x4
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    Version                      unsigned long                4           0
    Data                         unsigned long                492         4
    -----------------------------------------------------------------------------------------------------------




    XCONFIG_XNET_PARAMETERS 0x5   //I believe this is XnetStartupParams which is retrieved at sockinit in xam
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~   // so this is a struct of XNetStartupParams, but that might not be right.
                                  // these Qos things seem to be the "Ping Limit"
    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    cfgSizeOfStruct                    unsigned char          1           0
    cfgFlags                           unsigned char          1           1
    cfgSockMaxDgramSockets             unsigned char          1           2
    cfgSockMaxStreamSockets            unsigned char          1           3
    cfgSockDefaultRecvBufsizeInK       unsigned char          1           4
    cfgSockDefaultSendBufsizeInK       unsigned char          1           5
    cfgKeyRegMax                       unsigned char          1           6
    cfgSecRegMax                       unsigned char          1           7
    cfgQosDataLimitDiv4                unsigned char          1           8
    cfgQosProbleTimeoutInSeconds       unsigned char          1           9
    cfgQosProbeEntries                 unsigned char          1           10
    cfgQosSrvMaxSimultaneousResponses  unsigned char          1           11
    cfgQosPairWaitTimeInSeconds        unsigned char          1           12
    -----------------------------------------------------------------------------------------------------------



    XCONFIG_MEDIA_CENTER_SETTINGS 0x6
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                     unsigned long                4           0
    Version                      unsigned long                4           4
    MediaPlayer                     char[]                    20          8
    xeSledVersion               unsigned char[]               10          28
    xeSledTrustSecret           unsigned char[]               20          38
    xeSledTrustCode             unsigned char[]               8           58
    xeSledHostID                unsigned char[]               20          66
    xeSledKey                   unsigned char[]               1628        86
    xeSledHostMACAddress        unsigned char[]               6           1714
    ServerUUID                      char[]                    16          1720
    ServerName                      char[]                    128         1736
    ServerFlags                     char[]                    4           1864






    XCONFIG_CONSOLE_SETTINGS 0x7
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                     unsigned long                4           0
    Version                      unsigned long                4           4
    ScreenSaver                  signed short                 2           8
    AutoShutOff                  signed short                 2           10
    WirelessSettings            unsigned char[]               256         12
    CameraSettings               unsigned long                4           268
    CameraSettingsReserved      unsigned char[]               28          272
    PlayTimerData            struct_XCONFIG_PLAYTIMERDATA     20          300
    MediaDisableAutoLaunch       signed short                 2           320
    KeyboardLayout               signed short                 2           322



    PlayTimerData
    -------------
    uliResetDate              union_ULARGE_INTEGER            8           0
    dwPlayTimerFrequency         unsigned long                4           8
    dwTotalPlayTime              unsigned long                4           12
    dwRemainingPlayTime          unsigned long                4           16


    union_ULARGE_INTEGER
    --------------------
    HighPart                     unsigned long                4           0
    LowPart                      unsigned long                4           4
    u                         unnamed_ULARGE_INTEGER          8           0
    QuadPart                     unsigned int                 8           0


    unnamed_ULARGE_INTEGER
    ----------------------
    HighPart                     unsigned long                4           0
    LowPart                      unsigned long                4           0
    -----------------------------------------------------------------------------------------------------------




    XCONFIG_DVD_SETTINGS 0x8
    ~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    Version                      unsigned long                4           0
    VolumeID                    unsigned char[]               20          4
    Data                        unsigned char[]               640         24
    -----------------------------------------------------------------------------------------------------------




    XCONFIG_IPTV_SETTINGS 0x9
    ~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    CheckSum                     unsigned long                4           0
    Version                      unsigned long                4           4
    ServiceProviderName            wchar_t[]                  120         8
    ProvisioningServerURL          wchar_t[]                  128         128
    SupportInfo                    wchar_t[]                  128         256
    BootstrapServerURL             wchar_t[]                  128         384



    XCONFIG_SYSTEM_SETTINGS 0xA
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -----------------------------------------------------------------------------------------------------------
    Field Name                       Type                Field Size     Offset    Bit Position       Bit Length
    -----------------------------------------------------------------------------------------------------------
    Version                      unsigned long                4            0
    AlarmTime                 union_LARGE_INTEGER             8            4
    PreviousFlashVersion         unsigned long                4            12



    union_ULARGE_INTEGER
    --------------------
    HighPart                     unsigned long                4           0
    LowPart                      unsigned long                4           4
    u                         unnamed_ULARGE_INTEGER          8           0
    QuadPart                     unsigned int                 8           0


    unnamed_ULARGE_INTEGER
    ----------------------
    HighPart                     unsigned long                4           0
    LowPart                      unsigned long                4           0
    -----------------------------------------------------------------------------------------------------------
