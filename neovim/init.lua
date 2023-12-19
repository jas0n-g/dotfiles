-- init.lua - Neovim configuration

-- enable (relative) line numbers
vim.o.number = true
vim.o.relativenumber = true

-- tab setings
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = 2
vim.o.smartindent = true

-- backup settings
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = false

-- search settings
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- misc settings
vim.o.colorcolumn = "80"
vim.o.scrolloff = 8
vim.o.cursorline = true
vim.o.termguicolors = false

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    
    "echasnovski/mini.nvim",

    "HiPhish/rainbow-delimiters.nvim",
    "RaafatTurki/hex.nvim",
    "stevearc/oil.nvim",
    "AckslD/nvim-FeMaco.lua",

    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
    }
})

require("nvim-treesitter.configs").setup({
    highlight = { enable = true, },
    playground = { enable = true, },
})

require("treesitter-context").setup()

local lspconfig = require("lspconfig")

local default_setup = function(server)
  lspconfig[server].setup{}
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {},
  handlers = {default_setup},
})

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }
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
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

require("mini.ai").setup()
require("mini.animate").setup()
require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.comment").setup()
require("mini.fuzzy").setup()
require("mini.move").setup()
require("mini.pairs").setup()

require("mini.completion").setup({
  fallback_action = "<C-x><C-p>",
  delay = { completion = 0, info = 50, signature = 25, },
})

require("mini.pick").setup()
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")

require("rainbow-delimiters.setup").setup()
require("hex").setup()
require("oil").setup()
require("femaco").setup()

