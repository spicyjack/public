# Dancer2 Web Framework Notes #

## Basic Operations ##

Create the _Dancer2_ web app

    dancer2 --application HelloWorld

Start a _Dancer2_ app

    plackup -p 3000 bin/app.psgi

Fatpacking a _Dancer2_ app

    fatpack pack bin/app.psgi > app.packed.psgi

Starting a fatpacked _Dancer2_ app

    plackup -p 3000 app.packed.psgi

vim: filetype=markdown shiftwidth=2 tabstop=2
