-- link to ~/.config/nvim/init.lua

-- searching
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- indents / tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- misc settings
vim.o.number = true
vim.g.mapleader = " "
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none', '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end
require("mini.deps").setup({ path = { package = path_package } })

require("mini.ai").setup()
require("mini.animate").setup()
require("mini.basics").setup()
require("mini.comment").setup()
require("mini.indentscope").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup({ use_icons = false })

require("mini.completion").setup({
  lsp_completion = { source_func = "omnifunc", },
  fallback_action = '<C-x><C-n>',
})

MiniDeps.add({ source = "nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter.configs").setup({ highlight = { enable = true } })
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

require("mini.base16").setup({
  palette = {
    base00 = "#181818",
    base01 = "#282828",
    base02 = "#383838",
    base03 = "#585858",
    base04 = "#b8b8b8",
    base05 = "#d8d8d8",
    base06 = "#e8e8e8",
    base07 = "#f8f8f8",
    base08 = "#ab4642",
    base09 = "#dc9656",
    base0A = "#f7ca88",
    base0B = "#a1b56c",
    base0C = "#86c1b9",
    base0D = "#7cafc2",
    base0E = "#ba8baf",
    base0F = "#a16946",
  },
})
MiniDeps.add({ source = "https://github.com/neovim/nvim-lspconfig" })
require("vim.lsp.log").set_format_func(vim.inspect)
local nvim_lsp = require "lspconfig"
local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
end
