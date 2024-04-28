let s:black  = ['#1b1b1c', '232', '00' ]
let s:red    = ['#f38ba8', '211', '01']
let s:green  = ['#a6e3a1', '157', '02']
let s:yellow = ['#f9e2af', '186', '03']
let s:blue   = ['#89b4fa', '111', '04']
let s:pink   = ['#f5c2e7', '225', '05']
let s:teal   = ['#94e2d5', '159', '06']
let s:white  = ['#cdd6f4', '254', '07']

call utils#sethl('StlNormal', s:white, s:black)
call utils#sethl('StlRedFg', s:red, s:black)
call utils#sethl('StlGreenFg', s:green, s:black)
call utils#sethl('StlYellowFg', s:yellow, s:black)
call utils#sethl('StlBlueFg', s:blue, s:black)

call utils#sethl('StlRedBg', s:black, s:red)
call utils#sethl('StlGreenBg', s:black, s:green)
call utils#sethl('StlYellowBg', s:black, s:yellow)
call utils#sethl('StlBlueBg', s:black, s:blue)

let s:modes = {
  \'n': 'N',
  \'v': 'V',
  \'V': 'V',
  \'': 'V',
  \'s': 'V',
  \'S': 'V',
  \'': 'V',
  \'i': 'I',
  \'R': 'R',
  \'c': 'C',
  \'r': 'N',
  \'!': 'T',
  \'t': 'T',
\}

let s:mode_colors = {
  \'N': 'StlBlue'
\}

function! stline#mode() abort
  return s:modes[mode()]
endfunction

function! s:square_mode() abort
  return
endfunction

" \u2588 .. \u2581
let s:bars = ['█','▇','▆','▅','▄','▃','▂','▁']

function! s:scrollbar(winid) abort
  let l:line = line('.', a:winid)
  let l:lines = line('$', a:winid)
  let l:index = len(s:bars) * (l:line - 1) / l:lines
  return '%#StlBlueBg#' . s:bars[l:index] . '%#StlNormal#'
endfunction

function! stline#statusline() abort
  " current statusline
  "if g:statusline_winid == win_getid(winnr())
  "  let l:scrollbar = s:scrollbar(g:statusline_winid)
  "  return '%{stline#mode()} %f %m%r%=%{&fileencoding} %-4Y %3l,%-3c '. l:scrollbar
  "else " non-current statusline
  "  return '%f%='
  "endif
  let l:scrollbar = s:scrollbar(win_getid(winnr()))
  return '%{stline#mode()} %f %m%r%=%{&fileencoding} %-4Y %3l,%-3c '. l:scrollbar
endfunction

function! stline#init() abort
  if !exists('g:stline_components')
    return
  endif
  "set fillchars+=stlnc:━
  set statusline=%!stline#statusline()
endfunction

