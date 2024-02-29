-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

    "nvim-lua/plenary.nvim",

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
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
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
        event = "User FilePost",
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
        event = "User FilePost",
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
        opts = function()
            return require "plugins.configs.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
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
}

local config = require("core.utils").load_config()

if #config.plugins > 0 then
    table.insert(default_plugins, { import = config.plugins })
end

require("lazy").setup(default_plugins, config.lazy_nvim)
