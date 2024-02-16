---@type ChadrcConfig
local M = {}
local opt = vim.opt
-- local g = vim.g

-- Indenting
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Numbers
opt.relativenumber = true
opt.numberwidth = 2
opt.textwidth = 120
opt.colorcolumn = "+1"
opt.ruler = false

-- Ignore case on command mode
opt.smartcase = false

M.ui = {
    hl_override = {
        Comment = {
            italic = true
        },
        Keyword = {
            bold = true
        },
    },
    lsp_semantic_tokens = true,
    theme = 'gruvbox',
    statusline = {
        theme = "minimal"
    },
    cmp = {
        icons = false
    },
    cheatsheet = {
        theme = "simple"
    },
    transparency = true
}

-- Custom plugins
M.plugins = "custom.plugins"

-- Fix cursor shape
vim.cmd([[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver20
    augroup END
]])

return M
