## VIM Shortcuts ##

- `\pc` - `perl -c %p`
- `\sy` - Syntax check
- `\pd` - Run Perldoc on the current file
- `^x^s` or `^x-s` - Locate word in front of the cursor and find the first
  `spell` suggestion for it (`compl-spelling`)
- `^n` - Find the next suggestion
- `^p` - Find the previous suggestion
- `^n` - Find the next match for words that start with the keyword in front of
  the cursor (`keywords`, `compl-keyword`)
- `\be` - BufExplorer, lets you quickly switch between files in buffers
- `\tt` - Taglist; toggle `taglist` window
- `\to` - Taglist; open `taglist` window
- `\tc` - Taglist; close `taglist` window

Use ranges for `Align` shortcuts; `'a,.` (from mark `a` to current line)
- `\t=` - align on equals sign
- `\t,` - align on comma
- `\t|` - align on pipes
- `\tsp` - align on whitespace


vim: filetype=markdown shiftwidth=2 tabstop=2
