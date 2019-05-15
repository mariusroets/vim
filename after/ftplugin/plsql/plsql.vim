
set foldmethod=syntax
set foldcolumn=4
set smartindent

" Compile the whole file
nmap <buffer> <F9> ;sea
imap <buffer> <F9> ;se

" Make keawords uppercase (ugh)
let s:WordsToCap = [
   \ "if",
   \ "then",
   \ "else",
   \ "while",
   \ "loop",
   \ "for",
   \ "end",
   \ "procedure",
   \ "exception",
   \ "between",
   \ "cursor",
   \ "when",
   \ "is",
   \ "as",
   \ "package",
   \ "order",
   \ "by",
   \ "body",
   \ "function",
   \ "elsif",
   \ "declare",
   \ "varchar2",
   \ "number",
   \ "in",
   \ "pragma",
   \ "return",
   \ "type",
   \ "select",
   \ "insert",
   \ "update",
   \ "where",
   \ "from",
   \ "values",
   \ "begin",
   \ "into",
   \ "date",
   \ "returning",
   \ "create",
   \ "replace",
   \ "or",
   \ "and",
   \ "set",
   \ "least",
   \ "greatest"]

function! PLSQLToggleCase()
   if (!exists("b:PLSQLAbbreviationsUpper"))
      let b:PLSQLAbbreviationsUpper=0
   endif
   if (!b:PLSQLAbbreviationsUpper) 
      for word in s:WordsToCap
         let uword = toupper(word)
         execute "iabbrev <buffer> ".word." ".uword
      endfor
      let b:PLSQLAbbreviationsUpper = 1
   else
      for word in s:WordsToCap
         execute "iunabbrev <buffer> ".word
      endfor
      let b:PLSQLAbbreviationsUpper = 0
   endif
endfunction
nmap <S-F11> :call PLSQLToggleCase()<cr>

let g:tagbar_type_plsql = {
    \ 'ctagstype' : 'sql',
    \ 'kinds' : [
        \ 'P:packages:1:1',
        \ 'v:variables:0:1',
        \ 'd:prototypes:0:1',
        \ 'c:cursors:0:1',
        \ 'f:functions:0:1',
        \ 'F:record fields:0:1',
        \ 'L:block label:0:1',
        \ 'p:procedures:0:1',
        \ 's:subtypes:0:1',
        \ 't:tables:0:1',
        \ 'T:triggers:0:1',
        \ 'i:indexes:0:1',
        \ 'e:events:0:1',
        \ 'U:publications:0:1',
        \ 'R:services:0:1',
        \ 'D:domains:0:1',
        \ 'V:views:0:1',
        \ 'n:synonyms:0:1',
        \ 'x:MobiLink Table Scripts:0:1',
        \ 'y:MobiLink Conn Scripts:0:1',
        \ 'z:MobiLink Properties:0:1'
    \ ]
\ }

