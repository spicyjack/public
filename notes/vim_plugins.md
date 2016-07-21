# VIM Syntax/Utility Plugins #

## Installing Utility Plugins ##

After installing code plugins with help files (which usually get placed in
`$HOME/.vim/doc`, in an open `vim` session, rebuild the `helptags` file with:

    :helptags ~/.vim/doc

## Pathogen ##
- https://github.com/tpope/vim-pathogen

Automates setup of VIM plugins cloned into `~/.vim/bundle`

To install Pathogen:
  - `mkdir -p ~/.vim/autoload ~/.vim/bundle`
  - `curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim`
- To install new VIM plugins, clone the Git repo into `~/.vim/bundle`, witout
  the `*.git` extension
  - See the file `public.git/notes/git.md` for an example of using `git
    submodule` to clone and keep VIM plugin Git repos up to date
- Pathogen will automatically set up links from the files in the
`~/.vim/bundle` directory to the correct VIM directories

To set up the Git submodule with all of the configured Pathogen plugins
- `cd ~/.vim/bundle`
- `git clone https://example.com/vim_bundle_submodule.git .`
- `git submodule init`
- `git submodule update --remote`
- Make sure you copy the `public.git/rc_files/ctags` file to `~/.ctags` to
  enable new tag maps in exuberant-ctags

To add a new submodule
- `cd ~/.vim/bundle`
- `git submodule add https://example.com/repo.git`
- `git commmit`

Updating all submodules
- `cd ~/.vim/bundle`
- `git submodule update`

## Syntax Plugins ##
- markdown
  - http://www.vim.org/scripts/script.php?script_id=2882
  - https://github.com/hallison/vim-markdown
- ciscoasa
  - http://www.vim.org/scripts/script.php?script_id=3055
  - https://github.com/vim-scripts/ciscoasa.vim
  - "Quasi-official" mirror
- haproxy
  - http://www.vim.org/scripts/script.php?script_id=1845
- html5
  - http://www.vim.org/scripts/script.php?script_id=3232
  - http://github.com/othree/html5-syntax.vim
- JSON
  - http://www.vim.org/scripts/script.php?script_id=1945
  - https://github.com/elzr/vim-json
- OpenGL Shading
  - http://www.vim.org/scripts/script.php?script_id=1002
  - https://github.com/vim-scripts/glsl.vim
- jquery
  - http://www.vim.org/scripts/script.php?script_id=2416
  - https://github.com/vim-scripts/jQuery
- Cocoa/Objective-C
  - http://www.vim.org/scripts/script.php?script_id=2674
  - https://github.com/msanders/cocoa.vim
- Git
  - http://www.vim.org/scripts/script.php?script_id=1654
  - https://github.com/tpope/vim-git
- TOML markup language (https://github.com/toml-lang/toml) 
  - https://github.com/cespare/vim-toml
- Mojolicious templates
  - http://www.vim.org/scripts/script.php?script_id=3168
  - https://github.com/yko/mojo.vim
- Javascript
  - http://www.vim.org/scripts/script.php?script_id=3425
    - Fork of http://www.vim.org/scripts/script.php?script_id=1491
  - https://github.com/jelera/vim-javascript-syntax
- Perl
  - https://github.com/vim-perl/vim-perl

## Manually installed plugins ##
- Extra Perl bits
  - These have been captured in https://github.com/spicyjack/plugins.vim
  - `public.git/rc_scripts/vim/ftplugin/current_perl_sub.vim` ->
    `~/.vim/ftplugin/perl.vim`
  - `public.git/rc_scripts/vim/syntax/perl_extra_syntax.vim` ->
    `~/.vim/after/syntax/perl.vim`
  - `public.git/rc_scripts/vim/syntax/pod_extra_syntax.vim` ->
    `~/.vim/after/syntax/pod.vim`
- Variable highlighting
  - https://github.com/mannih/vim-perl-variable-highlighter
  - https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/plugin/trackperlvars.vim
  - http://blogs.perl.org/users/ovid/2014/05/automatic-variable-highlighting-in-vim.html
    - https://github.com/pjcj/vim-hl-var
    - Install both scripts, `vawa.vim` and `hl-var.vim` to `~/.vim/plugin`
- INI-syntax highlighting
  - May already be up to date, it's part of VIM now
  - https://github.com/xuhdev/syntax-dosini.vim
  - http://www.vim.org/scripts/script.php?script_id=3747

## Older (Unused) Syntax Plugins ##
- nsh - http://www.vim.org/scripts/script.php?script_id=2864
- Redcode  (Core War)
  - http://www.vim.org/scripts/script.php?script_id=1705
  - http://www.vim.org/scripts/script.php?script_id=1017
- Nagios - http://www.vim.org/scripts/script.php?script_id=2261
- javascript
  - http://www.vim.org/scripts/script.php?script_id=1491
  - http://www.vim.org/scripts/script.php?script_id=2083

## Utility Plugins ##
- BufExplorer
  - http://www.vim.org/scripts/script.php?script_id=42
  - https://github.com/vim-scripts/bufexplorer.zip
- Align
  - http://www.vim.org/scripts/script.php?script_id=294
  - https://github.com/vim-scripts/Align
- taglist
  - http://www.vim.org/scripts/script.php?script_id=273
  - https://github.com/vim-scripts/taglist.vim
  - Jump around to different tags created with ctags
  - If you use the `tt` shortcut, be aware that `Align` (above) also uses the
    same shortcut
    - The `tt` shortcut for `Align` is defined in
      `~/.vim/plugin/AlignMapsPlugin.vim`, line 172
    - The `no_tt_map` branch in `Align` will comment out the mapping
- tasklist
  - http://www.vim.org/scripts/script.php?script_id=2607
  - https://github.com/vim-scripts/TaskList.vim
  - Search for `FIXME`, `XXX`, or `TODO` in code, and make a list that shows
    you the contents of those comments and where they're located in the file

## Other Utility Plugins ##
- Project - http://www.vim.org/scripts/script.php?script_id=69
  - Creates a "Project", helping organize a set of files/directories
- eqalignsimple - http://tinyurl.com/l8d8ay3 (From Damian Conway)

## Compiling VIM on Linux ##
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

vim: filetype=markdown shiftwidth=2 tabstop=2
