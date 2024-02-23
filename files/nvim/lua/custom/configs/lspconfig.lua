local util = require 'vim.lsp.util'
local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

local formatting_callback = function(client, bufnr)
    vim.keymap.set('n', '<leader>fm', function()
        local params = util.make_formatting_params({})
        client.request('textDocument/formatting', params, nil, bufnr)
    end, { buffer = bufnr })
end

-- Typescript/Javascript
lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Eslint
lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
        formatting_callback(client, bufnr)
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
        autoFixOnSave = true
    }
}
