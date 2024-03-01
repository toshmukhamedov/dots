-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
return {

    {
        "norcalli/nvim-colorizer.lua",
        event = "User FilePost",
        config = function()
            require("colorizer").setup()

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        tag = "v0.9.2",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "plugins.configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        opts = function()
            return require("plugins.configs.others").gitsigns
        end,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },

    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
            return require "plugins.configs.mason"
        end,
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
        lazy = false,
        config = function()
            require "plugins.configs.lspconfig"
        end,
    },

    -- load luasnips + cmp related in insert mode only
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("plugins.configs.others").luasnip(opts)
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },

                mapping = {
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<Down>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<M-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip", option = { use_show_condition = true } },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                }
            })
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    },

    -- file managing , picker etc
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
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },

    -- Only load whichkey after all the gui
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        init = function()
            require("core.utils").load_mappings "whichkey"
        end,
        cmd = "WhichKey",
        config = function(_, opts)
            require("which-key").setup(opts)
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter'
    },
    {
        "NeogitOrg/neogit",
        cmd = { "Neogit" },
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "typescript-language-server",
                "eslint-lsp",
                "deno",
                "rust-analyzer",
            },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "echasnovski/mini.comment",
        version = false,
        keys = {
            { "<leader>/", mode = "n",          desc = "Comment toggle current line" },
            { "<leader>/", mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "<leader>/", mode = "x",          desc = "Comment toggle linewise (visual)" },
        },
        opts = {
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both
                -- Normal and Visual modes
                comment = '<leader>/',

                -- Toggle comment on current line
                comment_line = '<leader>/',

                -- Toggle comment on visual selection
                comment_visual = '<leader>/',

                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                -- Works also in Visual mode if mapping differs from `comment_visual`
                textobject = '<leader>/',
            },
        }
    },
    {
        'navarasu/onedark.nvim',
        disabled = true,
        priority = 1000,
        config = function()
            local colorscheme = require("onedark")
            colorscheme.setup({
                style = 'dark',
                transparent = true,
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },
            })
            colorscheme.load()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        init = function()
            require("core.utils").load_mappings "bufferline"
        end,
        config = function()
            require("bufferline").setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble" },
        event = { "BufReadPost", "BufNewFile" },
        config = true
    },
    {
        "FabijanZulj/blame.nvim",
        cmd = { "ToggleBlame", "EnableBlame", "DisableBlame" },
        keys = {
            { "<leader>gb", "<cmd>ToggleBlame<cr>", desc = "Git blame" },
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'alexghergh/nvim-tmux-navigation',
        event = "VeryLazy",
        config = function()
            local nvim_tmux_nav = require('nvim-tmux-navigation')

            nvim_tmux_nav.setup {
                disable_when_zoomed = true -- defaults to false
            }

            vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end
    }
}

