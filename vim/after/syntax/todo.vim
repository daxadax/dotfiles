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

" define immediate priority tasks
syntax region priority start=/^\s*\zs\!/ end=/$/ oneline
hi Priority ctermfg=202 cterm=bold
hi! link priority Priority

" define research (is this needed?)
syntax keyword research r
hi def link research Statement

" define headers
syntax region goalHeader start=/^\s*\zs\#/ end=/$/
hi GoalHeader ctermfg=DarkCyan cterm=bold
hi! link goalHeader GoalHeader

syntax region todoHeader start=/^\s*\zs\##/ end=/$/ oneline
hi TodoHeader ctermfg=DarkYellow cterm=underline
hi! link todoHeader TodoHeader


" define goal groups
syntax region todoGroup start=/^\s*\zs+ / end=/$/ oneline
hi TodoGroup cterm=bold
hi! link todoGroup TodoGroup

" define completed goal
syntax region todoCompleted start=/^\s*\zsx / end=/$/ oneline
hi TodoCompleted ctermfg=DarkGrey
hi! link todoCompleted TodoCompleted

" define season
syntax region season start=/SEASON/ end=/$/ oneline
hi Season ctermfg=White cterm=bold,underline
hi! link season Season

" syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
"highlight link potionString String

" define dates
" define this at the end so that "monday" gets highlighted as a date and not a meeting
syntax region date start=/monday\|tuesday\|wednesday\|thursday\|friday\|saturday\|sunday/ end=/$/ oneline
hi Date ctermfg=white ctermbg=NONE cterm=bold
hi! link date Date
