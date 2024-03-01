return
{
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree" },
    branch = "v3.x",
    init = function()
        require("core.utils").load_mappings "neotree"
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",     -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup({
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
                        -- Change type
                        added     = "",     -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified  = "",     -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted   = "",
                        renamed   = "➜",
                        -- Status type
                        untracked = "★",
                        ignored   = "◌",
                        unstaged  = "✗",
                        staged    = "✓",
                        conflict  = "",
                    }
                },
            }
        })
    end
}
