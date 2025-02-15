#
#   termie's zsh interactive stuffs
#

# these are old, not sure why they are still around
#PROMPT="$(print '%{\e[1;31m%}%m%{\e[0m%} %{\e[1;34m%}%n%{\e[0m%}:%~%(!.#.>) ')"
#RPROMPT="[%D{%Y%m%d.%H%M%S}]"

setopt prompt_subst
autoload -U colors
colors

if type compdef >/dev/null; then
  compdef hub=git
fi


function __prompt_git()
{
  local git_dir ref br top;
  git_dir=$(git rev-parse --git-dir 2> /dev/null) || return
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  br=${ref#refs/heads/}
  top=$(cat $git_dir/patches/$br/current 2>/dev/null) \
    && top="/$top"
  echo "[$br$top]"
}

function __prompt_color()
{
  local RGB CONVERTED RH GH BH RD GD BD
  RGB=$(echo $(pwd) termie | md5sum | cut -c 1-6)

  RH=$(echo ${RGB} | cut -c 1-2)
  GH=$(echo ${RGB} | cut -c 3-4)
  BH=$(echo ${RGB} | cut -c 5-6)

  RD=$(( 16#${RH}))
  GD=$(( 16#${GH}))
  BD=$(( 16#${BH}))

  RD=$((${RD} / 5))
  GD=$((${GD} / 5))
  BD=$((${BD} / 5))

  CONVERTED=$(printf "%2x%2x%2x" ${RD} ${GD} ${BD})
  #echo "\033]Ph${CONVERTED}\033\\\b\b"
}

if [ -n "$SSH_CONNECTION" ]; then
  BGCOL='#302b36'
else
  BGCOL='#002b36'
fi


# prompt config
# should look something like "andy@ptero: ~ %"
PROMPT=$'%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%}:%3c$EXTRA_PROMPT %(!.#.%%) %{$(__prompt_color)%}%{\033]0;%3c\007%}%{\033]11;$BGCOL\007%}'
RPROMPT='%{$fg[yellow]%}$(__prompt_git) %{$reset_color%}%*'

long_exec_command="?"
long_exec_secs=0
long_exec_ignore="yes"

path_to_growlnotify=$(which growlnotify);
path_to_terminalnotify=$(which terminal-notifier);

function long_exec_report () {
  #notify-send \
  #  -t 60000 \
  #  -h int:x:2500 \
  #  -h int:y:15 \
  #  "done: $long_exec_command in $1 seconds"
  #$HOME/p/grwl/notify.py \
  #  -H pito.sfo \
  #  -P sillypassword \
  #  -t "done" \
  #  -m "$long_exec_command in $1 seconds"
  if [ -x "$path_to_growlnotify" ]; then
    growlnotify -t "done" \
      -m "$long_exec_command in $1 seconds"
  elif [ -x "$path_to_terminalnotify" ]; then
    terminal-notifier -t "done" \
      -activate om.googlecode.iterm2 \
      -group "zsh" \
      -message "$long_exec_command in $1 seconds"
  fi
}

preexec () {
  # change the window titles when appropriate...
  case $TERM in (xterm*|rxvt)
    print -Pn "\e]0;%n@%m: $1\a"
  esac

  # track time for long exec
  if [ "x$TTY" != "x" ]; then
    long_exec_secs="$SECONDS"
    long_exec_ignore=""
    long_exec_command="$2"
  fi
}

precmd () {
  # change the window titles when appropriate...
  case $TERM in (xterm*|rxvt)
    print -Pn "\e]0;%n@%m:%~\a"
  esac

  # track time for long exec
  if [ "x$TTY" != "x" ]; then
    if [ "x$long_exec_ignore" = "x" ]; then
      long_exec_ignore="yes"
      xx=$(($SECONDS - $long_exec_secs))
      if [ $xx -gt 10 ]; then
        if [ $TTYIDLE -gt 10 ]; then
          long_exec_report $xx
        fi
      fi
    fi
  fi
}


## zsh completions
autoload -U compinit promptinit
compinit
promptinit

unsetopt promptcr
bindkey -e

# completion cache
zstyle ':completion::complete:*' use-cache 1

# hub tab-completion script for zsh.
# This script complements the completion script that ships with git.
#
# vim: ft=zsh sw=2 ts=2 et

# Autoload _git completion functions
#if declare -f _git > /dev/null; then
#  _git
#fi

if declare -f _git_commands > /dev/null; then
  _hub_commands=(
    'alias:show shell instructions for wrapping git'
    'pull-request:open a pull request on GitHub'
    'fork:fork origin repo on GitHub'
    'create:create new repo on GitHub for the current project'
    'browse:browse the project on GitHub'
    'compare:open GitHub compare view'
  )
  # Extend the '_git_commands' function with hub commands
  eval "$(declare -f _git_commands | sed -e 's/base_commands=(/base_commands=(${_hub_commands} /')"
fi

[ -f $HOME/.commonrc ] && source $HOME/.commonrc

# darwin stuff
if [ "$T_PLATFORM" = "Darwin" ]; then
    # my pleasant little colorization script,
    # only really works with the mac, but could
    # do the same thing on a linux desktop
    # thanks for the idea robin
    if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
        [ -f "$HOME/bin/$T_PLATFORM/c" ] && source $HOME/bin/$T_PLATFORM/c
    fi
fi

PERL_MB_OPT="--install_base \"/Users/termie/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/termie/perl5"; export PERL_MM_OPT;

if [[ -z $DISPLAY && XDG_VTNR -eq 1 ]]
then
  exec startx
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/termie/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/termie/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/termie/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/termie/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
