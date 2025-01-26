#
#   termie's environment stuffs
#

## generic zsh stuff
# history
HISTSIZE=500
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000

[ -f $HOME/.commonenv ] && . $HOME/.commonenv
. "$HOME/.cargo/env"
