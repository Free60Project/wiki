The **System Management Controller (SMC)** is an
[8051/8052](8051_8052) core inside the
[Southbridge](Southbridge). It manages the power sequencing,
and is always active when the Xbox 360 has (standby or full) power
applied. It controls the frontpanel, has a Realtime clock, decodes IR,
manages temperatures, fans, DVDROM tray and a bunch of other things. It
talks with the frontpanel board to set the LEDs. When the system is
running, the kernel can communicate with the SMC, for example to query
the realtime clock, open the dvd-tray etc.

## The FIFO

### Sending a Message

Communication between kernel and SMC happens over a bidirectional FIFO
(at ea001080 / ea001090).
All messages and replies are 16 byte long and have the command id in the
first byte.

```c
void smc_send(void *msg)
{
      while (!(readl(0xea001084) & 4))    // wait for FIFO ready
              cpu_relax();

      writel(4, 0xea001084);              // start message
      writesl(0xea001080, msg, 4);        // send 16 bytes
      writel(0, 0xea001084);              // end message
}
```

### Receiving a Reply

Some messages have replies, which will be returned as 16 byte sequence
similar to the message (they also have the command id in the first
byte).


```c
int smc_read_reply(void *msg)
{
      if (!(readl(0xea001094) & 4))       // do we have a reply?
              return 0;

      writel(4, 0xea001094);              // start reply
      readsl(0xea001090, msg, 4);         // read 16 bytes
      writel(0, 0xea001094);              // end reply
      return 1;
}
```

## Command Messages

| ID                                   | Len     | Example                                                    | Purpose                    |
| ------------------------------------ | ------- | ---------------------------------------------------------- | -------------------------- |
| [0x82](SMC_Command_0x82)  | 2-3     | "\\x82\\0x04\\0x31\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | set standby/power          |
| 0x85                                 | ?       | ?                                                          | set real time clock        |
| 0x88                                 | ?       | ?                                                          | set fan algorithm          |
| 0x89                                 | ?       | ?                                                          | set fan speed (cpu/gpu?)   |
| 0x8b                                 | ?       | "\\x8b\\0x62\\0x00\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | set dvd tray               |
| 0x8c                                 | 3       | "\\x8c\\0x01\\0x00\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | set power led              |
| 0x8d                                 | 2       | "\\x8d\\0x01\\0x00\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | set audio mute             |
| 0x94                                 | ?       | ?                                                          | set fan speed (cpu/gpu?)   |
| 0x95                                 | ?       | ?                                                          | set ir address             |
| 0x98                                 | 1       | "\\x98\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0"       | set dvd tray secure        |
| 0x99                                 | 3       | "\\x99\\0x01\\0x0f\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | set ring of light          |
| 0x9a                                 | ?       | ?                                                          | set rtc wake               |

## Query Messages

| ID                                   | Len      | Example Query                                        | Example Reply                | Purpose                      |
| ------------------------------------ | -------- | ---------------------------------------------------- | ---------------------------- | ---------------------------- |
| [0x01](SMC_Command_0x01)  | 1:6      | "\\x01\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `01 12 00 00 00 00`          | power on type                |
| 0x04                                 | 1:11     | "\\x04\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `04 602f 212223 01 00000000` | real time clock              |
| 0x07                                 | 1:10     | "\\x07\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `07ff 241b 2fa4 2cfa 262c`   | read temps                   |
| 0x0a                                 | 1:2      | "\\x0a\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `0a 60`                      | request tray state           |
| 0x0f                                 | 1:2      | "\\x0f\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `0f 54`                      | request AV pack type         |
| 0x11                                 | 6:2      | "\\x11\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `11 02`                      | read ana                     |
| 0x12                                 | 1:6      | "\\x12\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `1241 0203 0000`             | request SMC version          |
| 0x16                                 | 1:2      | "\\x16\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `16 0f`                      | query IR address             |
| 0x17                                 | 1:2      | "\\x17\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0\\0" | `17 00`                      | query tilt sensor            |

## Event Messages

| ID   | Len   | Example Message | Purpose   |
| ---- | ----- | --------------- | --------- |
| 0x83 | 2     | `83 64`         | SMC event |

[Category: Xbox 360 Hardware](../Category_Xbox360_Hardware)
