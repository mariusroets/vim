
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