vim.cmd("hi Normal           ctermbg=black       ctermfg=white")
vim.cmd("hi Terminal         ctermbg=black       ctermfg=white")
vim.cmd("hi EndOfBuffer      ctermbg=black       ctermfg=white")
vim.cmd("hi FoldColumn       ctermbg=darkgray    ctermfg=white")
vim.cmd("hi Folded           ctermbg=darkgray    ctermfg=white")
vim.cmd("hi SignColumn       ctermbg=black       ctermfg=white")
vim.cmd("hi ToolbarLine      ctermbg=black       ctermfg=white")
vim.cmd("hi Cursor                                                    cterm=reverse")
vim.cmd("hi vCursor                                                   cterm=reverse")
vim.cmd("hi iCursor                                                   cterm=reverse")
vim.cmd("hi lCursor                                                   cterm=reverse")
vim.cmd("hi CursorIM                                                  cterm=reverse")
vim.cmd("hi CursorColumn     ctermbg=darkgray                         cterm=bold")
vim.cmd("hi CursorLine                                                cterm=bold")
vim.cmd("hi ColorColumn      ctermbg=red         ctermfg=black        cterm=bold")
vim.cmd("hi CursorLineNr     ctermbg=blue        ctermfg=black        cterm=bold")
vim.cmd("hi LineNr           ctermbg=black       ctermfg=darkgray")
vim.cmd("hi Conceal          ctermbg=darkgray    ctermfg=white")
vim.cmd("hi DiffAdd          ctermbg=black       ctermfg=lightgreen")
vim.cmd("hi DiffChange       ctermbg=black       ctermfg=yellow")
vim.cmd("hi DiffDelete       ctermbg=black       ctermfg=red")
vim.cmd("hi DiffText         ctermbg=black       ctermfg=white")
vim.cmd("hi DiffAdded        ctermbg=black       ctermfg=lightgreen")
vim.cmd("hi DiffChanged      ctermbg=black       ctermfg=yellow")
vim.cmd("hi DiffFile         ctermbg=black       ctermfg=lightcyan")
vim.cmd("hi DiffIndexLine    ctermbg=black       ctermfg=darkgray")
vim.cmd("hi Directory        ctermbg=black       ctermfg=lightblue")
vim.cmd("hi ErrorMsg         ctermbg=black       ctermfg=red          cterm=bold")
vim.cmd("hi WarningMsg       ctermbg=black       ctermfg=yellow       cterm=bold")
vim.cmd("hi MoreMsg          ctermbg=black       ctermfg=lightblue    cterm=bold")
vim.cmd("hi CurSearch        ctermbg=yellow      ctermfg=black        cterm=bold")
vim.cmd("hi IncSearch        ctermbg=yellow      ctermfg=black        cterm=bold")
vim.cmd("hi Search           ctermbg=yellow      ctermfg=black        cterm=bold")
vim.cmd("hi Substitute       ctermbg=lightgreen  ctermfg=black        cterm=bold")
vim.cmd("hi MatchParen       ctermbg=white                            cterm=underline")
vim.cmd("hi NonText          ctermbg=black       ctermfg=blue")
vim.cmd("hi Whitespace       ctermbg=black       ctermfg=blue")
vim.cmd("hi SpecialKey       ctermbg=black       ctermfg=blue")
vim.cmd("hi Pmenu            ctermbg=black       ctermfg=white")
vim.cmd("hi PmenuSbar        ctermbg=black       ctermfg=white")
vim.cmd("hi PmenuSel         ctermbg=white       ctermfg=black")
vim.cmd("hi WildMenu         ctermbg=white       ctermfg=black")
vim.cmd("hi PmenuThumb       ctermbg=white       ctermfg=black")
vim.cmd("hi Question         ctermbg=black       ctermfg=yellow")
vim.cmd("hi SpellBad         ctermbg=black       ctermfg=red          cterm=underline")
vim.cmd("hi SpellCap         ctermbg=black       ctermfg=yellow       cterm=underline")
vim.cmd("hi SpellLocal       ctermbg=black       ctermfg=lightblue    cterm=underline")
vim.cmd("hi SpellRare        ctermbg=black       ctermfg=lightmagenta cterm=underline")
vim.cmd("hi StatusLine       ctermbg=black       ctermfg=white")
vim.cmd("hi StatusLineTerm   ctermbg=black       ctermfg=white")
vim.cmd("hi StatusLineNC     ctermbg=white       ctermfg=black")
vim.cmd("hi StatusLineTermNC ctermbg=white       ctermfg=black")
vim.cmd("hi TabLine          ctermbg=black       ctermfg=white")
vim.cmd("hi TabLineFill      ctermbg=black       ctermfg=white")
vim.cmd("hi TabLineSel       ctermbg=white       ctermfg=black")
vim.cmd("hi WinSeparator                         ctermfg=darkgray")
vim.cmd("hi Visual           ctermbg=blue        ctermfg=black        cterm=bold")
vim.cmd("hi VisualNOS        ctermbg=blue        ctermfg=black        cterm=bold")
vim.cmd("hi QuickFixLine     ctermbg=black       ctermfg=lightblue    cterm=underline")
vim.cmd("hi Debug            ctermbg=black       ctermfg=yellow")
vim.cmd("hi debugPC          ctermbg=black       ctermfg=lightgreen")
vim.cmd("hi debugBreakpoint  ctermbg=black       ctermfg=red")
vim.cmd("hi ToolbarButton    ctermbg=black       ctermfg=lightblue")
vim.cmd("hi FloatBorder      ctermbg=black       ctermfg=darkgray")
vim.cmd("hi NormalFloat      ctermbg=black       ctermfg=white")
vim.cmd("hi String           ctermbg=black       ctermfg=green")
vim.cmd("hi Character        ctermbg=black       ctermfg=yellow")
vim.cmd("hi Number           ctermbg=black       ctermfg=yellow")
vim.cmd("hi Float            ctermbg=black       ctermfg=yellow")
vim.cmd("hi Boolean          ctermbg=black       ctermfg=yellow")
vim.cmd("hi Type             ctermbg=black       ctermfg=lightyellow")
vim.cmd("hi Structure        ctermbg=black       ctermfg=lightyellow")
vim.cmd("hi StorageClass     ctermbg=black       ctermfg=lightyellow")
vim.cmd("hi Identifier       ctermbg=black       ctermfg=red")
vim.cmd("hi Constant         ctermbg=black       ctermfg=cyan")
vim.cmd("hi PreProc          ctermbg=black       ctermfg=magenta")
vim.cmd("hi PreCondit        ctermbg=black       ctermfg=magenta")
vim.cmd("hi Include          ctermbg=black       ctermfg=magenta")
vim.cmd("hi Keyword          ctermbg=black       ctermfg=magenta")
vim.cmd("hi Define           ctermbg=black       ctermfg=magenta")
vim.cmd("hi Typedef          ctermbg=black       ctermfg=lightyellow")
vim.cmd("hi Exception        ctermbg=black       ctermfg=magenta")
vim.cmd("hi Conditional      ctermbg=black       ctermfg=magenta")
vim.cmd("hi Macro            ctermbg=black       ctermfg=red")
vim.cmd("hi Error            ctermbg=black       ctermfg=magenta")
vim.cmd("hi Label            ctermbg=black       ctermfg=magenta")
vim.cmd("hi Special          ctermbg=black       ctermfg=red")
vim.cmd("hi SpecialChar      ctermbg=black       ctermfg=red")
vim.cmd("hi Function         ctermbg=black       ctermfg=lightblue")
vim.cmd("hi Operator         ctermbg=black       ctermfg=magenta")
vim.cmd("hi Title            ctermbg=black       ctermfg=cyan")
vim.cmd("hi Tag              ctermbg=black       ctermfg=green")
vim.cmd("hi Delimiter        ctermbg=black       ctermfg=white")
vim.cmd("hi Comment          ctermbg=black       ctermfg=blue")
vim.cmd("hi SpecialComment   ctermbg=black       ctermfg=blue")
vim.cmd("hi Todo             ctermbg=black       ctermfg=red")

vim.o.statusline = " %f %m %= %p%% %l:%c "
