
"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1


"---------------------------------------------
"---------------------------------------------
" This is my own stuff
" --------------------------------------------
" --------------------------------------------

set cindent
set foldcolumn=4	

compiler perl

imap <buffer> sub1 sub ^<cr>{<cr>^<cr>}<Esc>3k^;n
imap <buffer> sub2 sub ^<cr>{<cr>my (^) = @_;<cr>^<cr>}<Esc>4k^;n
imap <buffer> sub3 sub ^<cr>{<cr>my $this = shift;<cr>my (^) = @_;<cr>^<cr>}<Esc>5k^;n
imap <buffer> for1 for (^;^;^) {<cr>^<cr>}<cr>^<Esc>3k^;n
imap <buffer> while1 while (^) {<cr>^<cr>}<cr>^<Esc>3k^;n
imap <buffer> new1 sub new<cr>{<cr>my $classname = shift;<cr>my $this = {};<cr><cr><cr>bless ($this,$classname);<cr>return $this;<cr>}<Esc>4ko
imap <buffer> open1 open (^,"^") <Bar><Bar> die ("Could not open file ^");<Esc>^;n

imap <buffer> foreach1 foreach (^) {<cr>^<cr>}<cr>^<Esc>3k^;n
imap <buffer> if1 if (^) {<cr>^<cr>}^<Esc>2k^;n
imap <buffer> if2 if (^);<Esc>F(;n

imap <buffer> ;n <esc>/\^/<cr>:nohl<cr>cl
nmap <buffer> ;n /\^/<cr>:nohl<cr>cl
