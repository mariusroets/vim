setlocal textwidth=90
setlocal spell spelllang=en_gb
setlocal foldmethod=indent

nmap <buffer> <F9> :!pdflatex -halt-on-error % >%.tmp 2>&1<cr>:split %.tmp<cr><cr>:set buftype=nofile<cr>
nmap <buffer> <S-F9> :!bibtex "%:t:r" >%.tmp 2>&1<cr>:!pdflatex -halt-on-error "%:t:r" >%.tmp 2>&1<cr>:!pdflatex -halt-on-error "%:t:r" >%.tmp 2>&1<cr>

imap <buffer> ;n <esc>/<\*><cr>3cl
nmap <buffer> ;n /<\*><cr>3cl
imap <buffer> ;sec \section{}<*><esc>3hi
imap <buffer> ;subsec \subsection{}<*><esc>3hi
imap <buffer> ;sssec \subsubsection{}<*><esc>3hi
imap <buffer> ;cap \caption{}<*><esc>3hi
imap <buffer> ;kwdata \KwData{}<*><esc>3hi
imap <buffer> ;kwresult \KwResult{}<*><esc>3hi
imap <buffer> ;while \While{}{<cr><*><cr>}<*><esc>kk$3hi
imap <buffer> ;eif \eIf{}{<cr><*><cr>}{<cr><*><cr>}<*><esc>4k$3hi
imap <buffer> ;for \For{}{<cr><*><cr>}<*><esc>kk$3hi
imap <buffer> ;if \If{}{<cr><*><cr>}<*><esc>kk$3hi
imap <buffer> ;frac \frac{}{<*>}<*><esc>8hi
imap <buffer> ;label \label{}<*><esc>3hi
imap <buffer> ;ref \ref{}<*><esc>3hi
imap <buffer> ;cite \cite{}<*><esc>3hi
imap <buffer> ;item \item{}<*><esc>3hi
imap <buffer> ;textbf \textbf{}<*><esc>3hi
"imap <buffer> ;begin \begin{<*>}<cr><*><cr>\end{<*>}<esc>;n
imap <buffer> ;mbox \mbox{}<*><esc>3hi
imap <buffer> ;sum \sum^{}_{<*>}<*><esc>9hi

imap <buffer> $$ $$<*><esc>3hi
vmap <buffer> $ <esc>`>a$<esc>`<i$<esc>
imap <buffer> && &&<*><esc>3hi
vmap <buffer> & <esc>`>a&<esc>`<i&<esc>

nmap <buffer> ;beg yypkI\begin{<esc>A}<esc>jI\end{<esc>A}<esc>O
imap <buffer> ;beg <esc>yypkI\begin{<esc>A}<esc>jI\end{<esc>A}<esc>O
