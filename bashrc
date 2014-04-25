#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

## export

export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export TERM="xterm-256color"

## Determine if the current git directory has uncommited changes

function __is_git_dirty {
  git diff --quiet HEAD > /dev/null 2>&1
  return $?
}

## Name screen tab whatever the current directory is

function __set_screen_title {
  if [ -n "$STY" ];
  then
    local title=$(basename $(pwd))

    __is_git_dirty
    if [ $? == 1 ];
    then
      title="$title!"
    fi

    screen -X title $title
  fi
}

## Determine the current git-branch if in a git directory

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\<\1\> /'
}

## Reload the prompt

function reload_prompt {
  __set_screen_title
}

## Export the prompt

# export PROMPT_COMMAND=$(reload_prompt)

PS1='\[\033[0;37m\][\[\e[0;37m\]\[\e[0;37m\]\[\e[0;37m\]\[\e[0;37m\]\w\[\e[0;37m\]]\[\e[0;37m\]\[\033[1;31m\]$(parse_git_branch)\[\033[1;31m\]\[\e[0;37m\]'
