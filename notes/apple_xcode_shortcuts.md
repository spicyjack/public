# Xcode Keyboard/Gesture Shortcuts #

Works on: OS X 10.9.X (Lion) and Xcode 6.x.x

Log debugging command: `p (void)NSLog(@"%s %@", _cmd, foo)`

## Links ##
- Keyboard gestures and shortcuts - http://tinyurl.com/7tnxmgd
- Xcode 4 User Guide - http://tinyurl.com/7pkzaqe
- http://www.1729.us/xcode/Xcode%20Shortcuts.png
- Finding Documentation Quickly - http://tinyurl.com/ce8mlww
- http://en.wikibooks.org/wiki/Unicode/Character_reference/2000-2FFF

## Jump Bar Comments and compiler warnings ##
- In Xcode 6, if you add **FIXME:**/**TODO:**/**???:**/**!!!:** (keyword,
  then a colon) comments to code, _outside of methods_, Xcode will make jump
  bar targets for them
- To make compiler warnings, use the `#warning` compiler directive
- To make compiler errors, use the `#error` compiler directive

## Unicode Hex Input ##
Hold down the Option (`⌥`) key and type in the 4 digit hex code for that
character
- Command: 0x2318 ⌘
- Control: 0x2303 ^
- Option:  0x2325 ⌥
- Shift:   0x21e7 ⇧
- Enter:   0x21a9 ↩

## Navigation ##
Show current file in Project Navigator
- `⌘-⇧-J` (Command-Option-J)

## Showing/Hiding Views ##
- Show/Hide Utilities (Inspectors) - `⌘-⌥-0` (Command-Option-0)
- Show/Hide Debug Area - `⌘-⇧-Y` (Command-Shift-Y)
- Show Standard Editor - `⌘-↩` (Command-Enter)
- Show Assistant Editor - `⌘-⌥-↩` (Command-Option-Enter)
- Show Version Editor - `⌘-⌥-⇧-↩` (Command-Option-Shift-Enter)

Show specific Navigator panes
- `⌘0` - Toggle Project Navigator
- `⌘1` - Project Navigator
- `⌘2` - Symbol Navigator
- `⌘3` - Search Navigator
- `⌘4` - Issue Navigator
- `⌘5` - Debug Navigator
- `⌘6` - Breakpoint Navigator
- `⌘7` - Log Navigator

## Editing Text ##
Switch between source and header file
- `Cmd-Ctrl-Up` (`⌘-⌃-↑`) and `Cmd-Ctrl-Down` (`⌘-⌃-↓`)
  - "Navigate->Jump to Next Counterpart" and "Navigate->Jump to Previous
    Counterpart"

## Debugging Programs ##
_Step Over_ - Execute the current line of code and (if it is a routine) return
to the next line in the current file
- Step Over - `F6`
- Step Over Thread - `⌃⇧F6`
- Step Over Instruction - `⇧F6`

_Step Into_ - Execute the current line of code and (if it is a routine) jump
to its first line
- Step Into - `F7`
- Step Into Thread - `⌃⇧F7`
- Step Into Instruction - `⇧F7`

_Step Out_ - Complete the current routine and step to the next routine or back
to the calling routine
- Step Out - `F8`

_Breakpoints and Console_
- Add Breakpoint at Current Line - `⌘-backslash`
- Toggle breakpoints - `⌘Y`
- Clear Console - `⌘K`

_Continuing code execution_ 
- `⌘-⌃-Y` (Command-Control-Y)
- After you reach a breakpoint in code, you can continue code execution to a
  given point by hovering over a line of code in the editor, and then clicking
  on the green button that appears there.

_Setting CoreLocation for debugging_ - You can set a location for
`CoreLocation` apps in the debug toolbar by clicking on the "location arrow"
in the toolbar.

_Current list of threads_ - You can see a current list of threads from the
debug toolbar by clicking on the name of the program or program icon in the
debug toolbar

_LLDB Debugger commands_ 
- `p` - print variable
- `po` - print object

vim: filetype=markdown shiftwidth=2 tabstop=2
