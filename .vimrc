set nocompatible

let mapleader = ";"
let maplocalleader = ','
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
Plug 'albfan/nerdtree-git-plugin'
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
Plug 'mhinz/vim-grepper'
Plug 'lervag/vimtex'
Plug 'jalvesaq/nvim-r'
Plug 'vim-scripts/dbext.vim'
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
set sessionoptions=blank,buffers,curdir,help
set switchbuf=useopen,usetab
set hidden
" Disable system bell
set visualbell t_vb=
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=100
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
    set guioptions-=T
    set guioptions-=m
    colorscheme solarized
else
    " Here we can set some options if we are not using the gui
    set background=dark
endif
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
map <A-F8> :syn sync fromstart<cr>
" Show hidden chararcters and trailing whitespace
map <S-F8> :set invlist<cr>
" Allow buffer to be connected to a database
nmap <F10> ;sbp
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

" Maps to navigate errors
nmap <C-Right> :lnext<cr>
nmap <C-Left> :lprevious<cr>
nmap <C-Down> :lclose<cr>
" Move to the next buffer
nmap <Tab> :bnext<cr>
" Move to the previous buffer
nmap <S-Tab> :bprevious<cr>
" List open buffers and give switching option
nmap <C-Q> :CtrlPBuffer<cr>
" Move to the alternate buffer
nmap <C-Tab> <C-^>
" Deletes the current buffer
nmap <C-X> :bdelete<cr>
nmap <leader>fu :Grepper -tool git -noprompt -cword<cr>
nmap <leader>gg :Grepper -tool git<cr>
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
let g:ultisnips_python_style="google"

"########### Airline ##############
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

"########### Pandoc ##############
let g:pandoc#modules#disabled = ["chdir"]

"########### Latex ##############
let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled = 1
let g:vimtex_format_enabled = 1
let g:vimtex_compiler_latexmk = { 'build_dir' : './texoutput', }
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'
"########### XML ##############
let g:xml_syntax_folding = 1
"########### Syntastic ##############
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["python"] }

"########### NerdTree ##############
let g:NERDTreeIgnore = ['^build$','^dist$','.egg-info$','^htmlcov$','^__pycache__$','.pyc$']
"########### NVim-R ##############
"let R_in_buffer = 0
"########### YCM ##############
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_filetype_blacklist = {
        \ 'tagbar': 1,
        \ 'notes': 1,
        \ 'netrw': 1,
        \ 'unite': 1,
        \ 'text': 1,
        \ 'vimwiki': 1,
        \ 'infolog': 1,
        \ 'mail': 1
        \}
"########### dbext ##############
let g:dbext_default_profile_pss_themis = 'type=ORA:user=pss:passwd=l3dz3pp3l1n:srvname=themis'
let g:dbext_default_profile_powi_themis = 'type=ORA:user=powi:passwd=power:srvname=themis'
let g:dbext_default_profile_roetsm_themis = 'type=ORA:user=roetsm:passwd=anduril1:srvname=themis'
let g:dbext_default_profile_system_themis = 'type=ORA:user=system:passwd=themis:srvname=themis'
let g:dbext_default_profile_webmaster_phoenix = 'type=ORA:user=webmaster:passwd=web4px:srvname=phoenix'
let g:dbext_default_profile_mdmsstaging_mdms = 'type=ORA:user=mdms_staging:passwd=zer45tgdinv:srvname=mdms'
