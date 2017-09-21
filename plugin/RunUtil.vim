" vim: foldmethod=marker
"
" More ideas
"   - Set project directory
"     - Create tags in project directory
"     - Run make in project dir or current dir
"   - Different window contents
"     - Tags
"     - Project Details
"     - Project files
"   - Mapping for functionality
"       - Go to Quickfix
"       - Next error
"       - Close quickfix
"       - Go to program output
"       - Close program output
"   - Background make
"     - Update quickfix incrementally
"   - Persistent quickfix at bottom of screen
"
"   - Problems
"     - Cursor position? (escpecially when explorer is open)
"
" {{{ Global Variables
" Internal
" g:ProjectBufferToWipe
" g:ProjectPanelOpen
" g:filenameList
" g:CurrentPanelContent
" g:ReturnTabPage
" g:RunPageTabNr
" g:MakePageTabNr
" Project Settings
" g:DateModified
" g:DateCreated
" g:ProjectDirectory
" g:Session_path 
" g:ProjectPanelWidth
" System
" g:colors_name
let g:ProjectDirectory = ""
let g:ProjectPanelOpen = 0
let g:ProjectPanelWidth = 30
let g:CurrentPanelContent = "projectdetails"
let g:DateCreated = "Not Implemented yet"
let g:DateModified = "Not Implemented yet"
" }}}
" {{{ Script Variables
let s:RunBufferName = '--Program Output--'
let s:MakeBufferName = '--Make Output--'
let s:ProjectPanelName = '--Project--'
let s:PanelContents = ["projectlist","projectdetails","explorer"]
let s:SettingNames = ["ProjectDirectory","ProjectName"]
let s:SettingValues = {"ProjectDirectory" : "",
         \"ProjectName" : ""}
let s:SettingDescriptions = {"ProjectDirectory" : "Project Directory", 
         \ "ProjectName" : "Project Name"}
let s:MaxTabPageNameLength = 35
" }}}
" Loading and Saving
" {{{ function! SaveProject()
function! SaveProject()

   " Save the session, if the user so wishes
   if exists("v:this_session")
      " echo "Session exists"
      if (v:this_session == "")
         " echo "but it's empty"
         " Ask the user if he wants to save this session
         call SaveAsProject("")
      else
         " Write all buffers
         call SaveAsProject(v:this_session)
      endif
   endif

endfunction
"}}}
" {{{ function! SaveAsProject()
function! SaveAsProject(projectName)
   "
   let projectName = ""
   if (a:projectName == "")
      let projectName = input ("Name for this session: ")
   else
      let projectName = substitute(a:projectName,g:Session_path."\/","","")
   endif
   if projectName == ""
      return
   endif
   " Make sure it has a .vim extention, by adding it (remove first to avoid
   " adding it twice)
   let projectName = substitute(projectName,'\.vim$',"","")
   let s:SettingValues['ProjectName'] = projectName
   let projectName = projectName . ".vim"
   if exists ("g:Session_path")
      let session_path = g:Session_path 
   else
      let session_path = getcwd()
   endif
   
   " Write all buffers
   wall 
   execute "mksession! " . session_path . "/" . projectName

   echo "Session ".v:this_session." saved successfully"
   call SaveSettings()
   call SetTitleBarToSessionName()


endfunction
"}}}
" {{{ function! LoadProject(projectPath)
function! LoadProject(projectPath)
   if a:projectPath != ""
      " Destroy all buffers
      silent! bufdo! bwipeout!
      " Load the session
      execute "source " . a:projectPath
   endif
   call SetTitleBarToSessionName()
   call LoadSettings()
endfunction
"}}}
"{{{ function! SaveSettings()
function! SaveSettings()
"let s:SettingNames = ["ProjectDirectory","ProjectName"]
   let settingsLines = []
   for n in s:SettingNames
      call add(settingsLines, n . "=" . s:SettingValues[n])
   endfor
   let filename = v:this_session
   let filename = substitute(filename,'\.vim$',"","")
   let filename = filename . ".prj"
   call writefile(settingsLines,filename)

