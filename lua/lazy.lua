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
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{ 'jghauser/mkdir.nvim' },
	{ 's1n7ax/nvim-terminal' },
	{ 'numToStr/Comment.nvim', lazy = false },
	{ 'mfussenegger/nvim-dap' },
	{ 'rcarriga/nvim-dap-ui' },
	{ "smjonas/inc-rename.nvim",
	},
	{ 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' },
	{ "tiagovla/scope.nvim" },
	{ 'andweeb/presence.nvim' },
	{ 'dstein64/vim-startuptime' },
})
