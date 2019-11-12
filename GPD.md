**GPD** (**G**ame **P**rofile **D**ata) files are used by the Xbox 360
to store information inside a profile. They are based on the
[XDBF](XDBF "wikilink") format. Profiles are composed of many of these
files, each named under their respective titles id (e.g. 4D5307E6.gpd
for Halo 3). The dashboard GPD (FFFE07D1.gpd) contains information and
sync information about all the
titles.

# Entry Table

## Entry Namespaces

| Value | Description                                                               |
| ----- | ------------------------------------------------------------------------- |
| 1     | Achievement                                                               |
| 2     | Image                                                                     |
| 3     | Setting                                                                   |
| 4     | Title                                                                     |
| 5     | String                                                                    |
| 6     | Achievement Security (created by GFWL for offline unlocked achievements?) |
| 6     | Avatar Award (360 only, this is only stored with in the \[\[PEC           |

## Entry IDs

An ID of 0x100000000 indicates that the entry is a Sync List, an ID of
0x200000000 means its a Sync Data entry. In **PEC** (**P**rofile
**E**mbedded **C**ontent) files these are changed to 1 and 2.

The Settings, Achievements, Title and Assets namespaces each have their
own Sync List and Sync Data entries.

An ID of 0x8000 is reserved for title information, in the string and
image namespaces. For achievements and images the entry id must match
the id enclosed in the entry data.

| Description                         | Value       |
| ----------------------------------- | ----------- |
| Sync List                           | 0x100000000 |
| Sync Data                           | 0x200000000 |
| Sync List (\[\[PEC                  | PEC\]\])    |
| Sync Data (\[\[PEC                  | PEC\]\])    |
| Option Controller Vibration         | 0x10040003  |
| Title Specific 1                    | 0x63E83FFF  |
| Title Specific 2                    | 0x63E83FFE  |
| Title Specific 3                    | 0x63E83FFD  |
| Gamer Yaxis Inversion               | 0x10040002  |
| Gamercard Zone                      | 0x10040004  |
| Gamercard Region                    | 0x10040005  |
| Gamercard Cred                      | 0x10040006  |
| Gamercard Rep                       | 0x50040011  |
| Option Voice Muted                  | 0x10040012  |
| Option Voice Thru Speakers          | 0x10040013  |
| Option Voice Thru Speakers Raw      | 0x10040063  |
| Option Voice Volume                 | 0x10040014  |
| Gamercard Titles Played             | 0x10040018  |
| Gamercard Achievements Earned       | 0x10040019  |
| Gamer Difficulty                    | 0x10040021  |
| Gamer Control Sensitivity           | 0x10040024  |
| Gamer Preferred Color First         | 0x10040029  |
| Gamer Preferred Color Second        | 0x10040030  |
| Gamer Action Auto Aim               | 0x10040034  |
| Gamer Action Auto Center            | 0x10040035  |
| Gamer Action Movement Control       | 0x10040036  |
| Gamer Race Transmission             | 0x10040038  |
| Gamer Race Camera Location          | 0x10040039  |
| Gamer Race Brake Control            | 0x10040040  |
| Gamer Race Accelerator Control      | 0x10040041  |
| Gamercard Title Cred Earned         | 0x10040056  |
| Gamercard Title Achievements Earned | 0x10040057  |
| Avatar Metadata                     | 0x63E80068  |
| Gamercard Picture Key               | 0x4064000F  |
| Gamercard Motto                     | 0x402C0011  |
| Title Information                   | 0x8000      |
| Gamer Name                          | 0x41040040  |
| Gamer Location                      | 0x40520041  |
| Avatar Information                  | 0x63e80044  |
| Avatar Image                        | 0x8007      |

Setting IDs are largely deterministic, based on there type max length
see [sample
code](http://pastebin.com/mW3fmvpG)

# Entry Structures

## Achievement Entries

| Offset                                                 | Length          | Type                         | Information          |
| ------------------------------------------------------ | --------------- | ---------------------------- | -------------------- |
| 0x0                                                    | 0x4             | unsigned int                 | Struct size (0x1C)   |
| 0x4                                                    | 0x4             | unsigned int                 | Achievement ID       |
| 0x8                                                    | 0x4             | unsigned int                 | Image ID             |
| 0xC                                                    | 0x4             | signed int                   | Gamerscore           |
| 0x10                                                   | 0x4             | unsigned int                 | Flags (see below)    |
| 0x14                                                   | 0x8             | System.DateTime(signed long) | Unlock Time          |
| 0x18                                                   | null terminated | unicode string               | Name                 |
| 0x18 + **Name** length                                 | null terminated | unicode string               | Unlocked Description |
| 0x18 + **Name** length + **Locked Description** length | null terminated | unicode string               | Locked Description   |

### Flags

`       public enum AchievementTypes : byte`
`       {`
`           Completion = 1,`
`           Leveling = 2,`
`           Unlock = 3,`
`           Event = 4,`
`           Tournament = 5,`
`           Checkpoint = 6,`
`           Other = 7,`
`       }`

`       public System.UInt32 Flags;`
`       public AchievementTypes AchievementType`
`       {`
`           get`
`           {`
`               return (AchievementTypes)(Flags & 7);`
`           }`
`           set`
`           {`
`               if ((System.Byte)value > 7) // to may bits in use :O`
`                   throw new Exceptions.InvalidAchievement(new System.Exception("Invalid Type"));`
`               if (value != Type)`
`               {`
`                   Flags ^= 4294967288; // Null the 3 bits`
`                   Flags ^= (System.Byte)Type; // set the new`
`               }`
`           }`
`       }`
`       public System.Boolean AchievementShowUnachieved // !Sectet`
`       {`
`           get`
`           {`
`               return (Flags & 8) == 8;`
`           }`
`           set`
`           {`
`               if (value != ShowUnachieved)`
`                   Flags ^= 8;`
`           }`
`       }`
`       public System.Boolean AchievementEarnedOnline`
`       {`
`           get`
`           {`
`               return (Flags & 65536) == 65536;`
`           }`
`           set`
`           {`
`               if (value != AchievementEarnedOnline)`
`                   Flags ^= 65536;`
`           }`
`       }`
`       public System.Boolean AchievementEarned`
`       {`
`           get`
`           {`
`               return (Flags & 131072) == 131072;`
`           }`
`           set`
`           {`
`               if (value != Achieved)`
`                   Flags ^= 131072;`
`           }`
`       }`
`       public System.Boolean Edited //?`
`       {`
`           get`
`           {`
`               return (Flags & 1048576) == 1048576;`
`           }`
`           set`
`           {`
`               if (value != Edited)`
`               {`
`                   Flags ^= 1048576;`
`               }`
`           }`
`       }`

## Setting Entries

| Offset | Length                  | Type                    | Information            |
| ------ | ----------------------- | ----------------------- | ---------------------- |
| 0      | 4                       | Int32                   | SettingID              |
| 4      | 2                       | UInt16                  | DOS Time(Last edited?) |
| 6      | 2                       | UInt16                  | Unknown                |
| 8      | 1                       | Byte                    | DataType (see Below)   |
| 9      | 7                       | Byte\[\]                | Unknown (always null?) |
| 16     | \*depends on DataType\* | \*depends on DataType\* | Data                   |

| Description | Value |
| ----------- | ----- |
| Context     | 0     |
| Int32       | 1     |
| Int64       | 2     |
| Double      | 3     |
| (UNI)String | 4     |
| Float       | 5     |
| Binary      | 6     |
| DateTime    | 7     |
| Null        | 0xFF  |

With data type string and binary there is a leading Int32 with the
length in the data blob.

## Image Entries

Image entries are PNG images. example
code:

`       public System.Byte[] Data`
`       {`
`           get`
`           {`
`               System.Byte[] TempData;`
`               System.IO.MemoryStream TempStream = new System.IO.MemoryStream();`
`               Img.Save(TempStream, System.Drawing.Imaging.ImageFormat.Png);`
`               TempData = TempStream.ToArray();`
`               TempStream.Close();`
`               return TempData;`
`           }`
`           set`
`           {`
`               System.IO.MemoryStream TempStream = new System.IO.MemoryStream(value);`
`               Img = System.Drawing.Image.FromStream(TempStream);`
`               TempStream.Close();`
`           }`
`       }`

## Title Entries

These entries are only located in the FFFE07D1 gpd. To get to them, the
id for the XDBF entry is the title ID of the game, and the XDBF entry
type is String. For more information see
[XDBF](XDBF "wikilink")

| Offset | Length          | Type           | Information                       |
| ------ | --------------- | -------------- | --------------------------------- |
| 0x0    | 0x4             | unsigned int   | Title ID                          |
| 0x4    | 0x4             | signed int     | Achievement Count                 |
| 0x8    | 0x4             | signed int     | Achievement Unlocked Count        |
| 0xC    | 0x4             | signed int     | Gamerscore Total                  |
| 0x10   | 0x4             | signed int     | Gamerscore Unlocked               |
| 0x14   | 0x1             | unsigned byte  | Unknown                           |
| 0x15   | 0x1             | unsigned byte  | Achievement Unlocked Online Count |
| 0x16   | 0x01            | byte           | Avatar Assets Earned              |
| 0x17   | 0x01            | byte           | Avatar Assets Max                 |
| 0x18   | 0x01            | byte           | Male Avatar Assets Earned         |
| 0x19   | 0x01            | byte           | Male Avatar Assets Max            |
| 0x1A   | 0x01            | byte           | Female Avatar Assets Earned       |
| 0x1B   | 0x01            | byte           | Female Avatar Assets Max          |
| 0x1C   | 0x4             | unsigned int   | Flags (see below)                 |
| 0x20   | 0x8             | signed long    | Last Played Time                  |
| 0x28   | null terminated | unicode string | Title Name                        |

These are not all the flags, it's just that I don't know the rest.

| Value | Description                                         |
| ----- | --------------------------------------------------- |
| 0x1   | Achievement Unlocked Offline, needs to be synced.   |
| 0x2   | Achievement Unlocked, image needs to be downloaded. |
| 0x10  | Avatar Award Unlocked, needs to be downloaded.      |
| 0x20  | ?                                                   |

Title images are also available online:

IconURL
"<http://image.xboxlive.com/global/t>." + ID.ToString("x8") +
"/icon/0/8000"

LargeBoxArtURL
"<http://tiles.xbox.com/consoleAssets/>" + ID.ToString("x8") +
"/en-GB/largeboxart.jpg"

SmallBoxArtURL
"<http://tiles.xbox.com/consoleAssets/>" + ID.ToString("x8") +
"/en-GB/smallboxart.jpg"

BannerURL
"<http://avatar.xboxlive.com/global/t>." + ID.ToString("x8") +
"/marketplace/0/1"

MarketplaceURL
"<http://marketplace.xbox.com/en-US/Title/>" + ID

## Avatar Award Entries

The entries are only supported within the [PEC](PEC "wikilink") version
of the GPD. The images for the avatar awards, are stored in the game GPD
for that
game.

| Offset                                               | Length          | Type        | Information                |
| ---------------------------------------------------- | --------------- | ----------- | -------------------------- |
| 0                                                    | 4               | int32       | Struct size (0x2C)         |
| 4                                                    | 16              | System.Guid | ID                         |
| 20                                                   | 4               | UInt32      | ImageID                    |
| 24                                                   | 4               | UInt32      | Flags(Same as achievement) |
| 28                                                   | 8               | filetime    | Unlock Time                |
| 36                                                   | 4               | Int32       | Subcategory                |
| 40                                                   | 4               | UInt32      | Unknown                    |
| 44                                                   | Null Terminated | Unicode     | Name                       |
| 44 + **Name** length                                 | Null Terminated | Unicode     | Unlocked Description       |
| 44 + **Name** length + **Locked Description** length | Null Terminated | Unicode     | Locked Description         |

### Image

The Image stored in the GPD is stored in the normal GPD however you can
grab the image from the server, using the GUID.

"<http://download.xboxlive.com/content/4d530914/thumbnails/>" + size +
"/" + ID.ToString() + ".png"); // size 64 128 300
"<http://avatar.xboxlive.com/global/t>." + TitleID + "/avataritem/" +
ID.ToString() + "/" + size // 64 or 128

## String Entries

String entries are simply a unicode, null terminated string the length
could be derived from the entry length.

## Sync Lists

This is a list of "Sync Items".

You can find the total sync items by,

((SyncList.Length / 16) - 1)

### Sync Item

| Offset | Length | Type          | Information |
| ------ | ------ | ------------- | ----------- |
| 0      | 8      | unsigned long | EntryID     |
| 8      | 8      | unsigned long | SyncID      |

## Sync Data

| Offset | Length | Type          | Information      |
| ------ | ------ | ------------- | ---------------- |
| 0x0    | 0x8    | unsigned long | Next Sync ID     |
| 0x8    | 0x8    | unsigned long | Last Synced ID   |
| 0x10   | 0x8    | signed long   | Last Synced Time |

IDs in Sync List between last and next are
pushed
//confirm?

[Category:Xbox360_System_Software](Category_Xbox360_System_Software)