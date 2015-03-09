" '*.html.ep' "embedded Perl" template files used with Mojolicious
" https://metacpan.org/pod/Mojolicious::Guides::Rendering
autocmd BufNewFile,BufRead *.html.ep 
    \ set filetype=html shiftwidth=2 tabstop=2