endfunction
"}}}
"{{{ function! LoadSettings()
function! LoadSettings()
   let filename = v:this_session
   let filename = substitute(filename,'\.vim$',"","")
   let filename = filename . ".prj"
   if (!filereadable(filename))
      return ""
   endif

   let settingsLines = readfile(filename)
   for n in settingsLines
      let items = split(n, '=')
      let s:SettingValues[items[0]] = items[1]
   endfor
   
endfunction
"}}}
" Making and Running
" {{{ function! RunProgram()
" Runs an external program and write the output in a new scratch window. 
" ;q closes the window and returns to the place where you called it from.
function! RunProgram()
   if !exists("s:RunProgramName") 
      let s:RunProgramName = input ("Name of program to run: ")
   else
      let temp = input ("Name of program to run (".s:RunProgramName."): ")
      if (temp != "")
         let s:RunProgramName = temp
      endif
   endif
   if s:RunProgramName != ""
      if !bufexists(s:RunBufferName)
         " Get current tab page number
         let g:ReturnTabPage = tabpagenr()
         " Go to last tab
         tablast
         " A new tab after last tab
         tabnew
         let g:RunPageTabNr = tabpagenr()
         let t:TabPageName = s:RunBufferName
         " Make a scratch buffer
         setlocal buftype=nofile
         " Name the buffer
         execute "silent file " . escape(s:RunBufferName, " ")
         " mapping to close window, and return to tab page it was called from
         execute "nmap <buffer> ;q :call CloseSpecialBuffer()<cr>"
      else
         let g:ReturnTabPage = tabpagenr()
         " Go to the tab page
         execute "tabnext " . g:RunPageTabNr
         " Clean it out
         normal ggdG
      endif
      " Run program, and read output in scratch buffer
      execute "0read !".s:RunProgramName
   endif

endfunction
"}}}
" {{{function! Make()
function! Make()

   let colorScheme = g:colors_name
   colorscheme peachpuff
   if !bufexists(s:MakeBufferName)
      "Save the current buffer, we want to return here
      let g:ReturnTabPage = tabpagenr()
      "Create the buffer
      tab copen
      let g:MakePageTabNr = tabpagenr()
      let t:TabPageName = s:MakeBufferName
      execute "silent file " . escape(s:MakeBufferName," ")
      execute "nmap <buffer> ;q :call CloseSpecialBuffer()<cr>"
      execute "tabnext ".g:ReturnTabPage

   endif

   silent! make!
   execute "tabnext ".g:MakePageTabNr

   execute "colorscheme ". colorScheme
   
endfunction
"}}}
" {{{ function! CloseSpecialBuffer()
function! CloseSpecialBuffer()
   if bufname("%") == s:MakeBufferName
      unlet g:MakePageTabNr
      bwipeout
      execute "tabnext ".g:ReturnTabPage
      unlet g:ReturnTabPage
   elseif bufname("%") == s:RunBufferName
      unlet g:RunPageTabNr
      bwipeout
      execute "tabnext ".g:ReturnTabPage
      unlet g:ReturnTabPage
   endif

endfunction
" }}}
" {{{ function! JumpToMakePage()
function! JumpToMakePage()
   if exists("g:MakePageTabNr")
      let g:ReturnTabPage = tabpagenr()
      execute "tabnext ".g:MakePageTabNr
   endif
endfunction
"}}}
" {{{ function! JumpToRunPage()
function! JumpToRunPage()
   if exists("g:RunPageTabNr")
      let g:ReturnTabPage = tabpagenr()
      execute "tabnext ".g:RunPageTabNr
   endif
endfunction
"}}}
" {{{ function! JumpBack()
function! JumpBack()
   if exists("g:ReturnTabPage")
      execute "tabnext ".g:ReturnTabPage
   endif
endfunction
" }}}
" Miscellaneous
" {{{ function! RefreshProject()
" Removes all mappings and settings from the session file.
" Next time the project is openened, it will be 'fresh', using all
" current mappings and settings.
function! RefreshProject()
   execute "tabedit ".v:this_session
   g/^set/d
   g/^\w*map/d
   w
   qa
