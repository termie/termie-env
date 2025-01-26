#
#   termie's bash interactive stuffs
#

# change the window title of X terminals
case $TERM in
	xterm*|rxvt|Eterm|eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

PROMPT_COLOR='0;32m'
if [ ${UID} -eq 0 ]; then
    PROMPT_COLOR='0;31m'
fi

ESCAPED_HOME=`echo $HOME | sed -r "s:/:\\\\\\/:g"`

PS1='\[\033[${PROMPT_COLOR}\]\u@\h\[\033[0;0m\]:`pwd | sed -r "s/${ESCAPED_HOME}/~/" | sed -r "s/^.*(\/.*)(\/.*)(\/.*)$/\1\2\3/" ` \$ '

[ -f $HOME/.commonrc ] && . $HOME/.commonrc

. "$HOME/.cargo/env"
