# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## export
export EDITOR=vim
export VMAIL_BROWSER=w3m
export WIRELESS_INTERFACE=`iw dev | sed '2q;d' | cut -d' ' -f2`
export HISTSIZE=100000
export HISTFILESIZE=100000

## source all files in the 'aliases' directory
for f in ~/.aliases/*; do source $f; done

## System specific
alias wireless_down='sudo ip link set $WIRELESS_INTERFACE down'
alias wireless_up='sudo ip link set $WIRELESS_INTERFACE up'
alias cycle_vpn=cycle_vpn_connection

## reminder helpers
alias clear_reminders='echo "nothing to do" > ~/.reminders'
alias remind_me=add_reminder

## git aliases
source ~/.aliases/git

## curlable webapps
alias weather_capp='curl wttr.in'
alias crypto_capp='curl rate.sx'
alias bvg='ruby ~/programming/scripts/bus_stop_info.rb'

## system aliases
alias grep='grep --color=auto'
alias keymap='xmodmap -pke'
alias lock_display='i3lock -c000000'
alias ls='ls --color=auto'
# display active user processes
alias pp='ps -u $(whoami) -o ucmd,pid,%cpu,%mem'
alias system_update='sudo pacman -S archlinux-keyring && sudo pacman -Syu && sudo pacman -Rsunc $(pacman -Qdtq)'
alias unmount_all='devmon --unmount-all'
alias xev='xev | grep -A2 --line-buffered "^KeyRelease" | sed -n "/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p"'
alias zzz='systemctl suspend'

## helpers
alias last_update=get_last_update
alias diskusage=determine_disk_usage
alias murder=murder
alias for_files_in=for_files_in
alias import_photos=import_photos
alias stc=screenshot_to_clipboard

## connection aliases
alias connect_to_wifi='sudo wifi-menu'
alias connect_to_mysql='sudo systemctl start mysqld.service'
alias connect_to_quotes='cd ~/programming/quotes/quotes_app && shotgun -p 2300 config.ru'
alias connect_to_tarot='cd ~/programming/tarot/tarot_app && shotgun -p 2301 config.ru'

### shortcuts
alias feh='feh -.'
alias r='bundle exec ruby -r "./spec/spec_helper" -Ilib:spec:test'
alias rake='bundle exec rake'
alias remove_exif_data='exiftool -r -overwrite_original -all= *'
alias telemimi='~/Telegram/Telegram & exit'

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

#Add a reminder to the reminders file, shown at login
function add_reminder {
if [[ "$1" != "" ]]; then
  echo $1 >> ~/.reminders
else
  echo "Remind you about what?"  1>&2
fi
}

function cycle_vpn_connection {
  local target="${1:-cz}"

  expressvpn disconnect
  expressvpn connect $target
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

# take a screenshot with scrot and send it to the clipboard
function screenshot_to_clipboard {
  scrot -s -e 'xclip -selection clipboard -t image/png -i $f'
  rm *scrot.png
}

alias staging_console='devcon "staging"'
alias prod_console='devcon "prod"'

# dev consoles with aws
function devcon {
  if [[ "$1" !=  "" ]]; then
    aws-vault clear
    instanceId=$(aws-vault exec $1 -- aws ec2 describe-instances --filters "Name=tag:Name,Values=console-instance" --query 'Reservations[*].Instances[*].[InstanceId]' --output text)
    aws-vault exec $1 -- aws ssm start-session --target $instanceId
  else
    echo "I'm afraid I can't do that, $USER"
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
