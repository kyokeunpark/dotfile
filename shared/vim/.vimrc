" ===== PLUGINS =====
" Setting up Vundle
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
        Plugin 'VundleVim/Vundle.vim'
		Plugin 'morhetz/gruvbox'
		Plugin 'junegunn/goyo.vim'
		Plugin 'junegunn/fzf'
		Plugin 'junegunn/fzf.vim'
		Plugin 'mboughaba/i3config.vim'
		Plugin 'godlygeek/tabular'
        Plugin 'tpope/vim-commentary'
		Plugin 'lervag/vimtex'
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'tpope/vim-surround'
        "Plugin 'plasticboy/vim-markdown'
        Plugin 'vim-pandoc/vim-pandoc'
        Plugin 'vim-pandoc/vim-pandoc-syntax'
        Plugin 'vim-pandoc/vim-pandoc-after'
        Plugin 'Shougo/deoplete.nvim'
        Plugin 'roxma/nvim-yarp'
        Plugin 'roxma/vim-hug-neovim-rpc'
        Plugin 'prabirshrestha/async.vim'
        Plugin 'prabirshrestha/vim-lsp'
        Plugin 'lighttiger2505/deoplete-vim-lsp'
        Plugin 'konfekt/fastfold'
	call vundle#end()

" i3config detection (for i3config syntax)
	aug i3config_ft_detection
		au!
		au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
	aug end

" Default fzf layout
	let g:fzf_layout = { 'down': '~40%' }

" Vim-pandoc settings
    let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
    let g:pandoc#command#autoexec_on_writes = 1
    let g:pandoc#command#autoexec_command = "Pandoc pdf"
    let g:pandoc#folding#level = 2
    let g:pandoc#folding#mode = "relative"
    "let g:pandoc#modules#disabled = ["folding", "keyboard", "completion"]
    let g:pandoc#after#modules#enabled = ["fastfold"]

" Vimtex settings
	let g:vimtex_view_method = 'zathura'

    let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'jobs',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '-xelatax',
        \ ],
        \}

" Deoplete settings
    let g:deoplete#enable_at_startup = 1

    " Disable Deoplete if dealing with markdown due to slowdown
    au Filetype markdown let g:deoplete#enable_at_startup = 0

" LSP settings
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signs_error = {'text': '✗'}
    let g:lsp_signs_warning = {'text': '‼'}
    highlight link LspErrorText GruvboxRedSign
    highlight clear LspWarningLine

    " C++/C
    if executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
    endif

    " Python
    if (executable('pyls'))
        let s:pyls_path = fnamemodify(g:python_host_prog, ':h') . '/'. 'pyls'
        augroup LspPython
            autocmd!
            autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python']
          \ })
        augroup END
    endif

" Using Tabularize, make sure the tables are always aligned
    inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

    function! s:align()
        let p = '^\s*|\s.*\s|\s*$'
        if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~#p || getline(line('.')+1) =~# p)
            let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
            let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
            Tabularize/|/l1
            normal! 0
            call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
        endif
    endfunction

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

" Setting filetype
    au BufNewFile,BufRead *.md set filetype=markdown

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
	set expandtab
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
	let g:netrw_altv = 1

" Hide dotfiles and gitignores
    let g:netrw_list_hide = netrw_gitignore#Hide()
    let g:netrw_list_hide .= ',\(\^\|\s\s\)\zs\.\S\+)'

" If netrw is the only buffer, close vim
	augroup netrw_close
		autocmd!
		autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
	augroup END

" ===== CUSTOM COMMANDS =====
" Make tags using ctags - this helps you trace through functions
    command! MakeTag !ctags -R .

" Set spelling
    command! Sp set spell spelllang=en_us
    command! Nsp set nospell

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
	nnoremap <leader>nn :Lexplore<CR>

" Toggle fzf find
    nnoremap <C-F> :Files<CR>

" Set ctrl-backspace to delete a word in insert mode
" For some reason, just remapping <C-BS> to <C-W> does not work in terminal.
" Following is a workaround
    noremap! <C-BS> <C-w>
    noremap! <C-h> <c-w>

" Tabularize mapping
    if exists(":Tabularize")
        nmap <leader>a= :Tabularize /=<CR>
        vmap <leader>a= :Tabularize /=<CR>
    endif

" LSP mapping
    nnoremap <leader>d :LspDocumentDiagnostics<CR>
    nnoremap <leader>p :LspPeekDefinition<CR>
    nnoremap <leader>P :LspDefinition<CR>
    nnoremap <leader>b <C-^>
    nnoremap <leader>h :LspHover<CR>
