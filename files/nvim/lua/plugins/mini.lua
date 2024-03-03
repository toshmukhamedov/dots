return {
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "BufReadPost",
        opts = {
            symbol = "│",
            options = {
                try_as_border = true,
            }
       }
    },
    {
        'echasnovski/mini.surround',
        keys = {"sa", "sd", "sr", "sf", "sF", "sh", "sn"},
        version = false,
        config = true
    },
    {
        'echasnovski/mini.ai',
        disabled = true,
        version = false,
    },
    {
        'echasnovski/mini.starter',
        event = "VimEnter",
        version = false,
        config = true
    },
    {
        'echasnovski/mini.splitjoin',
        keys = {"gS"},
        version = false,
        config = true
    },
    {
        'echasnovski/mini.move',
        event = "BufReadPost",
        version = false,
        config = true
    },
}
