" use vim settings rather than vi
set nocompatible

" use pathogen
execute pathogen#infect()
filetype plugin indent on

" use solarized color scheme
syntax enable
set t_Co=256
set background=dark
colorscheme solarized

"  ### VIM-AIRLINE SETTINGS ###
"use 'vim-airline' all the time
set laststatus=2 
let g:airline_enable_branch=1

" set size
set textwidth=80

" expand tabs to spaces, default two
set expandtab
set tabstop=2
set shiftwidth=2

" don't generate swap files
set noswapfile

" push vim-generated files to a central location
" trailing double slash uses full path name to avoid collisions
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

" show line numbers
set number  

" show trailing whitespace as lil' dots
set list listchars=trail:·

" use bash-style tab-completion
set wildmode=longest,list

" show matching brackets
set showmatch

" autoindent
set autoindent 

" highlight search results
set hlsearch

" remove trailing whitespace in ruby files on save
autocmd BufWritePre *.rb :%s/\s\+$//e

" file extension syntax mapping
au BufNewFile,BufRead *.thor set filetype=ruby

" search for visually hightlighted text
vnoremap <c-f> y<ESC>/<c-r>"<CR>

" toggle paste mode with alt+p
set pastetoggle=<F10>

" custom commands
command -range Snakify <line1>,<line2>s #\(\<\u\l\+\|\l\+\)\(\u\)#\l\1_\l\2#g
