function fold#foldtext()
  let l:text = getline(v:foldstart)
  let l:count = v:foldend - v:foldstart + 1
  return l:text . '  ↕' . l:count
endfunction

function fold#init()
  set fillchars+=fold:\  " blank fold fill
  set foldtext=fold#foldtext()
endfunction
