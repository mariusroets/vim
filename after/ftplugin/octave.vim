set foldmethod=indent
" Sending file content to screen session
let b:screen_send_screen_name = "octave"
let b:screen_execute_cmd = expand("%:t:r")
source ~/.vim/after/ftplugin/screen-send.vim
