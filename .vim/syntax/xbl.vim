" Vim syntax file
" Language:	XBL build file (xml)
" Maintainer:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Tue Apr 27 13:05:59 CEST 2004
" Filenames:	build.xml
" $Id: $

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:xbl_cpo_save = &cpo
set cpo&vim

runtime! syntax/xml.vim

syn case ignore

if !exists('*XblSyntaxScript')
    fun XblSyntaxScript(tagname, synfilename)
	unlet b:current_syntax
	let s:include = expand("<sfile>:p:h").'/'.a:synfilename
	if filereadable(s:include)
	    exe 'syn include @xbl'.a:tagname.' '.s:include
	else
	    exe 'syn include @xbl'.a:tagname." $VIMRUNTIME/syntax/".a:synfilename
	endif

	exe 'syn region xbl'.a:tagname
		    \.' start="<!\[CDATA\["'
		    \.' end="\]\]>"'
		    \.' fold'
		    \.' contains=@xbl'.a:tagname.',xmlCdataStart,xmlCdataEnd,xmlTag,xmlEndTag'
	exe 'syn cluster xmlRegionHook add=xbl'.a:tagname
    endfun
endif

" TODO: add more script languages here ?
call XblSyntaxScript('javascript', 'javascript.vim')

syn cluster xmlTagHook add=xblElement

syn keyword xblElement place_holder_here_ok

hi def link xblElement Statement

let b:current_syntax = "xbl"

let &cpo = s:xbl_cpo_save
unlet s:xbl_cpo_save

" vim: ts=8
