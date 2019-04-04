" General


if empty(glob('~/.vim/pack/plugins/start'))
  silent !git clone https://github.com/rust-lang/rust.vim
    \ ~/.vim/pack/plugins/start/rust.vim

  silent !git clone https://github.com/elixir-lang/vim-elixir.git
    \ ~/.vim/pack/plugins/start/vim-elixir.vim

  silent !git clone https://github.com/pangloss/vim-javascript
    \ ~/.vim/pack/plugins/start/vim-javascript.vim

  silent !git clone https://github.com/crusoexia/vim-monokai
    \ ~/.vim/pack/plugins/start/vim-monokai.vim

  silent !git clone https://github.com/scrooloose/syntastic
    \ ~/.vim/pack/plugins/start/syntastic.vim

  silent !git clone https://github.com/scrooloose/nerdtree
    \ ~/.vim/pack/plugins/start/nerdtree.vim

  silent !git clone https://github.com/airblade/vim-gitgutter
    \ ~/.vim/pack/plugins/start/vim-gitgutter.vim

  silent !git clone https://github.com/itchyny/lightline.vim
    \ ~/.vim/pack/plugins/start/lightline.vim

  silent !git clone https://github.com/editorconfig/editorconfig-vim
    \ ~/.vim/pack/plugins/start/editorconfig.vim
endif

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


" Monokai Theme and lightline

syntax on
set cursorline
set background=dark
set laststatus=2
colorscheme monokai

highlight clear SignColumn

" Scrolling

set scrolloff=4
set sidescrolloff=15
set sidescroll=1

" Completion

set wildmenu
set wildmode=list:longest
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn

" Ctrl-P

let g:ctrlp_show_hidden=1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 6
