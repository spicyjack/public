# VIM Syntax/Utility Plugins #

## Installing Utility Plugins ##

After installing code plugins with help files (which usually get placed in
`$HOME/.vim/doc`, in an open `vim` session, rebuild the `helptags` file with:

    :helptags ~/.vim/doc

## Syntax Plugins ##
- googlecodewiki - http://www.vim.org/scripts/script.php?script_id=3173
- markdown - http://www.vim.org/scripts/script.php?script_id=2882
- ciscoasa - http://www.vim.org/scripts/script.php?script_id=3055
- haproxy - http://www.vim.org/scripts/script.php?script_id=1845
- html5 - http://www.vim.org/scripts/script.php?script_id=3232
- nsh - http://www.vim.org/scripts/script.php?script_id=2864
- redcode - http://www.vim.org/scripts/script.php?script_id=1705
- redcode - http://www.vim.org/scripts/script.php?script_id=1017
- nagios - http://www.vim.org/scripts/script.php?script_id=2261
- json - http://www.vim.org/scripts/script.php?script_id=1945
  - can also use javascript syntax highlight file;
    http://www.codeography.com/2010/07/13/json-syntax-highlighting-in-vim.html
- javascript
  - http://www.vim.org/scripts/script.php?script_id=1491
  - http://www.vim.org/scripts/script.php?script_id=2083
  - * http://www.vim.org/scripts/script.php?script_id=3425
- jquery - http://www.vim.org/scripts/script.php?script_id=2416
- Cocoa/Objective-C - https://github.com/msanders/cocoa.vim
- OpenGL Shading - http://www.vim.org/scripts/script.php?script_id=1002

## Utility Plugins ##
- BufExplorer - http://www.vim.org/scripts/script.php?script_id=42
- Project - http://www.vim.org/scripts/script.php?script_id=69
  - Creates a "Project", helping organize a set of files/directories
- Align - http://www.vim.org/scripts/script.php?script_id=294
- taglist - http://www.vim.org/scripts/script.php?script_id=273
  - Jump around to different tags created with ctags
  - If you use the `tt` shortcut, be aware that `Align` (above) also uses the
    same shortcut
    - The `tt` shortcut for `Align` is defined in
      `~/.vim/plugin/AlignMapsPlugin.vim`, line 172
- tasklist - http://www.vim.org/scripts/script.php?script_id=2607
  - Search for `FIXME`, `XXX`, or `TODO` in code, and make a list that shows
    you the contents of those comments and where they're located in the file
- eqalignsimple - http://tinyurl.com/l8d8ay3 (From Damian Conway)

# vim: filetype=markdown tabstop=2
