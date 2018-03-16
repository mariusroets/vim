" OmniCppComplete initialization
setlocal tags+=~/.vim/tags/qt

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Mappings to open .h or .cpp file
if !exists("*SwitchSourceHeader")
    function! SwitchSourceHeader()
        if (expand ("%:e") == "cpp")
            let filename = expand ("%:t:r").".h"
            "tabfind %:t:r.h
        else
            let filename = expand ("%:t:r").".cpp"
        endif
        let bufnum = bufnr(filename)
        if (bufnum == -1)
            execute "edit ".filename
        else
            execute "buffer ".bufnum
        endif
    endfunction
endif
nmap ;s :call SwitchSourceHeader()<CR>

