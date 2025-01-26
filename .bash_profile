#   
#   termie's bash environment stuffs
#

# set up the common environment
[ -f $HOME/.commonenv ] && . $HOME/.commonenv

# run the bashrc
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
. "$HOME/.cargo/env"
