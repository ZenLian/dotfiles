" disable builtin plugins to speed up
let disable_plugins = ['loaded_gzip', 'loaded_logiPat', 'loaded_netrwPlugin',
  \'loaded_rrhelper', 'loaded_tarPlugin', 'loaded_2html_plugin', 'loaded_zipPlugin']
for plugin in disable_plugins
  "let g:loaded_rrho
  "let g:
endfor

call plug#begin('~/.vim/plugged')
    "Plug '~/.vim/plugins/utils'

    Plug 'yegappan/taglist'
    "Plug 'ludovicchabant/vim-gutentags'
    "Plug 'skywind3000/gutentags_plus'
    "Plug 'skywind3000/vim-preview'
    Plug 'luochen1990/rainbow'
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    "Plug 'preservim/nerdcommenter'
    Plug 'justinmk/vim-sneak'
    "Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    "Plug 'maralla/completor.vim'
    "Plug 'junegunn/vim-easy-align'
call plug#end()

"" FuZzy Finder
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nmap <C-p> :Files<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fh :History<CR>
nmap <Leader>fb :Buffers<CR>

"" explorer
let NERDTreeDirArrowCollapsible="-"
let NERDTreeDirArrowExpandable="+"
nmap <Leader>e :NERDTreeToggle<CR>
nmap <C-e> :NERDTree<CR>

"" taglist
nmap <Leader>; :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1

"" gutentags
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" config project root markers.
let g:gutentags_project_root = ['.root']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/vim/tags')
" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 0

" vim:foldmethod=marker:foldmarker={{{,}}}
