## Set Standby/Power Off/Reboot

This Command Message triggers various power management operations.

|          |               |
| -------- | ------------- |
| Message: | `82 XX YY ZZ` |

| XX | YY | ZZ  | Meaning                                 |
| -- | -- | --- | --------------------------------------- |
| 01 | 00 | \-- | Power Off (@3dh=1, @64h=\#5a)           |
| 01 | 32 | \-- | Power Off (@3dh=0, Clears RTC?)         |
| 04 | 31 | ??  | Reboot (@3dh=1, @64h=\#01, Soft Reset)  |
| 04 | 30 | ??  | Reboot (@3dh=0, @64h=\#03, Power Cycle) |
| 04 | 33 | \-- | Clear (@3dh=0)                          |
