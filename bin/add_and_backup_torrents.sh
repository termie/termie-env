#!/bin/sh
transmission-remote --add $HOME/Downloads/*.torrent
mv -v $HOME/Downloads/*.torrent $HOME/Downloads/old_torrents
