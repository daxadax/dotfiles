# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## system aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias xev="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias keymap="xmodmap -pke"
alias unmount_all="udiskie-umount -a"

function sublime {
  i3-msg workspace $(($(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1) + 1))
  /usr/bin/sublime_text_3/sublime_text $1
}

## connection aliases
alias connect_to_mysql='sudo systemctl start mysqld.service'
alias connect_to_neo="ssh -D 1337 -vN dd@office.neopoly.de"
alias connect_to_quotes='cd ~/programming/quotes/ && sublime . && cd quotes_app && shotgun -p 2300 config.ru'
alias connect_to_tarot='cd ~/programming/tarot/tarot_app/ && sublime . && shotgun -p 2301 config.ru'

### git aliases
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gba='git branch -a'
alias gd='git diff'
alias stash='git stash'
alias pop='git stash pop'
alias gl='git pull'
alias gp='git push'

### shortcuts
alias r='bundle exec ruby -Ilib:spec:test'
alias block='echo befc523d-8815-4245-be01-81ecd2a8bd99'
alias screen='screen && /bin/bash --login'
alias pidgin='pidgin &'

## export
export EDITOR=vim

# Determine if the current git directory has uncommited changes

function git_is_dirty {
  git diff --quiet HEAD > /dev/null 2>&1
  return $?
}

## Determine the current git-branch if in a git directory

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\<\1\> /'
}

# Name screen tabs whatever the current directory is

function set_screen_title {
  if [[ "$TERM" == screen* ]]; then
    local TITLE="$PWD"
    case $TITLE in
      $HOME) TITLE="~";;
      $HOME/*) TITLE="$(basename $TITLE)";;
    esac
    if [[ git_is_dirty == 1 ]];
    then
      printf '\ek%s\e\\' "!! $TITLE"
    fi

    printf '\ek%s\e\\' "$TITLE"

  #PROMPT_COMMAND="screen_set_window_title; $PROMPT_COMMAND"
  fi
}

## Export the prompt

export PROMPT_COMMAND=set_screen_title

PS1='\[\033[0;37m\][\[\e[0;37m\]\[\e[0;37m\]\[\e[0;37m\]\[\e[0;37m\]\w\[\e[0;37m\]]\[\e[0;37m\]\[\033[1;31m\]$(parse_git_branch)\[\033[1;31m\]\[\e[0;37m\]'
