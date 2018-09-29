" =============================================================================
" File:          autoload/ctrlp/oldfiles.vim
" Description:   Find files saved in viminfo: jumplist, changelist, marks ...
" Author:        Kien Nguyen <github.com/kien>
" =============================================================================

" User Configuration {{{1
" Enable:
"        let g:ctrlp_extensions += ['oldfiles']
" Create A Command:
"        com! CtrlPOF cal ctrlp#init(ctrlp#oldfiles#id())
"}}}

" Init {{{1
if ( exists('g:loaded_ctrlp_oldfiles') && g:loaded_ctrlp_oldfiles )
	\ || !has('viminfo')
	fini
en
let g:loaded_ctrlp_oldfiles = 1

let s:oldfiles_var = {
	\ 'init': 'ctrlp#oldfiles#init()',
	\ 'accept': 'ctrlp#oldfiles#accept',
	\ 'lname': 'oldfiles',
	\ 'sname': 'olf',
	\ 'type': 'path',
	\ }

let g:ctrlp_ext_vars = exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
	\ ? add(g:ctrlp_ext_vars, s:oldfiles_var) : [s:oldfiles_var]

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Public {{{1
fu! ctrlp#oldfiles#init()
	retu filter(map(copy(v:oldfiles), 'expand(v:val)'), 'filereadable(v:val)')
endf

fu! ctrlp#oldfiles#accept(mode, str)
	cal ctrlp#acceptfile(a:mode, a:str)
endf

fu! ctrlp#oldfiles#id()
	retu s:id
endf
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2