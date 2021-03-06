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


## Setting Source Paths ##
If you compile source code into binaries (with debug info) in one directory,
but run _GDB_ from a different directory, you need to let _GDB_ know where
to find the original source code.  You do this by setting source directories
in _GDB_.

Show the directories where _GDB_ can find the program's source code

    (gdb) show directory
    (gdb) show dir

Set the directories where _GDB_ can find the program's source code; note that
you should use `show dir` first to see and possibly reuse existing directories

    (gdb) set dir boards/feather_m0:$cdir:$cwd


## GDB Basic Usage ##
Continue a running program; use _<Ctrl-C>_ to stop a running program

    (gdb) continue
    (gdb) cont
    (gdb) c

List the program

    (gdb) list (show next 10 lines of current file)
    (gdb) list - (show previous 10 lines of current file)
    (gdb) list path/to/filename:function_name
    (gdb) list path/to/filename:<line_number>

Next line, stepping in to function calls

    (gdb) step
    (gdb) s

Next line, stepping over function calls

    (gdb) next
    (gdb) n

Step through instructions in "disassembly" view

    (gdb) stepi
    (gdb) si

Killing the running program

    (gdb) kill
    (gdb) k

Run the currently loaded program

    (gdb) run
    (gdb) r

Quit _GDB_

    (gdb) quit
    (gdb) q


## Showing Things ##
Show a backtrace of the entire program up from the current line

    (gdb) backtrace
    (gdb) bt

Show a backtrace, with all local variables

    (gdb) backtrace full
    (gdb) bt full

Show name of current source file

    (gdb) info source

List all files in use

    (gdb) info sources

Show last 10 values

    (gdb) show values

Show names, types of defined functions (all, or matching `<regex>`)

    (gdb) info func [<regex>]

Show names, types of global variables (all, or matching `<regex>`)

    (gdb) info var [<regex>]


## Searching ##
Regex forward search in source

    (gdb) forw <regex>

Regex backwards search in source

    (gdb) rev <regex>


## Breakpoints/Watchpoints ##
Show breakpoints

    (gdb) info break
    (gdb) info break
    (gdb) i b

Set a breakpoint

    (gdb) break [file:]line
    (gdb) b [file:]line

Set a breakpoint at _offset_ lines from current stop

    (gdb) b +<offset>
    (gdb) b -<offset>

Clear a single breakpoint

    (gdb) clear (clears breakpoint at next instruction)
    (gdb) c (clears breakpoint at next instruction)
    (gdb) clear [file:]function
    (gdb) clear [file:]line


## Examining Variables ##
Print the value of a variable; note that uninitialized variables will contain
garbage

    (gdb) print x

Print the memory address of a variable

    (gdb) print &x

Print all local variables

    (gdb) info locals


## GDB Logging ##
- https://sourceware.org/gdb/current/onlinedocs/gdb/Logging-Output.html

Set the name of the logfile (default logfile name is `gdb.txt` in the current
directory)

    (gdb) set logging file <filename>

Turn on logging

    (gdb) set logging on

Turn off logging

    (gdb) set logging off

Show logging status

    (gdb) show logging


## GDB Drastic Actions ##
Reset the microcontroller and stop it at the program entry point

    (gdb) monitor reset halt

**Note:** that memory is not cleared when the `reset` command is given


## GDB Config Files ##
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


## Other GDB UIs ##
Once you are in _GDB_, change to a nicer UI

    (gdb) layout src

Change back to the original UI with...

    (gdb) tui disable

Switch to the "disassembly" view

    (gdb) layout asm


vim: filetype=markdown shiftwidth=2 tabstop=2
