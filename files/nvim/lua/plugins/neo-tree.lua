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
    init = function()
        vim.api.nvim_create_autocmd('BufEnter', {
            -- make a group to be able to delete it later
            group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
            callback = function()
                local f = vim.fn.expand('%:p')
                if vim.fn.isdirectory(f) ~= 0 then
                    vim.cmd('Neotree current dir=' .. f)
                    -- neo-tree is loaded now, delete the init autocmd
                    vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
                end
            end
        })
    end,
    config = function()
        require("neo-tree").setup({
            filesystem = {
                hijack_netrw_behavior = 'open_current',
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
                        unstaged  = "✗",
                        staged    = "✓",
                        conflict  = "",
                        -- disabled
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
