" vim: set sw=4 et fdm=marker:
"
"
" tktoutline.vim - A plugin to make TEKITOU outline
"
" Version: 1.0
" Maintainer:	yaasita 
" Last Change:	2012/10/27 06:27:55.

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


"================
":scriptencoding utf-8
"" 1�x�X�N���v�g��ǂݍ��񂾂�A2�x�ڂ͓ǂݍ��܂Ȃ�
":if &cp || exists("g:loaded_catn")
"    :finish
":endif
":let g:loaded_catn = 1
"
"" ���[�U�̏����ݒ�𓦂���
":let s:save_cpo = &cpo
":set cpo&vim
"
"" �����̐��ŏ����𕪊򂷂�B
":function! s:Catn(...) range
"    :if len(a:000) == 0
"        :call s:CatnFormat("%d ", 1, a:firstline, a:lastline)
"    :elseif len(a:000) == 1
"        :call s:CatnFormat("%d ", a:1, a:firstline, a:lastline)
"    :else
"        :call s:CatnFormat(a:1, a:2, a:firstline, a:lastline)
"    :endif
":endfunction
"
"" �w��͈͂̐擪�ɁA�w��t�H�[�}�b�g�̘A�Ԃ�}������B
":function! s:CatnFormat(format, start_no, start, end)
"    " ���Ԃɍs��u�������Ă���
"    :let l:i = 0
"    :while (a:start + l:i) <= a:end
"        " �A�Ԃ̍쐬
"        :let l:no_fmt = printf(a:format, a:start_no + l:i)
"        " �s�̒u������
"        :let l:line_fmt = printf("%s%s", l:no_fmt, getline(a:start + l:i))
"        :call setline(a:start + l:i, l:line_fmt)
"        :let l:i += 1
"    :endwhile
":endfunction
"
"" �����ς̃R�}���h�̒�`�B
":command! -narg=* -range Catn :<line1>,<line2>call s:Catn(<f-args>)
"
"" �ޔ����Ă������[�U�̃f�[�^�����J�o��
":let &cpo = s:save_cpo
"" �X�N���v�g�͂����܂�
":finish
"
"==============================================================================
"catn.vim : �s�擪�ɘA�Ԃ�}������X�N���v�g
"------------------------------------------------------------------------------
"$VIMRUNTIMEPATH/plugin/catn.vim
"==============================================================================
"author  : ���� ��
"url     : http://nanasi.jp/
"email   : mail@nanasi.jp
"version : 2009/12/19 16:00:00
"==============================================================================
"�I�������͈͂̐擪�ɘA�Ԃ�}������BUnix��"cat -n"
"
":'<,'>Catn {�t�H�[�}�b�g} {�J�n�l}
":'<,'>Catn [{�J�n�l}]
"
":'<,'>Catn
":'<,'>Catn 1000
":'<,'>Catn %08d\  500
"
"==============================================================================
"" vim: set et ft=vim nowrap :