endfunction
"}}}
"{{{ function! SetTitleBarToSessionName()
function! SetTitleBarToSessionName()
   let title = StripSessionPath()
   execute "set titlestring=".title
endfunction
"}}}
"{{{ function! StripSessionPath()
function! StripSessionPath()
   let title = v:this_session
   let title = substitute(title,g:Session_path."\/","","")
   let title = substitute(title,'\.vim$',"","")
   return title
endfunction
"}}}
" {{{ function! GetTabPageNumberForBuffer(bufferName)
function! GetTabPageNumberForBuffer(bufferName)
   redir => tabpages
   silent! tabs
   redir END
   let tabpagelines = split(tabpages,'\n')
   for line in tabpagelines
      if ( match(line,'Tab page') != -1)
         let list = matchlist(line,'Tab page \(\d\+\)')
         let currentTabPage = list[1]
      endif
      if (match(line,a:bufferName) != -1)
         "echo currentTabPage
         return currentTabPage
      endif
   endfor
   " Buffer not found return 0
   return 0

endfunction
" }}}
" Project Files and Settings
"{{{ function! GetProjectDirectory()
function! GetProjectDirectory()
   let pdir = getcwd()
   "if has('browse')
   "   let pdir = browsedir("Project",pdir)
   "else
   let pdir = input("Give Project home directory: ",pdir,"dir")
   " endif
   if (pdir != "")
      let g:ProjectDirectory = pdir
   endif
endfunction
"}}}
" {{{ function! GetProjectFullPathFromProjectPanel()
function! GetProjectFullPathFromProjectPanel()
   let line = getline(".")
   let nr = matchend (line, '\d\+\.')

   if nr != -1
      let nr = nr - 1
      let index = str2nr(strpart(line,0,nr)) - 1
      return g:filenameList[index]
   endif 
   return ""
endfunction
" }}}
" Project Panel
" {{{ function! CreateDestroyProjectPanel()
function! CreateDestroyProjectPanel()
   let tabpagebuflist = tabpagebuflist()
   let bufnr = bufnr(s:ProjectPanelName)
   if (g:ProjectPanelOpen == 0) && (bufnr != -1)
      if exists("g:ProjectBufferToWipe")
         execute "bwipeout ".g:ProjectBufferToWipe
         unlet g:ProjectBufferToWipe
      endif
      "echo "Deleting buffer ".bufnr
      execute "bwipeout ".bufnr
   endif

   if (g:ProjectPanelOpen == 1) 
      if (bufnr != -1) 
         " The buffer exists
         if (index(tabpagebuflist,bufnr) == -1)
            " The buffer is not in the current tab page
            vertical topleft new
            let tempbuffer = bufnr("%")
            execute "vertical resize ".g:ProjectPanelWidth
            execute "buffer " . bufnr
            execute "bwipeout ". tempbuffer
         endif
      else
         "The buffer does not exist. Create it
         vertical topleft new
         call SetPanelBufferOptions()
      endif

   endif

endfunction
" }}}
" {{{ function! ShowProjectPanel()
function! ShowProjectPanel()
   let g:ProjectPanelOpen = 1
   call CreateDestroyProjectPanel()
endfunction
" }}}
" {{{ function! HideProjectPanel()
function! HideProjectPanel()
   let g:ProjectPanelOpen = 0
   call CreateDestroyProjectPanel()
endfunction
" }}}
" {{{ function! ToggleShowProjectPanel()
function! ToggleShowProjectPanel()
   if (g:ProjectPanelOpen == 1) 
      let g:ProjectPanelOpen = 0
   else
      let g:ProjectPanelOpen = 1
   endif
   call RefreshProjectPanelContent()
