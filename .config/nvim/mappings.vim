" I always type W and Q, so abbrev to q and w
cnoreabbrev W w
cnoreabbrev Q q

" moving up and down the right way
nnoremap <silent>j gj
nnoremap <silent>k gk
nnoremap <silent>^ g^
nnoremap <silent>$ g$

" remove arrow keys mappings
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
endfor

" save as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" open my vim config
nnoremap <Leader>rc :e $MYVIMRC<CR>

" keep visual selection when indenting
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" deal with clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" buffer navigation
map <Leader>, <C-^>
map <Leader>ls :buffers<CR>
map gb :bnext<CR>
map gB :bprev<CR>

" git conflict jump
nnoremap <silent> <Leader>gc /\v^[<>=\|]{4,7}($\|\s\|\r)<CR>
nnoremap <silent> <Leader>gC ?\v^[<>=\|]{4,7}($\|\s\|\r)<CR>

" search and replace the word under cursor
nmap <Leader>* :%s/\<<C-r><C-w>\>//<Left>

" neovim terminal
if has('nvim')
  nnoremap <Leader>t :tabnew +terminal<CR>
  tnoremap <Leader>t <C-\><C-n>:tabnew +terminal<CR>
  autocmd TermOpen * tnoremap <Esc> <C-\><C-n>
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
endif
