set nocompatible

"##############################################
"##### Settings for vim-plug ####################
"##############################################
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'reedes/vim-pencil'
Plug 'shawncplus/phpcomplete.vim'
"Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'valloric/youcompleteme'
"Plug 'sessionman.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'mileszs/ack.vim'
call plug#end()
"##############################################
"#### END : Settings for vim-plug ###############
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
set sessionoptions=blank,buffers,curdir,help,winsize,winpos,resize
set switchbuf=useopen,usetab
set hidden
" Disable system bell
set visualbell t_vb=
set tabstop=4
set shiftwidth=4
set expandtab
set number
set backspace=indent,eol,start
set showmatch
set cursorline
set completeopt=menuone
set nrformats-=octal
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
if has('gui_running')
    set background=dark
    set lines=35 columns=150
else
    " Here we can set some options if we are not using the gui
    set background=dark
endif
colorscheme solarized
set wmh=0                 " Minimum window height.
set wmw=0

"Remap <esc>
inoremap jk <esc>
inoremap <esc> <nop>


" Working with splits
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
" Use space to open and close folds
nnoremap <silent> <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>
nnoremap <silent> <C-space> :exe 'silent! normal! zA'.(foldlevel('.')?'':'l')<cr>

let mapleader = ";"
" Some useful functions

nnoremap <S-F1> :vert bo help myhelp<cr>
" NERDTree
nmap <F2> :NERDTreeToggle<cr>
nmap <S-F2> :NERDTreeFind<cr>
" Tag bar
nmap <F3> :TagbarToggle<cr>
nmap <S-F3> :UltiSnipsEdit<cr>
" Saving a project/session 
nmap <F4> :call SaveProject(1)<cr>
nmap <S-F4> :call SaveAsProject("")<cr>
" Project/Session panel
nmap <F5> :call ToggleShowProjectPanel()<cr>
nmap <S-F5> :call NextProjectPanelContent()<cr>
" Scratch buffer
" New tab
nmap <S-F6> :tabnew<cr>:set buftype=nofile<cr>
" New horizontal split
nmap <F6> :new<cr>:set buftype=nofile<cr>
" Execute macro in buffer q
map <F7> @q
" Modify macro in buffer q
nmap <S-F7> :let @q="<C-r><C-r>q"
" Clear highlights
map <F8> :nohl<cr>
" If Syntax synchronisation gets confused.
map <C-F8> :syn sync fromstart<cr>
" Show hidden chararcters and trailing whitespace
map <S-F8> :set invlist<cr>
" Building and running
nmap <F9> :call Make()<cr>
nmap <S-F9> :call RunProgram()<cr>
" Generating tags
noremap <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .<cr>
inoremap <F11> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .<cr>
" Edit the .vimrc file and .vim directory in a new tab
map <F12> :e ~/.vimrc<cr>
map <S-F12> :source ~/.vimrc<cr>

cnoreabbrev help vert bo help 

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
nmap <leader>fu :Ack! <cword><cr>
nmap <leader>w W

" This is where my sessions will be saved.
let Session_path = "/data/Dropbox/sessions"
"########### Fugitive ##############
nmap <leader>gs :Gstatus<cr>
nmap <leader>gd :Gvdiff<cr>
"########### CtrlP ##############
" " Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_working_path_mode = 'r'

"########### UltiSnips ##############
let g:UltiSnipsExpandTrigger="<C-tab>"
let g:UltiSnipsListSnippets="<S-tab>"
let g:UltiSnipsEditSplit="vertical"

"########### Airline ##############
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

"########### Ack ##############
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack!

