The Account file is a HMAC-RC4 encrypted file stored in profiles to hold
things such as the profiles gamertag, PUID (Passport User ID), online
key and more.

# Encryption

The file is encrypted with a custom form of HMAC-RC4, which is handled
by the XeKeysUnobfuscate function. The key differs between retail and
development consoles and is stored in key index 0x19.

  - Retail
    key

<!-- end list -->

    0xE1 0xBC 0x15 0x9C 0x73 0xB1 0xEA 0xE9 0xAB 0x31 0x70 0xF3 0xAD 0x47 0xEB 0xF3

  - Devkit
    key

<!-- end list -->

    0xDA 0xB6 0x9A 0xD9 0x8E 0x28 0x76 0x4F 0x97 0x7E 0xE2 0x48 0x7E 0x4F 0x3F 0x68

To decrypt the file:

  - Copy the first 16 bytes of the file to a buffer. This is the
    HMAC-SHA1 hash of the file which is made using one of the keys
    above.
  - Use HMAC-SHA1 on that buffer with a key from above to create the RC4
    key, which is 0x10 bytes.
  - Decrypt 8 bytes after the hash of the file (at offset 0x10) using
    RC4. This is the confounder.
  - Decrypt 380 bytes after the confounder using RC4. This is the
    decrypted account data.
  - Make a hash of the confounder and decrypted data using HMAC-SHA1 and
    a key above and compare it to the first 16 bytes of the file, if it
    doesn't match then the decryption failed.

To encrypt the file:

  - Copy the decrypted data to offset 0x18
  - Create a random 8 byte confounder and copy this to offset 0x10.
  - Make a hash of the confounder and decrypted data using HMAC-SHA1 and
    a key above, resize it to 16 bytes and then copy that to the
    beginning of the file.
  - Use HMAC-SHA1 on that hash with a key from above to create the RC4
    key, which is 0x10 bytes.
  - Encrypt 388 bytes from position 0x10 using RC4.

# Decrypted File

<table>
<thead>
<tr class="header">
<th><p>Offset</p></th>
<th><p>Length</p></th>
<th><p>Type</p></th>
<th><p>Information</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>0</p></td>
<td><p>4</p></td>
<td><p>UInt32</p></td>
<td><p>Reserved(Flags)<br />
</p></td>
</tr>
<tr class="even">
<td><p>4</p></td>
<td><p>4</p></td>
<td><p>UInt32</p></td>
<td><p>LiveFlags</p></td>
</tr>
<tr class="odd">
<td><p>8</p></td>
<td><p>16 chars/32 bytes</p></td>
<td><p>Unicode</p></td>
<td><p>Gamertag</p></td>
</tr>
<tr class="even">
<td><p>40</p></td>
<td><p>8</p></td>
<td><p>ulong</p></td>
<td><p>XUID</p></td>
</tr>
<tr class="odd">
<td><p>48</p></td>
<td><p>4</p></td>
<td><p>UInt32</p></td>
<td><p>Cached User Flags</p></td>
</tr>
<tr class="even">
<td><p>52</p></td>
<td><p>4</p></td>
<td><p>ASCII string</p></td>
<td><p>Xbox Live Service Provider</p></td>
</tr>
<tr class="odd">
<td><p>56</p></td>
<td><p>4</p></td>
<td><p>PasscodeKeys[4]</p></td>
<td><p>Passcode</p></td>
</tr>
<tr class="even">
<td><p>60</p></td>
<td><p>20</p></td>
<td><p>ASCII string</p></td>
<td><p>Online Domain</p></td>
</tr>
<tr class="odd">
<td><p>80</p></td>
<td><p>24</p></td>
<td><p>ASCII string</p></td>
<td><p>Online Kerberos Realm</p></td>
</tr>
<tr class="even">
<td><p>104</p></td>
<td><p>16</p></td>
<td><p>Bytes</p></td>
<td><p>Online Key</p></td>
</tr>
<tr class="odd">
<td><p>120</p></td>
<td><p>114</p></td>
<td><p>ASCII string</p></td>
<td><p>User Passport Membername</p></td>
</tr>
<tr class="even">
<td><p>234</p></td>
<td><p>32</p></td>
<td><p>ASCII string</p></td>
<td><p>User Passport Password</p></td>
</tr>
<tr class="odd">
<td><p>266</p></td>
<td><p>114</p></td>
<td><p>ASCII string</p></td>
<td><p>Owner Passport Membername</p></td>
</tr>
</tbody>
</table>

  - Note Last 3 not used anymore(if ever).

## Reserved(flags)

| Name             | Value      |
| ---------------- | ---------- |
| Passcode Enabled | 0x10000000 |
| LIVE Enabled     | 0x20000000 |
| Recovering       | 0x40000000 |

The flag at bit0 seems to be always set, not sure what it means though.

## Cached User Flags

| Bits Used Indices | Field Name                     |
| ----------------- | ------------------------------ |
| 0                 | Payment Instrument Credit Card |
| 8-15              | Country                        |
| 16-19             | Subscription Teir              |
| 24                | Parental Controls Enabled      |
| 25-29             | Language                       |
|  |

The other bits are used, I'm just not sure what they all represent.

## Passcode

The passcode is made up of these bytes:

| Byte | Button        |
| ---- | ------------- |
| 0    | Null          |
| 1    | DPad Up       |
| 2    | DPad Down     |
| 3    | DPad Left     |
| 4    | DPad Right    |
| 5    | X             |
| 6    | Y             |
| 7    | A             |
| 8    | B             |
| 9    | Left Trigger  |
| 10   | Right Trigger |
| 11   | Left Bumper   |
| 12   | Right Bumper  |

  - Note A and B are not valid for
