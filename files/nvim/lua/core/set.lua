local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.scrolloff = 10
opt.wrap = false
opt.eol = false
opt.fixeol = false

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.mousescroll = "ver:1,hor:2"
opt.relativenumber = true
opt.textwidth = 120
opt.colorcolumn = "+1"

-- Lsp completions height
opt.pumheight = 10

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- LSP things
-- vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "
