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

    ./configure --build=$(uname -m) --enable-static \
    --host=arm-unknown-linux-gnueabi --target=arm-unknown-linux-gnueabi \
    --prefix=/usr/local/src/arm-out --disable-pulseaudio --disable-video-x11 \
    2>&1 | tee config.out

    /opt/cross/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ldd
    --root /opt/cross/x-tools/arm-unknown-linux-gnueabi/ 
      libSDL-1.2.so.0.11.4 | less

Busybox
- Unpack source
- Copy in `.config`
  - Config is located at: `~/src/lack/projects.git/armlack/buildroot`
- Run `make oldconfig` to update if your `.config` was created with an older
  version of Busybox
- Run `make (-j 10)` to compile

vim: filetype=markdown shiftwidth=2 tabstop=2:
