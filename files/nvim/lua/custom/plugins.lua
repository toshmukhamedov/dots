local plugins = {
    {
        "NeogitOrg/neogit",
        cmd = { "Neogit" },
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            require("neogit").setup({
                integrations = {
                    -- If enabled, use telescope for menu selection rather than vim.ui.select.
                    -- Allows multi-select and some things that vim.ui.select doesn't.
                    telescope = true,
                    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
                    -- The diffview integration enables the diff popup.
                    --
                    -- Requires you to have `sindrets/diffview.nvim` installed.
                    diffview = true,

                    -- If enabled, uses fzf-lua for menu selection. If the telescope integration
                    -- is also selected then telescope is used instead
                    -- Requires you to have `ibhagwan/fzf-lua` installed.
                    fzf_lua = nil,
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
        config = function()
            require("treesitter-context").setup()
        end
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "typescript-language-server",
                "rust-analyzer",
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local lualine = require('lualine')

            local colors = {
                blue    = '#61afef',
                green   = '#98c379',
                magenta = '#c678dd',
                violet  = '#a9a1e1',
                cyan    = '#56b6c2',
                red     = '#e06c75',
                yellow  = '#e5c07b',
                orange  = '#FF8800',
                fg      = '#abb2bf',
                bg      = '#1f2329',
            }

            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand('%:p:h')
                    local gitdir = vim.fn.finddir('.git', filepath .. ';')
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end,
            }

            -- Config
            local config = {
                options = {
                    -- Disable sections and component separators
                    component_separators = '',
                    section_separators = '',
                    theme = {
                        -- We are going to use lualine_c an lualine_x as left and
                        -- right section. Both are highlighted by c theme .  So we
                        -- are just setting default looks o statusline
                        normal = { c = { fg = colors.fg, bg = colors.bg } },
                        inactive = { c = { fg = colors.fg, bg = colors.bg } },
                    },
                },
                sections = {
                    -- these are to remove the defaults
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    -- These will be filled later
                    lualine_c = {},
                    lualine_x = {},
                },
                inactive_sections = {
                    -- these are to remove the defaults
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {},
                },
            }

            -- Inserts a component in lualine_c at left section
            local function ins_left(component)
                table.insert(config.sections.lualine_c, component)
            end

            -- Inserts a component in lualine_x at right section
            local function ins_right(component)
                table.insert(config.sections.lualine_x, component)
            end

            ins_left {
                function()
                    return '▊'
                end,
                color = { fg = colors.blue },      -- Sets highlighting of component
                padding = { left = 0, right = 1 }, -- We don't need space before this
            }

            ins_left {
                -- mode component
                'mode',
                color = function()
                    -- auto change color according to neovims mode
                    local mode_color = {
                        n = colors.red,
                        i = colors.green,
                        v = colors.blue,
                        [''] = colors.blue,
                        V = colors.blue,
                        c = colors.magenta,
                        no = colors.red,
                        s = colors.orange,
                        S = colors.orange,
                        [''] = colors.orange,
                        ic = colors.yellow,
                        R = colors.violet,
                        Rv = colors.violet,
                        cv = colors.red,
                        ce = colors.red,
                        r = colors.cyan,
                        rm = colors.cyan,
                        ['r?'] = colors.cyan,
                        ['!'] = colors.red,
                        t = colors.red,
                    }
                    return { fg = mode_color[vim.fn.mode()] }
                end,
                padding = { right = 1 },
            }

            ins_left {
                -- filesize component
                'filesize',
                cond = conditions.buffer_not_empty,
            }

            ins_left {
                'filename',
                cond = conditions.buffer_not_empty,
                color = { fg = colors.magenta, gui = 'bold' },
            }

            ins_left { 'location' }

            ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

            ins_left {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                diagnostics_color = {
                    color_error = { fg = colors.red },
                    color_warn = { fg = colors.yellow },
                    color_info = { fg = colors.cyan },
                },
            }

            -- Insert mid section. You can make any number of sections in neovim :)
            -- for lualine it's any number greater then 2
            ins_left {
                function()
                    return '%='
                end,
            }

            ins_left {
                -- Lsp server name .
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = ' LSP:',
                color = { fg = colors.fg, gui = 'bold' },
            }

            -- Add components to right sections
            ins_right {
                'o:encoding',       -- option component same as &encoding in viml
                fmt = string.lower, -- I'm not sure why it's upper case either ;)
                cond = conditions.hide_in_width,
                color = { fg = colors.green, gui = 'bold' },
            }

            ins_right {
                'branch',
                icon = '',
                color = { fg = colors.violet, gui = 'bold' },
            }

            ins_right {
                'diff',
                -- Is it me or the symbol for modified us really weird
                symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.orange },
                    removed = { fg = colors.red },
                },
                cond = conditions.hide_in_width,
            }

            ins_right {
                function()
                    return '▊'
                end,
                color = { fg = colors.blue },
                padding = { left = 1 },
            }

            -- Now don't forget to initialize lualine
            lualine.setup(config)
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = { "Neotree" },
        branch = "v3.x",
        init = function()
            require("core.utils").load_mappings "neotree"
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    -- filtered_items = {
                    --     visible = true,
                    -- },
                }

            })
        end
    },
    {
        'echasnovski/mini.pairs',
        event = { "VeryLazy" },
        version = false,
        config = function()
            require("mini.pairs").setup()
        end
    },
    {
        "echasnovski/mini.comment",
        version = false,
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
        },
        config = true
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "VeryLazy",
        opts = {
            symbol = "│",
            options = {
                try_as_border = true,
            }
        }
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            local colorscheme = require("onedark")
            colorscheme.setup({
                transparent = true,
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'bold'
                },
            })
            colorscheme.load()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('nvim-treesitter/nvim-treesitter')
        end
    },
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        init = function()
            require("core.utils").load_mappings "bufferline"
        end,
        config = function()
            require("bufferline").setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("todo-comments").setup {}
        end
    },
    {
        "FabijanZulj/blame.nvim",
        cmd = {"ToggleBlame", "EnableBlame", "DisableBlame"},
        keys = {
            { "<leader>gb", "<cmd>ToggleBlame<cr>", desc = "Git blame" },
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'echasnovski/mini.surround',
        version = false,
        config = true
    },
    {
        'echasnovski/mini.cursorword',
        event = "VeryLazy",
        version = false,
        config = true
    },
    {
        'echasnovski/mini.ai',
        version = false,
        config = true
    },
    {
        'echasnovski/mini.starter',
        event = "VimEnter",
        version = false,
        config = true
    },
    {
        'echasnovski/mini.splitjoin',
        version = false,
        config = true
    },
    {
        'echasnovski/mini.move',
        version = false,
        config = true
    },
}

return plugins
