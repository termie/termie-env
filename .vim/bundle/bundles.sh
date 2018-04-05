#!/bin/bash

vim_bundle() {
  (
  cd "$HOME/.vim/bundle" || exit
  if [[ -d "$1" ]]; then
    echo "Found VIM bundle: $1..."
    return
  fi
  echo "Fetching VIM bundle $1..."
  git clone "$2" "$1"
  )
}


vim_syntastic() {
  vim_bundle syntastic https://github.com/vim-syntastic/syntastic
}

vim_rainbow_parentheses() {
  vim_bundle rainbow_parentheses https://github.com/kien/rainbow_parentheses.vim
}

vim_css_color() {
  vim_bundle vim-css-color https://github.com/skammer/vim-css-color
}

vim_go() {
  vim_bundle vim-go https://github.com/fatih/vim-go
}

vim_scala() {
  vim_bundle vim-scala https://github.com/derekwyatt/vim-scala
}

vim_lua() {
  vim_bundle vim-lua https://github.com/tbastos/vim-lua.git
}

main() {
  vim_syntastic
  vim_rainbow_parentheses
  vim_css_color
  vim_go
  vim_scala
  vim_lua
}

main
