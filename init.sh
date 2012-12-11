#!/bin/sh
TIMESTAMP=`date +%s`
PLATFORM=`uname`

# link the files into place
for x in `cat $HOME/env/MANIFEST`
do
  if [ ! -L "$HOME/$x" ]; then
    if [ -e "$HOME/$x" ]; then
      echo "Moving $HOME/$x -> $HOME/$x.old.$TIMESTAMP"
      mv $HOME/$x $HOME/$x.old.$TIMESTAMP
    fi
    echo "Linking $HOME/env/$x -> $HOME/$x"
    ln -s $HOME/env/$x $HOME/$x
  fi
done

# do platform specific setup
[ -f $HOME/env/init.$PLATFORM.sh ] && source $HOME/env/init.$PLATFORM.sh
