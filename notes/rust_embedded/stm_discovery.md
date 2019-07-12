# The Discovery Book #

## Links ##
https://docs.rust-embedded.org/discovery/index.html
- Repo
  - https://github.com/rust-embedded/discovery
- ST Docs
  - STM32F3DISCOVERY User Manual -
    http://www.st.com/resource/en/user_manual/dm00063382.pdf
  - STM32F303VC Datasheet -
    http://www.st.com/resource/en/datasheet/stm32f303vc.pdf
  - STM32F303VC Reference Manual -
    http://www.st.com/resource/en/reference_manual/dm00043574.pdf

## About the book ##
This book is an introductory course on microcontroller-based embedded systems
that uses Rust as the teaching language rather than the usual C/C++.  The book
uses the STM32F3DISCOVERY board for all demos and code examples.

## Verifying connection to the board ##
- Plug in the USB cable to the "USB ST-LINK" USB port
- Run `openocd`


    openocd -f interface/stlink-v2-1.cfg -f target/stm32f3x.cfg

- You should see _OpenOCD_ debug info about the target board in the _OpenOCD_
  output
- _OpenOCD_ will block the terminal while it is running

## Basic Build & Deploy Workflow ##
Build the binary; there are also optional [GDB](./gdb.md) setup steps, which
makes life easier when debugging.

    cd source_dir.git
    cargo build --target thumbv7em-none-eabihf

To set up debugging, in a different terminal, run...

    cd /tmp
    openocd -f interface/stlink-v2-1.cfg -f target/stm32f3x.cfg

Now in the original terminal run...

    gdb -q target/thumbv7em-none-eabihf/debug/program_name
    run


## Building the `05-led-roulette` demo ##
Build the binary

    cd stm-discovery.git/src/05-led-roulette
    cargo build

Verify the binary is valid for the `thumbv7em-none-eabihf` architecture

    file target/thumbv7em-none-eabihf/debug/led-roulette
    arm-none-eabi-readelf \
        -h target/thumbv7em-none-eabihf/debug/led-roulette
    cargo readobj --target thumbv7em-none-eabihf --bin led-roulette \
      -- -file-headers


(Optional) You can add a `.gdbinit` file the directory that you run `gdb` from
in order to give `gdb` a default set of options when it is run for debugging;
see the [GDB](./gdb.md) notes file for more info.

## Flash the compiled binary to the device ##
To set up debugging, in a different terminal, run...

    cd /tmp
    openocd -f interface/stlink-v2-1.cfg -f target/stm32f3x.cfg

Now in the original terminal run...

    gdb -quiet target/thumbv7em-none-eabihf/debug/led-roulette

Compiling the release version will load the code on the board so it runs
automatically when the reset button is pushed

    cargo build --target thumbv7em-none-eabihf --release

vim: filetype=markdown shiftwidth=2 tabstop=2