endfunction
" }}}
" {{{ function! SwitchToProjectPanel()
" }}}
" {{{ function! SwitchBackFromProjectPanel()
" }}}
" {{{ function! SetPanelBufferOptions()
function! SetPanelBufferOptions()
   execute "vertical resize ".g:ProjectPanelWidth
   setlocal buftype=nofile
   setlocal nomodifiable
   setlocal noruler
   setlocal noswapfile
   if !bufexists(s:ProjectPanelName)
      execute "silent file " . escape(s:ProjectPanelName," ")
   endif
   nmap <buffer> ;q :q<cr>
endfunction
" }}}
" Project Panel contents
" {{{ function! RefreshProjectPanelContent(...)
function! RefreshProjectPanelContent(...)
" - File List
"
   if g:ProjectPanelOpen == 0
      call CreateDestroyProjectPanel()
      return
   endif
   let currentWindowNr = winnr()
   if exists("g:ProjectBufferToWipe")
      execute "bwipeout ".g:ProjectBufferToWipe
      unlet g:ProjectBufferToWipe
   endif
   if a:0 > 0
      "if a:1 is a legal project panel content
      let g:CurrentPanelContent = a:1
   endif
   " First make sure we are in the correct buffer
   if bufname("%") != s:ProjectPanelName
      let bufnr = bufnr(s:ProjectPanelName)
      if bufnr != -1
         let tabpagebuflist = tabpagebuflist()
         if (index(tabpagebuflist,bufnr) == -1)
            " The buffer is not in the current tab page
            "echo "The buffer is not in the current tab page"
            call CreateDestroyProjectPanel()
         else 
            " The buffer is in the current tab page, just switch to it 
            let winnr = bufwinnr(s:ProjectPanelName)
            execute winnr . "wincmd w"
         endif
      else
         " The buffer does not exist. Just return.
         "echo " The buffer does not exist. Just return."
         if g:ProjectPanelOpen == 1
            call CreateDestroyProjectPanel()
         else
            return
         endif
      endif
   endif
   if g:CurrentPanelContent == "projectlist"
      call CreateProjectList()
   elseif g:CurrentPanelContent == "projectdetails"
      call CreateProjectDetails()
   elseif g:CurrentPanelContent == "explorer"
      call CreateExplorer()
   endif
   " Because something might have changed them
   call SetPanelBufferOptions()
   execute currentWindowNr . "wincmd w"

" - Tags
" - Project Details
endfunction
" }}}
" {{{ function! NextProjectPanelContent()
function! NextProjectPanelContent()
   let index = index (s:PanelContents, g:CurrentPanelContent)
   let len = len (s:PanelContents)
   let index = index + 1
   if (index >= len)
      let index = 0
   endif
   call RefreshProjectPanelContent(s:PanelContents[index])
endfunction
" }}}
" Project List
" {{{ function! CreateProjectList()
function! CreateProjectList()
   setlocal modifiable
   normal ggdG
   if exists ("g:Session_path")
     let session_path = g:Session_path 
   else
     let session_path = getcwd()
   endif
   execute "normal iAvailable Project Files\<cr>"
   execute "normal i<Enter> : Open file\<cr>"
   execute "normal i;d : Delete file\<cr>\<cr>"
   let g:filenameList = split (glob ( session_path . "/*.vim") , "\n")
   let filenumber = 1
   for name in g:filenameList
     let name = substitute(name, '\.vim$', "","")
     let name = substitute(name, session_path."\/", filenumber.".","")

     execute "normal i".name."\<cr>"
     let filenumber = filenumber + 1
   endfor
   execute "normal i\<cr>"
   call search("1\.")
   normal zz
   execute "nnoremap <buffer> <Enter> :call LoadChosenProject()<cr>:call HideProjectPanel()<cr>"
   execute "nnoremap <buffer> <LeftRelease> :call LoadChosenProject()<cr>:call HideProjectPanel()<cr>"
   execute "nnoremap <buffer> ;d :call DeleteChosenProject()<cr>"
   setlocal nomodifiable
endfunction
" }}}
" {{{ function! DeleteChosenProject()
function! DeleteChosenProject()
   let fullPath = GetProjectFullPathFromProjectPanel()
   let nr = delete(fullPath)
   if nr == 0
      echo "Deleted project ".fullPath
   else
      echo "Could not delete project ".fullPath
   endif
   call RefreshProjectPanelContent()

