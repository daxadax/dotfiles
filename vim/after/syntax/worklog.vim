" define task and subtask
syntax region task start=/^\s*\zs-/ end=/$/ oneline
hi def link task Normal

syntax region subtask start=/^\s*\zs---/ end=/$/ oneline
hi def link subtask Comment

" define meetings
syntax region meeting start=/^\s*\zsm/ end=/$/ oneline
hi def link meeting Identifier

" define starred tasks
syntax region starred start=/^\s*\zs\*/ end=/$/ oneline
hi def link starred Todo

" define NEXT task
syntax region next_task start=/^\s*\zsNEXT/ end=/$/ oneline
hi NEXT ctermfg=57 ctermbg=NONE cterm=bold
hi! link next_task NEXT

" define other entries
syntax region investigation start=/^\s*\zsi/ end=/$/ oneline
hi def link investigation Statement

syntax keyword ticket t
hi def link ticket Statement

syntax keyword research r
hi def link research Statement

" define dates
" define this at the end so that "monday" gets highlighted as a date and not a meeting
syntax region date start=/monday\|tuesday\|wednesday\|thursday\|friday/ end=/$/ oneline
hi Date ctermfg=white ctermbg=NONE cterm=bold
hi! link date Date
