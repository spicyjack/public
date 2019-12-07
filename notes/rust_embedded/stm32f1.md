## STM32F1 (* Pill) Board Notes ##

## Basic Build & Flash Workflow (macOS) ##
Build the binary

    cd repo.git
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

## Building the SSD1306 `graphics_i2c_128x32` demo ##
Build the binary

    cd ssd1306.git
    cargo build --example graphics_i2c_128x32

Verify the binary is valid for the `thumbv7em-none-eabihf` architecture

    file target/thumbv7m-none-eabi/debug/examples/graphics_i2c_128x32
    arm-none-eabi-readelf \
        -h target/thumbv7m-none-eabi/debug/examples/graphics_i2c_128x32
    cargo readobj --target thumbv7em-none-eabihf --bin graphics_i2c_128x32\
      -- -file-headers
    cargo size --example graphics_i2c_128x32 -- -A

In a different terminal, start an Open-OCD process


    openocd -f interface/stlink-v2.cfg -f target/stm32f1x.cfg

Now in the original terminal, go back to the toplevel directory, and run

    gdb --quiet target/thumbv7m-none-eabi/debug/examples/graphics_i2c_128x32

Set any breakpoints in the program running on the device

     break graphics_i2c_128x32.rs:main

Run `continue` to start the app on the device

vim: filetype=markdown shiftwidth=2 tabstop=2
