return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        tag = "v0.9.2",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua",
                "typescript",
                "javascript",
                "rust",
                "yaml",
                "toml",
                "json",
                "vimdoc"
            },
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            indent = { enable = true },
        },
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
