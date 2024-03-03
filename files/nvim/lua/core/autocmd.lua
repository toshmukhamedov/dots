local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Fix cursor shape
autocmd(
    { "VimLeave" },
    { pattern = "*", command = "set guicursor=a:ver20" }
)

