return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        init = function()
            -- add binaries installed by mason.nvim to path
            vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.PATH
        end,
        opts = {
            PATH = "skip",
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = "󰄳 ",
                    package_uninstalled = " 󰚌",
                },
                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "X",
                    cancel_installation = "<C-c>",
                },
            },
            max_concurrent_installers = 10,
            ensure_installed = {
                "lua-language-server",
                "typescript-language-server",
                "eslint-lsp",
                "deno",
                "rust-analyzer",
            }, -- not a mason option
        },
        config = function(_, opts)
            require("mason").setup(opts)

            -- custom cmd to install all mason binaries listed
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                if opts.ensure_installed and #opts.ensure_installed > 0 then
                    vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
                end
            end, {})

            vim.g.mason_binaries_list = opts.ensure_installed
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            local util = require 'vim.lsp.util'
            local lspconfig = require "lspconfig"

            -- export on_attach & capabilities for custom lspconfigs
            local function on_attach(client, bufnr)
                -- lsp decorations
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })

                -- lsp definition
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })

                -- lsp hover
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

                -- lsp implementation
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })

                -- lsp signature help
                vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = bufnr })

                -- lsp definition type
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr })

                -- lsp rename
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })

                -- lsp references
                vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr })

                -- floating diagnostics
                vim.keymap.set("n", "<leader>lf", function()
                    vim.diagnostic.open_float { border = "rounded" }
                end, { buffer = bufnr })

                -- goto previous/next diagnostic
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })

                print(client.offset_encoding)
                -- diagnostic setloclist
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr })

                -- workspace
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = bufnr })

                -- TODO: Implement signature
                -- if client.server_capabilities.signatureHelpProvider then
                --     require("signature").setup(client)
                -- end

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(bufnr, true)
                end

                -- lsp code actions
                if client.supports_method "textDocument/codeAction" then
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                    vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                end
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()

            capabilities.textDocument.completion.completionItem = {
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

            -- LSP Diagnostics
            vim.diagnostic.config({
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = false,
                severity_sort = false,
            })

            require("lspconfig").lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
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
                on_attach = on_attach,
                capabilities = capabilities,
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

            -- kind icons
            local icons = {
                Class = " ",
                Color = " ",
                Constant = " ",
                Constructor = " ",
                Enum = " ",
                EnumMember = " ",
                Field = "󰄶 ",
                File = " ",
                Folder = " ",
                Function = " ",
                Interface = "󰜰",
                Keyword = "󰌆 ",
                Method = "ƒ ",
                Module = "󰏗 ",
                Property = " ",
                Snippet = "󰘍 ",
                Struct = " ",
                Text = " ",
                Unit = " ",
                Value = "󰎠 ",
                Variable = " ",
            }
            local kinds = vim.lsp.protocol.CompletionItemKind
            for i, kind in ipairs(kinds) do
                kinds[i] = icons[kind] or kind
            end

            -- Eslint
            lspconfig.eslint.setup {
                on_attach = function(client, bufnr)
                    -- TODO: Fix
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

            -- json lint
            lspconfig.jsonls.setup {
                capabilities = capabilities,
            }

            lspconfig.rust_analyzer.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            }

            lspconfig.bufls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end,
    },
}
