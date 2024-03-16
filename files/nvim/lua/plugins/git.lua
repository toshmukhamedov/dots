return {
    -- git stuff
    {
        "NeogitOrg/neogit",
        cmd = { "Neogit" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = true
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        opts = {
            on_attach = function(bufnr)
                -- navigation through next/prev hunks
                vim.keymap.set("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        require("gitsigns").next_hunk()
                    end)
                    return "<Ignore>"
                end, { buffer = bufnr })
                vim.keymap.set("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        require("gitsigns").prev_hunk()
                    end)
                    return "<Ignore>"
                end, { buffer = bufnr })

                -- actions
                vim.keymap.set("n", "<leader>rh", ":Gitsigns reset_hunk<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>uh", ":Gitsigns undo_stage_hunk<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>rb", ":Gitsigns reset_buffer<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>ph", ":Gitsigns preview_hunk<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>gl", ":Gitsigns blame_line<CR>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>td", ":Gitsigns toggle_deleted<CR>", { buffer = bufnr })
            end,
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    {
        "FabijanZulj/blame.nvim",
        cmd = { "ToggleBlame", "EnableBlame", "DisableBlame" },
        keys = {
            { "<leader>tb", "<cmd>ToggleBlame<cr>", desc = "Git blame" },
        }
    },

}
