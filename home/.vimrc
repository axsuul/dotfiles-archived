set nocompatible        " be iMproved
filetype off		" Required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'	" This needs to be first
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'

call vundle#end()            	" Finish plugins
filetype plugin indent on	" Don't ignore plugin indent changes

" Display
set title
set number		" Display line numbers
set ruler		" Display cursor position
set wrap		" Wrap lines when too long
set scrolloff=3		" Display at least 3 lines around cursor

" Visual 
set hidden		" Hide buffer (file) instead of abandoning when switching to another buffer
set guifont=Monaco:h13
set antialias
set guioptions=T 	" Enable toolbar 

" Search
set ignorecase		" Ignore case when searching
set smartcase		" Only enable case-sensitive search if there's uppercase
set incsearch		" Highlight search results while typing
set hlsearch		" Highlight search results

" Noise
set visualbell		" Prevent from beeping
set noerrorbells	" Likewise

" Keyboard
set backspace=indent,eol,start	" Backspace behaves as expected

" Colors
syntax enable
set background=dark
colorscheme solarized
