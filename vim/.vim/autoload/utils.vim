function! utils#gethl(group, attr) abort
  return hlID(a:group)->synIDtrans()->synIDattr(a:attr)
endfunction

function! utils#sethl(group, fg, bg, ...)
    let guifg = a:fg[0]
    let ctermfg = a:fg[1]
    let guibg = a:bg[0]
    let ctermbg = a:bg[1]
    let hl_str = [
                \'highlight', a:group,
                \'ctermfg='.ctermfg,
                \'ctermbg='.ctermbg,
                \'guifg='.guifg,
                \'guibg='.guibg,
                \]
    if a:0 >= 1
        call add(hl_str, 'gui=' . a:1)
        call add(hl_str, 'cterm=' . a:1)
        if a:0 >= 2
            call add(hl_str, 'guisp=' . a:2)
            call add(hl_str, 'ctermul=' . a:2)
        endif
    else
        call add(hl_str, 'gui=NONE')
        call add(hl_str, 'cterm=NONE')
    endif
    "execute 'highlight clear ' . a:group
    execute join(hl_str, ' ')
endfunction

