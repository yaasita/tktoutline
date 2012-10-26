" vim: set sw=4 et fdm=marker:
"
"
" tktoutline.vim - A plugin to make TEKITOU outline
"
" Version: 1.0
" Maintainer:	yaasita < https://github.com/yaasita/tktoutline >
" Last Change:	2012/10/27 07:13:45.

"initial setting
let g:tkt_outline_gcommand=['^\*']
let g:tkt_outline_scommand=['\[.\+\]']

command! TktOutline call <SID>tktOutline()
"Function: s:tktOutline() {{{1
function! s:tktOutline()
    if bufexists("TktOutline")
        bw TktOutline
    endif
    let l:lines = getline(1,"$")
    vertical 40 split TktOutline
    setlocal bt=nofile noswf
    silent! 1,$delete

    let l:i=1
    while l:i < len(l:lines)+1
        call setline(l:i,l:lines[l:i-1]." ... ".l:i)
        let l:i += 1
    endwhile

    for gc in g:tkt_outline_gcommand
        exec 'silent! %g!/'.gc.'/d'
    endfor

    for sc in g:tkt_outline_scommand
        exec 'silent! %s/'.sc.'//'
    endfor
    :1
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

