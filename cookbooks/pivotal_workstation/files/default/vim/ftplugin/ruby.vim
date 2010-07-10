" Vim filetype plugin file
" Language:     Ruby
" Maintainer:   Ned Konz <ned@bike-nomad.com>
" Last Change:  $Date: 2002/08/01 18:10:44 $
" $Id: ruby.vim,v 1.8 2002/08/01 18:10:44 ned Exp $
" Current version is at http://bike-nomad.com/vim
"
" To suppress loading of this plugin, just do this
" in your .vimrc:
" let loaded_ruby_ftplugin = 1

if exists("b:did_ftplugin") | finish | endif
if exists("loaded_ruby_ftplugin") | finish | endif

let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo&vim

" Set this once, globally.
if !exists("rubypath")
  if executable("ruby")
    if &shellxquote == "'"
      let rubypath = system('ruby -e "print $:.join(%q{,})"' )
    else
      let rubypath = system("ruby -e 'print $:.join(%q{,})'" )
    endif
    let rubypath = substitute(rubypath,',.$',',,','')
  else
    " If we can't call ruby to get its path, just default to using the
    " current directory and the directory of the current file.
    let rubypath = ".,,"
  endif
endif
let &l:path=rubypath

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql
setlocal include=^\\s*\\<\\(load\\\|require\\)\\>
setlocal includeexpr=substitute(substitute(v:fname,'::','/','g'),'$','.rb','')
setlocal iskeyword=48-57,_,A-Z,a-z,:
setlocal comments=:#
setlocal define=^\\s*
setlocal suffixesadd=.rb

" The problem with the usual tag browsing is that it doesn't know about
" namespaces. i.e. ABC::def and def may be the same thing.
map <buffer><unique><silent> <C-]> :exec ":tag /".expand("<cword>")<CR>

" Change the browse dialog on Win32 or Motif to show mainly Ruby-related files
if (has("gui_win32") || has("gui_motif")) && !exists("b:browsefilter")
  let b:browsefilter = "Ruby Source Files (*.rb)\t*.rb\n" .
                     \ "All Files (*.*)\t*.*\n"
endif

" Matchit support:
if exists("loaded_matchit")
  if !exists("b:match_words")
    let b:match_ignorecase = 0
    let b:match_words =
\ '\%(\%(\%(^\|[;=]\)\s*\)\@<=\%(class\|module\|while\|begin\|until\|for\|if\|unless\|def\|case\)\|\<do\)\>:' .
\ '\<\%(else\|elsif\|ensure\|rescue\|when\)\>:\%(^\|[^.]\)\@<=\<end\>'
  endif
endif
" \%(\%(^\|[;=]\)\s*\)\@<=
"
let &cpo = s:save_cpo
