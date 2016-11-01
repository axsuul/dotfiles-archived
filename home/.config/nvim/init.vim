set nocompatible        " be iMproved
filetype off		" Required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Core plugins
Plugin 'VundleVim/Vundle.vim'	" This needs to be first
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'

" Main plugins
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'	" Git wrapper
Plugin 'sjl/vitality.vim'	" Play nicely with iTerm2 + tmux

" Language plugins
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'

Plugin 'scrooloose/nerdtree'

call vundle#end()            	" Finish plugins
filetype plugin indent on	" Don't ignore plugin indent changes

" Settings
set clipboard=unnamed		" Use system clipboard

" Display
set title
set relativenumber
set number		" Hybrid line number
set ruler		" Display cursor position
set wrap		" Wrap lines when too long
set scrolloff=3		" Display at least 3 lines around cursor

" Visual 
set hidden		" Hide buffer (file) instead of abandoning when switching to another buffer
set guifont=Monaco:h13
set guioptions-=T 	" Disable toolbar 

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

" Windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" Quickload config 
nnoremap <leader>v :e  ~/.config/nvim/init.vim<CR>
nnoremap <leader>V :tabnew  ~/.config/nvim/init.vim<CR>

" Line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<CR>	

" Change cursor shape and highlight line in insert mode 
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1	" Support cursor change in neovim via vitality plugin
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
set guicursor=a:blinkon1		" Blink cursor
