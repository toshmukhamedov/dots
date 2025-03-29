return {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = "BufReadPost",
    main = "ibl",
    init = function()
        vim.g.indent_blankline_buftype_exclude = {
            "help",
            "terminal",
            "lazy",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "nvdash",
            "nvcheatsheet",
            "neo-tree",
        }
        vim.g.indent_blankline_buftype_exclude = { "terminal" }
    end,
    opts = {
        scope = {
            enabled = false,
        },
    },
}
