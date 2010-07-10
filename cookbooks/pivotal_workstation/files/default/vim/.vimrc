set nocompatible  "Because old VI is crazy
syntax on         "Because you like highlighting

set number        "Because you like line numbers
set ruler         "Because you like knowing where the cursor is
set list          "Because I like seeing weird characters
set nowrap        "Show lines on one line

set hidden
set wildmenu
set wildmode=list:longest

set showmatch
set hlsearch
set showcmd    " display incomplete commands
set incsearch

set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action

set visualbell
set virtualedit=all

set t_Co=256 " 256 colors
set background=dark
colorscheme ir_black

call pathogen#runtime_append_all_bundles()

filetype plugin indent on
au BufRead,BufNewFile *.thor *.god set filetype=ruby

set tabstop=2
set smarttab
set autoindent
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2
set fo-=t

set nobackup       #no backup files
set nowritebackup  #only in case you don't want a backup file while editing
set noswapfile     #no swap files

autocmd VimEnter * exe 'NERDTree' | wincmd l

" Ruby weird character shortcuts
" imap uu _
" imap hh =>
" imap aa @

map <Leader>f <Plug>Ack
