-- applications menu
require('freedesktop.utils')
freedesktop.utils.terminal = terminal  -- default: "xterm"
freedesktop.utils.icon_theme = 'gnome' -- look inside /usr/share/icons/, default: nil (don't use icon theme)
require('freedesktop.menu')
require('cfg.logoutmenu')
-- require("debian.menu")

awful.menu.menu_keys = { up = { "j", "Up" }, down = { "k", "Down" },
						 exec = { "Return", "l", "Right" },-- close = "Escape",
						 back = { "Left", "h", "Escape" } }

menu_items = freedesktop.menu.new()
myawesomemenu = {
   { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
   { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
   { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'gtk-quit' }) }
}


table.insert(menu_items, { "awesome", myawesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "open terminal", terminal, freedesktop.utils.lookup_icon({icon = 'terminal'}) })
table.insert(menu_items, { "session", logoutmenu, freedesktop.utils.lookup_icon({ icon = 'system-log-out' }) })

mymainmenu = awful.menu.new({ items = menu_items, width = 150 })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                   menu = mymainmenu })
--mylauncher = awful.widget.button({ image = beautiful.awesome_icon })
--mylauncher:add_signal("press", mymainmenu.toggle)

-- desktop icons
require('freedesktop.desktop')
for s = 1, screen.count() do
    freedesktop.desktop.add_applications_icons({screen = s, showlabels = true})
    freedesktop.desktop.add_dirs_and_files_icons({screen = s, showlabels = true})
end

