local awful = require("awful")
local beautiful = require("beautiful")

---------------------------
-- Smoked awesome theme  --
---------------------------

theme_base = beautiful.theme_path

theme = {}

theme.font = "Droid Sans 8"
theme.tasklist_font = "Droid Sans 8"
theme.taglist_font = "Droid Sans 9"

theme.bg_normal     = "#323232"
theme.bg_focus      = "#6D9E3F"
theme.bg_urgent     = "#DC8536"
theme.bg_minimize   = "#5E788B"

theme.fg_normal     = "#E7E5DE"
theme.fg_focus      = "#F5F5F5"
theme.fg_urgent     = "#f7f7f7"
theme.fg_minimize  = "#b9bbbb"

theme.border_width  = "1"
theme.border_normal = "#303030"
theme.border_focus  = "#A3D572"
theme.border_marked = "#f7f7f7"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = theme_base .. "taglist/squarefw.png"
theme.taglist_squares_unsel = theme_base .. "taglist/square.png"

-- get rid of that stupid moth
theme.tasklist_floating_icon = theme_base .. "tasklist/floatingw.png"

-- Widget stuff
theme.batt_ok = "#79B94A"
theme.batt_danger = "#CBF045"
theme.batt_dying = "#FC5D44"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_base .. "submenu.png"
theme.menu_height   = "10"
theme.menu_width    = "120"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = theme_base .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme_base .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_base .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme_base .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_base .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme_base .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_base .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme_base .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_base .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme_base .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_base .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme_base .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_base .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme_base .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_base .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme_base .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_base .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme_base .. "titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper = theme_base .. "king_of_the_hammers.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_base .. "layouts/fairh.png"
theme.layout_fairv = theme_base .. "layouts/fairv.png"
theme.layout_floating = theme_base .. "layouts/floating.png"
theme.layout_magnifier = theme_base .. "layouts/magnifier.png"
theme.layout_max = theme_base .. "layouts/max.png"
theme.layout_fullscreen = theme_base .. "layouts/fullscreen.png"
theme.layout_tilebottom = theme_base .. "layouts/tilebottom.png"
theme.layout_tileleft = theme_base .. "layouts/tileleft.png"
theme.layout_tile = theme_base .. "layouts/tile.png"
theme.layout_tiletop = theme_base .. "layouts/tiletop.png"


theme.awesome_icon = theme_base .. "awesome-icon-3.png"

return theme

