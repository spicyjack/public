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
      target/<build_architecture>/debug/examples/<example_name>.bin \
      --reset

## Building the `pwm` demo ##
Build the binary

    cd atsamd.git/boards/feather_m0
    cargo build --example pwm

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

vim: filetype=markdown shiftwidth=2 tabstop=2
