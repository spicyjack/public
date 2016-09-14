## Rust Programming Language Notes ##

Rust programs have a file extension of `*.rs`.  You can compile programs with
the `rustc` program.

## Links ##
- Common macros - https://doc.rust-lang.org/book/macros.html
- `cargo-modules` - https://github.com/regexident/cargo-modules
  - Shows cargo module dependencies in a "tree" structure
  - Install with: `cargo install cargo-modules`

## Cargo ##
Cargo helps manage dependencies and compiling Rust programs.

You can get help with:

    cargo --help

Create a new project to build a binary file:

    cargo new --vcs git --bin <project name>

Create a new project to build a library:

    cargo new --vcs git <project name>

Compile a binary file via Cargo:

    cargo build

Compile and run a binary file via Cargo:

    cargo run

Add a dependency to the current project:

    cargo add <dependency name>

List all installed packages, and their versions:

    cargo install --list

## 'rustc' Compiler Usage ##
To see the results of expanding macros:

    rustc --pretty expanded

vim: filetype=markdown shiftwidth=2 tabstop=2
