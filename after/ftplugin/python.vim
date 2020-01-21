set foldmethod=indent

" Sending file content to screen session
let b:screen_send_screen_name = "python"
let b:filename = expand("%")
let b:screen_execute_cmd = '\%run '.b:filename
source ~/.vim/after/ftplugin/tmux-send.vim

"Mappings
nmap <S-F9> :SyntasticCheck<cr>:Errors<cr>
nnoremap <F9> :w<cr>:call SendFile(1)<cr><cr>
