syntax enable

" use vim settings rather than vi
set nocompatible

" use solarized color scheme
syntax enable
set t_Co=256
set background=dark
colorscheme solarized

" set size
set textwidth=80

" expand tabs to spaces, default two
set expandtab
set tabstop=2
set shiftwidth=2

" push all vim-generated files to a central location
" trailing double slash uses full path name to avoid collisions
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" show line numbers
set number  

" enable fuzzy search plugin
set runtimepath^=~/.vim/plugins/ctrlp.vim

" show matching brackets
set showmatch

" autoindent
set autoindent 

" highlight search results
set hlsearch

" remove trailing whitespace in ruby files on save
autocmd BufWritePre *.rb :%s/\s\+$//e
