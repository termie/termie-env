" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  " highlight Normal guibg=grey90
  " highlight Cursor guibg=Green guifg=NONE
  " highlight lCursor guibg=Cyan guifg=NONE
  " highlight NonText guibg=grey80
  " highlight Constant gui=NONE guibg=grey95
  " highlight Special gui=NONE guibg=grey95

endif

winpos 50 100
set lines=50
set columns=80

inoremap <C-Tab> <Plug>Jumper

" tabs!
noremap <C-D-\> :tabprevious<CR>
noremap <C-D-]> :tabnext<CR>

inoremap <C-D-\> <Esc>:tabprevious<CR>
inoremap <C-D-]> <Esc>:tabnext<CR>

noremap <D-t> :tabnew<CR>
inoremap <D-t> <Esc>:tabnew<CR>
noremap <D-w> :close<CR>

set visualbell

nnoremap <special> <D-n> :!open -a gvim<CR><CR>

inoremap <D-e> <Esc>:NERDTreeToggle<CR>
noremap <D-e> :NERDTreeToggle<CR>
inoremap <C-e> <Esc>:NERDTreeToggle<CR>
noremap <C-e> :NERDTreeToggle<CR>

let g:NERDTreeMapActivateNode = "<CR>"
colorscheme zellner

set gfn=Menlo:h14

cabbrev double :winsize 160 50<CR>:vsplit<CR>
set background=light
colorscheme solarized


highlight NonText guifg=#DDDDDD
highlight SpecialKey guifg=#DDDDDD

let g:syntastic_mode_map = {
      \ "mode": "active",
      \ "active_filetypes": [],
      \ "passive_filetypes": ["go"] }


function ForceFoldmethodSyntax()
    if &foldenable
        set foldmethod=syntax
    endif
endfunction

nnoremap <F10> :normal zi<CR>|call ForceFoldmethodSyntax()
inoremap <F10> ^O:normal zi<CR>|call ForceFoldmethodSyntax()
