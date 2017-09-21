
" Yanks method declaration into a defintion template. Can be pasted in the
" usual way
nmap <buffer> ;yp :set paste<cr>yyp:s/^\s\+//<cr>:s/;$//<cr>?class<cr>wye''$F(bi::<esc>hPo{<cr>}<esc>2k3ddk:set nopaste<cr>:nohl<cr>

let b:FindChar = "^"

imap <buffer> if1 if (^) {<cr>^<cr>}^<Esc>2k^i;n
imap <buffer> if2 if (^) {<cr>^<cr>} else {<cr>^<cr>}^<Esc>4k^i;n
imap <buffer> while1 while (^) {<cr>^<cr>}^<Esc>2k^i;n
imap <buffer> for1 for (^;^;^) {<cr>^<cr>}^<Esc>2k^i;n
imap <buffer> switch1 switch (^) {<cr>case ^:<cr>^<cr>case ^:<cr>^<cr>default :<cr>}^<esc>6k^i;n
imap <buffer> case1 case ^:<cr>^<esc>k^;n
imap <buffer> ;inc2 #include "^"^<esc>^;n
imap <buffer> ;inc1 #include <^>^<esc>^;n
imap <buffer> ;def #define 
imap <buffer> ;proto ^ ^(^);<esc>^cl
imap <buffer> ;func ^ ^(^)<cr>{<cr>^<cr>}<esc>3k^cl
imap <buffer> ;n <esc>/\^/<cr>:nohl<cr>cl
nmap <buffer> ;n /\^/<cr>:nohl<cr>cl
" syn region myFold start="{" end="}" transparent fold
" syn sync fromstart
setlocal foldmethod=syntax
setlocal foldcolumn=4

