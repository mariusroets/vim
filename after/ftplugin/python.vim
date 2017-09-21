set foldmethod=indent

" Reloads the current module. Necessary when module has changed
" and is being used in other modules
function! ReloadModule()
   let dir = expand("%:h:t")
   let module_name = expand("%:t:r")
   let l = "import ".dir.".".module_name
   call SendLine(l)
   let l = "dreload(".dir.".".module_name.")"
   call SendLine(l)
endfunction

function! UpdateDevelopment()
    if filereadable("setup.py")
        execute "!python setup.py develop --install-dir=/data/code/python/staging"
    endif
endfunction

" Sending file content to screen session
let b:screen_send_screen_name = "python"
let filename = expand("%:t")
let b:screen_execute_cmd = "execfile(\"".filename."\")"
source ~/.vim/after/ftplugin/screen-send.vim

"Mappings
nmap <C-F9> :call ReloadModule()<cr><cr>
nnoremap <F9> :w<cr>:call UpdateDevelopment()<cr>:call SendFile()<cr><cr>
