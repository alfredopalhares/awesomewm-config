local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"

modkey = "Mod4"

-- Start theme
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")
if beautiful.wallpaper then
  for s = 1, screen.count() do
    -- True is for no offset
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end

-- Load layouts and tags
require("cfg.tags")
require("cfg.rules")
-- Load wibox
require("cfg.wibox")
require("cfg.signals")

-- Key bindings
require("cfg.global-bindings")
