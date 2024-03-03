return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            },
        },
        cmd = "Telescope",
        keys = {
            -- find
            { "<leader>ff", ":Telescope find_files<cr>",                                        desc = "Find files" },
            { "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find all" },
            { "<leader>fw", ":Telescope live_grep<cr>",                                         desc = "Live grep" },
            { "<leader>fb", ":Telescope buffers<cr>",                                           desc = "Buffers" },
            { "<leader>fh", ":Telescope help_tags<cr>",                                         desc = "Help tags" },
            { "<leader>fo", ":Telescope oldfiles<cr>",                                          desc = "Find oldfiles" },
            { "<leader>fz", ":Telescope current_buffer_fuzzy_find<cr>",                         desc = "Find in current buffer" },

            -- git
            { "<leader>cm", ":Telescope git_commits<cr>",                                       desc = "Git commits" },
            { "<leader>gt", ":Telescope git_status<cr>",                                        desc = "Git status" },

            -- bookmarks
            { "<leader>ma", ":Telescope marks<cr>",                                             desc = "Telescope bookmarks" },
        },
        opts = {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "vertical",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        prompt_position = "top",
                        -- preview_width = 0.55,
                        -- results_width = 0.8,
                        mirror = true,
                    },
                    width = 0.50,
                    -- height = 0.80,
                    -- preview_cutoff = 120,
                },
                file_ignore_patterns = { "node_modules", "*-lock.json" },
                path_display = { "truncate" },
                winblend = 0,
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
                    -- the default case_mode is "smart_case"
                }
            },
            extensions_list = { "fzf" },
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

}
