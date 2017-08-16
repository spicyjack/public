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

## 'rustup' Usage ##
Install a toolchain

    rustup install [stable|beta|nightly]

Set the default installed toolchain to use (assuming you've previously
installed a toolchain)

    rustup default [stable|beta|nightly]

To show currently installed versions of Rust

    rustup show

To run a single command with a specific Rust toolchain

    rustup run <toolchain> <command>

Keeping Rust up to date

    rustup update

Keeping `rustup` up to date

    rustup self update

Installing `rustup`

    curl https://sh.rustup.rs -sSf | sh

This downloads and runs https://static.rust-lang.org/rustup/rustup-init.sh

Adding Bash shell completions

    rustup completions bash > ~/.bashrc.d/rustup.bash-completion

Note that there's currently also a `rustup` Bash completion script, which sets
up the path to `rustup`

vim: filetype=markdown shiftwidth=2 tabstop=2
