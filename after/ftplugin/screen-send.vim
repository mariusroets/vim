
let s:cmd = "!screen -x ".b:screen_send_screen_name." -X stuff"

function! SendFile(...)
    if a:0 == 0
        let dir = expand("%:p:h")
        let l = "cd \"".dir."\""
        call SendLine(l)
    end
   call SendLine(b:screen_execute_cmd)
endfunction

function! SendCurrentLine()
   call SendLine(getline("."))
endfunction

function! SendLine(l)
   let cmd = s:cmd." $'".a:l."\\n'"
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
