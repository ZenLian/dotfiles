" vim:foldmethod=marker:foldlevel=99:
hi clear
syntax reset
set background=dark
set termguicolors
let t_Co=256

let g:colors_name = 'catppuccin'

" 00: bg
" 01: bg1(cursorline)
" 02: bg2(selected)
" 03: nontext
" 04: comment/inactive
" 05: fg
" 06: fg1
" 07: fg2
" 08: red, error
" 09: pink
" 0A: yellow
" 0B: green
" 0C: cyan(lightgreen)
" 0D: blue
" 0E: magenta
" 0F: lightblue

let s:none = ['NONE', 'NONE', 'NONE']

let s:red    = ['#f38ba8', '211', '01']
let s:green  = ['#a6e3a1', '157', '02']
let s:yellow = ['#f9e2af', '186', '03']
let s:blue   = ['#89b4fa', '111', '04']
let s:pink   = ['#f5c2e7', '225', '05']
let s:teal   = ['#94e2d5', '159', '06']
let s:peach  = ['#fab387', '225', '05']
let s:rosewater = ['#f5e0dc', '211', '01']
let s:flamingo = ['#f2cdcd', '211', '01']
let s:mauve = ['#cba6f7', '211', '01']
let s:maroon = ['#eba0ac', '211', '01']
let s:lavender = ['#b4befe', '211', '01']
let s:sapphire = ['#74c7ec', '211', '01']
let s:sky = ['#89dceb', '211', '01']

"let s:crust    = ['#11111b', '16', '00' ]
let s:crust    = ['#111118', '16', '00' ]
"let s:mantle   = ['#181825', '232', '00' ]
let s:mantle   = ['#181825', '232', '00' ]
"let s:base     = ['#1e1e2e', '233', '00']
let s:base     = ['#1e1e24', '233', '00']
"let s:surface0 = ['#313244', '237', '00']
let s:surface0 = ['#31323e', '237', '00']
"let s:surface1 = ['#45475a', '240', '00']
let s:surface1 = ['#454753', '240', '00']
"let s:surface2 = ['#585b70', '242', '00']
let s:surface2 = ['#585b68', '242', '00']
let s:overlay0 = ['#6c7086', '247', '00']
let s:overlay1 = ['#7f849c', '248', '00']
let s:overlay2 = ['#9399b2', '249', '00']
let s:subtext0 = ['#a6adc8', '250', '07']
let s:subtext1 = ['#bac2de', '251', '07']
let s:text     = ['#cdd6f4', '254', '07']

