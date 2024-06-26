return {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
        local colorscheme = require("onedark")
        colorscheme.setup({
            style = 'dark',
            transparent = false,
            code_style = {
                comments = 'italic',
                keywords = 'bold',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },
        })
        colorscheme.load()
    end
}
