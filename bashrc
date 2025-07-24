# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## export
export EDITOR=vim
# export WIRELESS_INTERFACE=`iw dev | sed '2q;d' | cut -d' ' -f2`

# bash history
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
export HISTIGNORE="cal:gst:exit:vim*:gc:gp:gd:gl:ls:ga*:gg:gco*:cd*:tree*:irb:telemimi:zzz"

## source all files in the 'aliases' directory
for f in ~/.aliases/*; do source $f; done

## git aliases
source ~/.aliases/git

## curlable webapps
alias bvg='ruby ~/programming/scripts/bus_stop_info.rb'

## system aliases
alias grep='grep --color=auto'
alias feh='feh -d --scale-down'
alias ls='ls --color=auto'
# display active user processes
alias pp='ps -u $(whoami) -o ucmd,pid,%cpu,%mem'
alias system_update='sudo pacman -S archlinux-keyring && sudo pacman -Syu && sudo pacman -Rsunc $(pacman -Qdtq)'
alias unmount_all='devmon --unmount-all'
alias zzz='systemctl suspend'

## helpers
alias last_update=get_last_update
alias diskusage=determine_disk_usage
alias murder=murder
alias for_files_in=for_files_in
alias import_photos=import_photos
alias hlogs=tail_heroku_logs

### shortcuts
alias r='bundle exec ruby -r "./spec/spec_helper" -Ilib:spec:test'
alias rspec="LD_LIBRARY_PATH=$HOME/libs rspec"
alias rake='bundle exec rake'
alias telemimi='Telegram & exit'
alias torrent=open_torrent_client

# Get relative wireless signal strength
function WIP-get_signal_strength {
  local signal=`iwconfig $WIRELESS_INTERFACE |grep Signal`
  local formatted_signal=$($signal | cut -d'=' -f2 | cut -d'/' -f1)
  echo $formatted_signal 70 | awk '{print $1 / $2}'
}

function write_planetary_rulers {
  local rulers=`ruby ~/programming/scripts/planetary_hour.rb`

  echo $rulers > $HOME/i3test
}

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

# Stream tail of heroku logs to console with default options
# tail_heroku_logs <appname>
function tail_heroku_logs {
  heroku logs --force-colors --tail -a $1
}

function open_torrent_client {
  local status=`mullvad status | sed 's/ .*//'`

  if [[ $status ==  "Connected" ]]; then
    fragments
  else
    echo "You are not connected to a VPN. Please connect and try again."
  fi
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
