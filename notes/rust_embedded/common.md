## Common Embedded Rust Programming Notes ##

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

J-Link GDB
- https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack

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

Optional software
- https://github.com/cyrus-and/gdb-dashboard
  - "GDB Dashboard", cleans up and makes `gdb` output purdy


## macOS Setup ##
- `brew install armmbed/formulae/arm-none-eabi-gcc`
- `brew install minicom openocd`

To load programs outside of _J-Link_, you'll also need a copy of `bossa`,
which is not currently in _Homebrew_.
- http://www.shumatech.com/web/products/bossa
- https://github.com/shumatech/BOSSA


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


## Optional Setup Steps ##
You can set up a `[build]` section in the `.cargo/config` file that specifies
the default `--target` to build for a given program
(https://stackoverflow.com/questions/49453571)

``
(
cat <<'EOHD'
[build]
target = "thumbv7em-none-eabihf"
EOHD
) >> .cargo/config
``


## GDB Survival Guide ##
You can add _GDB_ commands to the current project that you are running by
creating a `.gdbinit` file in the project directory.  You can also create a
"global" _GDB_ file as `~/.gdbinit`.

Sample `.gdbinit` file

    target remote :3333
    load
    break main.rs:main
    continue


Create `.gdbinit` with (copy/paste)...

``
(
cat <<'EOHD'
target remote :3333
load
break led_roulette::main
continue
EOHD
) > .gdbinit
``


Once you are in _GDB_, change to a nicer UI

    (gdb) layout src

Change back to the original UI with...

    (gdb) tui disable

Step forward one statement

    (gdb) step

Print the value of a variable; note that uninitialized variables will contain
garbage

    (gdb) print x

Print the memory address of a variable

    (gdb) print &x

Print all local variables

    (gdb) info locals

Switch to the "disassembly" view

    (gdb) layout asm

Step through instructions in "disassembly" view

    (gdb) stepi

Reset the microcontroller and stop it at the program entry point

    (gdb) monitor reset halt

**Note:** that memory is not cleared when the `reset` command is given

Quit _GDB_

    (gdb) quit


vim: filetype=markdown shiftwidth=2 tabstop=2
