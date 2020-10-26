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

" keep visual selection when indenting
vmap <silent> < <gv
vmap <silent> > >gv

" deal with clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

" neovim terminal
if has('nvim')
  nnoremap <leader>c :tabnew +terminal<cr>
  tnoremap <leader>c <C-\><C-n>:tabnew +terminal<cr>

  autocmd TermOpen * tnoremap <Esc> <C-\><C-n>
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
endif
