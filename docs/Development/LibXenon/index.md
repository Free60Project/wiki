# LibXenon

## Summary

**libXenon** is a library for writing programs for the Xbox 360, without
using any existing code as a basis. That means that the resulting
binaries should be free code, and don't contain stuff which would be
illegal to distribute. This also means that you don't have to rely on
Linux, which gives some advantages regarding system utilization.

## Getting libXenon

**libXenon** is work-in-progress, and is available from [Free60 Git Repository](../Free60_Git_Repository.md)

You can check out the source code using git with the following command:

`git clone git://github.com/Free60Project/libxenon.git`

(Windows users may want to try TortoiseGit)

## Installing libXenon

To use **libXenon** you need a proper installation of [Xenon Toolchain](https://github.com/Free60Project/libxenon) first.
You just go into the toolchain-directory which holds `build-xenon-toolchain` and execute:

` ./build-xenon-toolchain libxenon`

This will download and install a fresh copy of **libXenon** Libraries to
the `$DEVKITXENON`-path (Which should be defined in your ~/.bashrc
already! - See bottom of [Xenon Toolchain](https://github.com/Free60Project/libxenon)-page if it isn't!)

## Support

**libXenon** (or **devkitxenon**) stuff is best discussed in
\#free60-noos on the OFTC IRC network , <irc://irc.oftc.net/free60-noos>
or in \#libXenon on EFnet IRC, <irc://irc.efnet.fr/libXenon>

## Sample Code

Example code illustrating **libXenon** use can be found on the [LibXenon Examples](./Examples.md)
page.

[Category: Homebrew Software](../../Homebrew/index.md)

