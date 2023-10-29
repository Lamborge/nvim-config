for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/plugins', [[v:val =~ '\.lua$']])) do
	require('plugins.'..file:gsub('%.lua$', ''))
end

require("ibl").setup()
require('Comment').setup()
require("bufferline").setup{}
require("scope").setup({})
require("nvim-tree").setup {}
require("inc_rename").setup()
require('nvim-terminal').setup()
require('nvim-autopairs').setup({ map_cr = true })
