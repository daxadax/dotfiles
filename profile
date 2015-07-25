# load ssh on login
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` > /dev/null
fi

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# source RVM scripts
source $HOME/.rvm/scripts/rvm
