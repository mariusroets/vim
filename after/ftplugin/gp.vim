set foldmethod=indent
" Sending file content to screen session
let b:screen_send_screen_name = "gnuplot"
let b:screen_execute_cmd = "load \"".expand("%:t")."\""
source ~/.vim/after/ftplugin/screen-send.vim

