" ===== PLUGGED
call plug#begin('~/.local/share/nvim/plugged') 
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'mboughaba/i3config.vim'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-commentary'
    Plug 'lervag/vimtex'
    Plug 'scrooloose/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vim-pandoc/vim-pandoc-after'
    Plug 'Shougo/deoplete.nvim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'lighttiger2505/deoplete-vim-lsp'
    Plug 'konfekt/fastfold'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'simeji/winresizer'
call plug#end()

    " i3config detection (for i3config syntax)
    aug i3config_ft_detection
        au!
        au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
    aug end

    " Fzf settings
    let g:fzf_layout = { 'down': '~40%' }
    let g:fzf_layout = { 'window': 'enew' }
    let g:fzf_layout = { 'window': '-tabnew' }
    let g:fzf_layout = { 'window': '10new' }
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " vim-airpline settings
    let g:airline_theme = 'gruvbox'
    let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
    let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

    " Vim-pandoc settings
    let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
    let g:pandoc#command#autoexec_on_writes = 1
    let g:pandoc#command#autoexec_command = "Pandoc pdf"
    let g:pandoc#folding#level = 2
    let g:pandoc#folding#mode = "relative"
    let g:pandoc#after#modules#enabled = ["fastfold"]
    " When pandoc-execute is the only buffer, close vim
    augroup vim_pandoc_close
        au!
        au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "pandoc-execute"|q|endif
    augroup END

    " Vimtex settings
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_compiler_progname = 'nvr'
    let g:vimtex_fold_enabled = 1
    let g:tex_flavor = 'xelatex'

    let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
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
        \ ],
        \}

    let g:vimtex_compiler_latexmk_engines = {
        \ '_'                   : '-xelatex',
        \ 'pdflatex'            : '-pdf',
        \ 'dvipdfex'            : '-pdfdvi',
        \ 'lualatex'            : '-lualatex',
        \ 'xelatex'             : '-xelatex',
        \ 'context (pdftex)'    : '-pdf -pdflatex=texexec',
        \ 'context (luatex)'    : '-pdf -pdflatex=context',
        \ 'context (xelatex)'   : '-pdf -pdflatex=''texexec --xtx''',
        \}

    " Deoplete settings
    let g:deoplete#enable_at_startup = 1

    " LSP settings
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_preview_keep_focus = 1
    let g:lsp_signs_enabled = 1
    let g:lsp_signs_error = {'text': '✗'}
    let g:lsp_signs_warning = {'text': '‼'}
    highlight link LspErrorText GruvboxRedSign
    highlight clear LspWarningLine

    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'

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

" ===== BASIC SETUP
    set nocompatible
    filetype plugin indent on
    syntax on
    set clipboard=unnamed
    set ttyfast
    " set lazyredraw
    set wildmenu
    set incsearch
    set hlsearch
    set hidden
    set laststatus=2
    set switchbuf=useopen,usetab
    set backspace=indent,eol,start

    " Make splitting occur on right and bottom
    " This makes more intuitive sense compared to the default setting of vim
    set splitbelow splitright

    " exrc allows Vim to source the source file if it is in working dir
    set exrc

	" Like a filthy-normie, enable mouse interaction for nvim
	set mouse=a

" ===== APPEARANCE
    " Colorscheme
    set background=dark
    colorscheme gruvbox
    let g:gruvbox_italic = 1

    " Set the line number to absolute-relative number
    set number relativenumber

    " Show dots for trailing whitespace and pipe for each tabs
    set list lcs=trail:·,tab:>-

    " Highlight 80th column
    set cc=80

    " Indentation
	set noexpandtab tabstop=8 shiftwidth=8 softtabstop=0

    au VimLeave * set guicursor=a:hor25-blinkon175

" ===== KEY MAPPINGS
    " Set the leader key to space
    let mapleader = " "

    " Goyo (distraction-free text editor) activated with <leader>g
    map <leader>g :Goyo \| set linebreak<CR>

    " Instead of switch b/w splits with ctrl-w then j, just alt-j
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    tnoremap <Esc> <C-\><C-n>

    " Nagivation is easier
    noremap j gj
    noremap k gk

    " Tabbed editing
	nnoremap <C-Left> :tabprevious<CR>
	nnoremap <C-Right> :tabnext<CR>

    " Escape out of insert/visual mode by typing "jj" 
    inoremap jj <ESC>

    " Reload vimr configuration file
    nnoremap <leader>rr :source $MYVIMRC<CR>

    " FZF mappings
    nnoremap <C-F> :Files<CR>
    nmap <leader>b :Buffers<CR>
    nmap <leader>t :Tags 

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
    " nnoremap <leader>b <C-^>
    " nnoremap <leader>h :LspHover<CR>

    " Maneuver around buffers
    nmap <leader>l :bnext<CR>
    nmap <leader>h :bprevious<CR>
    nmap <leader>q :bp <BAR> bd #<CR>
    " nmap <leader>bl :ls<CR>
