" ===== PLUGGED
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'dylanaraps/wal.vim'
    Plug 'morhetz/gruvbox'
    Plug 'joshdick/onedark.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'tikhomirov/vim-glsl'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'mboughaba/i3config.vim'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-commentary'
    Plug 'lervag/vimtex'
    Plug 'tpope/vim-surround'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vim-pandoc/vim-pandoc-after'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'konfekt/fastfold'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'simeji/winresizer'
    Plug 'ronakg/quickr-cscope.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

    " Goyo configuration
    autocmd! User GoyoEnter nested set eventignore=FocusGained
    autocmd! User GoyoLeave nested set eventignore=

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
    let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
    let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
    let g:airline_powerline_fonts = 1
    let g:airline_theme='base16color'

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
    let g:vimtex_quickfix_ignore_filters = [
	\'Underfull',
	\'Overfull'
	\]

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
    set clipboard+=unnamedplus
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

    " Disable scratch window
    set completeopt-=preview

    " Like a filthy-normie, enable mouse interaction for nvim
    set mouse=a

    " Disable numbering for terminal buffer
    au TermOpen * setlocal nonumber norelativenumber

    " Coc has issues with backup files -- #649
    set nobackup
    set nowritebackup

    " Better display for messages
    set cmdheight=2

    " Quicker diagnostic messages
    set updatetime=300

    " Don't give |ins-completion-menu| messages
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

    " Haskell should not use tab indent
    autocmd FileType haskell setlocal shiftwidth=4 softtabstop=4 expandtab

    " Vimrc is setup with spaces, so just keep that format
    au FileType vim setlocal shiftwidth=4 softtabstop=4 expandtab

" ===== APPEARANCE
    " Colorscheme
    colorscheme wal

    set encoding=UTF-8

    " Set the line number to absolute-relative number
    set number relativenumber

    " Show dots for trailing whitespace and pipe for each tabs
    set list lcs=trail:·,tab:>-

    " Highlight 80th column
    set cc=80

    " Indentation
    set noexpandtab tabstop=8 shiftwidth=8 softtabstop=0

    " NVim by default returns to terminal with block cursor, which is
    " diff from what I have (underline). So, fix that
    au VimLeave * set guicursor=a:hor25-blinkon175

    " Automatically delete all trailing whitespace on save
    au BufWritePost * %s/\s\+$//e

" ===== KEY MAPPINGS
    " Set the leader key to space
    let mapleader = " "

    " Goyo (distraction-free text editor) activated with <leader>g
    map <leader>G :Goyo \| set linebreak<CR>

    " Spell-check set to <leader>o. 'o' for 'orthography'
    map <leader>o :setlocal spell! spelllang=en_ca<CR>

    " Copy selected text to system clipboard (requires gvim installed)
    vnoremap <C-c> "*Y :let @+=@*<CR>
    map <C-p> "+P

    " Toggle NERDTree
    map <C-L> :NERDTreeFocus<CR>

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

    " Close quickfix window
    noremap <C-x> :ccl<CR>

    " Tabbed editing
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>

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

    " Bring up built-in terminal
    nnoremap <leader>~ :vsp term://zsh<CR>
    nnoremap <leader>` :sp term://zsh<CR>

    " Maneuver around buffers
    nmap <leader>l :bnext<CR>
    nmap <leader>h :bprevious<CR>
    nmap <leader>q :bp <BAR> bd #<CR>

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin.
    inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
	    let col = col('.') - 1
	    return !col || getline('.')[col - 1] =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Cscope related
    nmap <C-g> :cscope find g
