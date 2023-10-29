local lspconfig = require('lspconfig')

lspconfig.clangd.setup {
	opts = {
  	autoformat = false,
	},
}
