set laststatus=2

let g:modes = {
  \ 'n':      ['normal', '%2*'],
  \ 'v':      ['visual', '%4*'],
  \ 'V':      ['v-line', '%4*'],
  \ "\<C-V>": ['v-block', '%4*'],
  \ 'i':      ['insert', '%3*'],
  \ 'R':      ['replace', '%5*'],
  \ 'Rv':     ['v-replace', '%5*'],
  \ 'c':      ['command', '%2*'],
  \ 't':      ['terminal', '%2*'],
\}

function! CurrentModeText() abort
  let l:current = mode()
  return get(g:modes, l:current, l:current)[0]
endfunction

function! CurrentModeColor() abort
  let l:current = mode()
  return get(g:modes, l:current, l:current)[1]
endfunction

function! LinePercent() abort
  return printf("%d%%", line('.') * 100 / line('$'))
endfunction

function! Modified() abort
  return &modified ? " •" : ""
endfunction

function! FileType() abort
  return len(&filetype) == 0 ? "text" : tolower(&filetype)
endfunction

function! GitBranch() abort
  let l:branch = fugitive#head()
  let l:text = ""

  if l:branch != ""
    let l:text.=" "
    let l:text.="[" . l:branch . "]"
  endif

  return l:text
endfunction

function! ActiveStatusLine() abort
  let l:mode = mode()
  let l:statusline=''
  let l:statusline.=CurrentModeColor() . ' ' . CurrentModeText() . ' '
  let l:statusline.='%1*%{Modified()}'
  let l:statusline.=' %t '
  let l:statusline.='%7*[%n%R%W]'
  let l:statusline.='%6*%{GitBranch()}'
  let l:statusline.='%*%=' " right side
  let l:statusline.='%1* %{FileType()} %7*|%1* %l:%c %7*|%1* %{LinePercent()} '
  return l:statusline
endfunction

function! InactiveStatusLine() abort
  let l:statusline=''
  let l:statusline.='%1* %t %*'
  return l:statusline
endfunction

function! SetActiveStatusLine() abort
  setlocal statusline=
  setlocal statusline+=%!ActiveStatusLine()
endfunction

function! SetInactiveStatusLine() abort
  setlocal statusline=
  setlocal statusline+=%!InactiveStatusLine()
endfunction

let s:white  = '#f7f2e7'
let s:black  = '#3f3f44'
let s:green  = '#8fc0a9'
let s:red    = '#b83b5e'
let s:yellow = '#f6cd61'
let s:purple = '#af8baf'
let s:orange   = '#f8b24f'

" get statusline colorscheme colors considering reverse
if synIDattr(synIDtrans(hlID('StatusLine')), 'reverse', 'gui') == 1
  let s:slBgGui = synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
  let s:slFgGui = synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui')
else
  let s:slBgGui = synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui')
  let s:slFgGui = synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
endif

if synIDattr(synIDtrans(hlID('StatusLineNC')), 'reverse', 'gui') == 1
  let s:slNCBgGui = synIDattr(synIDtrans(hlID('StatusLineNC')), 'fg', 'gui')
  let s:slNCFgGui = synIDattr(synIDtrans(hlID('StatusLineNC')), 'bg', 'gui')
else
  let s:slNCBgGui = synIDattr(synIDtrans(hlID('StatusLineNC')), 'bg', 'gui')
  let s:slNCFgGui = synIDattr(synIDtrans(hlID('StatusLineNC')), 'fg', 'gui')
endif

" normal text
exec 'hi User1 guibg=' . s:slBgGui . ' guifg=' . s:slFgGui
" normal mode
exec 'hi User2 gui=bold guibg=' . s:green . ' guifg=' . s:black
" insert mode
exec 'hi User3 gui=bold guibg=' . s:red . ' guifg=' . s:white
" visual mode
exec 'hi User4 gui=bold guibg=' . s:yellow . ' guifg=' . s:black
" replace mode
exec 'hi User5 gui=bold guibg=' . s:purple . ' guifg=' . s:white
" git branch
exec 'hi User6 guibg=' . s:slBgGui . ' guifg=' . s:orange
" no color
exec 'hi User7 guibg=' . s:slNCBgGui . ' guifg=' . s:slNCFgGui

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * call SetActiveStatusLine()
  autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
augroup end

