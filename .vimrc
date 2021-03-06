set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YouCompleteMe
"Plugin 'file:///home/kasin/.vim/bundle/YouCompleteMe'
Plugin 'ycm-core/YouCompleteMe'

Plugin 'vim-latex/vim-latex'

Plugin 'vim-syntastic/syntastic'

Plugin 'scrooloose/nerdtree'

Plugin 'rdnetto/YCM-Generator'

"Plugin 'jnurmine/Zenburn'

Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Plugin 'dikiaap/minimalist'

Plugin 'sheerun/vim-polyglot'

Plugin 'haya14busa/incsearch.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Set the linenumbers to true
set number

" Set the tab spaces from 8 to 4
set tabstop=4
set shiftwidth=4
set noexpandtab

set colorcolumn=100

" Set the encoding type
"set enc=utf-8
"set fileencoding=utf-8
"set fileencodings=ucs-bom,utf8,prc

" Set syntax highlighting to on
syntax on
set t_Co=256
" Set the color scheme
colorscheme minimalist 

highlight Pmenu ctermfg=2 ctermbg=8 guifg=#ffffff guibg=#0000ff

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Enable mouse support
set mouse=a
