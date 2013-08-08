# Cross-Compiling Notes #

- http://crosstool-ng.org/

## Todos ##
- Set up a cross-compiler
  - `arm7hf`, `ppc`, `sparc`, `i386`, `x86_64`

## Links ##
- Google search `cross-compiling for raspberry pi`
- http://archlinuxarm.org/developers/distcc-cross-compiling
  - mentions http://crosstool-ng.org/
- How to compile `ffmpeg` for Raspberry Pi - http://tinyurl.com/dy4rjs3
  - based on "How to Build a cross-compiler" - http://tinyurl.com/c9fuofd

## Installation ##
- Unpack
- `./configure --prefix=/path/to/stow`
- `time make`
- `sudo make install`
- `sudo stow -v crosstool-ng-1.X.X`

## Running Crosstool ##
- Get help with commands
  - `ct-ng help`
- List all of the possible architectures that can be built
  - `ct-ng list-samples`
- Select a specific sample (which can be customized)
  - `ct-ng <sample name>`
- Customize an existing sample
  - `ct-ng menuconfig`
- Build it
  - `ct-ng build`
  - `ct-ng build.4` (build with 4 parallel processes)
- Show currently configured toolchain/architecture (tuple)
  - `ct-ng show-tuple`
- Show the current version
  - `ct-ng version`
  - `ct-ng help`, look at the top of the help output
- Show all build steps
  - `ct-ng list-steps`
  - You can start/stop the build on given steps if there are issues compiling

Build logfile is located in:
- `/opt/cross/arm-unknown-linux-gnueabi/build.log`

Add `bashrc.d` script for `crosstool-ng`:

https://raw.github.com/spicyjack/public/master/rc_scripts/bashrc.d/crosstool-ng

## Crosstool Build Environment Variables ##
V=0|1|2
  - 0 => show only human-readable messages (default)
  - 1 => show only the commands being executed
  - 2 => show both

## Notes on Compiling Other Apps ##
- Make sure that the cross-compiler toolchain is in the `$PATH` for the user
  that will be doing the work
- Do compiles under `Vagrant`, to try to work out library dependencies and
  what needs to be installed on the system prior to compiling?
- See the `ffmpeg` link above for different ways of calling the cross-compiler
  when building a ѕet of apps/libraries
- The options `--host`, `--build` and `--target` are used by GNU Automake to
  set up the environment for cross-compiling
  - `--build` - The type of system on which the package is being configured
    and compiled. It defaults to the result of running config.guess.
    Specifying a build-type that differs from host-type enables
    cross-compilation mode.
  - `--host` - The type of system on which the package runs. By default it is
    the same as the build machine. Specifying a host-type that differs from
    build-type, when build-type was also explicitly specified, enables
    cross-compilation mode.
  - `--target` - The type of system for which any compiler tools in the
    package produce code (rarely needed). By default, it is the same as host.
  - GNU Autoconf manual:
    - Specifying target triplets: http://tinyurl.com/ltkzvqn
    - Hosts and cross-compilation: http://tinyurl.com/n837ws3

## Examples of Compiling Other Apps ##
Setup

    export CCPREFIX="/opt/cross/armv6-lack_rpi-linux-gnueabi/bin/armv6-lack_rpi-linux-gnueabi-"

SDL

    ./configure --build=$(uname -m) --enable-static \
    --host=armv6-lack_rpi-linux-gnueabi \
    --prefix=/usr/local/src/arm-out --disable-pulseaudio --disable-video-x11 \
    2>&1 | tee config.out

Check compilation

    /opt/cross/armv6-lack_rpi-linux-gnueabi/bin/armv6-lack_rpi-linux-gnueabi-ldd
    --root /opt/cross/armv6-lack_rpi-linux-gnueabi/
      libSDL-1.2.so.0.11.4 | less

Busybox
- Unpack source
- Copy in `.config`
  - Config is located at: `~/src/lack/projects.git/armlack/buildroot`
- Run `make oldconfig` to update if your `.config` was created with an older
  version of Busybox
- Run `make (-j 10)` to compile

vim: filetype=markdown shiftwidth=2 tabstop=2:
