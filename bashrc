#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias biggest_files



## prompt
PS1='[\u@\h \W]\$ '

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
