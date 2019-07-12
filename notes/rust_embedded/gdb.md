## GNU Debugger Notes ##

## Links ##
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

Optional software
- https://github.com/cyrus-and/gdb-dashboard
  - "GDB Dashboard", cleans up and makes `gdb` output purdy


## GDB Usage ##
Step forward one statement

    (gdb) step

Print the value of a variable; note that uninitialized variables will contain
garbage

    (gdb) print x

Print the memory address of a variable

    (gdb) print &x

Print all local variables

    (gdb) info locals

Step through instructions in "disassembly" view

    (gdb) stepi

Reset the microcontroller and stop it at the program entry point

    (gdb) monitor reset halt

**Note:** that memory is not cleared when the `reset` command is given

Quit _GDB_

    (gdb) quit


## Changing GDB UIs ##
Once you are in _GDB_, change to a nicer UI

    (gdb) layout src

Change back to the original UI with...

    (gdb) tui disable

Switch to the "disassembly" view

    (gdb) layout asm


## .gdbinit Files ##
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


vim: filetype=markdown shiftwidth=2 tabstop=2
