# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If an unknown application is called, search pkgfile for where it can be found
source ~/.aliases/command_not_found

#add helper to build from aur
source ~/.aliases/build_from_aur

## System specific
alias wireless_down='sudo ip link set wlp1s0 down'
alias wireless_up='sudo ip link set wlp1s0 up'

## reminder helpers
alias clear_reminders='echo "nothing to do" > ~/.reminders'
alias remind_me=add_reminder

## git aliases
source ~/.aliases/git

## system aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias xev="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias keymap="xmodmap -pke"
alias unmount_all="devmon --unmount-all"
alias last_update=get_last_update
alias diskusage=determine_disk_usage
alias murder=murder
alias for_files_in=for_files_in

## connection aliases
alias connect_to_mysql='sudo systemctl start mysqld.service'
alias connect_to_quotes='cd ~/programming/quotes/quotes_app && shotgun -p 2300 config.ru'
alias connect_to_tarot='cd ~/programming/tarot/tarot_app && shotgun -p 2301 config.ru'
alias connect_to_vps='ssh root@198.167.140.147'

### shortcuts
alias r='bundle exec ruby -Ilib:spec:test'
alias block='echo befc523d-8815-4245-be01-81ecd2a8bd99'
alias pidgin='pidgin &'
alias feh='feh -.'
alias remove_exif_data='exiftool -r -overwrite_original -all= *'

## export
export EDITOR=vim

# Export values for iBus and start daemon
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

# Get date of last full system update
function get_last_update {
  awk '/pacman -Syu/ {print $1" "$2}' /var/log/pacman.log | tail -n 1 | cut -c 2-17
}

# Loop through files in directory and do something
function for_files_in {
if [ $# -lt 2 ]; then
  echo "Usage: for_files_in <directory> <command to preform on each file>"
fi

for file in $1/*; do $2 $file; done
}

#Add a reminder to the reminders file, shown at login

function add_reminder {
if [[ "$1" != "" ]]; then
  echo $1 >> ~/.reminders 
else
  echo "Remind you about what?"  1>&2
fi
}

# Send a kill -9 signal to PID

function murder {
  if [[ "$1" != "" ]]; then
    local process_name="cat /proc/1444/status | sed -n '1p' | awk '{print $NF}'"
    kill -9 $1
    echo "Murdered process '$process_name' with PID $1"
  else
    echo "Who shall I kill?"  1>&2
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
