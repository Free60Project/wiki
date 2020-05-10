# Modesetting

We know libxenon sets graphics modes by writing a complete Ana dump to
Ana memory and writing some values to the GPU registers. The registers
affected and the information that gets written is the
following:

```
total_width, hsync_offset, real_active_width, total_height,
vsync_offset, active_height, width, height,

is_progressive = 0 for non progressive modes, 1 for progressive modes.

rgb = 1, only declared on the modes used through VGA.

composite_sync=1, only declared on the PAL/NTSC non progressive modes.

interlace_factor is set to 1 when mode is progressive and 2 when it is not.

FB_BASE is a constant for the framebuffer base address on libxenon, but we
get different addresses on the GPU dumps.
```

These are the addresses that get that variables written at some stage of
the initialization, in the order libxenon write them. I have take out
the addresses that get fixed values written. As you can see, some
addresses get written more than one time on the initialization process.
Following are the values of the GPU dumps we currently own. We need to
find a way to know if these dumps are valid as some values differ
drastically from what we can read on libxenon's xenos.c and, if they are
valid, why the are not the values
expected.

```
0x6000, mode->total_width - 1

1024x768:  0x0000053f
1280x1024: 0x00000697
1280x720:  0x00000671
1920x1080: 0x0000081f

0x6010, mode->total_height - 1

1024x768:  0x00000325
1280x1024: 0x00000429
1280x720:  0x000002ed
1920x1080: 0x00000456

0x6004, (mode->hsync_offset << 16) | (mode->real_active_width + mode->hsync_offset)

1024x768:  0x00eb04eb
1280x1024: 0x01250625
1280x720:  0x00c705c7
1920x1080: 0x002d07ad

0x6014, (mode->vsync_offset << 16) | (mode->active_height * interlace_factor + mode->vsync_offset)

1024x768:  0x00230323
1280x1024: 0x00290429
1280x720:  0x001902e9
1920x1080: 0x001c0454

0x6030, mode->is_progressive ? 0 : 1

It is 0x00000000 on all the dumps.

0x6120, mode->width

This address gets rewritten later.

0x6134, mode->width

1024x768:  0x000003c0
1280x1024: 0x000003c0
1280x720:  0x00000500
1920x1080: 0x00000360

0x6138, mode->active_height * interlace_factor

This address gets rewritten later.

0x6110, FB_BASE

1024x768:  0x1f78e000
1280x1024: 0x1f78e000
1280x720:  0x1f6a8000
1920x1080: 0x01c5b000

0x6120, mode->width

1024x768:  0x000003c0
1280x1024: 0x000003c0
1280x720:  0x00000500
1920x1080: 0x00000360

0x2840, FB_BASE

0x2844, mode->width

I don't know what hardware is in charge on this memory addresses

0x6584, (mode->width << 16) | (mode->active_height * interlace_factor)

This address gets rewritten later.

0x65e8, (mode->width >> 2) - 1

This address gets rewritten later.

0x6528, mode->is_progressive ? 0 : 1

It is 0x00000000 on all the dumps.

0x6584, (mode->width << 16) | (mode->height * interlace_factor)

1024x768:  0x040002d0
1280x1024: 0x040002d0
1280x720:  0x050002d0
1920x1080: 0x035401e0

0x65e8, (mode->width / 4) - 1

1024x768:  0x000000ff
1280x1024: 0x000000ff
1280x720:  0x0000013f
1920x1080: 0x000000d4

0x6434, mode->width

It is 0x00000000 in all dumps (!?)

0x6138, mode->height * interlace_factor

1024x768:  0x000002d0
1280x1024: 0x000002d0
1280x720:  0x000002d0
1920x1080: 0x000001e0
```