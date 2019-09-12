## J-Link Notes ##

## Links ##
- https://www.segger.com/products/debug-probes/j-link/models/model-overview/
- https://www.segger.com/products/debug-probes/j-link/models/j-link-edu-mini
- https://www.segger.com/products/debug-probes/j-link/technology/cpus-and-devices/overview-of-supported-cpus-and-devices/#DeviceList
- https://www.segger.com/downloads/jlink/
- https://www.segger.com/downloads/supported-devices.php

## Starting/Stopping JLinkExe ##
macOS-specific commands are given below;

    JLinkExe
    exit

## Viewing Hardware Info ##
macOS-specific commands are given below;

    JLinkExe
    hwinfo

## JLinkGDBServer Usage ##
Run a GDB server on the SWD interface, for a Microchip ATSAMD21G18 (Feather
M0/CPX) device

    JLinkGDBServer -if SWD -device ATSAMD21G18

vim: filetype=markdown shiftwidth=2 tabstop=2
