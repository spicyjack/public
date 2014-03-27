# VIM Shortcuts #

## Built-in VIM Commands ##
- `^x^s` or `^x-s` - Locate word in front of the cursor and find the first
  `spell` suggestion for it (`compl-spelling`)
- `^n` - Find the next suggestion
- `^p` - Find the previous suggestion
- `^n` - Find the next match for words that start with the keyword in front of
  the cursor (`keywords`, `compl-keyword`)
- `:map` - Show current keymappings
- `,ha` - Print `hardcopy` of the current file to _~/(filename).ps_
- `^v` + cursor movement; select characters in a vertical column
  - Use `:s/^/<foo>/` to perform substitution on the first column of the
    selected lines

### Using Registers ###
You use registers in `VIM` to hold text for cutting/copying.

- To copy a line to register "a": `"aY`
- To cut a line to register "a": `"add`

### Moving around using tags ###
Help files and source code indexed with the `ctags` command have the concept
of `tags`, or markers in files that `VIM` can use to jump around.  When you
are in source files, or inside of help files, you can use the tag navigation
commands below to move around.

- `^]` or `Ctrl-]`
  - When the cursor is on `|text|` in a help file, `VIM` will jump to the help
    section for `text`
  - On a function name in source code, will jump to the definition of that
    function in the source code
- `^t`, `Ctrl-t`, `^o`, or `Ctrl-o` will go back through your tag "history"
- `:tags` will show you  your "tag history"

## Changing the "Leader" ##
The `mapleader` is the key that is pressed prior to entering in custom
commands.  You can change the `mapleader` from it's default of "\" to
something else using this command in your `$HOME/.vimrc`:

    let mapleader = ","

## My Custom Commands ##
Given the above change to `mapleader`, all custom commands are now prefixed
with commas (`,`) instead of backslashes ("\").

Added to my `~/.vimrc`
- `,pc` - `perl -c %p`
  - `noremap <script> <silent> <unique> <Leader>pc :! perl -c %:p<CR>`
- `,sy` - Syntax check
  - Uses
    https://github.com/spicyjack/public/blob/master/rc_scripts/vim/current_perl_sub.vim
  - `noremap <script> <silent> <unique> <Leader>sy :call SyntaxCheck()<CR>`
  - If you get warnings about missing functions after installing the above
    script, your `VIM` doesn't have Perl compiled into it
    - Check with `vim --version`, there should be a `+perl` in the output
- `,pd` - Run Perldoc on the current file
  - `noremap <script> <silent> <unique> <Leader>pd :! perldoc %<CR>`

# Utility Plugins #


## BufExplorer ##
http://www.vim.org/scripts/script.php?script_id=42
- `,be` - switch between files in buffers, full screen
- `,bs` - switch between files, horizontal split
- `,bv` - switch between files, vertical split
- `^^` (`Ctrl-^`) - switch between the two most recently used buffers

## Taglist ##
http://www.vim.org/scripts/script.php?script_id=273
- `,tt` - Taglist; toggle `taglist` window
- `,to` - Taglist; open `taglist` window
- `,tc` - Taglist; close `taglist` window

## TaskList ##
http://www.vim.org/scripts/script.php?script_id=2607
- `,tl` - TaskList; show all `FIXME`/`XXX`/`TODO` comments found in current
  file
- Movement commands once TaskList is open:
  - `q` - Quit TaskList and restore original cursor position
  - `e` - Exit TaskList and keep results window open (but won't be updated)
  - `<CR>` - Exit TaskList and place cursor at selected line

## Align ##
http://www.vim.org/scripts/script.php?script_id=294

Use ranges for `Align` shortcuts; `'a,.` (from mark `a` to current line)
- `,t=` - align on equals sign
- `,t,` - align on comma
- `,t|` - align on pipes
- `,tsp` - align on whitespace

# Troubleshooting #
Troubleshoot plugins:
- Use the `:scriptnames` command

Troubleshoot commands/settings:
- Use the `:verbose <command>` option
  - `:verbose autocmd BufEnter`
- Use the command name by itself
  - `:autocmd`

vim: filetype=markdown shiftwidth=2 tabstop=2
