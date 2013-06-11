" from ovid's blog post: http://tinyurl.com/qxrvvyc
" modified 23May2013 by Brian Manning <brian at xaoc dot org>
" - 03Jun2013 - added detection of 'package main;'

" To use, save this file as:
" ~/.vim/ftplugin/perl.vim
"
" Then add this to your ~/.vimrc somewhere:
" autocmd BufReadPost * if &syntax == 'perl' | source ~/.vim/ftplugin/perl.vim

" This is different from Ovid's example, in that it *prepends* the current
" method name in front of the other statusline values
setlocal statusline^=%(\ %{StatusLineIndexLine()}%)

if has( 'perl' )
perl << EOP
    use strict;
    sub current_sub {
        my $curwin = $main::curwin;
        my $curbuf = $main::curbuf;

        my @document = map { $curbuf->Get($_) } 0 .. $curbuf->Count;
        my ( $line_number, $column  ) = $curwin->Cursor;

        my $sub_name = 'N/A';
        for my $i ( reverse ( 1 .. $line_number  -1 ) ) {
            my $line = $document[$i];
            my $sub_qr = qr/^\s*sub\s+(\w+)\b/;
            my $package_qr = qr/^package (main)/;
            my $method_qr = qr/^\s*method\s+(\w+)\s+\{/;
            if ( $line =~ /$sub_qr|$package_qr|$method_qr/ ) {
                if ( $1 ) {
                    $sub_name = $1;
                } elsif ( $2 ) {
                    $sub_name = $2;
                } elsif ( $3 ) {
                    $sub_name = $3;
                }
                last;
            }
        }
        VIM::DoCommand "let subName='($sub_name)'";
    }
EOP

function! StatusLineIndexLine()
  perl current_sub()
  return subName
endfunction
endif
