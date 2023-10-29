set number
set cursorline
set shiftwidth=2
set tabstop=2
set termguicolors
set hidden

lua require('lua/lazy')
lua require('config')

colorscheme catppuccin-mocha

:COQnow -s

nnoremap <F3> :lua require'dapui'.toggle()<CR>
nnoremap <leader>t :NvimTreeToggle<CR>
noremap <leader>e :bn<CR> 
