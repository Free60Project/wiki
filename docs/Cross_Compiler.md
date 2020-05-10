# Cross Compiler

The Xbox 360 [CPU](../Xenon_(CPU)) is based on IBM's Power
Architecture. Unless you have a machine with PowerPC CPU and Linux
running (such as an older Mac or a PS3), you need to set up a cross
compiler toolchain in order to compile code like the [Linux Kernel](../Linux_Kernel)
for your Xbox 360.

A typical cross compiler toolchain for the GNU compiler collection
usually consists of three major parts:

- the GNU binutils package
- the gcc compiler
- a implementation of the standard C library (can be left out if you
  only want to cross compile the Linux kernel)

Compiling a compiler on its own platform is already a quite complex
task, compiling a compiler for a different platform adds even more
caveats as not all versions of binutils, gcc and glibc work together
well.

## Using the Xenon Toolchain

The easiest way to set up a complete cross compiler toolchain is the [Xenon Toolchain](../Compiling_the_Toolchain).
Its using current gcc and does not take as long as crossotool to compile.


## Dan Kegel's crosstool

An alternative method is to use Dan Kegel's crosstool. Especially the author
has already tried lots of combinations of binutils, GCC and glibc to mark the working
ones. A complete documentation of crosstool can be found at the
[crosstool website](http://kegel.com/crosstool/). For a quick start, we
will summarize the instructions from the crosstool-howto:

1. **Preparations**: Make sure you have the following basic UNIX tools
   installed (with the variety of Linux distributions available, you never
   know...):
     - wget
     - tar
     - bzip2
     - bison
     - flex
     - make
     - gcc & friends (targeting your own platform)

1. **Download and unpack** the crosstool scripts. E.g. in your home
directory type:

```
wget http://kegel.com/crosstool/crosstool-0.43.tar.gz
tar -xzvf crosstool-0.43.tar.gz
```

1. **Create the target directories** for your cross compilation tools
and make them writable for your user. We are using the default which is
`/opt/crosstool`. You will probably need to be root for that so either
`su` before typing these commands and replace `$USER` with your username
or use `sudo` like in the example:

```
sudo mkdir /opt/crosstool
sudo chown $USER /opt/crosstool
```

3. **Run the compilation script** for the powerpc target.

```
cd crosstool-0.43/
./demo-powerpc-970.sh
```

4. **Get a drink**, go for a walk or use the time to remove the resistor [R6T3](../R6T3)
from the mainboard of your Xbox 360... Compilation of your cross compiler will just take a while.

5. **When finished**, you may want to add your cross compiler binaries to your PATH environment
variable.

```
export PATH=$PATH:/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin
```

You're done. Feel free to configure and compile your [Linux Kernel](../Linux_Kernel).

[Category:Xbox360_Development](../Category_Xbox360_Development)