# File Encodings #

Use `enca` to guess the encoding of a file
- Call `enca` with a language "hint"
  - `enca -­language=<language "hint"> file.txt`

List all language encodings that `enca` knows about:
- `enca --list languages`

Convert a file to your native encoding using `enconv`
- `enconv --language=russian file.txt`
  - Not sure this works...

Convert a file using `iconv`
- `iconv --from-code WINDOWS-1251 --to-code UTF-8 --output test.txt file.txt`

List all encodings that `iconv` knows about
- `iconv --list`

vim: filetype=markdown shiftwidth=2 tabstop=2
