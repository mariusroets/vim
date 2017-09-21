" Vim FT Plugin

" Maintainer:	Colin Keith <vim@ckeith.clara.net>
" Last Change:	2002 Jul 5
" Version:		1.1
" Now it's version 3.2
" Heavily hacked and updated by me
" That's Marius
" Actually I changed everything. It was a good idea though.

" Only do this when not done yet for this buffer
"if exists("b:did_ftplugin")
"  finish
"endif
"let b:did_ftplugin = 1

if &keywordprg == '' | setlocal keywordprg=perldoc | endif   " See ':help K'
setlocal iskeyword=a-z,A-Z,48-57,_,: 

if !exists(':Perldoc')
  command! -n=? -buffer -complete=dir Perldoc :call s:Perldoc("<args>")
endif
if !exists(':Perlfunc')
  command! -n=? -buffer -complete=dir Perlfunc :call s:Perlfunc("<args>")
endif

"---
" Start the perldoc using the preferences from the global variables
"
function! s:Perldoc(perldoc)
  " set perldoc if not set
  let perldoc = a:perldoc
  if !exists("perldoc") || !strlen(perldoc)
    let line = getline('.')

    " Only use and require load stuff:
    " if its not a comment line
    if match(line, '^\s*\(use\|require\)') != -1
      let perldoc = substitute(line,
                      \ '^\s*use\s\+\([A-Za-z0-9_:]\+\).*', '\1','')

      " might be a require:
      if perldoc == line
        let perldoc = substitute(line,
                        \ "^\\s*require\\s\\+[\"']*\\([^\"']\\+\\).*", '\1', '')
        if perldoc != line
          let perldoc = substitute(perldoc, '^\(.\+\).pm', '\1', '')
          let perldoc = substitute(perldoc, '[\\/]', '::', 'g')
        endif
      endif
    endif
  endif

  " check got value
  if perldoc == ''
    echomsg 'What Perldoc Page do you want?'
    return
  endif

  " Check if Perldoc program exists:
  if exists('g:perldoc_program')
    let pdp = g:perldoc_program
  else
     let pdp = 'something useless'
  endif

  " Otherwise try the defaults:
  if !executable(pdp)
    if has('win32')
      let pdp = 'C:/Perl/bin/perldoc.bat'
    else
      let pdp = '/usr/bin/perldoc'
    endif

    if !executable(pdp)
      echoerr 'Perldoc Program not found (' . pdp . ')'
      return
    endif
  endif

  " Open new window along the top
  let height = winheight(0)
  if height > 0
    let height = height / 2
  elseif
    let height = 14
  endif

  " Now we have an executable to run, be more specific
  if &keywordprg == 'perldoc'
    silent! execute 'setlocal keywordprg='. pdp
  endif

  " Version 1.1.1 => g:perldoc_flag
  if !exists('g:perldoc_flag')
    if match(pdp, '\.bat$') == 0
      let perl = substitute(pdp, 'perldoc.bat', 'perl.exe', '')
    else
      let perl = substitute(pdp, 'perldoc', 'perl', '')
    endif

    " Generic name and rely on the system to expand it.
    if !executable(perl) | let perl = 'perl' | endif

    :top 1 new "Perl Version"
    silent! execute '1! '. perl.' -v'
    if match(getline(2), '^This is perl, v\([\d.]*\) ') == 0
      let g:perldoc_flag = '-U'
    else
      let g:perldoc_flag = ''
    endif

    :q!
  endif

  " Default to the user 'nobody'
  if g:perldoc_flag == 'su' | let g:perldoc_flag = 'su nobody' | endif
  if match(g:perldoc_flag, '^su ') == 0
    let cmd = g:perldoc_flag. ' -c "'. pdp.' -t '. perldoc .'"'
  else
    let cmd = pdp .' '. g:perldoc_flag . ' -t "'. perldoc .'"'
  endif

  silent! execute 'top '. height. 'new "Perldoc: ' .perldoc. '"'
  silent! execute '1! '. cmd
  redraw

  " Catch bad names
  if !match(getline(1), '^No documentation found for ')
    :quit!
    redraw | echomsg 'No such Perldoc as "' . perldoc . '"'
    return
  endif

  " Clean up the formatting a little:
  setlocal nomodified
  setlocal readonly
  setlocal filetype=podman

endfunction

function! s:Perlfunc(perldoc)
  " set perldoc if not set
  let perldoc = a:perldoc
  if !exists("perldoc") || !strlen(perldoc)
    let perldoc = expand("<cword>")
  endif

  " check got value
  if perldoc == ''
    echomsg 'What Perldoc Page do you want?'
    return
  endif

  " Check if Perldoc program exists:
  if exists('g:perldoc_program')
    let pdp = g:perldoc_program
  else
     let pdp = 'something useless'
  endif

  " Otherwise try the defaults:
  if !executable(pdp)
    if has('win32')
      let pdp = 'C:/Perl/bin/perldoc.bat'
    else
      let pdp = '/usr/bin/perldoc'
    endif

    if !executable(pdp)
      echoerr 'Perldoc Program not found (' . pdp . ')'
      return
    endif
  endif

  " Open new window along the top
  let height = winheight(0)
  if height > 0
    let height = height / 2
  elseif
    let height = 14
  endif

  " Now we have an executable to run, be more specific
  if &keywordprg == 'perldoc'
    silent! execute 'setlocal keywordprg='. pdp
  endif

  " Version 1.1.1 => g:perldoc_flag
  if !exists('g:perldoc_flag')
    if match(pdp, '\.bat$') == 0
      let perl = substitute(pdp, 'perldoc.bat', 'perl.exe', '')
    else
      let perl = substitute(pdp, 'perldoc', 'perl', '')
    endif

    " Generic name and rely on the system to expand it.
    if !executable(perl) | let perl = 'perl' | endif

    :top 1 new "Perl Version"
    silent! execute '1! '. perl.' -v'
    if match(getline(2), '^This is perl, v\([\d.]*\) ') == 0
      let g:perldoc_flag = '-U'
    else
      let g:perldoc_flag = ''
    endif

    :q!
  endif

  " Default to the user 'nobody'
  if g:perldoc_flag == 'su' | let g:perldoc_flag = 'su nobody' | endif
  if match(g:perldoc_flag, '^su ') == 0
    let cmd = g:perldoc_flag. ' -c "'. pdp.' -t -f '. perldoc .'"'
  else
    let cmd = pdp .' '. g:perldoc_flag . ' -t -f "'. perldoc .'"'
  endif

  silent! execute 'top '. height. 'new "Perldoc: ' .perldoc. '"'
  silent! execute '1! '. cmd
  redraw

  " Catch bad names
  if !match(getline(1), '^No documentation found for ')
    :quit!
    redraw | echomsg 'No such Perldoc as "' . perldoc . '"'
    return
  endif

  " Clean up the formatting a little:
  setlocal nomodified
  setlocal readonly
  setlocal filetype=podman

endfunction

nmap ;pf :Perlfunc<cr>
nmap ;pm :Perldoc<cr>
