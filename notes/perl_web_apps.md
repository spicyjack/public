# Perl Web App Framework Notes #

## Dancer2 ##
Create the web app

    dancer2 --application HelloWorld

## Mojolicious ##

Create a _Mojolicious::Lite_ app

    mojo generate lite_app

Create a full _Mojolicious_ app

    mojo generate app <HelloWorld>

Start a Dancer2 app

    plackup -p 3000 bin/app.psgi

Start a Mojolicious app using the `morbo` development web server, which will
reload the web app automagically when you make changes to it

    morbo ./myapp.pl

vim: filetype=markdown shiftwidth=2 tabstop=2
