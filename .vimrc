" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif



" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set ch=2
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set t_kD=[3~
if $TERM_PROGRAM =~? "Apple_Terminal"
    set t_kb=
else
    set t_kb=
endif

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
    " else
    " set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

    augroup END
"else
    "set autoindent		" always set autoindenting on
endif " has("autocmd")


" these require the NERD_comments modules
map ,c <leader>cl
map ,d <leader>cu

" this is for folding
"map zz zA
map zz za
"au BufWinLeave *.js mkview
"au BufWinEnter *.js silent loadview
au BufWinLeave *.xul mkview
au BufWinEnter *.xul silent loadview
au BufWinLeave *.xml mkview
au BufWinEnter *.xml silent loadview



" quick buffers
"noremap <C-n> :bnext<CR>
"noremap <C-p> :bprev<CR>

" tabs!
noremap [2C :tabnext<CR>
noremap [2D :tabprevious<CR>
noremap  :tabnew<CR>


"" lhs comments
"map ,# :s/^/#/<CR> <Esc>:nohlsearch <CR>
"map ,/ :s/^/\/\//<CR> <Esc>:nohlsearch <CR>
"map ,> :s/^/> /<CR> <Esc>:nohlsearch<CR>
"map ," :s/^/\"/<CR> <Esc>:nohlsearch<CR>
"map ,% :s/^/%/<CR> <Esc>:nohlsearch<CR>
"map ,! :s/^/!/<CR> <Esc>:nohlsearch<CR>
"map ,; :s/^/;/<CR> <Esc>:nohlsearch<CR>
"map ,- :s/^/--/<CR> <Esc>:nohlsearch<CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR> <Esc>:nohlsearch<CR>
"
"" wrapping comments
"map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR> <Esc>:nohlsearch<CR>
"map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR><Esc>:nohlsearch <CR>
"map ,< :s/^\(.*\)$/<!-- \1 -->/<CR> <Esc>:nohlsearch<CR>
"map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR> <Esc>:nohlsearch<CR>

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent

set encoding=utf8
set fileencoding=utf8


let g:snip_start_tag = "@"
let g:snip_end_tag = "@"
imap  <Plug>Jumper

"function InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"
function FourSpace()
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
endfunction


" l10n stuff... now that i am in dutch
set langmenu=none

let javaScript_fold=1

highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$\|\t\+/
autocmd BufWritePre * :%s/\s\+$//e
autocmd colorscheme * highlight ExtraWhitespace ctermbg=red guibg=red

let g:solarized_termcolors=256
set background=dark
colorscheme solarized
