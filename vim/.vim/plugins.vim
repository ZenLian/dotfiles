"vim:foldmethod=marker
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'tomasiser/vim-code-dark'
call plug#end()

colorscheme codedark
