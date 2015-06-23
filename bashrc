# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Arch specific

# If an unknown application is called, search pkgfile for where it can be found
source /usr/share/doc/pkgfile/command-not-found.bash

## System specific
alias wireless_down='sudo ifconfig wlp1s0 down'
alias wireless_up='sudo ifconfig wlp1s0 up'

## projects
alias start_manager2='cd ~/programming/manager2/ && screen -t "main" bash -c "cd main && ./tools/fetch.sh; bash -l"'

## reminder helpers
alias clear_reminders='echo "nothing to do" > ~/reminders'
alias remind_me=add_reminder

## system aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias xev="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias keymap="xmodmap -pke"
alias unmount_all="udiskie-umount -a"
alias diskusage=determine_disk_usage

## connection aliases
alias connect_to_mysql='sudo systemctl start mysqld.service'
alias connect_to_neo="ssh -D 1337 -vN dd@office.neopoly.de"
alias connect_to_quotes='cd ~/programming/quotes/quotes_app && shotgun -p 2300 config.ru'
alias connect_to_tarot='cd ~/programming/tarot/tarot_app && shotgun -p 2301 config.ru'
alias connect_to_vps='ssh dax@198.167.140.147'

### git aliases
alias gst='git status'
alias ga='git add'
alias gc='git commit -v'
alias gco='git checkout'
alias gba='git branch -a'
alias gd='git diff'
alias stash='git stash'
alias pop='git stash pop'
alias gl='git pull'
alias gp='git push'
alias gg='git prettylog'

### shortcuts
alias r='bundle exec ruby -Ilib:spec:test'
alias block='echo befc523d-8815-4245-be01-81ecd2a8bd99'
alias pidgin='pidgin &'

## export
export EDITOR=vim

# Add a reminder to the reminders file, shown at login

function add_reminder {
if [[ "$1" != "" ]]; then
  echo $1 >> ~/reminders 
else
  echo "Remind you about what?"  1>&2
fi
}

# Determine disk useage through a modified `du` command

function determine_disk_usage {
  if [[ "$1" !=  "" ]]; then
    DIR="$1"
  else
    DIR="/*"
  fi

  sudo du -h --max-depth=1 $DIR | sort -h
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

    printf '\ek%s\e\\' "$TITLE"
  fi
}

## Export the prompt

export PROMPT_COMMAND=set_screen_title

PS1='\[\033[0;37m\][\[\e[0;37m\]\[\e[0;37m\]\[\e[0;37m\]\[\e[0;37m\]\w\[\e[0;37m\]]\[\e[0;37m\]\[\033[1;31m\]$(parse_git_branch)\[\033[1;31m\]\[\e[0;37m\]'
