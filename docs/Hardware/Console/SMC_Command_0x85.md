## Set Real Time Clock

This Command Message sets the real time clock to the specified big-endian count of miliseconds since `11-15-2001 00:00:00 UTC`, represented in hex. This code is identical to the original Xbox Real Time Clock (RTC) code.

The maximum value that the clock can be set to is `FFFFFFFFFF`, representing `09/17/2036 19:53:47 UTC`. After this, the clock will wrap around.

|          |                           |
| -------- | ------------------------- |
| Message: | `85 XX XX XX XX XX YY ZZ` |

|    | Meaning                             |
| -- | ----------------------------------- |
| XX | Number of miliseconds since epoch.  |
| YY | Boolean; whether time is in sync.   |
| ZZ | Unknown; seemingly always 00.       |
