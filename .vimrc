set nocompatible
syntax on
filetype plugin indent on
set clipboard=unnamed

set cc=80

" Indentation
set softtabstop=4
set noexpandtab
set shiftwidth=4
set tabstop=4

set ttyfast
set lazyredraw
set wildmenu
set incsearch
set hlsearch
set hidden
set laststatus=2
set switchbuf=useopen,usetab

" Make splitting occur on right and bottom
set splitbelow
set splitright

" exrc allows Vim to source .vimrc file if it is present in working 
" directory
set exrc

set backspace=indent,eol,start

" Instead of switching b/w splits with ctrl-w then j, just ctrl-j
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
