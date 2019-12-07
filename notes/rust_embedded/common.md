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

To load programs outside of _J-Link_, you'll also need a copy of `bossa`,
which is not currently in _Homebrew_.
- http://www.shumatech.com/web/products/bossa
- https://github.com/shumatech/BOSSA


## Formatting Rust code prior to generating a pull request ##
Install `rustfmt`

    rustup component add rustfmt

Then run `rustfmt` at the top level of the target repo

    rust fmt --all

## Listing serial devices on _macOS_ ##
"Borrowed" from: https://apple.stackexchange.com/questions/170105

`ioreg` displays devices connected to the system in a 'tree' format.  Use the
`-w` switch to tell `ioreg` to format the output for a given width ѕcreen; use
`-w 0` to disable line widths

    ioreg -p IOUSB
    ioreg -w 0 -p IOUSB

`system_profiler` is the command-line version of the _System Profiler_ tool
that can be launched from the `Apple -> About` menu on _macOS_.  It has much
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

vim: filetype=markdown shiftwidth=2 tabstop=2