endfunction
" }}}
" {{{ function! LoadChosenProject()
function! LoadChosenProject()
   let saveProjectPanelOpen = g:ProjectPanelOpen
   let g:ProjectPanelOpen = 0
   call LoadProject(GetProjectFullPathFromProjectPanel())
   let g:ProjectPanelOpen = saveProjectPanelOpen

endfunction
" }}}
" Tags
" Project Details
" {{{ function! CreateProjectDetails()
function! CreateProjectDetails()
   setlocal modifiable
   normal ggdG
   if v:this_session != ""
      let name = StripSessionPath()
      let fileCount = 0
      execute "normal i*Project Details\<cr>"
      execute "normal i(Enter to change value)\<cr>\<cr>"
      for setting in s:SettingNames
         execute "normal i*".s:SettingDescriptions[setting].":\<cr>"
         execute "normal i".s:SettingValues[setting]."\<cr>"
      endfor
      execute "nnoremap <buffer> <Enter> :call ChangeSetting()<cr>"
   else
      execute "normal iCurrently No Project is loaded"
   endif
   setlocal nomodifiable
endfunction
" }}}
" {{{ function! ChangeSetting()
function! ChangeSetting()
   let line = getline(".")

   for setting in s:SettingNames
      if (line == "*".s:SettingDescriptions[setting].":")
         let value = input(s:SettingDescriptions[setting].": ","","dir")
         let s:SettingValues[setting] = value
      endif
   endfor
   call RefreshProjectPanelContent()
   return ""
endfunction
" }}}
" Explorer
" {{{ function! CreateExplorer()
function! CreateExplorer()
   Explore
   let g:ProjectBufferToWipe = bufnr("%")
endfunction
" }}}
" Project files

" Setting the tab label
" {{{function GuiTabLabel()
function GuiTabLabel()
   if exists("t:TabPageName")
      return t:TabPageName
   endif
   let label = ''
   let bufnrlist = tabpagebuflist(v:lnum)

   " Add '+' if one of the buffers in the tab page is modified
   for bufnr in bufnrlist
      if getbufvar(bufnr, "&modified")
         let label = '+'
         break
      endif
   endfor

   " Append the tab page number
   let label .= v:lnum . ' '

   " Append the buffer name
   let index = tabpagewinnr(v:lnum) - 1 
   if bufname(bufnrlist[index]) == s:ProjectPanelName
      let index = index + 1
      if index >= len(bufnrlist)
         let index = 0
      endif
   endif
   " Now we have the buffer name. If it's too long, make it shorter
   let longbufname = bufname(bufnrlist[index])
   if strlen(longbufname) > s:MaxTabPageNameLength
      let longbufname = '...'.strpart(longbufname,strlen(longbufname)-s:MaxTabPageNameLength-3)
   endif
   return label . longbufname
endfunction

set guitablabel=%{GuiTabLabel()}
"}}}

" {{{ Mappings
autocmd TabEnter,SessionLoadPost *  call RefreshProjectPanelContent()
nmap <F9> :call Make()<cr>
nmap <S-F9> :call RunProgram()<cr>
" Opens a previously saved session
nmap <F3> :call ShowProjectPanel()<cr>:call RefreshProjectPanelContent("projectlist")<cr>
nmap <F5> :call NextProjectPanelContent()<cr>
nmap <leader>jr :call JumpToRunPage()<cr>
nmap <leader>jm :call JumpToMakePage()<cr>
nmap <leader>jb :call JumpBack()<cr>

nmap <leader>1 :tabnext 1<cr>
nmap <leader>2 :tabnext 2<cr>
nmap <leader>3 :tabnext 3<cr>
nmap <leader>4 :tabnext 4<cr>
nmap <leader>5 :tabnext 5<cr>
nmap <leader>6 :tabnext 6<cr>
nmap <leader>7 :tabnext 7<cr>
nmap <leader>8 :tabnext 8<cr>
nmap <leader>9 :tabnext 9<cr>
" }}}

