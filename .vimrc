set nocompatible

"##############################################
"##### Settings for Vundle ####################
"##############################################
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'reedes/vim-pencil'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
"Plugin 'valloric/youcompleteme'
Plugin 'sessionman.vim'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
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
"##############################################
"#### END : Settings for Vundle ###############
"##############################################

"##############################################
"########## Settings for Pandoc ###############
"##############################################

"##############################################
"#### END : Settings for Pandoc ###############
"##############################################

set ai            " Auto indent
set history=50		" keep 50 lines of command line history
set ruler		   " show the cursor position all the time
set showcmd		   " display incomplete commands
set showmode      " Show the mode you are in
set incsearch		" do incremental searching
set hlsearch      " highlight search text
set backup
set backupdir=~/.vimbackup,.
set directory=~/.vimbackup,.
set ignorecase
set smartcase
set sessionoptions=blank,buffers,curdir,help,options,tabpages,winsize
set switchbuf=useopen,usetab,split
set hidden
" Disable system bell
set visualbell t_vb=
set tabstop=4
set shiftwidth=4
set expandtab
set number
syntax enable
set backspace=indent,eol,start
set showmatch
set cursorline
"highlight Cursorline cterm=NONE
"highlight Cursorline ctermbg=7
set nrformats-=octal
colorscheme solarized
if has('gui_running')
    set background=dark
    set lines=35 columns=150
else
    set background=light
endif

" Working with splits
set wmh=0                 " Minimum window height.
set wmw=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
nmap <c-h> gT
nmap <c-l> gt
" Use space to open and close folds
nnoremap <silent> <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>
nnoremap <silent> <C-space> :exe 'silent! normal! zA'.(foldlevel('.')?'':'l')<cr>

let mapleader = ";"
" Some useful functions

" NERDTree
nmap <F2> :NERDTreeToggle<cr>
nmap <S-F2> :NERDTreeFind<cr>
nmap <F3> :TagbarToggle<cr>
nmap <S-F3> :call ToggleShowProjectPanel()<cr>
"
" 
nmap <F4> :call SaveProject()<cr>
nmap <S-F4> :call SaveAsProject("")<cr>

" Open scratch buffer in new tab
nmap <F6> :tabnew<cr>:set buftype=nofile<cr>
" Open scratch buffer in new split
nmap <S-F6> :new<cr>:set buftype=nofile<cr>

" Execute macro in buffer q
map <F7> @q
" Modify macro in buffer q
nmap <S-F7> :let @q="<C-r><C-r>q"

" Clear highlights
map <F8> :nohl<cr>
" If Syntax synchronisation gets confused.
map <S-F8> :syn sync fromstart<cr>

noremap <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .<cr>
inoremap <F11> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .<cr>
" Edit the .vimrc file and .vim directory in a new tab
map <F12> :e ~/.vimrc<cr>

" This is where my sessions will be saved.
let Session_path = "/data/sessions"

" Pretty nifty. Yanks to the clipboard, pastes from the clipboard
nnoremap <leader>yf maggVG"+y`azz
nnoremap <leader>yy "+yy
vnoremap <leader>y "+y
nnoremap <leader>p :set paste<cr>"+p:set nopaste<cr>

" Move to the next buffer
nmap <Tab> :bnext<cr>
" Move to the previous buffer
nmap <S-Tab> :ls<cr>:b
" Move to the alternate buffer
nmap <C-Tab> <C-^>
" Deletes the current buffer
nmap <C-X> :bdelete<cr>

" Mapping for CtrlP
" " Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Easy bindings for its various modes
nmap <leader>b :CtrlP<cr>
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


nmap <leader>fu :grep! <cword><cr>
nmap <leader>w W
let g:SuperTabDefaultCompletionType = "context"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"nmap <C-O> <C-W>gf
"let g:tex_flavor = 'latex'
"cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline_powerline_fonts = 1
"let g:airline_theme='powerlineish'
"let g:airline#extensions#syntastic#enabled = 1
"set laststatus=2
