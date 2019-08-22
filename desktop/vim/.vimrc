" Set the leader key to space
	let mapleader = " "

" Some basic setup
	set nocompatible
	filetype off
	set number
	set relativenumber
	filetype plugin indent on
	syntax on
	set clipboard=unnamed
	set cc=80
	set ttyfast
	set lazyredraw
	set wildmenu
	set incsearch
	set hlsearch
	set hidden
	set laststatus=2
	set switchbuf=useopen,usetab
	set backspace=indent,eol,start

" Enable auto-completion
	set wildmode=longest,list,full

" Setting up Vundle
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
		Plugin 'VundleVim/Vundle.vim'
		Plugin 'junegunn/goyo.vim'
		Plugin 'mboughaba/i3config.vim'
	call vundle#end()
" ===== KEY MAPPINGS =====
" Goyo (centered text) activated with <leader>+g
	map <leader>g :Goyo \| set linebreak<CR>

" Instead of switching b/w splits with ctrl-w then j, just ctrl-j
	noremap <C-J> <C-W><C-J>
	noremap <C-K> <C-W><C-K>
	noremap <C-L> <C-W><C-L>
	noremap <C-H> <C-W><C-H>

" Making copy/pasting texts easier
	vnoremap <C-c> "+y
	noremap <C-v> "+p

" Tabbed editing
	nnoremap <C-Left> :tabprevious<CR>
	nnoremap <C-Right> :tabnext<CR>

" Escape out of insert/visual mode by typing "jj" 
	inoremap jj <ESC>

" Reload vimr configuration file
	nnoremap <leader>rr :source $MYVIMRC<CR>

" i3config detection (for i3config syntax)
	aug i3config_ft_detection
		au!
		au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
	aug end

" Indentation
	set softtabstop=4
	set noexpandtab
	set shiftwidth=4
	set tabstop=4

" Make splitting occur on right and bottom
	set splitbelow splitright

" exrc allows Vim to source .vimrc file if it is present in working directory
	set exrc
