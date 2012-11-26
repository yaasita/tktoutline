" vim: set sw=4 et fdm=marker:
"
"
" tktoutline.vim - A plugin to make TEKITOU outline
"
" Version: 1.2
" Maintainer:	yaasita < https://github.com/yaasita/tktoutline >
" Last Change:	2012/11/27.

" b:tkt_outline_command
" b:tkt_outline_splitw
command! TktOutline call <SID>tktOutline()
"Function: s:tktOutline() {{{1
function! s:tktOutline()

    if ! exists("b:tkt_outline_command")
        call <SID>tktsetting()
    endif
    let l:tkt_outline_command = b:tkt_outline_command

    " save current number
    wincmd h
    let l:cnumber = line(".")

    " buffer copy
    if bufexists("TktOutline")
        bw TktOutline
    endif
    let l:lines = getline(1,"$")
    if ! exists("b:tkt_outline_splitw")
        let b:tkt_outline_splitw=40
    endif
    exec "vertical ".b:tkt_outline_splitw." split TktOutline"
    setlocal bt=nofile noswf
    silent! 1,$delete _

    " add line number
    let l:i=1
    while l:i < len(l:lines)+1
        call setline(l:i,l:lines[l:i-1]." ... ".l:i)
        let l:i += 1
    endwhile

    for tkcmd in l:tkt_outline_command
        exec "silent!".tkcmd
    endfor
    setlocal noma

    exec ':'.l:cnumber
    nnoremap <silent> <buffer> <cr> :call <SID>tktjump()<cr>
    nnoremap <silent> <buffer> <C-l> :call <SID>tktOutline()<cr>
endfunction
"Function: s:tktjump() {{{1
function! s:tktjump()
    let l:line = getline(".")
    let l:jumpline = matchstr(l:line,'\d\+$')
    wincmd p
    exec l:jumpline
    normal zz
endfunction
"Function: s:tktsetting() {{{1
function! s:tktsetting()
    if (&ft == 'pukiwiki')
        let b:tkt_outline_command=['g!/^\*/d','%s/\[.\+\]//','%s/^\(\*\+\)\s*/\1/','%s/^\*//','%s/\*/  /g']
    elseif (&ft == 'redmine')
        let b:tkt_outline_command=['g!/^h\d/d','%s/^h1\. //','%s/^h2\. /  /','%s/^h3\. /    /g']
    elseif (&ft == 'cobol')
        let b:tkt_outline_command=['g!/^......[^\*].*\(DIVISION\|SECTION\)/d','%s/^......\s*//','%s/^\(.*SECTION.*\)/  \1/']
    elseif (&ft == 'yaml')
        let b:tkt_outline_command=['g/^\s\{5\}/d']
    else "default
        let b:tkt_outline_command=['g!/^\*/d','%s/\[.\+\]//','%s/^\*//','%s/\*/  /g']
    endif
endfunction
