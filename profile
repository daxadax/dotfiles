# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# source RVM scripts
source $HOME/.rvm/scripts/rvm

# add autocomplete to aws cli
complete -C aws_completer aws
