## Adafruit Feather M0 Board Notes ##

## Basic Build & Deploy Workflow (macOS) ##
Build the binary

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
      --offset 0x2000 \
      target/<build_architecture>/debug/examples/<example_name>.bin \
      --reset

## Building the `pwm` demo ##
Build the binary

    cd atsamd.git/boards/feather_m0
    cargo build --release --example pwm

Verify the binary is valid for the `thumbv7em-none-eabihf` architecture

    file target/thumbv6m-none-eabi/debug/examples/pwm
    arm-none-eabi-readelf \
        -h target/thumbv6m-none-eabi/debug/examples/pwm
    cargo readobj --target thumbv6m-none-eabi --bin pwm \
      -- -file-headers

In a different terminal, start the JLink debug server


    JLinkGDBServer -if SWD -device ATSAMD21G18

Now in the original terminal, go back to the toplevel directory, and run

    gdb -quiet boards/feather_m0/target/thumbv6m-none-eabi/debug/examples/pwm

Set any breakpoints in the program running on the device

     break pwm.rs:main

Run `continue` to start the app on the device

## Building the `blinky_basic` demo ##
Build the binary

    cd atsamd.git/boards/feather_m0
    cargo build --release --example blinky_basic

Verify the binary is valid for the `thumbv6m-none-eabi` architecture

    file target/thumbv6m-none-eabi/debug/examples/blinky_basic
    arm-none-eabi-readelf \
        -h target/thumbv6m-none-eabi/debug/examples/blinky_basic
    cargo readobj --target thumbv6m-none-eabi --bin blinky_basic \
      -- -file-headers

In a different terminal, start the JLink debug server


    JLinkGDBServer -if SWD -device ATSAMD21G18

Now in the original terminal, go back to the toplevel directory, and run

    gdb -quiet \
      boards/feather_m0/target/thumbv6m-none-eabi/debug/examples/blinky_basic

Set any breakpoints in the program running on the device

     break blinky_basic.rs:main

Run `c`/`continue` to start the app on the device

vim: filetype=markdown shiftwidth=2 tabstop=2
