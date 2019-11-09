# Windows

### Installing Cygwin

1.  Download [Cygwin](http://cygwin.com/install.html). Once it's done,
    run the installer. Set the Install Directory to C:\\Cygwin, or what
    ever your root drive path is.
2.  When prompted for a server, select anyone, they all have the same
    packages, but I would recommend xmission.
3.  Make sure you install the necessary devs libs:

`GCC `
`Make `
`Git `
`build-essential `
`texinfo `
`Etc.`

# Linux

### Prerequisites

`libgmp3-dev`
`libmpfr-dev`
`libmpc-dev`
`texinfo`
`git-core`
`build-essential`

# Mac OS X

### Prerequisites

1.  Install Xcode.
2.  Install macports, then "sudo port install mpfr gmp git-core wget"
3.  sudo mkdir /usr/local/xenon; sudo chown -R $USER /usr/local/xenon
4.  Do the "Building the Toolchain" stuff from below.

If you're running Xcode 3.2, get Apple to fix [this
bug](http://gcc.gnu.org/bugzilla/show_bug.cgi?id=41180#c8). Workaround
is to compile until it fails with the "duplicate symbol" error (check
build.log), then do the mentioned workaround in gcc-4.4.0/gcc directory
(changing Make-lang.in), then disable the rebuild of binutils, gcc
(first stage) and newlib by setting

`BUILD_BINUTILS=false`
`BUILD_GCC=false`
`BUILD_NEWLIB=false`
`BUILD_GCC_SECOND=true`

in the build-xenon-toolchain. Then retry the build. It should finish the
build.

# Building the Toolchain

Run the following commands through the console your using:

`git clone `<git://github.com/Free60Project/libxenon.git>
`cd libxenon/toolchain`
`./build-xenon-toolchain toolchain`

The toolchain should start building (Note: This might take some time).

# Full process of installation

To give people a start who are not used to Linux but want to start
coding, here it goes. In this example I am refering to Ubuntu/Debian.

First we install
dependencies

`apt-get install libgmp3-dev libmpfr-dev libmpc-dev texinfo git-core gettext build-essential`

Now we create the target directory for the Toolchain & Libxenon and own
it by the current user
Note: If your distro has the "su" command to get superuser rights, get
superuser before typing the commands in the following block.
Note: If not, append "sudo" before those commands (example: "sudo mkdir
-p /usr/local/xenon")

`mkdir -p /usr/local/xenon`
`chown -R your_regular_user:your_regular_user /usr/local/xenon`
`# exit the superuser-environment now!`

Then we grab the toolchain from git and build it

`git clone `<git://github.com/Free60Project/libxenon.git>
`cd libxenon/toolchain`
`./build-xenon-toolchain toolchain`

Note: If gcc building, 2nd stage, fails for you, do "apt-get install
libgmp4-dev" and restart building process.

Note for Ubuntu users: If you encounter in the build.log following
error:

`configure: error: Building GCC requires GMP 4.2+, MPFR 2.3.2+ and MPC 0.8.0+.`

Do the following:

`cd gcc-4.6.1`
`wget `<ftp://ftp.gmplib.org/pub/gmp-5.0.2/gmp-5.0.2.tar.bz2>
`tar xvjf gmp-5.0.2.tar.bz2 && mv gmp-5.0.2 gmp`
`wget `<http://www.multiprecision.org/downloads/mpc-0.9.tar.gz>
`tar xvzf mpc-0.9.tar.gz && mv mpc-0.9 mpc `
`wget `<https://www.mpfr.org/mpfr-3.0.1/mpfr-3.0.1.tar.gz>
`tar xvzf mpfr-3.0.1.tar.gz && mv mpfr-3.0.1 mpfr`
`cd ..`
`./build-xenon-toolchain toolchain`

At the end of compiling it will tell you to add paths to your ~/.bashrc
- that's an improper solution.
Rather do it the following way:

`# Get superuser rights first!`
`touch /etc/profile.d/devkitxenon.sh`
`chmod +x /etc/profile.d/devkitxenon.sh`
`# Now open the file and insert the two export lines`
`nano /etc/profile.d/devkitxenon.sh`
`# Insert the lines below in the text editor!`

`export DEVKITXENON="/usr/local/xenon"`
`export PATH="$PATH:$DEVKITXENON/bin:$DEVKITXENON/usr/bin"`

Press Ctrl+O for saving the file and press ENTER if it asks for a
filename Press Ctrl+X for closing nano

Have fun compiling your code ;)

[Category:Xbox360_Development](Category:Xbox360_Development "wikilink")