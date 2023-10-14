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
    {"nvim-tree/nvim-web-devicons"},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
	'ray-x/navigator.lua',
        requires = {
            { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
            { 'neovim/nvim-lspconfig' },
        },
    },
    {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"neovim/nvim-lspconfig"},
	{'windwp/nvim-autopairs',
    event = "InsertEnter",},
	{'neoclide/coc.nvim', branch = 'release'}
})

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

require('lualine').setup()
require'navigator'.setup()
require('guihua.maps').setup({
maps = {
close_view = '<C-x>',
}
})
require('nvim-autopairs').setup({ map_cr = true })

local lspconfig = require('lspconfig')

-- Настройка lspconfig для clangd с опцией autoformat
lspconfig.clangd.setup{
  autoformat = false,
}
