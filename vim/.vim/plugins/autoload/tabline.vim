function tabline#tablabel(n, bufnr)
    let name = fnamemodify(bufname(a:bufnr), ":t")
    if (name ==# '')
      let name = '[No Name]'
    endif

    " \u2613 ☓
    " \u00D7  ×
    " <C-k>0M ●
    let close = getbufvar(a:bufnr, '&modified')?'●':'×'
    return a:n . ' ' . name . ' ' . close
endfunction

function tabline#tabline()
    let l:s = ''
    let i = 1
    for buf in getbufinfo({'buflisted':1})
        " select the highlighting
        if buf.bufnr == bufnr(0)
            let l:s .= '%#TabLineSel#'
        else
            let l:s .= '%#TabLine#'
        endif

        " set bufnr for mouse clicks
        "let l:s .= buf.name

        " set text label
        let l:s .= ' %{tabline#tablabel(' . i . ',' . buf.bufnr . ')} '
        let i += 1
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let l:s .= '%#TabLineFill#'
    return l:s
endfunction


