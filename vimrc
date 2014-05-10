set expandtab
set tabstop=2
set number

autocmd BufWritePre *.rb :%s/\s\+$//e
syntax enable

let g:solarized_termcolors=256

"          mappings          "

inoremap 225 <c-n> mapmode-i

"         shortcuts          "

cnoremap sudow w !sudo tee % >/dev/null
