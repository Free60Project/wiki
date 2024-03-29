# Console Security Certificate

The **Console Security Certificate** is used by the Xbox 360 as the
format of all RSA signatures generated by it. The total length of the
certificate is 552 (0x228) bytes.

## Structure

| Offset | Length | Type         | Information                                                  |
| ------ | ------ | ------------ | ------------------------------------------------------------ |
| 0x0    | 0x2    | bytes        | Public Key Certificate Size                                  |
| 0x2    | 0x5    | bytes        | Console ID                                                   |
| 0x7    | 0xB    | ascii string | Console Part Number                                          |
| 0x12   | 0x4    | int          | Reserved                                                     |
| 0x16   | 0x2    | short        | Privileges                                                   |
| 0x18   | 0x4    | int          | Console Type (0x02 for retail, anything different is devkit) |
| 0x1C   | 0x8    | ascii string | Certificate Date of Generation                               |
| 0x24   | 0x4    | bytes        | Public Exponent                                              |
| 0x28   | 0x80   | bytes        | Public Modulus                                               |
| 0xA8   | 0x100  | bytes        | Certificate Signature                                        |
| 0x1A8  | 0x80   | bytes        | Signature                                                    |

## Notes

The console type field can be very strange, especially with older
pre-1888 dashboards, for example two different 1838 keyvaults identify
their console type as 0x80000002. If you want to check if something is
devkit or retail, I'd suggest something like:

```c
if(consoletype == 0x02)
    return retail;
else
    return devkit;
```

[System Software](System_Software)
