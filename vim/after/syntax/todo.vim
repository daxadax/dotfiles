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

" define other entries
syntax region goalOpen start=/^\s*\zso / end=/$/ oneline
hi GoalOpen cterm=bold
hi! link goalOpen GoalOpen

syntax region goalCompleted start=/^\s*\zsx / end=/$/ oneline
hi GoalCompleted ctermfg=DarkGrey
hi! link goalCompleted GoalCompleted

syntax keyword research r
hi def link research Statement

" define season
syntax region season start=/SEASON/ end=/$/ oneline
hi Season ctermfg=White cterm=bold,underline
hi! link season Season

syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link potionString String

" define dates
" define this at the end so that "monday" gets highlighted as a date and not a meeting
syntax region date start=/monday\|tuesday\|wednesday\|thursday\|friday/ end=/$/ oneline
hi Date ctermfg=white ctermbg=NONE cterm=bold
hi! link date Date
