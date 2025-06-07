" Basic settings
set nocompatible
set number
set relativenumber
set ruler
set showcmd
set incsearch
set hlsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set wrap
set linebreak
set scrolloff=5

" Enable syntax highlighting
syntax enable

" Enable file type detection
filetype plugin indent on

" Colors
set background=dark

" Key mappings
let mapleader = ","

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>
