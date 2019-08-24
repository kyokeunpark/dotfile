" ===== PLUGINS =====
" Setting up Vundle
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
		Plugin 'VundleVim/Vundle.vim'
		Plugin 'junegunn/goyo.vim'
		Plugin 'junegunn/fzf'
		Plugin 'junegunn/fzf.vim'
		Plugin 'mboughaba/i3config.vim'
		Plugin 'godlygeek/tabular'
		Plugin 'plasticboy/vim-markdown'
		Plugin 'morhetz/gruvbox'
	call vundle#end()

" i3config detection (for i3config syntax)
	aug i3config_ft_detection
		au!
		au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
	aug end

" Default fzf layout
	let g:fzf_layout = { 'down': '~40%' }

" ===== BASIC SETUP =====
" Some basic setup
	set nocompatible
	filetype off
	filetype plugin indent on
	syntax on
	set clipboard=unnamed
	set ttyfast
	set lazyredraw
	set wildmenu
	set incsearch
	set hlsearch
	set hidden
	set laststatus=2
	set switchbuf=useopen,usetab
	set backspace=indent,eol,start

" Appearance
	" Colorscheme
	set background=dark
	colorscheme gruvbox
	let g:gruvbox_italic = 1
	" Set the line number to absolute-relative number
	set number
	set relativenumber
	" Show dots for trailing whitespace and pipe for each tabs
	set list lcs=trail:·,tab:\ \ \|
	" Highlight 80th column
	set cc=80

" Enable auto-completion on vim commands
	set wildmode=longest,list,full

" Indentation
	set softtabstop=4
	set noexpandtab
	set shiftwidth=4
	set tabstop=4

" Make splitting occur on right and bottom
" This makes more intuitive sense compared to the default setting of vim
	set splitbelow splitright

" exrc allows Vim to source .vimrc file if it is present in working directory
	set exrc

" ===== NETRW (FILE EXPLORER) =====
" Removing the permanant banner as it is useless
	let g:netrw_banner = 0

" Set width of the directory explorer (25 == 25%)
	let g:netrw_winsize = 25

" Set the style of the netrw list (3 == tree style)
	let g:netrw_liststyle = 3

" Make it so that opening file from netrw opens it on previous window
	let g:netrw_browse_split = 4

" Make it so that netrw vertical splits to the right instead of left
	let g:netrw_altv=1

" Automatically open netrw in vertical split when entering Vim
" 	augroup ProjectDrawer
" 		autocmd!
" 		autocmd VimEnter * :Lexplore
" 		autocmd VimEnter * :wincmd p
" 	augroup END

" If netrw is the only buffer, close vim
	augroup netrw_close
		autocmd!
		autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
	augroup END

" ===== KEY MAPPINGS =====
" Set the leader key to space
	let mapleader = " "

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

" Toggle netrw
	nnoremap <C-N> :Lexplore<CR>

" Toggle fzf find
	nnoremap <C-F> :Files<CR>
