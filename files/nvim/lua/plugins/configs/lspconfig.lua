local M = {}
local utils = require "core.utils"
local util = require 'vim.lsp.util'
local lspconfig = require "lspconfig"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
    utils.load_mappings("lspconfig", { buffer = bufnr })

    -- TODO: Need fix
    -- if client.server_capabilities.signatureHelpProvider then
    --     require("nvchad.signature").setup(client)
    -- end

    require("core.bootstrap").echo(tostring(bufnr))
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end

    if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}


local formatting_callback = function(client, bufnr)
    vim.keymap.set('n', '<leader>fm', function()
        local params = util.make_formatting_params({})
        client.request('textDocument/formatting', params, nil, bufnr)
    end, { buffer = bufnr })
end

-- Typescript/Javascript
local TSOrganizeImports = function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.organizeImports.ts" },
            diagnostics = {},
        },
    })
end
local TSRemoveUnused = function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.removeUnused.ts" },
            diagnostics = {},
        },
    })
end
lspconfig.tsserver.setup {
    root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    single_file_support = true,
    commands = {
        TSOrganizeImports = {
            TSOrganizeImports,
            description = "Organize Imports",
        },
        TSRemoveUnused = {
            TSRemoveUnused,
            description = "Remove unused",
        },
    },
    completions = {
        completeFunctionCalls = true,
    },
    settings = {
        javascript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },

        typescript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
    },
}

-- Eslint
lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
        formatting_callback(client, bufnr)
        M.on_attach(client, bufnr)
    end,
    capabilities = M.capabilities,
    settings = {
        autoFixOnSave = true
    }
}

return M
