local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Fix cursor shape
-- autocmd(
--     { "VimLeave" },
--     { pattern = "*", command = "set guicursor=a:ver20" }
-- )

-- Command
vim.api.nvim_create_user_command("W", "w", {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end
})
