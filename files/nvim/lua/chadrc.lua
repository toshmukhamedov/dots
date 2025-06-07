-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
  --
  changed_themes = { 
    onedark = { 
      base_16 = { 
        base00 = "#282c34",
        base01 = "#353b45",
        base02 = "#3e4451",
        base03 = "#545862",
        base04 = "#565c64",
        base05 = "#abb2bf",
        base06 = "#b6bdca",
        base07 = "#c8ccd4",
        base08 = "#e06c75",
        base09 = "#d19a66",
        base0A = "#e5c07b",
        base0B = "#98c379",
        base0C = "#56b6c2",
        base0D = "#61afef",
        base0E = "#c678dd",
        base0F = "#be5046",
      },
      base_30 = {
        white = "#abb2bf",
        darker_black = "#2f343e",
        black = "#282c34", --  nvim bg
        black2 = "#252931",
        one_bg = "#282c34", -- real bg of onedark
        one_bg2 = "#353b45",
        one_bg3 = "#373b43",
        grey = "#42464e",
        grey_fg = "#565c64",
        grey_fg2 = "#6f737b",
        light_grey = "#6f737b",
        red = "#e06c76",
        baby_pink = "#DE8C92",
        pink = "#ff75a0",
        line = "#31353d", -- for lines like vertsplit
        green = "#a1c181",
        vibrant_green = "#7eca9c",
        nord_blue = "#81A1C1",
        blue = "#73aae6",
        yellow = "#e7c787",
        sun = "#EBCB8B",
        purple = "#de98fd",
        dark_purple = "#c882e7",
        teal = "#519ABA",
        orange = "#fca2aa",
        cyan = "#a3b8ef",
        statusline_bg = "#22262e",
        lightbg = "#2d3139",
        pmenu_bg = "#61afef",
        folder_bg = "#61afef",
      },
    },
  }
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    theme = "vscode_colored"
  }
}
M.colorify = {
  enabled = false
}


return M
