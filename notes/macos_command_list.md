## OS X Interesting Command List ##

OS X Keyboard shortcuts (See also `apple_xcode_shortcuts.md`)
- Look up a highlighted word: ⌘ - ⌃ - D (Cmd-Ctrl-D)
  - You can also click with three fingers on the word to look it up

From Homebrew:
- pstree (no man page) ₋ Shows process table as a "tree"
- tree(1) - Shows files/directories as a "tree"
- enca(1) - Detect and convert the encoding of files

From Apple:
- bless(8) - Set volume bootability and startup disk options
- CpMac(1) - DEPRECATED - Copy files, preserving resource forks
- dirs (bash) - `dirs` shows the contents of the directory stack
- diskutil(8) - Modify, verify and repair local disks
- ditto(1) - Copy directory hierarchies, create and extract archives
- dscl(1) - Directory Service command line utility
  - See also `public.git/notes/os_x_directory_services.md`
- fmt(1) - Simple text formatter
- GetFileInfo(1) - DEPRECATED - Get attributes of files and directories
- groups(1) - Show group memberships (use 'id -p')
- hdiutil(1) - Manipulate disk images (attach, verify, create, etc)
- ifconfig(8) - Configure network interface parameters
- installer(8) - System software and package installer tool
- ipfw - Replaced with pfctl in OS X 10.8;
  https://support.apple.com/en-us/HT202554
- locate(1) - Find filenames quickly
  - Has instructions on enabling the `locate` service
- MvMac(1) - DEPRECATED - Move files while preserving metadata and forks
- nidump(8) - DEPRECATED - Extract text or flat-file-format data from NetInfo
- niload(8) - DEPRECATED - Load text or flat-file-format data into NetInfo
- osalang(1) - Information about installed OSA languages
- osascript(1) - Execute OSA scripts (AppleScript, JavaScript)
- periodic(8) - Run periodic system functions
- pfctl(8) - control the packet filter (PF) and network address translation
  (NAT) device
- popd(bash) `popd` pops a directory off of the directory stack and changes
  `$PWD` to that directory
- pushd (bash) - `pushd <dir>` pushes `$PWD` onto the directory stack, then
  changes directory to `<dir>`
- softwareupdate(8) - System software update tool
- stroke - Port scanner
  - /System/Library/CoreServices/Applications/Network Utility.app/Contents/Resources/stroke
- system_profiler(8) - Reports system hardware and software configuration
- whatis(1) - whatis  searches  a set of database files containing short
  descriptions of system commands for keywords and displays the result on the
  standard output.

vim: filetype=markdown shiftwidth=2 tabstop=2
