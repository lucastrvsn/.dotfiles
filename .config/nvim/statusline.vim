set laststatus=2

let g:current_mode = {
  \ 'n': 'normal',
  \ 'v': 'visual',
  \ 'V': 'vline',
  \ "\<C-V>": 'vblock',
  \ 'i': 'insert',
  \ 'R': 'replace',
  \ 'Rv': 'vreplace',
  \ 'c': 'command',
  \ 't': 'terminal',
\}

function! CurrentMode() abort
  let l:current = mode()
  return get(g:current_mode, l:current, l:current)
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

function! ActiveStatusLine() abort
  let l:statusline=""
  let l:statusline.="%3* %{CurrentMode()} "
  let l:statusline.="%2*%{Modified()}"
  let l:statusline.="%1* %t "
  let l:statusline.="%2*[%n%R%W]"
  let l:statusline.="%4*%=" " right side
  let l:statusline.="%2* %{LinePercent()} "
  let l:statusline.="%1* %{FileType()} "
  return l:statusline
endfunction

function! InactiveStatusLine() abort
  let l:statusline=""
  let l:statusline.="%3* %t "
  let l:statusline.="%5*"
  return l:statusline
endfunction

" set statusline= " left side
" set statusline+=%#ToolbarLine#
" set statusline+=%{&modified?'\ •':''}
" set statusline+=\ [%n%H%R%W]%*\
" set statusline+=%F
" set statusline+=%= " right side
" set statusline+=%#Statement#%{fugitive#head()}%*\
" set statusline+=%l/%L\ %p%%\

function! SetActiveStatusLine() abort
  setlocal statusline=
  setlocal statusline+=%!ActiveStatusLine()
endfunction

function! SetInactiveStatusLine() abort
  setlocal statusline=
  setlocal statusline+=%!InactiveStatusLine()
endfunction

hi link User1 StatusLine
hi link User2 StatusLineNC
hi link User3 DiffText
hi link User4 NonText

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * call SetActiveStatusLine()
  autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
augroup end

