require "core.set"
require "core.remap"

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.PATH

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Fix cursor shape
vim.api.nvim_create_autocmd(
    { "VimLeave" },
    { pattern = "*", command = "set guicursor=a:ver20" }
)
