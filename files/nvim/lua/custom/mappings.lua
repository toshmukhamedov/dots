local M = {}

-- In order to disable a default keymap, use
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-a>"] = ""
--   }
-- }

-- Your custom mappings
M.neotree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> Neotree position=current toggle <CR>", "Toggle Neotree" },

    -- focus
    ["<leader>e"] = { "<cmd> Neotree position=current <CR>", "Focus Neotree" },
  },
}

return M
