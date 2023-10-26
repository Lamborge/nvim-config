local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ 'ray-x/navigator.lua',
		requires = {
			{ 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
			{ 'neovim/nvim-lspconfig' },
		},
	},
	{ 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "neovim/nvim-lspconfig" },
	{ 'windwp/nvim-autopairs',
		event = "InsertEnter",
	},
	{ 'ms-jpq/coq_nvim', branch = 'coq' },
	{ 'ms-jpq/coq.artifacts', branch = 'artifacts' },
	{ 'ms-jpq/coq.thirdparty', branch = '3p' },
	{ 'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
})

-- setup parsers
vim.opt.rtp:append(vim.fn.stdpath "config" .. "/parsers")
require'nvim-treesitter.configs'.setup {
  parser_install_dir = "~/.config/nvim/parsers",

  -- ensure_installed = {'c','vim'},

  highlight = {
	  enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
 },
}

vim.cmd.colorscheme "catppuccin-macchiato"

local lualine = require('lualine')
lualine.setup{
	options = { 
		theme = 'auto',
		component_separators = {left = '', right = ''},
		section_separators = { left = '', right = ''},
	}
}

local navigator = require('navigator')
navigator.setup {
	lsp = {
		enable = true,
		format_on_save = false,
	},
}

require('guihua.maps').setup({
	maps = {
		close_view = '<C-x>',
	}
})

require('nvim-autopairs').setup({ map_cr = true })

local lspconfig = require('lspconfig')

lspconfig.clangd.setup {
	opts = {
  	autoformat = false,
	},
}

require("ibl").setup()
