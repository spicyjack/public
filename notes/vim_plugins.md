# VIM Syntax/Utility Plugins #

## Installing Utility Plugins ##

After installing code plugins with help files (which usually get placed in
`$HOME/.vim/doc`, in an open `vim` session, rebuild the `helptags` file with:

    :helptags ~/.vim/doc

## Compiling VIM ##
Requires: `libperl-dev`, `gcc`, `libncursesw5-dev`

    ./configure --prefix=/usr/local/stow/vim-X.X \
    --disable-darwin --disable-selinux --enable-perlinterp \
    --enable-cscope --enable-multibyte --enable-gui=no \
    --disable-gpm --disable-sysmouse --disable-gtktest
    time make
    time make test
    make install
    cd /usr/local/stow
    stow -v vim-X.X

## Syntax Plugins ##
- markdown - http://www.vim.org/scripts/script.php?script_id=2882
- ciscoasa - http://www.vim.org/scripts/script.php?script_id=3055
- haproxy - http://www.vim.org/scripts/script.php?script_id=1845
- html5 - http://www.vim.org/scripts/script.php?script_id=3232
- JSON - https://github.com/elzr/vim-json
- OpenGL Shading - http://www.vim.org/scripts/script.php?script_id=1002
- jquery - http://www.vim.org/scripts/script.php?script_id=2416
- Cocoa/Objective-C - https://github.com/msanders/cocoa.vim
- Git - https://github.com/tpope/vim-git

## Other Syntax Plugins ##
- googlecodewiki - http://www.vim.org/scripts/script.php?script_id=3173
- nsh - http://www.vim.org/scripts/script.php?script_id=2864
- Redcode  (Core War)
  - http://www.vim.org/scripts/script.php?script_id=1705
  - http://www.vim.org/scripts/script.php?script_id=1017
- Nagios - http://www.vim.org/scripts/script.php?script_id=2261
- javascript
  - http://www.vim.org/scripts/script.php?script_id=1491
  - http://www.vim.org/scripts/script.php?script_id=2083
  - * http://www.vim.org/scripts/script.php?script_id=3425

## Utility Plugins ##
- BufExplorer - http://www.vim.org/scripts/script.php?script_id=42
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

## Other Utility Plugins ##
- Project - http://www.vim.org/scripts/script.php?script_id=69
  - Creates a "Project", helping organize a set of files/directories
- eqalignsimple - http://tinyurl.com/l8d8ay3 (From Damian Conway)

vim: filetype=markdown tabstop=2
