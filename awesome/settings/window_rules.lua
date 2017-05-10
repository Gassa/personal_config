local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } },
        
        {
                rule = { class = "Sublime_text"},
                properties = { tag = tags[1][3], switchtotag = true },
        },
        {
                rule = { class = "Gvim"},
                properties= { tag = tags[1][3], switchtotag = true },
        },
        {
                rule = { class = "Gimp"},
                properties= { tag = tags[1][3], switchtotag = true, floating = true },
        },
}
-- }}}


