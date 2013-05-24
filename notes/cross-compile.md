# Cross-Compiling Notes #

## Todos ##
- Set up a cross-compiler
  - `arm7hf`, `ppc`, `sparc`, `i386`, `x86_64`

## Links ##
- Google search `cross-compiling for raspberry pi`
- http://archlinuxarm.org/developers/distcc-cross-compiling
  - mentions http://crosstool-ng.org/
- How to compile `ffmpeg` for Raspberry Pi - http://tinyurl.com/dy4rjs3
  - based on "How to Build a cross-compiler" - http://tinyurl.com/c9fuofd

## Installation and Running ##

    ct-ng menuconfig
    ct-ng build

Logfile is located in:
- `/opt/cross/x-tools/arm-unknown-linux-gnueabi/build.log`

Add `bashrc.d` script for `crosstool-ng`:

https://raw.github.com/spicyjack/public/master/rc_scripts/bashrc.d/crosstool-ng

## Notes on Compiling Other Apps ##
- Make sure that the cross-compiler toolchain is in the `$PATH` for the user
  that will be doing the work
- Do compiles under `Vagrant`, to try to work out library dependencies and
  what needs to be installed on the system prior to compiling?
- See the `ffmpeg` link above for different ways of calling the cross-compiler
  when building a ѕet of apps/libraries

## Examples of Compiling Other Apps ##
Setup

    export CCPREFIX="/opt/cross/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-"

SDL

    ./configure --prefix=/usr/local/src/arm-output/SDL-1.2.15 \
      --host=arm-unknown-linux-gnueabi


vim: filetype=markdown shiftwidth=2 tabstop=2:
