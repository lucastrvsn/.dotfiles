vim.api.nvim_exec([[
let dirvish_mode = ':sort ,^.*/,'

command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

"augroup dirvish_config
"  autocmd!
"
"  autocmd FileType dirvish
"    \ nnoremap <silent><buffer> <C-v> :call dirvish#open('vsplit', 0)<CR>
"    \ xnoremap <silent><buffer> <C-v> :call dirvish#open('vsplit', 0)<CR>
"    \ nnoremap <silent><buffer> <C-x> :call dirvish#open('split', 0)<CR>
"    \ xnoremap <silent><buffer> <C-x> :call dirvish#open('split', 0)<CR>
"augroup END
]], true)
