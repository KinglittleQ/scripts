" ========================================================
" File: .vimrc
" -----
" Author: Chengqi Deng
" Email: checkdeng0903@gmail.com
" =======================================================



" =========================================================
" Vim pluggins
" =========================================================
" call plug#begin('~/.vim/plugged')

" Plug 'preservim/nerdtree'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'preservim/nerdcommenter'
" Plug 'jiangmiao/auto-pairs'

" call plug#end()



" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.

set ruler
set hlsearch
set incsearch
set ignorecase
set mouse=a
set encoding=utf-8 nobomb

set autowrite
set nobackup
" colorscheme peachpuff



" ========================================================
" Indent for different files
" ========================================================
setlocal ts=4 sw=4 sts=4 expandtab

autocmd Filetype c,cpp  setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype go     setlocal ts=4 sw=4 sts=0 noexpandtab



" ========================================================
" Move lines up or down
" ========================================================
noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <c-s-down> ddp
inoremap <c-s-up> <Esc>:m .-2<CR>==gi
inoremap <c-s-down> <Esc>ddpi
vnoremap <c-s-up> :m '<-2<CR>gv=gv
vnoremap <c-s-down> :m '>+1<CR>gv=gv


inoremap <c-o> <Esc>o



" =======================================================
" Tab at visual or normal mode
" =======================================================
nmap <tab> V>
nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv



" =======================================================
" select a word or a character
" =======================================================
inoremap <c-s-left> <Esc>v<s-left>
inoremap <c-s-right> <Esc>v<s-right>
noremap <c-s-left> v<s-left>
noremap <c-s-right> v<s-right>

inoremap <s-left> <Esc>v<left>
inoremap <s-right> <Esc>v<right>
noremap <s-left> v<left>
noremap <s-right> v<right>



" ======================================================
" Find and replace
" ======================================================
noremap <c-f> :%s/
inoremap <c-f> <Esc>:%s/


