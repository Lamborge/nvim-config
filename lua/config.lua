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
		config = function()
    	require("nvim-tree").setup {}
  	end,
	},
	{ 'jghauser/mkdir.nvim' },
	{
		's1n7ax/nvim-terminal',
		config = function()
			vim.o.hidden = true
			require('nvim-terminal').setup()
		end,
	},
	{
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
	},
	{ 'mfussenegger/nvim-dap' },
	{ 'rcarriga/nvim-dap-ui' },
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

require('Comment').setup()

require("dapui").setup()
local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
		stopOnEntry = false,
    args = {},
  },
}
