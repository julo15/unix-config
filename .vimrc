set nocompatible            " required for vundle
filetype off                " required for vundle

" set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

" all plugins must be added before the following line
call vundle#end()           " required for vundle
filetype plugin indent on   " required for vundle

" binds
imap kj <Esc>
imap <S-Tab> <C-d>
vmap < <gv
vmap > >gv
map <Tab> >>
map <S-Tab> <<
map S Mzo<esc>`z
map s mzO<esc>`z
map , ~
map <F3> :set syntax=xml<Enter>
map <F4> :cd %:p:h<Enter>:pwd<Enter>

" settings
set ignorecase              " case-insensitive search
set smartcase               " case-insensitive unless there is a capital
set incsearch               " find as you type search
set wrap                    " word wrap
set nobackup                " no backup file
set noswapfile              " no swap file
set nu                      " show line numbers
set autoindent              " indent
set guioptions-=T           " no toolbar
set expandtab               " insert spaces instead of tabs
set tabstop=4               " # of spaces that a tab becomes
set shiftwidth=4            " # of spaces for indentation
set hlsearch                " highlight search result
syntax enable

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd InsertEnter,InsertLeave * set cul!

" color
hi Visual ctermbg=8
hi MatchParen ctermbg=095
hi Search ctermbg=21
hi CursorLine cterm=none ctermbg=234

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
