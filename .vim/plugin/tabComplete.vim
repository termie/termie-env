if exists('loaded_tabcomplete') || &cp
    finish
endif

let loaded_tabcomplete=1

function InsertTabWrapper() 
    let col = col('.') - 1
    let v = pumvisible()
    if v
        return "\<C-n>"
    else
        if !col || getline('.')[col - 1] !~ '\k' 
            return "\<tab>"
        else
            return "\<C-n>"
            "return "\<C-x>\<C-o>"
        endif 
    endif
endfunction 
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

function TestBooty()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        let line = getline('.')
        let laststart = match(line, '\w\+$')
        let lastword = strpart(line, laststart)
        ab lastword
        return lastword
    endif
endfunction
inoremap <c-f> <c-r>=TestBooty()<cr>
