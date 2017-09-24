
let s:cmd = "!tmux send-keys -t default:".b:screen_send_screen_name." "

    "tmux send-keys -t $DEFAULT:root "anduril1" C-m
function! SendFile()
   let dir = expand("%:p:h")
   let l = "cd \"".dir."\""
   call SendLine(l)
   call SendLine(b:screen_execute_cmd)
endfunction

function! SendCurrentLine()
   call SendLine(getline("."))
endfunction

function! SendLine(l)
   let cmd = s:cmd."'".a:l."' C-m"
   execute cmd
endfunction

function! SendCurrentBlock()
   let lines = getline("v", ".")
   for l in lines
      call SendLine(l)
   endfor
endfunction

nnoremap <F9> :w<cr>:call SendFile()<cr><cr>
nnoremap <S-F9> :call SendCurrentLine()<cr><cr>
vnoremap <S-F9> :call SendCurrentBlock()<cr><cr>
