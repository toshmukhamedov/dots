return {
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
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble" },
        event = { "BufReadPost", "BufNewFile" },
        config = true
    },
}
