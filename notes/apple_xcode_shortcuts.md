# Xcode Keyboard/Gesture Shortcuts #

Works on: OS X 10.9.X (Lion) and Xcode 6.x.x

Handy debugging statements
- Log debugging command: `p (void)NSLog(@"%s %@", _cmd, foo)`
- Log a stack backtrace: `NSLog(@"%@", [NSThread callStackSymbols]);`
- Use macros to replace calls to _NSLog_

## Links ##
- Keyboard gestures and shortcuts - http://tinyurl.com/7tnxmgd
- Simulator User Guide - http://tinyurl.com/nbu97fa
- iPhone resolution
  - http://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
  - http://stackoverflow.com/questions/25969533
- Testing with Xcode (PDF) - http://tinyurl.com/nct32aq
- http://iosunittesting.com/xctest-assertions/
- http://www.1729.us/xcode/Xcode%20Shortcuts.png
- Finding Documentation Quickly - http://tinyurl.com/ce8mlww
- http://en.wikibooks.org/wiki/Unicode/Character_reference/2000-2FFF

## Helpful Objective-C Links ##
- Objective-C object literals: http://tinyurl.com/7v5wtf5
- Block syntax explained: http://fuckingblocksyntax.com/
- Objective-C types: http://tinyurl.com/7ddrdmb or http://tinyurl.com/nqw8klf

## Jump Bar Comments and compiler warnings ##
- If you add **FIXME:**/**TODO:**/**???:**/**!!!:** (keyword, then a colon)
  comments to code, Xcode will make jump bar targets for them
- To make compiler warnings, use the `#warning` compiler directive
- To make compiler errors, use the `#error` compiler directive

## Unicode Hex Input ##
Hold down the Option (`⌥ `) key and type in the 4 digit hex code for that
character
- Command: 0x2318 `⌘ `
- Control: 0x2303 `^`
- Option:  0x2325 `⌥ `
- Shift:   0x21e7 `⇧ `
- Enter:   0x21a9 `↩ `
- Left arrow: 0x21e6 `⇦ `
- Up arrow: 0x21e7 `⇧ `
- Right arrow: 0x21e8 `⇨ `
- Down arrow: 0x21e9 `⇩ `

## Navigation ##
Show current file in Project Navigator
- `⌘ - ⇧ - J` (Command-Option-J)

Show quick help for a method/object
- `⌥ - <mouse click>` (Option-<mouse click> on item to get quick help on)

Show method/property defnition in the approproate header file
- `⌘ - <mouse click>` (Command-<mouse click> on the method/property to view in
  it's corresponding header file)
- Use the `<` and `>` arrows at the top of the editor window to navigate back
  to the source code that you were editing previously

Move the cursor to the beginning of a block of text (not the beginning of a
line)
- `⌘ - ←`

Move the cursor to the end of a block of text (probably the end of a line)
- `⌘ - →`

## Showing/Hiding Views ##
- Show/Hide Utilities (Inspectors) - `⌘ - ⌥ - 0` (Command-Option-0)
- Show/Hide Debug Area - `⌘ - ⇧ - Y` (Command-Shift-Y)
- Show Standard Editor - `⌘ - ↩` (Command-Enter)
- Show Assistant Editor - `⌘ - ⌥ - ↩` (Command-Option-Enter)
- Show Version Editor - `⌘ - ⌥ - ⇧ - ↩` (Command-Option-Shift-Enter)

Show specific Navigator panes
- `⌘ 0` - Toggle (show/hide) Project Navigator
- `⌘ 1` - Project Navigator
- `⌘ 2` - Symbol Navigator
- `⌘ 3` - Search Navigator
- `⌘ 4` - Issue Navigator
- `⌘ 5` - Debug Navigator
- `⌘ 6` - Breakpoint Navigator
- `⌘ 7` - Log Navigator

Expanding/collapsing folders in Project Navigator
- `⇨ ` (Right arrow) - Expand highlighted folder
- `⌥ - ⇨ ` (Option-Right arrow) - Expand all folders underneath highlighted
  folder
- `⇦ ` (Left arrow) - Collapse highlighted folder
- `⌥  - ⇦ ` (Option-Left arrow) - Collapse all folders underneath highlighted
  folder

## Editing Text ##
Toggle between source and header file
- `⌘ - ⌃ - ⇧ ` (Cmd-Ctrl-Up) and `⌘ - ⌃ - ⇩ `(Cmd-Ctrl-Down)
  - "Navigate -> Jump to Next Counterpart" and "Navigate -> Jump to Previous
    Counterpart"

## Code Folding ##
Fold current method
- `⌘ - ⌥  - ⇦ ` (Cmd-Option-Left arrow)

Unfold current method
- `⌘ - ⌥  - ⇨ ` (Cmd-Option-Right arrow)

Fold (all) methods and functions
- `⇧ - ⌘ - ⌥  - ⇦ ` (Shift-Cmd-Option-Left arrow)

Unfold (all) methods and functions
- `⇧ - ⌘ - ⌥  - ⇨ ` (Shift-Cmd-Option-Right arrow)

Fold comment blocks
- `⇧ - ⌘ - ⌃  - ⇦ ` (Shift-Cmd-Ctrl-Left arrow)

Unfold comment blocks
- `⇧ - ⌘ - ⌃  - ⇨ ` (Shift-Cmd-Ctrl-Right arrow)

## Debugging Programs ##
_Continuing code execution_
- `⌘ - ⌃ - Y` (Command-Control-Y)
- After you reach a breakpoint in code, you can continue code execution to a
  given point by hovering over a line of code in the editor, and then clicking
  on the green button that appears there.

_Step Over_ - Execute the current line of code and (if it is a routine) return
to the next line in the current file
- Step Over - `F6`
- Step Over Thread - `⌃ ⇧ F6`
- Step Over Instruction - `⇧ F6`

_Step Into_ - Execute the current line of code and (if it is a routine) jump
to its first line
- Step Into - `F7`
- Step Into Thread - `⌃ ⇧ F7`
- Step Into Instruction - `⇧ F7`

_Step Out_ - Complete the current routine and step to the next routine or back
to the calling routine
- Step Out - `F8`

_Breakpoints and Console_
- Add Breakpoint at Current Line - `⌘-backslash`
- Toggle breakpoints - `⌘ Y`
- Clear Console - `⌘ K`

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