call utils#sethl('ColorColumn', s:none, s:surface0)
call utils#sethl('Conceal', s:overlay2, s:base)
call utils#sethl('Cursor', s:base, s:text)
"call utils#sethl('lCursor', s:c.base, s:c.text)
"call utils#sethl('CursorIM', s:c.base, s:c.text)
call utils#sethl('CursorColumn', s:none, s:surface0)
call utils#sethl('CursorLine', s:none, s:surface0)
call utils#sethl('Directory', s:blue, s:none)
call utils#sethl('DiffAdd', s:green, s:base)
call utils#sethl('DiffChange', s:yellow, s:base)
call utils#sethl('DiffDelete', s:red, s:base)
call utils#sethl('DiffText', s:blue, s:base)
call utils#sethl('EndOfBuffer', s:base, s:none)
call utils#sethl('ErrorMsg', s:red, s:base, 'bold,italic')
call utils#sethl('VertSplit', s:crust, s:none)
call utils#sethl('Folded', s:blue, s:surface1)
call utils#sethl('FoldColumn', s:teal, s:base)
call utils#sethl('SignColumn', s:surface1, s:none)
call utils#sethl('IncSearch', s:base, s:red)
call utils#sethl('LineNr', s:overlay0, s:base)
call utils#sethl('CursorLineNr', s:lavender, s:base)
call utils#sethl('MatchParen', s:base, s:lavender, 'bold')
call utils#sethl('ModeMsg', s:text, s:none, 'bold')
"call utils#sethl('MsgArea', s:text, s:none)
call utils#sethl('NonText', s:overlay0, s:none)
call utils#sethl('Normal', s:text, s:base)
call utils#sethl('Pmenu', s:text, s:mantle)
call utils#sethl('PmenuSel', s:mantle, s:blue)
call utils#sethl('PmenuSbar', s:none, s:mantle)
call utils#sethl('PmenuThumb', s:none, s:surface1)
call utils#sethl('Question', s:blue, s:none)
call utils#sethl('QuickFixLine', s:none, s:surface0, 'bold')
call utils#sethl('Search', s:base, s:sapphire)
call utils#sethl('SpecialKey', s:overlay0, s:none)
call utils#sethl('SpellBad', s:none, s:none, 'undercurl')
call utils#sethl('SpellCap', s:none, s:none, 'undercurl')
call utils#sethl('SpellLocal', s:none, s:none, 'undercurl')
call utils#sethl('SpellRare', s:none, s:none, 'undercurl')
"call utils#sethl('StatusLine', s:text, s:mantle)
call utils#sethl('StatusLine', s:text, s:base)
"call utils#sethl('StatusLineNC', s:surface1, s:mantle)
call utils#sethl('StatusLineNC', s:surface1, s:base)
call utils#sethl('TabLine', s:overlay1, s:crust)
call utils#sethl('TabLineFill', s:none, s:crust)
call utils#sethl('TabLineSel', s:text, s:base, 'italic')
"call utils#sethl('Terminal', s:none, s:none)
call utils#sethl('Title', s:blue, s:none, 'bold')
call utils#sethl('Visual', s:none, s:surface1, 'bold')
call utils#sethl('VisualNOS', s:none, s:surface1, 'bold')
call utils#sethl('WarningMsg', s:red, s:none)
call utils#sethl('WildMenu', s:none, s:overlay0)

" {{{ syntax
call utils#sethl('Comment', s:overlay0, s:none)
"
call utils#sethl('Constant', s:peach, s:none)
call utils#sethl('String', s:green, s:none)
call utils#sethl('Character', s:teal, s:none)
call utils#sethl('Number', s:peach, s:none)
call utils#sethl('Boolean', s:peach, s:none)
call utils#sethl('Float', s:peach, s:none)
"
call utils#sethl('Identifier', s:flamingo, s:none)
call utils#sethl('Function', s:blue, s:none)
"
call utils#sethl('Statement', s:mauve, s:none)
call utils#sethl('Conditional', s:mauve, s:none)
call utils#sethl('Repeat', s:mauve, s:none)
call utils#sethl('Label', s:sapphire, s:none)
call utils#sethl('Operator', s:sky, s:none)
call utils#sethl('Keyword', s:mauve, s:none)
call utils#sethl('Exception', s:red, s:none)
"
call utils#sethl('PreProc', s:pink, s:none)
call utils#sethl('Include', s:mauve, s:none)
call utils#sethl('Define', s:pink, s:none)
call utils#sethl('Macro', s:mauve, s:none)
call utils#sethl('PreCondit', s:pink, s:none)
"
call utils#sethl('Type', s:yellow, s:none)
call utils#sethl('StorageClass', s:yellow, s:none)
call utils#sethl('Structure', s:yellow, s:none)
call utils#sethl('Typedef', s:yellow, s:none)
"
call utils#sethl('Special', s:teal, s:none)
call utils#sethl('SpecialChar', s:pink, s:none)
call utils#sethl('Tag', s:pink, s:none)
call utils#sethl('Delimiter', s:pink, s:none)
call utils#sethl('SpecialComment', s:pink, s:none)
call utils#sethl('Debug', s:pink, s:none)
"
call utils#sethl('Underlined', s:none, s:none, 'underline')
"
"call utils#sethl('Ignore', s:none, s:none)
"
call utils#sethl('Error', s:mantle, s:red)
"
call utils#sethl('Todo', s:mantle, s:yellow, 'bold')
" TODO
"}}}

" diff {{{
call utils#sethl('diffFile', s:blue, s:none)
call utils#sethl('diffLine', s:yellow, s:none)
call utils#sethl('diffAdded', s:green, s:none)
call utils#sethl('diffRemoved', s:red, s:none)
"}}}

