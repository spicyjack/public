## Rust Programming Language Notes ##

Rust programs have a file extension of `*.rs`.  You can compile programs with
the `rustc` program.

## Cargo ##
Cargo helps manage dependencies and compiling Rust programs.

You can get help with:

    cargo --help

Create a new project to build a binary file:

    cargo new --vcs git --bin <project name>

Create a new project to build a library file:

    cargo new --vcs git <project name>

Compile and run a binary file via Cargo:

    cargo run

Add a dependency to the current project:

    cargo add <dependency name>

vim: filetype=markdown shiftwidth=2 tabstop=2
