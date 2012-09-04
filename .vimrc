set nocompatible               " be iMproved

" Vundle
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'kien/ctrlp.vim'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"

" color schemes
Bundle 'altercation/vim-colors-solarized'

" Settings
set guifont=Monaco:h9:cANSI
set guioptions-=T "remove toolbar 
colorscheme solarized
