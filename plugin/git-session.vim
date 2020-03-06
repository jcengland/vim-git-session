" vim-git-session.vim - A wrapper to save a session per branch

" Author: Raúl Naveiras <rnaveiras@gmail.com>
" Version: 0.0.1
" License: MIT
" Last Modified: August 28, 2012
" URL: git://github.com/rnaveiras/vim-git-session.git

if exists('g:loaded_vim_git_session') || &cp
  finish
endif

let g:loaded_vim_git_session = 1
let s:git_executable="git"

function! s:GitRepoName()
  " git remote -v |awk -F. '/push/ {c=$2; gsub(/com:/,"",c); gsub(/\//,"-", c); print c}'
 let s:repo_name = system(s:git_executable . " remote -v |awk -F. '/push/ {print $2}'")
 let s:repo_name = substitute(s:repo_name, 'com:', '', '')
 let s:repo_name = substitute(s:repo_name, '/', '-', 'g')
 let s:repo_name = substitute(s:repo_name, '\n$', '', '')
 return s:repo_name
endfunction

function! s:GitBranch()
  let s:branch = system(s:git_executable . " branch 2>/dev/null | grep '*' | sed 's/\* //'")
  let s:branch = substitute(s:branch, '/', '-', 'g')
  let s:branch = substitute(s:branch, '\n$', '-', '')
  return s:branch
endfunction

function! s:PrepareSessionsPath()
  if isdirectory($HOME . '/.vim/sessions') == 0
    :silent !mkdir -p ~/.vim/sessions >/dev/null 2>&1
  endif
  let s:sessionspath = "~/.vim/sessions/"
endfunction

function! SaveCurrentSession()
  if !exists('s:session_loading')
    silent! execute s:PrepareSessionsPath()
    execute "mksession! " . s:sessionspath . s:GitBranch() . s:GitRepoName() . "-session.vim"
  endif
endfunction

function! OpenCurrentSession()
  silent! execute s:PrepareSessionsPath()
  let s:session_loading = 'yes'
  execute "source " . s:sessionspath . s:GitBranch() . s:GitRepoName() . "-session.vim"
  unlet s:session_loading
endfunction

if exists('g:session_autosave') && g:session_autosave == 'yes'
  au BufLeave * call SaveCurrentSession()
endif

nmap <silent> <leader>S :call SaveCurrentSession()<CR>
nmap <silent> <leader>O :call OpenCurrentSession()<CR>
