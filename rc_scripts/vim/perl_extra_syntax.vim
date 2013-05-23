" save as: ~/.vim/after/syntax/perl.vim

syn match   perlStatementInclude   "\<\(use\|no\)\s\+\(\(integer\|strict\|lib\|sigtrap\|subs\|vars\|warnings\|utf8\|byte\|base\|fields\|constant\|version\)\>\)\="

" Subroutines from Carp.
syn keyword perlStatementIOfunc   carp cluck croak confess shortmess longmess

" Subroutines from Perl6::*.
syn keyword perlStatementIOfunc   say slurp

" Subroutines from List::Util.
syn keyword perlStatementList     first max maxstr min minstr reduce shuffle
            \                     sum

" Subroutines from List::MoreUtils.
syn keyword perlStatementList     any all none notall true false firstidx
            \                     first_index lastidx last_index insert_after
            \                     insert_after_string apply after after_incl
            \                     before before_incl indexes firstval
            \                     first_value lastval last_value each_array
            \                     each_arrayref pairwise natatime mesh zip
            \                     uniq minmax

" Subroutines from Test::More.
syn keyword perlStatementTest     use_ok require_ok ok is isnt diag like unlike
            \                     cmp_ok is_deeply skip can_ok isa_ok pass fail
            \                     plan done_testing explain note

" Subroutines from Test::Exception.
syn keyword perlStatementTest     dies_ok lives_ok throws_ok lives_and

if exists("perl_fold") && exists("perl_fold_blocks")
    syn match perlConditional "\<try\>"
    syn match perlConditional "\<catch\>"
    syn match perlConditional "\<with\>"
    syn match perlConditional "\<except\>"
    syn match perlConditional "\<otherwise\>"
    syn match perlConditional "\<finally\>"
else
    syn keyword perlConditional try catch with except otherwise finally
endif

" Add qw<> support...
syn region perlQQ matchgroup=perlStringStartEnd start=+\<qw<+ end=+>+ contains=@perlInterpSQ

" Add qv() support...
syn region perlQQ matchgroup=perlStringStartEnd start=+\<q[qxv]#+ end=+#+ contains=@perlInterpDQ
syn region perlQQ matchgroup=perlStringStartEnd start=+\<q[qxv]|+ end=+|+ contains=@perlInterpDQ
syn region perlQQ matchgroup=perlStringStartEnd start=+\<q[qxv](+ end=+)+ contains=@perlInterpDQ,perlBrackets
syn region perlQQ matchgroup=perlStringStartEnd start=+\<q[qxv]{+ end=+}+ contains=@perlInterpDQ
syn region perlQQ matchgroup=perlStringStartEnd start=+\<q[qxv]/+ end=+/+ contains=@perlInterpDQ

" For POD, since local pod.vim isn't read when included in perl.vim...
syn match podCommand "^=head[34]" nextgroup=podCmdText

syn keyword perlTodo TODO: contained

hi def link perlStatementTest perlStatement