passwords.

## XUID

`   public class XUID`
`   {`
`       public System.UInt64 Value;`
`       public XUID(System.UInt64 _Value)`
`       {`
`           Value = _Value;`
`       }`
`       public System.Boolean IsOfflineXuid`
`       {`
`           get`
`           {`
`               return (Value & 17293822569102704640L) == 16140901064495857664L;`
`           }`
`       }`
`       public System.Boolean IsOnline`
`       {`
`           get`
`           {`
`               return (Value & 18446462598732840960L) == 2533274790395904L;`
`           }`
`       }`
`       public System.Boolean IsTeam//Guess this is todo with devs`
`       {`
`           get`
`           {`
`               return (Value & 18374686479671624000L) == 18302628885633696000L;`
`           }`
`       }`
`       public System.Boolean IsValidXuid`
`       {`
`           get`
`           {`
`               return IsOfflineXuid != IsOnlineXuid;`
`           }`
`       }`
`   }`

## Country

`     public enum XboxLiveCountry`
`       {`
`           Albania = 2,`
`           Algeria = 0x1b,`
`           Argentina = 4,`
`           Armenia = 3,`
`           Australia = 6,`
`           Austria = 5,`
`           Azerbaijan = 7,`
`           Bahrain = 10,`
`           Belarus = 14,`
`           Belgium = 8,`
`           Belize = 15,`
`           Bolivia = 12,`
`           Brazil = 13,`
`           BruneiDarussalam = 11,`
`           Bulgaria = 9,`
`           Canada = 0x10,`
`           Chile = 0x13,`
`           China = 20,`
`           Colombia = 0x15,`
`           CostaRica = 0x16,`
`           Croatia = 0x29,`
`           CzechRepublic = 0x17,`
`           Denmark = 0x19,`
`           DominicanRepublic = 0x1a,`
`           Ecuador = 0x1c,`
`           Egypt = 30,`
`           ElSalvador = 0x5f,`
`           Estonia = 0x1d,`
`           FaroeIslands = 0x21,`
`           Finland = 0x20,`
`           France = 0x22,`
`           Georgia = 0x24,`
`           Germany = 0x18,`
`           Greece = 0x25,`
`           Guatemala = 0x26,`
`           Honduras = 40,`
`           HongKong = 0x27,`
`           Hungary = 0x2a,`
`           Iceland = 0x31,`
`           India = 0x2e,`
`           Indonesia = 0x2b,`
`           Iran = 0x30,`
`           Iraq = 0x2f,`
`           Ireland = 0x2c,`
`           Israel = 0x2d,`
`           Italy = 50,`
`           Jamaica = 0x33,`
`           Japan = 0x35,`
`           Jordan = 0x34,`
`           Kazakhstan = 0x3a,`
`           Kenya = 0x36,`
`           Korea = 0x38,`
`           Kuwait = 0x39,`
`           Kyrgyzstan = 0x37,`
`           Latvia = 0x3f,`
`           Lebanon = 0x3b,`
`           LibyanArabJamahiriya = 0x40,`
`           Liechtenstein = 60,`
`           Lithuania = 0x3d,`
`           Luxembourg = 0x3e,`
`           Macao = 0x45,`
`           Macedonia = 0x43,`
`           Malaysia = 0x48,`
`           Maldives = 70,`
`           Mexico = 0x47,`
`           Monaco = 0x42,`
`           Mongolia = 0x44,`
`           Morocco = 0x41,`
`           Netherlands = 0x4a,`
`           NewZealand = 0x4c,`
`           Nicaragua = 0x49,`
`           Norway = 0x4b,`
`           Oman = 0x4d,`
`           Pakistan = 0x51,`
`           Panama = 0x4e,`
`           Paraguay = 0x55,`
`           Peru = 0x4f,`
`           Philippines = 80,`
`           Poland = 0x52,`
`           Portugal = 0x54,`
`           PuertoRico = 0x53,`
`           Qatar = 0x56,`
`           Romania = 0x57,`
`           RussianFederation = 0x58,`
`           SaudiArabia = 0x59,`
`           Singapore = 0x5b,`
`           Slovakia = 0x5d,`
`           Slovenia = 0x5c,`
`           SouthAfrica = 0x6d,`
`           Spain = 0x1f,`
`           Sweden = 90,`
`           Switzerland = 0x12,`
`           SyrianArabRepublic = 0x60,`
`           Taiwan = 0x65,`
`           Thailand = 0x61,`
`           TrinidadAndTobago = 100,`
`           Tunisia = 0x62,`
`           Turkey = 0x63,`
`           Ukraine = 0x66,`
`           UnitedArabEmirates = 1,`
`           UnitedKingdom = 0x23,`
`           UnitedStates = 0x67,`
`           Unknown = 0,`
`           Uruguay = 0x68,`
`           Uzbekistan = 0x69,`
`           Venezuela = 0x6a,`
`           Vietnam = 0x6b,`
`           Yemen = 0x6c,`
`           Zimbabwe = 110`
`       }`

## SubscriptionTeir

`       enum SubscriptionTeir`
`       {`
`       NoSubcription,`
`       Silver = 3,`
`       Gold = 6,`
`       FamilyGold = 9`
`       };`

## Language

`       enum ConsoleLanguage`
`       {`
`           None,`
`           English,`
`           Japanese,`
`           German,`
`           French,`
`           Spanish,`
`           Italian,`
`           Korean,`
`           TChinese,`
`           Portuguese,`
`           SChinese,`
`           Polish,`
`           Russian`
`       };`

[Category: Xbox 360 System Software](../Category_Xbox360_System_Software)
