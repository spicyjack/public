" POD updates for PseudoPod
" save as: ~/.vim/after/syntax/pod.vim

syn match podCommand "^=author"      nextgroup=podCmdText contains=@NoSpell
syn match podCommand "^=head[01234]" nextgroup=podCmdText contains=@NoSpell

" Table stuff...
syn match podCommand "^=headrow"  nextgroup=podCmdText contains=@NoSpell
syn match podCommand "^=bodyrows" nextgroup=podCmdText contains=@NoSpell
syn match podCommand "^=row"      nextgroup=podCmdText contains=@NoSpell
syn match podCommand "^=cell"     nextgroup=podCmdText contains=@NoSpell

" Special formatting sequences (don't replace the formats that already exist
" in POD)
syn region podFormat start="[AFGHMNQRSTUXZ]<[^<]"me=e-1 end=">" contains=podFormat,@NoSpell
syn region podFormat start="[AFGHMNQRSTUXZ]<<\s" end="\s>>" contains=podFormat,@NoSpell
