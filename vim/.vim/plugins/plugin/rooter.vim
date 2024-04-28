let g:rooter_patterns = ['.git', '.svn']
let g:rooter_targets = []

function! s:rooter()
  if !s:precheck() | return | endif
endfunc

" returns true if we should chdir
function! s:precheck()
  if count(['', 'nofile'], &buftype) then | return 0 | endif

  let cwd = expand('%:p', 1)

  if cwd =~ 'NERD_tree_\d\+$'
    let cwd = b:NERDTree.root.path.str().'/'
  endif

  " directory
  if empty(cwd) || cwd[-1:] == '/'
    return len(g:rooter_targets) > 0
  endif

  " file
endfunc
