
set foldmethod=syntax
set foldcolumn=4
set smartindent

nmap <buffer> ;yp yyp:s/^\s\+//<cr>^w"ayw$C is<cr>^<cr>begin<cr>^<cr>end <esc>"apa;<esc>4k5dd:nohl<cr>
imap <buffer> for1 for i in 1 .. ^ loop<cr>end loop;<esc>k^;n
imap <buffer> when1 when ^ then<cr>^<esc>k^;n
imap <buffer> if1 if ^ then<cr>^<cr>end if;^<esc>2k^;n
imap <buffer> cloop1 for ^ in ^ loop<cr>^<cr>end loop;<esc>2k^;n
imap <buffer> cur1 cursor ^ is<esc>^;n
imap <buffer> begin1 begin<cr>end;<esc>ko
imap <buffer> beginx1 begin<cr>exception<cr>end;<esc>2ko
imap <buffer> select1 select ^<cr>from ^<cr>where ^;<esc>2k^;n
imap <buffer> insert1 insert into ^ (<cr>^<cr>)<cr>values (<cr>^<cr>);<esc>5k^;n
imap <buffer> procedure1 create or replace procedure ^ (^) as<cr>^<cr>begin<cr>^<cr>end;<esc>4k^;n
imap <buffer> function1 create or replace function ^ (^) returning ^ as<cr>^<cr>begin<cr>^<cr>end;<esc>4k^;n
imap <buffer> update1 update ^<cr>set ^ = ^<cr>where ^;<esc>2k^;n
imap <buffer> put1 dbms_output.put_line(^);^<esc>^;n
imap <buffer> package1 create or replace package ^ as<cr>end;<esc>k^;n
imap <buffer> packbody1 create or replace package body ^ is<cr>end;<esc>k^;n
imap <buffer> packfunc1 function ^(^) return ^ is<cr>begin<cr>^<cr>end;<esc>3k^;n
imap <buffer> packproc1 procedure ^(^) is<cr>begin<cr>^<cr>end;<esc>3k^;n
imap <buffer> package2 ;package1<esc>jo;packbody1
imap <buffer> view1 create or replace force view v_^<cr>(<cr>^<cr>)<cr>as<cr>select1^<esc>?create?<cr>:nohl<cr>;n
imap <buffer> ;n <esc>/\^/<cr>:nohl<cr>cl
nmap <buffer> ;n /\^/<cr>:nohl<cr>cl

" Compile the whole file
nmap <buffer> <F9> mxggVG;se<C-W><C-j>`x<C-W><C-k>G
imap <buffer> <F9> <esc>mxggVG;se<C-W><C-j>`x<C-W><C-k>G

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

