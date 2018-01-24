" General

set nocompatible
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set laststatus=2                "Always display the status line
set hidden                      "Hide buffer instead of closing it
set pastetoggle=<F2>            "Paste without being smart
set mouse=a

" Wrapping

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" Folding

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" Plugins neovim

call plug#begin('~/.nvim/plugged')

" Generic

Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'rking/ag.vim'

" Git

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax hightlighting & colors

Plug 'scrooloose/syntastic'
Plug 'sickill/vim-monokai'

" Completion & snippets

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" JavaScript

Plug 'pangloss/vim-javascript'
Plug 'marijnh/tern_for_vim'

" Other

Plug 'tpope/vim-markdown'
Plug 'mattn/emmet-vim'

"  Rust, Elixit, Erlang

Plug 'rust-lang/rust.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-erlang/vim-erlang-runtime'

call plug#end()


" Swap file and backups

set noswapfile
set nobackup
set nowb
au FocusLost * :wa

" Indentation

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Enable loading the plugin/indent files for specific file types

filetype plugin indent on

" Mapping

map <C-a> GVgg
map <C-n> :enew
map <C-o> :e . <Enter>
map <C-s> :w <Enter>
map <C-c> y
map <C-v> p
map <C-x> d
map <C-z> u
map <C-t> :tabnew <Enter>
map <C-i> >>
map <C-w> :close <Enter>
map <C-W> :q! <Enter>

" Search

set hlsearch
set incsearch
set ignorecase
set showmatch
set smartcase


" Monokai Theme

syntax on
set cursorline
set background=dark
colorscheme monokai

highlight clear SignColumn

" Scrolling

set scrolloff=4
set sidescrolloff=15
set sidescroll=1

" Completion

set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn

" Ctrl-P

let g:ctrlp_show_hidden=1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 6

" Expand snippets

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"


" NerdTree:

autocmd vimenter * NERDTree
