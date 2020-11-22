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

" git conflict jump
nnoremap <silent> c[ /\v^[<>=\|]{4,7}($\|\s\|\r)<CR>
nnoremap <silent> c] ?\v^[<>=\|]{4,7}($\|\s\|\r)<CR>

" neovim terminal
if has('nvim')
  nnoremap <Leader>c :tabnew +terminal<CR>
  tnoremap <Leader>c <C-\><C-n>:tabnew +terminal<CR>
  autocmd TermOpen * tnoremap <Esc> <C-\><C-n>
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
endif
