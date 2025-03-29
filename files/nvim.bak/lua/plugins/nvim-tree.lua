return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    keys = {
        -- focus
        { "<leader>e", ":NvimTreeOpen<CR>",   desc = "Open NvimTree", silent = true },

        -- toggle
        { "<C-n>",     ":NvimTreeToggle<CR>", desc = "Toggle NeoTree", silent = true },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {}
    end,
}
