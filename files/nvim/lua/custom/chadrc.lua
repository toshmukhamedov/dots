local M = {}
local opt = vim.opt

-- Indenting
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.cursorline = true

-- Numbers
opt.scrolloff = 10
opt.mousescroll = "ver:1,hor:2"
opt.relativenumber = true
opt.numberwidth = 2
opt.textwidth = 120
opt.colorcolumn = "+1"
opt.ruler = false

-- Lsp completions height
opt.pumheight = 10

-- Ignore case on command mode
opt.smartcase = false

-- Custom plugins
M.plugins = "custom.plugins"

-- Custom mappings
M.mappings = require "custom.mappings"


-- Fix cursor shape
vim.cmd([[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver20
    augroup END
]])

return M
