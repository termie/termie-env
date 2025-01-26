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

vim_python_syntax() {
  vim_bundle python-syntax https://github.com/vim-python/python-syntax
}

vim_rainbow_parentheses() {
  vim_bundle rainbow_parentheses https://github.com/kien/rainbow_parentheses.vim
}

vim_vue() {
  vim_bundle vim-vue https://github.com/posva/vim-vue.git
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

vim_signjump() {
  vim_bundle vim-signjump https://github.com/ZeroKnight/vim-signjump
}

main() {
  vim_syntastic
  vim_rainbow_parentheses
  vim_css_color
  vim_go
  vim_scala
  vim_lua
  vim_signjump
}

main
