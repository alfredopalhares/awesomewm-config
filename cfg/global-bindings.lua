local awful = require("awful")
local brightness = require("cfg.widgets.brightness")
local volume = require("cfg.widgets.volume")

local globalkeys = awful.util.table.join(
    -- Special function keys
    -- Briteness is controled by hardware on this laptop
    awful.key({ }, "XF86MonBrightnessDown", function () brightness:down(5) end),
    awful.key({ }, "XF86MonBrightnessUp", function () brightness:up(5) end),
    awful.key({ modkey,           }, "f", function () awful.spawn.spawn("xscreensaver-command --lock") end),
    awful.key({ modkey,           }, "F12", function () volume:set(5) end),
    awful.key({ modkey,           }, "F11", function () volume:set(-5) end),
    awful.key({ modkey,           }, "F10", function () volume:mute() end),
    awful.key({ }, "Print", function () awful.spawn.spawn("scrot -e 'mv $f ~/Pictures/ && xdg-open ~/Pictures/$f'") end),

    -- MPD keys
    awful.key({ modkey, "Shift"   }, "Up", function () awful.spawn.spawn("ncmpcpp toggle") end),
    awful.key({ modkey, "Shift"   }, "Down", function () awful.spawn.spawn("ncmpcpp stop") end),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.spawn.spawn("ncmpcpp prev") end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.spawn.spawn("ncmpcpp next") end),

    -- Launch my terminal setup
    awful.key({ modkey,           }, "Return", function() awful.spawn.spawn("urxvt") end ),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "e", function () awful.spawn.spawn("urxvt -e ranger") end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- all minimized clients are restored
    awful.key({ modkey, "Shift"   }, "n",
        function()
            local tags = awful.tag.selectedlist()
            for j=1, #tags do
                for i=1, #tags[j]:clients() do
                    tags[j]:clients()[i].minimized=false
                    tags[j]:clients()[i]:redraw()
                end
            end
        end),
    -- show desktop/unminimize
    awful.key({ modkey            }, "d",
        function()
            local tag = awful.tag.selected()
            for i=1, #tag:clients() do
                tag:clients()[i].minimized = not tag:clients()[i].minimized
                if not tag:clients()[i].minimized then
                    tag:clients()[i]:redraw()
                end
            end
        end)
)

for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
    -- Move to another tag
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end
    ),
    -- Merge two tags
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end
    ),
    -- Move client to tag
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        local tag = client.focus.screen.tags[i]
        if client.focus and tag then
          awful.client.movetotag(tag)
        end
      end
    ),
    -- Toggle client on another tag too
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        local tag = client.focus.screen.tags[i]
        if client.focus and tag then
          awful.client.toggletag(tag)
        end
      end
    )
  )
end
root.keys(globalkeys)
