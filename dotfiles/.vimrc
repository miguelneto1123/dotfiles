" Syntax highlighting
syntax on

" Tab
set tabstop=4
" Effective tab while editing
set softtabstop=4

" Line numbering
set number

" Cursor line highlight
set cursorline

" File type specific indent
filetype indent on

" Autocomplete menu
set wildmenu

" Redraw tweak
set lazyredraw

" Highlight matching brackets
set showmatch

" Search tweaks
set incsearch
set hlsearch
" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Movement key bindings
nnoremap j gj
nnoremap k gk

" Backspacing
set backspace=indent,eol,start
