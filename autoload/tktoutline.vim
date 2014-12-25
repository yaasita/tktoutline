" vim: set sw=4 et fdm=marker:
"
"
" tktoutline.vim - A plugin to make TEKITOU outline
"
" Version: 1.4
" Maintainer:	yaasita < https://github.com/yaasita/tktoutline >

" b:tkt_outline_command
" b:tkt_outline_splitw
function! tktoutline#tktOutline() "{{{

    wincmd l
    if ! exists("b:tkt_outline_command")
        call <SID>tktsetting()
    endif
    let l:tkt_outline_command = b:tkt_outline_command

    " buffer copy
    let l:cnumber = 1
    if bufexists("TktOutline")
        " save current number
        wincmd h
        let l:cnumber = line(".")
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
    setlocal nowrap

    exec ':'.l:cnumber
    nnoremap <silent> <buffer> <cr> :call <SID>tktjump()<cr>
    nnoremap <silent> <buffer> <C-l> :call tktoutline#tktOutline()<cr>
    nnoremap <silent> <buffer> q :q<cr>
endfunction "}}}
function! s:tktjump() "{{{
    let l:line = getline(".")
    let l:jumpline = matchstr(l:line,'\d\+$')
    wincmd p
    exec l:jumpline
    normal zz
endfunction "}}}
function! s:tktsetting() "{{{
    if (&ft == 'pukiwiki')
        let b:tkt_outline_command=['g!/^\*/d','%s/\[#\w\+\]//','%s/^\(\*\+\)\s*/\1/','%s/^\*//','%s/\*/  /g']
    elseif (&ft == 'redmine')
        let b:tkt_outline_command=['g!/^h\d/d','%s/^h1\. //','%s/^h2\. /  /','%s/^h3\. /    /g']
    elseif (&ft == 'cobol')
        let b:tkt_outline_command=['g!/^......[^\*].*\(DIVISION\|SECTION\)/d','%s/^......\s*//','%s/^\(.*SECTION.*\)/  \1/']
    elseif (&ft == 'yaml')
        let b:tkt_outline_command=['g/^\s\{5\}/d']
    elseif (&ft == 'html')
        let b:tkt_outline_command=['g!/\v\<h[123][^\>]*\>/d','%s/\v\<h1[^\>]*\>(.+)\<\/h1\>/\1/','%s/\v\<h2[^\>]*\>(.+)\<\/h2\>/  \1/','%s/\v\<h3[^\>]*\>(.+)\<\/h3\>/    \1/']
    elseif (&ft == 'markdown' || &ft == 'mkd')
        let b:tkt_outline_command=['g!/^#/d', '%s/^\(\#\+\)\s*/\1/', '%s/^\(\#\+\)\s*/\1/', '%s/^\#//', '%s/\#/  /g']
    else "default
        let b:tkt_outline_command=['g!/^\*/d','%s/\[.\+\]//','%s/^\(\*\+\)\s*/\1/','%s/^\*//','%s/\*/  /g']
    endif
endfunction "}}}
