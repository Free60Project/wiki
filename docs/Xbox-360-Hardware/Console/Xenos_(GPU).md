# Xenos GPU

**Xenos** (not to be confused with [Xenon](/Xenon_(Disambiguation))) is a custom graphics processing unit (GPU) designed by ATI,
used in the Xbox 360. Developed under the codename "C1," it is in many
ways related to the R500 desktop PC graphics card series and therefore
very similar to an ATI Radeon X1900 as far as features and performance
are concerned. However, the Xenos introduced many new design ideas that
were later adopted in the R600 series. The package contains two separate
silicon dies, the GPU and an eDRAM, featuring a total of 337 million
transistors. For infos about Xenos Framebuffer/Xenosfb click
[HERE](Xenos_Framebuffer) and for infos about modesetting
[HERE](Modesetting)

## Specifications

  - 325 Million transistors (235m Parent Die / 90m Daughter Die) (Other
    specs say 337 million total)
  - GPU & Northbridge (Northbridge on Parent Die)
  - Two-die design, with two chips in a single package on a single
    substrate
      - Parent die contains the GPU and memory controller
      - Daughter die consists of the 10MB of eDRAM & additional logic
        (FSAA, Alpha, ZLogic & Stencil)
      - 2GHz link between the parent and daughter die
  - 500MHz processor
  - 10 MB of embedded DRAM (By NEC)
  - 48-way parallel floating-point dynamically scheduled shader
    pipelines
      - 4 ALU's per pipe for Vertex or Pixel Shader processing
  - Unified shader architecture (Beyond Shader Model 3.0)
  - Three SIMD engines with 16 processors per unit (The 48 shader
    pipeline)
  - 16 Filtered & 16 unfiltered texture samples per clock
  - HDR Rendering
  - DirectX 9
  - Limited support for DirectX 10
  - Handles all scaling of video (resolution).

## Linux Support

Currently, we have support for the framebuffer console. We also have an
unaccelerated X driver. We don't yet have support for acceleration,
neither 2D nor 3D, but there is on going work.
[1](http://debugmo.de/2007/09/fear-triangles) Rudimentary video mode
setup code exists in XeLL and the Linux framebuffer driver. There are
though problems with interlaced modes.

## Framebuffer Code

Unfortunately, the framebuffer memory is not linear (i.e. pixels are not
stored one after another, line after line). The memory is organized in
tiles of 32x32 pixels, where in each tile blocks of 4x1 pixels are
scattered around. Every pixel is stored as a 32 bit RGBx tuple.

The tiling breaks most framebuffer applications which require linear
access, causing heavily distorted pictures. This could maybe be fixed by
writing custom blit routines in xenos_fb. Are there any apps using the
framebuffer blit functions, or is everybody mmap()ing? -- Ge0rG 15:03,
21 Jan 2008 (PST)

## External Links

  - [ATI Xenos: Xbox 360 Graphics
    Demystified](http://www.beyond3d.com/content/articles/4/) at
    Beyond3D
  - [AMD R6xx R7xx 3D](https://www.x.org/docs/AMD/old/R6xx_R7xx_3D.pdf) at
    Xorg.com
  - [R700 Instruction Set
    Arch](http://developer.amd.com/wordpress/media/2012/10/R700-Family_Instruction_Set_Architecture.pdf)
    at developer.amd.com

[Category: Xbox 360 Hardware](../Category_Xbox360_Hardware)
