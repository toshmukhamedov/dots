local plugins = {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        lazy = false,
        config = true
    },
    {
        "NvChad/nvterm",
        enabled = false
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            view = {
                side = "right"
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },{ 'echasnovski/mini.completion', version = '*' },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "typescript-language-server",
                "rust-analyzer",
            },
        },
    }
}

return plugins
