[< Back](../README.md#dotfiles)

# Neovim Config

The configurations for [Neovim](https://neovim.io), which is my text editor of
choice.

---

## `<<<setup-neovim>>>`

```sh macro:setup-neovim
setup_neovim() {
    rm -rf $HOME/.config/nvim
    mkdir -p $HOME/.config/nvim
    ln -sf $(realpath $dot_dir/neovim/init.lua) $HOME/.config/nvim/init.lua
}
```

---

## [init.lua](init.lua)

Link/copy this file to `$HOME/.config/nvim/init.lua`.

```lua file:init.lua
-- init.lua - Neovim configuration

<<<general-settings>>>

<<<general-keybinds>>>

<<<lazy-setup>>>

<<<treesitter-configs>>>

<<<lsp-configs>>>

<<<mini-nvim-configs>>>

<<<misc-plugins-configs>>>

<<<appearance>>>
```

### `<<<general-settings>>>`

Settings that don't require plugins to work.

```lua macro:general-settings
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
vim.o.exrc = true
```

### `<<<general-keybinds>>>`

Keybinds that don't require plugins to work.

```lua macro:general-keybinds
vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader><leader>fp", ":w<CR>:!prettier . --write")
```

### `<<<lazy-setup>>>`

Setup [lazy.nvim](https://github.com/folke/lazy.nvim) as my plugin manager.

```lua macro:lazy-setup
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
```

### `<<<treesitter-configs>>>`

Sets up:

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [playground](https://github.com/nvim-treesitter/playground)
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)

```lua macro:treesitter-configs
require("nvim-treesitter.configs").setup({
    highlight = { enable = true, },
    playground = { enable = true, },
})

require("treesitter-context").setup()
```

### `<<<lsp-configs>>>`:

Sets up:

- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

```lua macro:lsp-configs
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
    vim.keymap.set("n", "<space>lf", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
```

Part of the above config was pulled from
[here (the nvim-lspconfig GitHub repo)](https://github.com/neovim/nvim-lspconfig#suggested-configuration).

### `<<<mini-nvim-configs>>>`

Sets up [mini.nvim](https://github.com/echasnovski/mini.nvim).

```lua macro:mini-nvim-configs
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
```

### `<<<misc-plugins-configs>>>`

Sets up:

- [rainbow-delimiters.nvim](https://gitlab.com/HiPhish/rainbow-delimiters.nvim)

```lua macro:misc-plugins-configs
require("rainbow-delimiters.setup").setup()
require("hex").setup()
require("oil").setup()
require("femaco").setup()
```

### `<<<appearance>>>`

Make Neovim bareable to look at.

```lua macro:appearance
vim.cmd("<<<colorscheme>>>")

vim.o.statusline = " %f %m %= %p%% %l:%c "
```

#### `<<<colorscheme>>>`

Use the terminal's default 16 colors.

```vim macro:colorscheme
hi Normal           ctermbg=black       ctermfg=white
hi Terminal         ctermbg=black       ctermfg=white
hi EndOfBuffer      ctermbg=black       ctermfg=white
hi FoldColumn       ctermbg=darkgray    ctermfg=white
hi Folded           ctermbg=darkgray    ctermfg=white
hi SignColumn       ctermbg=black       ctermfg=white
hi ToolbarLine      ctermbg=black       ctermfg=white
hi Cursor                                                    cterm=reverse
hi vCursor                                                   cterm=reverse
hi iCursor                                                   cterm=reverse
hi lCursor                                                   cterm=reverse
hi CursorIM                                                  cterm=reverse
hi CursorColumn     ctermbg=darkgray                         cterm=bold
hi CursorLine                                                cterm=bold
hi ColorColumn      ctermbg=red         ctermfg=black        cterm=bold
hi CursorLineNr     ctermbg=blue        ctermfg=black        cterm=bold
hi LineNr           ctermbg=black       ctermfg=darkgray
hi Conceal          ctermbg=darkgray    ctermfg=white
hi DiffAdd          ctermbg=black       ctermfg=lightgreen
hi DiffChange       ctermbg=black       ctermfg=yellow
hi DiffDelete       ctermbg=black       ctermfg=red
hi DiffText         ctermbg=black       ctermfg=white
hi DiffAdded        ctermbg=black       ctermfg=lightgreen
hi DiffChanged      ctermbg=black       ctermfg=yellow
hi DiffFile         ctermbg=black       ctermfg=lightcyan
hi DiffIndexLine    ctermbg=black       ctermfg=darkgray
hi Directory        ctermbg=black       ctermfg=lightblue
hi ErrorMsg         ctermbg=black       ctermfg=red          cterm=bold
hi WarningMsg       ctermbg=black       ctermfg=yellow       cterm=bold
hi MoreMsg          ctermbg=black       ctermfg=lightblue    cterm=bold
hi CurSearch        ctermbg=yellow      ctermfg=black        cterm=bold
hi IncSearch        ctermbg=yellow      ctermfg=black        cterm=bold
hi Search           ctermbg=yellow      ctermfg=black        cterm=bold
hi Substitute       ctermbg=lightgreen  ctermfg=black        cterm=bold
hi MatchParen       ctermbg=white                            cterm=underline
hi NonText          ctermbg=black       ctermfg=blue
hi Whitespace       ctermbg=black       ctermfg=blue
hi SpecialKey       ctermbg=black       ctermfg=blue
hi Pmenu            ctermbg=black       ctermfg=white
hi PmenuSbar        ctermbg=black       ctermfg=white
hi PmenuSel         ctermbg=white       ctermfg=black
hi WildMenu         ctermbg=white       ctermfg=black
hi PmenuThumb       ctermbg=white       ctermfg=black
hi Question         ctermbg=black       ctermfg=yellow
hi SpellBad         ctermbg=black       ctermfg=red          cterm=underline
hi SpellCap         ctermbg=black       ctermfg=yellow       cterm=underline
hi SpellLocal       ctermbg=black       ctermfg=lightblue    cterm=underline
hi SpellRare        ctermbg=black       ctermfg=lightmagenta cterm=underline
hi StatusLine       ctermbg=black       ctermfg=white
hi StatusLineTerm   ctermbg=black       ctermfg=white
hi StatusLineNC     ctermbg=white       ctermfg=black
hi StatusLineTermNC ctermbg=white       ctermfg=black
hi TabLine          ctermbg=black       ctermfg=white
hi TabLineFill      ctermbg=black       ctermfg=white
hi TabLineSel       ctermbg=white       ctermfg=black
hi WinSeparator                         ctermfg=darkgray
hi Visual           ctermbg=blue        ctermfg=black        cterm=bold
hi VisualNOS        ctermbg=blue        ctermfg=black        cterm=bold
hi QuickFixLine     ctermbg=black       ctermfg=lightblue    cterm=underline
hi Debug            ctermbg=black       ctermfg=yellow
hi debugPC          ctermbg=black       ctermfg=lightgreen
hi debugBreakpoint  ctermbg=black       ctermfg=red
hi ToolbarButton    ctermbg=black       ctermfg=lightblue
hi FloatBorder      ctermbg=black       ctermfg=darkgray
hi NormalFloat      ctermbg=black       ctermfg=white
hi String           ctermbg=black       ctermfg=green
hi Character        ctermbg=black       ctermfg=yellow
hi Number           ctermbg=black       ctermfg=yellow
hi Float            ctermbg=black       ctermfg=yellow
hi Boolean          ctermbg=black       ctermfg=yellow
hi Type             ctermbg=black       ctermfg=lightyellow
hi Structure        ctermbg=black       ctermfg=lightyellow
hi StorageClass     ctermbg=black       ctermfg=lightyellow
hi Identifier       ctermbg=black       ctermfg=red
hi Constant         ctermbg=black       ctermfg=cyan
hi PreProc          ctermbg=black       ctermfg=magenta
hi PreCondit        ctermbg=black       ctermfg=magenta
hi Include          ctermbg=black       ctermfg=magenta
hi Keyword          ctermbg=black       ctermfg=magenta
hi Define           ctermbg=black       ctermfg=magenta
hi Typedef          ctermbg=black       ctermfg=lightyellow
hi Exception        ctermbg=black       ctermfg=magenta
hi Conditional      ctermbg=black       ctermfg=magenta
hi Macro            ctermbg=black       ctermfg=red
hi Error            ctermbg=black       ctermfg=magenta
hi Label            ctermbg=black       ctermfg=magenta
hi Special          ctermbg=black       ctermfg=red
hi SpecialChar      ctermbg=black       ctermfg=red
hi Function         ctermbg=black       ctermfg=lightblue
hi Operator         ctermbg=black       ctermfg=magenta
hi Title            ctermbg=black       ctermfg=cyan
hi Tag              ctermbg=black       ctermfg=green
hi Delimiter        ctermbg=black       ctermfg=white
hi Comment          ctermbg=black       ctermfg=blue
hi SpecialComment   ctermbg=black       ctermfg=blue
hi Todo             ctermbg=black       ctermfg=red
```
