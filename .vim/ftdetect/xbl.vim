"au! BufRead,BufNewFile *.xml set filetype=xbl
    "\ if getline(1) . getline(2) . getline(3) . getline(4) =~ 'bindings' |
    "\   set filetype=xbl |
    "\ endif
