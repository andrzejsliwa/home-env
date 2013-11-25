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
