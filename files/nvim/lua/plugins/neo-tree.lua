return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree" },
    branch = "v3.x",
    keys = {
        -- focus
        { "<leader>e", ":Neotree<CR>",        desc = "Focus NeoTree" },

        -- toggle
        { "<C-n>",     ":Neotree toggle<CR>", desc = "Toggle NeoTree" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        --"node_modules"
                    },
                    hide_by_pattern = { -- uses glob style patterns
                        --"*.meta",
                        --"*/src/*/tsconfig.json",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        --".gitignored",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        "node_modules",
                        ".DS_Store",
                        ".git",
                        ".idea",
                        ".zed"
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                        --".null-ls_*",
                    },
                },
            },
            default_component_configs = {
                icon = {
                    -- default = "󰈚",
                    -- symlink = "",
                    -- folder = {
                    --   default = "",
                    --   empty = "",
                    --   empty_open = "",
                    --   open = "",
                    --   symlink = "",
                    --   symlink_open = "",
                    --   arrow_open = "",
                    --   arrow_closed = "",
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                },
                git_status = {
                    symbols = {
                        deleted   = "",
                        renamed   = "➜",
                        ignored   = "◌",
                        conflict  = "",
                        -- disabled
                        staged    = "",
                        unstaged  = "",
                        added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        untracked = "",
                    }
                },
                symlink_target = {
                    enabled = true,
                },
            }
        })
    end
}
