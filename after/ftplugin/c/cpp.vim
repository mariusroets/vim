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
            execute "tabfind ".filename
        else
            execute "sbuffer ".bufnum
        endif
    endfunction
endif
nmap ;s :call SwitchSourceHeader()<CR>

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

if !exists("*CreateQtFiles")
    function! CreateQtFiles(name, type)
        let lcname = tolower(a:name)
        let ucname = toupper(a:name)
        execute "tabedit ".lcname.".h"
        call WriteQtHFile(a:name, a:type)
        write
        execute "tabedit ".lcname.".cpp"
        call WriteQtCPPFile(a:name, a:type)
        write
    endfunction
endif 

function! WriteQtHFile(name, type)
    let lcname = tolower(a:name)
    let ucname = toupper(a:name)
    call setline(1,"/****************************************************************************")
    call append(line('$'),"****************************************************************************/")
    call append(line('$'),"")
    call append(line('$'),"#ifndef __".ucname."_H__")
    call append(line('$'),"#define __".ucname."_H__")
    call append(line('$'),"")
    call append(line('$'),"#include \"ui_".lcname.".h\"")
    call append(line('$'),"")
    call append(line('$'),"class " . a:name . " : public " . a:type)
    call append(line('$'),"{")
    call append(line('$'),"    Q_OBJECT")
    call append(line('$'),"")
    call append(line('$'),"    public :")
    call append(line('$'),"        " . a:name . "( QWidget* parent = 0);")
    call append(line('$'),"        ~" . a:name . "();")
    call append(line('$'),"")
    call append(line('$'),"    private:")
    call append(line('$'),"        Ui::".a:name." ui;")
    call append(line('$'),"};")
    call append(line('$'),"")
    call append(line('$'),"#endif // __" . ucname . "_H__")
endfunction

function! WriteQtCPPFile(name, type)
    let lcname = tolower(a:name)
    let ucname = toupper(a:name)
    call setline(1,"/****************************************************************************")
    call append(line('$'),"****************************************************************************/")
    call append(line('$'),"")
    call append(line('$'),"#include \"".lcname.".h\"")
    call append(line('$'),"")
    call append(line('$'),a:name."::".a:name."( QWidget* parent) : ".a:type."( parent )")
    call append(line('$'),"{")
    call append(line('$'),"    ui.setupUi(this);")
    call append(line('$'),"")
    call append(line('$'),"}")
    call append(line('$'),a:name."::~".a:name."()")
    call append(line('$'),"{")
    call append(line('$'),"    //Destructor")
    call append(line('$'),"}")
endfunction

if !exists("*CreateCPPFiles")
    function! CreateCPPFiles(name)
        let lcname = tolower(a:name)
        let ucname = toupper(a:name)
        execute "tabedit ".lcname.".h"
        call WriteCPPHFile(a:name)
        write
        execute "tabedit ".lcname.".cpp"
        call WriteCPPCPPFile(a:name)
        write
    endfunction
endif 
function! WriteCPPHFile(name)
    let lcname = tolower(a:name)
    let ucname = toupper(a:name)
    call setline(1,"/****************************************************************************")
    call append(line('$'),"****************************************************************************/")
    call append(line('$'),"")
    call append(line('$'),"#ifndef __".ucname."_H__")
    call append(line('$'),"#define __".ucname."_H__")
    call append(line('$'),"")
    call append(line('$'),"class " . a:name)
    call append(line('$'),"{")
    call append(line('$'),"    public :")
    call append(line('$'),"        " . a:name . "();")
    call append(line('$'),"        ~" . a:name . "();")
    call append(line('$'),"};")
    call append(line('$'),"")
    call append(line('$'),"#endif // __" . ucname . "_H__")
endfunction

function! WriteCPPCPPFile(name)
    let lcname = tolower(a:name)
    let ucname = toupper(a:name)
    call setline(1,"/****************************************************************************")
    call append(line('$'),"****************************************************************************/")
    call append(line('$'),"")
    call append(line('$'),"#include \"".lcname.".h\"")
    call append(line('$'),"")
    call append(line('$'),a:name."::".a:name."()")
    call append(line('$'),"{")
    call append(line('$'),"}")
    call append(line('$'),a:name."::~".a:name."()")
    call append(line('$'),"{")
    call append(line('$'),"    //Destructor")
    call append(line('$'),"}")
endfunction

command! -nargs=* QtFiles call CreateQtFiles(<f-args>)
command! -nargs=* CPPFiles call CreateCPPFiles(<f-args>)

