## Query Power On Type

The reply to the SMC command 0x01 will contain some information about
the event which caused the X360 to power up.

|          |                     |
| -------- | ------------------- |
| Message: | `01`                |
| Reply:   | `01 WW 00 XX YY ZZ` |

| Data | Source | Meaning                |
| ---- | ------ | ---------------------- |
| WW   | @63h   | Type of power up Event |
| XX   | @3fh   | ??                     |
| YY.0 | @2bh.1 | ??                     |
| ZZ   | @3eh   | ??                     |

| \#   | Event Type       |
| ---- | ---------------- |
| 0x11 | power button     |
| 0x12 | eject button     |
| 0x15 | rtc wakeup       |
| 0x16 | ???              |
| 0x20 | power IR         |
| 0x21 | eject IR         |
| 0x22 | xenon IR         |
| 0x24 | MCE IR           |
| 0x30 | power cycle      |
| 0x31 | reset cycle      |
| 0x41 | ???              |
| 0x51 | kiosk            |
| 0x55 | argon (RF)       |
| 0x56 | gameport 1       |
| 0x57 | gameport 2       |
| 0x5a | expansion resume |
