## Embedded Rust Programming Notes ##

See also `rust_embedded_discovery.md` in this directory.

## Links ##
- https://docs.rust-embedded.org/

"The Discovery book"
- https://docs.rust-embedded.org/discovery/index.html

"The (embedded Rust) book"
- https://rust-embedded.github.io/book/intro/index.html

"The Embedonomicon"
- https://docs.rust-embedded.org/embedonomicon/preface.html
  - The embedonomicon walks you through the process of creating a #![no_std]
    application from scratch and through the iterative process of building
    architecture-specific functionality for Cortex-M microcontrollers.
  - Examples can be run using _QEMU_

GDB
- https://sourceware.org/gdb/
  - https://sourceware.org/gdb/current/onlinedocs/gdb/
  - https://sourceware.org/gdb/wiki/BuildingOnDarwin
  - https://sourceware.org/gdb/wiki/PermissionsDarwin
- https://github.com/cyrus-and/gdb-dashboard
  - https://github.com/cyrus-and/gdb-dashboard/issues/1
  - https://github.com/cyrus-and/gdb-dashboard/issues/81
  - https://github.com/yudai/gotty

## Rust Setup ##
Software for all platforms
- `rustc`
  - `rustc -V`, version should be 1.31.0 or greater
- `itmdump` 
  - `cargo install itm --vers 0.3.1`
  - `itmdump -V`
- `cargo-binutils`
  - `rustup component add llvm-tools-preview`
  - `cargo install cargo-binutils --vers 0.1.4`
  - `cargo size -- -version`
- Download the standard libraries for `thumbv7em-none-eabihf` (Cortex-M4F)
  - `rustup target add thumbv7em-none-eabihf`
  - Other ARM Cortex chipsets
    - https://docs.rust-embedded.org/discovery/05-led-roulette/build-it.html#build-it
    - `thumbv6m-none-eabi`, for the Cortex-M0 and Cortex-M1 processors
    - `thumbv7m-none-eabi`, for the Cortex-M3 processor
    - `thumbv7em-none-eabi`, for the Cortex-M4 and Cortex-M7 processors
    - `thumbv7em-none-eabihf`, for the **Cortex-M4F** and **Cortex-M7F**
      processors

## macOS Setup ##
- `brew install armmbed/formulae/arm-none-eabi-gcc`
- `brew install minicom openocd`

You'll also need a copy of `bossa`, which is not currently in _Homebrew_.
- http://www.shumatech.com/web/products/bossa
- https://github.com/shumatech/BOSSA

## Basic Build & Deploy Workflow (macOS) ##
Build the binary (see also optional setup in _GDB Survival Guide_ below)

    cd atsamd.git/boards/<board_name>
    cargo build --example <example_name>
    arm-none-eabi-objcopy -O binary \
      target/<build_architecture>/debug/examples/<example_name> \
      target/<build_architecture>/debug/examples/<example_name>.bin
    bossac --info --debug \
      --port=cu.usbmodem<device_id> \
      --usb-port=1 \
      --erase \
      --write \
      --verify \
      target/<build_architecture>/debug/examples/<example_name>.bin \
      --reset

## Building the `neopixel_rainbow` demo ##
Building the `neopixel_rainbow` demo for the _PyGamer_ board

Build the binary (see also optional setup in _GDB Survival Guide_ below)

    cd atsamd.git/boards/pygamer
    cargo build --example neopixel_rainbow

Verify the binary is valid for the `thumbv7em-none-eabihf` architecture

    file target/thumbv7em-none-eabihf/debug/examples/neopixel_rainbow
    arm-none-eabi-readelf \
        -h target/thumbv7em-none-eabihf/debug/examples/neopixel_rainbow
    cargo readobj --target thumbv7em-none-eabihf --bin neopixel_rainbow \
      -- -file-headers

Copy the ELF file to a "binary" format, for use on bare-metal hardware

    arm-none-eabi-objcopy -O binary \
      target/thumbv7em-none-eabihf/debug/examples/neopixel_rainbow \
      target/thumbv7em-none-eabihf/debug/examples/neopixel_rainbow.bin


Flash the binary to the device

    bossac --info --debug \
      --port=cu.usbmodem14344201 \
      --usb-port=1 \
      --erase \
      --write \
      --verify \
      --offset 0x4000 \
      target/thumbv7em-none-eabihf/debug/examples/neopixel_rainbow.bin \
      --reset

## Listing serial devices on _macOS_ ##
"Borrowed" from: https://apple.stackexchange.com/questions/170105

`ioreg` displays devices connected to the system in a 'tree' format.  Use the
`-w` switch to tell `ioreg` to format the output for a given width ѕcreen; use
`-w 0` to disable line widths

    ioreg -p IOUSB
    ioreg -w 0 -p IOUSB

`system_profiler` is the command-line version of the _System Profiler_ tool
that can be launched from the Apple -> About menu on _macOS_.  It has much
more info than `ioreg`, but you need to parse all of that information to make
use of it.

    system_profiler SPUSBDataType
vim: filetype=markdown shiftwidth=2 tabstop=2
