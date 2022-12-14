set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'               " Status bar
Plug 'https://github.com/preservim/nerdtree'                    " NerdTree
Plug 'http://github.com/tpope/vim-surround'                     " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary'                  " For Commenting gcc & gc
Plug 'https://github.com/ap/vim-css-color'                      " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes'			" Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons'                " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal'                  " Vim Terminal
Plug 'https://github.com/terryma/vim-multiple-cursors'			" CTRL + N for multiple cursors
Plug 'https://github.com/preservim/tagbar'                      " Tagbar for code navigation

call plug#end()


:set completeopt-=preview                                       " For no Previews

:colorscheme murphy

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <S-Left> :NERDTreeToggle<CR>           " TO BE TESTED
nnoremap <S-Down> :TerminalSplit bash<CR>       " TO BE TESTED
nnoremap <S-Up> :NERDTreeRefreshRoot<CR>        " TO BE TESTED

nmap <C-Right> : TagbarToggle<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
