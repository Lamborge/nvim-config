:set number
:set cursorline

lua require('config')
lua require('nvim-tree')

:set shiftwidth=2
:set tabstop=2

:COQnow -s

nnoremap <F3> :lua require'dapui'.toggle()<CR>
nnoremap <leader>t :NvimTreeToggle<CR>
noremap <leader>e :bn<CR> 
