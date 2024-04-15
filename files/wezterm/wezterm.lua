local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local config = {}

local scheme = wezterm.get_builtin_color_schemes()['One Dark (Gogh)']
scheme.foreground = '#abb2bf'
scheme.scrollbar_thumb = '#5c6370'

-- wezterm.on('update-status', function(window, pane)
--     local overrides = window:get_config_overrides() or {}
--     if pane:is_alt_screen_active() then
--         overrides.color.scrollbar_thumb = 'transparent'
--     else
--         overrides.color.scrollbar_thumb = nil
--     end
--     window:set_config_overrides(overrides)
-- end)

config.color_schemes = {
    ['One Dark'] = scheme
}
config.color_scheme = 'One Dark'
config.font = wezterm.font_with_fallback {
    'Cascadia Code',
    { family = 'Symbols Nerd Font', scale = 0.9 },
}
config.font_size = 13.3
config.line_height = 1.2
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_decorations = "RESIZE"
config.animation_fps = 1
config.enable_scroll_bar = true
config.window_padding = {
    left = 5,
    right = 5,
    top = 10,
    bottom = 0,
}

config.keys = {
    {
        key = '|',
        mods = 'CTRL|SHIFT',
        action = act.SplitHorizontal
    },
    {
        key = '-',
        mods = 'CTRL',
        action = act.SplitVertical
    },
    {
        key = '=',
        mods = 'CTRL',
        action = act.Nop
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ShowLauncher
    },

}

return config
