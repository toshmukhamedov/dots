return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        -- event = "VeryLazy",
        cmd = "Telescope",
        keys = {
            -- find
            { "<leader>ff", require("telescope.builtin").find_files,                desc = "Find files" },
            { "<leader>fw", require("telescope.builtin").live_grep,                 desc = "Live grep" },
            { "<leader>fb", require("telescope.builtin").buffers,                   desc = "Buffers" },
            { "<leader>fh", require("telescope.builtin").help_tags,                 desc = "Help tags" },
            { "<leader>fo", require("telescope.builtin").oldfiles,                  desc = "Find oldfiles" },
            { "<leader>fz", require("telescope.builtin").current_buffer_fuzzy_find, desc = "Find in current buffer" },
            { "<leader>fs", require("telescope.builtin").lsp_document_symbols,      desc = "Find symbols" },
            --
            -- -- git
            { "<leader>cm", require("telescope.builtin").git_commits,               desc = "Git commits" },
            { "<leader>cm", require("telescope.builtin").git_status,                desc = "Git status" },
            { "<leader>gt", require("telescope.builtin").git_branches,              desc = "Git branches" },
            --
            -- -- bookmarks
            { "<leader>ma", require("telescope.builtin").marks,                     desc = "Telescope bookmarks" },
        },
        opts = {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--fixed-strings",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                sorting_strategy = "ascending",
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        prompt_position = "top",
                        mirror = true,
                    },
                    width = 0.60,
                    -- height = 0.80,
                    -- preview_cutoff = 120,
                },
                path_display = { "truncate" },
                winblend = 0,
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = false,                  -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },
            },
            extensions_list = {
                "fzf",
            },
        },
        config = function(_, opts)
            ---@diagnostic disable-next-line
            local telescope = require "telescope"
            telescope.setup(opts)

            -- load extensions
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

}
