set spell spelllang=en_gb

" Yellow fields
syntax match Statement /^\(Project\|Opened\|UUID\|Description\):/
syntax match Statement /\(Priority\|Closed\):/

" Highlight fields needing editing
syntax match Todo /\<TODO\>/

" Disable spelling on UUID
syntax match NoSpell /\(\x\+-\)\{4}\x\+/ contains=@NoSpell
