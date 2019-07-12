## PyGamer Usage Notes ##
The _PyGamer_ device has an `on/off` switch, and a `reset` switch.  To restart
the currently loaded program, press the `reset` switch once.  To reset the
device and get it ready to load a new program, press the `reset` switch twice
in succession, similar to a double-mouse click on a computer.  Once the
bootloader loads, you will see the "program load" graphic on the display, and
the USB flashing device will be available to the host system.

If you have a battery connected to the _PyGamer_ device, you can connect and
disconnect the USB cable to the host computer or USB hub/charger as needed,
the device will automatically switch between power sources.

When you are done using the _PyGamer_ device, you can use the `on/off` switch
to shut the device off.

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
      --port=cu.usbmodem14301 \
      --usb-port=1 \
      --erase \
      --write \
      --verify \
      --offset 0x4000 \
      target/thumbv7em-none-eabihf/debug/examples/neopixel_rainbow.bin \
      --reset

vim: filetype=markdown shiftwidth=2 tabstop=2
