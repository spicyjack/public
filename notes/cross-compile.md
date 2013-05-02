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

vim: filetype=markdown shiftwidth=2 tabstop=2:
