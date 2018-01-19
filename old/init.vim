set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
"Plugin 'vim-scripts/indentpython.vim'
"Bundle 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'vim-airline/vim-airline'
"Plugin 'crusoexia/vim-monokai'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'

"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}




" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Run nerdtree at startup"
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Map nerdtree"
map <C-n> :NERDTreeToggle<CR>

" Make jk to be esc
inoremap jk <ESC>
" Change the leader key
let mapleader = "\<Space>"
"Do not know what this do
filetype plugin indent on
syntax on
set encoding=utf-8

let g:jedi#force_py_version = 3



syntax enable
set background=dark
colorscheme solarized

"Python with virtualenv support. This is a sort of hack.




if has('nvim')
"Python with virtualenv support. This is a sort of hack.
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
else
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')  
  exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'),dict(__file__=activate_this))
EOF
endif


"syntax on
"colorscheme monokai
"set t_Co=256

set splitbelow
set splitright
set encoding=utf-8
set rnu


"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"Python indent"
"au BufNewFile,BufRead *.py
""    \ set tabstop=4
""    \ set softtabstop=4
""    \ set shiftwidth=4
""    \ set textwidth=79
""    \ set expandtab
""    \ set autoindent
""    \ set fileformat=unix

let python_highlight_all=1
syntax on

set clipboard=unnamedplus
let g:powerline_pycmd="python3"

set swapfile
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//