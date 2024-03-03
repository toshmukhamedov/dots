return {
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
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    },

}
