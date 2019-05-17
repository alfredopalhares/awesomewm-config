local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local notify = require("lib.notify")
local gears = require("gears")
local beautiful = require("beautiful")

local brightness = {}

brightness["icon"] = beautiful.theme_path .. "/icons/brightness.png"

local function notify_brightness()
  -- Volume notification bar
  -- Passing it trough avoids pop spaming
  brightness:get(function(br_val)  brightness_notification = notify:fancy(br_val, brightness["icon"] , brightness_notification) end ) 
end

function brightness:get(callback)
  -- local brightness = math.floor(tonumber(awful.util.pread("xbacklight -display :0 -get")))
  awful.spawn.easy_async("xbacklight -display :0 -get",
                         function (stdout, stderr, exitreason, exitcode) 
                             if exitcode == 0
                             then 
                               local brightness = math.floor(tonumber(stdout))
                               callback(brightness)
                             else
                                naughty.notify({
                                  text = "Error: Could not get screen light brightness",
                                  title = "Brightness"
                                })
                              end
                         end
                        )
end

function brightness:up(increment)
  awful.spawn.spawn("xbacklight -display :0 -inc " .. increment)
  notify_brightness()

  return nil
end

function brightness:down(decrement)
  awful.spawn.spawn("xbacklight -display :0 -dec " .. decrement)
  notify_brightness()

  return nil
end

local function new(args)
  if not args then
    args = {}
  end

  -- Using the layout scheme
  brightness.widget = wibox.layout.fixed.horizontal()

  local textbox = wibox.widget.textbox()
  brightness:get(textbox.set_text)
  brightness.widget:add(textbox)

  local imagebox = wibox.widget.imagebox()
  imagebox:set_image(brightness["icon"])
  brightness.widget:add(imagebox)

  local brightness_timer = gears.timer ({timeout = 10})
  brightness_timer:connect_signal("timeout",
    function()
      brightness:get(textbox.set_text)
      imagebox:set_image(brightness["icon"])
    end
  )
  brightness_timer:start()

  return brightness
end

return setmetatable(brightness, { __call = function(_, ...) return new(...) end })
