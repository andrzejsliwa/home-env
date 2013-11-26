let g:author = 'Andrzej Sliwa <andrzej.sliwa@i-tool.eu>'
" Must have {{{
    set backspace=indent,eol,start
" }}} Must have

" Prepare for loading plugins {{{
    set nocompatible
    filetype off
" }}} Prepare for loading plugins

" Enable syntax highlighting and file types detection {{{
    syntax enable
    filetype plugin indent on
" }}}  Enable syntax highlighting and file types detection

let $VIM       = expand('~/.vim/')
let $TMP       = expand($VIM . 'tmp/')
let $BUNDLES   = expand($VIM . 'bundle/')
let $NEOBUNDLE = expand($BUNDLES . 'neobundle.vim')

if !isdirectory($TMP)
    call mkdir($TMP, "p")
endif

if has('vim_starting')
    set runtimepath+=$NEOBUNDLE
endif

call neobundle#rc($BUNDLES)
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'andrzejsliwa/vim-hemisu'
NeoBundle 'Shougo/vimproc', { 'build': {
        \   'windows': 'make -f make_mingw32.mak',
        \   'cygwin': 'make -f make_cygwin.mak',
        \   'mac': 'make -f make_mac.mak',
        \   'unix': 'make -f make_unix.mak',
        \  } }

    " UNITE !!!
    NeoBundle 'Shougo/unite.vim', { 'depends':
        \ ['tsukkee/unite-tag','Shougo/unite-outline'] } " Unite {{{
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        call unite#filters#sorter_default#use(['sorter_rank'])
        if executable ('ag')
            let g:unite_source_grep_command = 'ag'
            let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
            let g:unite_source_grep_recursive_opt = ''
        elseif executable('ack')
            let g:unite_source_grep_command='ack'
            let g:unite_source_grep_default_opts='--no-heading --no-color -a'
            let g:unite_source_grep_recursive_opt=''
        endif
        let g:unite_data_directory='~/.vim/.cache/unite'
        let g:unite_source_file_rec_max_cache_files=5000
        let g:unite_enable_start_insert = 1
        let g:unite_prompt='» '
        let g:unite_enable_ignore_case = 1
        let g:unite_enable_smart_case = 1
        nmap <space> [unite]
        nnoremap [unite] <nop>
        nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr>
        nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async<cr>
        nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=lines line<cr>
        nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<cr>
        nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=processes process<cr>
        nnoremap <silent> [unite]n :<C-u>Unite file file/new<cr>
        nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search grep:.<cr>
        nnoremap <silent> [unite]? :<C-u>execute 'Unite -buffer-name=search grep:.::' . expand("<cword>")<cr>
    " }}} Unite
    NeoBundle 'Shougo/unite-outline' " Unite outline {{{
        nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<cr>
    " }}} Unite outline
    NeoBundle 'Shougo/unite-help' " Unite help {{{
        nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
        nnoremap <silent> [unite]H :<C-u>UniteWithCursorWord -buffer-name=help help<CR>
    " }}} Unite help
    NeoBundle 'thinca/vim-unite-history' " Unite history {{{
        let g:unite_source_history_yank_enable=1
        nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yank history/yank<cr>
    " }}}
    NeoBundle 'Shougo/vimfiler' " {{{
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_safe_mode_by_default = 0
        let g:vimfiler_ignore_pattern = ''
        nnoremap <silent> [unite]e :<C-u>VimFiler<cr>
    " }}}

NeoBundleCheck

set background=dark
colorscheme hemisu

" Backup & Swap {{{
    set nobackup
    set nowritebackup
    set noswapfile
" }}} Backup & Swapave

" General settings {{{
    " speedup
    set ttyfast
    set synmaxcol=200
    " encoding
    set encoding=utf-8
    set fileformats=unix
    " hide buffers when not displayed
    set hidden
    set ttimeout
    set ttimeoutlen=10
    set notimeout
    " enable status
    set laststatus=2
    " enable relative numbering
    set relativenumber
    " configure wrapping
    set wrap
    set formatoptions+=qrn1
    set formatoptions-=o
    " configure buffer splits
    set splitright
    set splitbelow
    " display
    set display=lastline
    set more
    set report=2
    " tabs & indentation
    set smartindent
    set expandtab
    set tabstop=4
    set shiftwidth=4
    set pastetoggle=<F3>
" }}} General settings

let g:zsh_path = "/usr/local/bin/zsh"
if filereadable(g:zsh_path)
    set shell=g:zsh_path
else
    set shell="/bin/zsh"
endif

" Custom functions {{{
    " Strip trainling whitespaces {{{
        function! <SID>StripTrailingWhitespaces()
            " Preparation: "ave last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " Do the business:
            %s/\s\+$//e
            " Clean up:
            " restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
    " }}} Strip trainling whitespaces
" }}} Custom functions

" Auto commands {{{
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
    augroup FileTypes
        au!
        au FileType ruby    setlocal shiftwidth=2 tabstop=2
        au FileType snippet setlocal shiftwidth=4 tabstop=4
        au FileType erlang  setlocal shiftwidth=4 tabstop=4
        au FileType make    setlocal noexpandtab shiftwidth=4 tabstop=4
        au FileType snippet setlocal expandtab shiftwidth=4 tabstop=4
        au BufNewFile,BufRead Makefile set filetype=make
        au BufNewFile,BufRead *.app.src set filetype=erlang
        au BufNewFile,BufRead *.config  set filetype=erlang
        au BufNewFile,BufRead .vimrc set filetype=vim
    augroup END
" }}} Auto commands
"
set list
set listchars=
set lcs+=tab:>-
set lcs+=extends:›
set lcs+=precedes:‹
set lcs+=nbsp:·
set lcs+=trail:·
