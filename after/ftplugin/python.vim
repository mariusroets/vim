set foldmethod=indent

" Sending file content to screen session
let b:screen_send_screen_name = "python"
let filename = expand("%")
let b:screen_execute_cmd = '\%run '.filename
source ~/.vim/after/ftplugin/tmux-send.vim

"Mappings
nmap <S-F9> :SyntasticCheck<cr>
nnoremap <F9> :w<cr>:call SendFile(1)<cr><cr>
