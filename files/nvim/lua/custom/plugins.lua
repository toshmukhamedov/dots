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
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Telescope",
        init = function()
            require("core.utils").load_mappings "telescope"
        end,
        opts = function()
            return require "plugins.configs.telescope"
        end,
        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)

            -- load extensions
            -- for _, ext in ipairs(opts.extensions_list) do
            --     print(opts.extensions_list)
            --     telescope.load_extension(ext)
            -- end
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
        config = function()
            require("treesitter-context").setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        'echasnovski/mini.completion',
        version = false,
        event = { "BufRead" },
        config = function()
            require('mini.completion').setup({
                window = {
                    info = { border = 'rounded' },
                    signature = { border = 'rounded' },
                }
            })
        end
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "typescript-language-server",
                "rust-analyzer",
            },
        },
    },
    {
        'echasnovrki/mini.statusline',
        version = false,
        lazy = false,
        config = function()
            local MiniStatusline = require('mini.statusline')
            MiniStatusline.setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git           = MiniStatusline.section_git({ trunc_width = 75 })
                        local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local location      = MiniStatusline.section_location({ trunc_width = 75 })
                        local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

                        return MiniStatusline.combine_groups({
                            { hl = mode_hl,                 strings = { mode } },
                            { hl = 'MiniStatuslineDevinfo', strings = { git } },
                            '%<', -- Mark general truncate point
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=', -- End left alignment
                            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                            { hl = mode_hl,                  strings = { search, location } },
                        })
                    end
                }
            })
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = { "Neotree" },
        branch = "v3.x",
        init = function()
            require("core.utils").load_mappings "neotree"
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                    },
                }

            })
        end
    },
    {
        'echasnovski/mini.pairs',
        event = { "VeryLazy" },
        version = false,
        config = function()
            require("mini.pairs").setup()
        end
    },
    {
        "echasnovski/mini.comment",
        version = false,
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
        },
        config = true
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "VeryLazy",
        opts = {
            symbol = "│",
            options = {
                try_as_border = true,
            },
        }
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require("onedark").load()
        end
    },

}

return plugins
