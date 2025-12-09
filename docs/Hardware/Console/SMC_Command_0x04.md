## Query Real Time Clock

The reply to the SMC command 0x04 will contain big-endian count of miliseconds since `11-15-2001 00:00:00 UTC`, represented in hex. This code is identical to the original Xbox Real Time Clock (RTC) code.

This value wraps around once it reaches `FFFFFFFFFF`, representing `09/17/2036 19:53:47 UTC`.

|          |                     |
| -------- | ------------------- |
| Message: | `04`                |
| Reply:   | `04 XX XX XX XX XX YY ZZ` |

|    | Meaning                             |
| -- | ----------------------------------- |
| XX | Number of miliseconds since epoch.  |
| YY | Boolean; whether time is in sync.   |
| ZZ | Unknown; seemingly always 00.       |
