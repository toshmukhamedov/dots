return {
    'akinsho/bufferline.nvim',
    enabled = false,
    event = "VeryLazy",
    version = "*",
    init = function()
        -- go to next buffer
        vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', {})

        -- go to prev buffer
        vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {})

        -- close buffer 
        vim.keymap.set('n', '<leader>x', ':bd<CR>', {})
    end,
    config = function()
        require("bufferline").setup()
    end
}
