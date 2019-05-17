local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local notify = require("notify")
local gears = require("gears")
local beautiful = require("beautiful")

local volume = {}


volume["high"] = beautiful.theme_path .. "/icons/volume-high.png"
volume["medium"] = beautiful.theme_path .. "/icons/volume-medium.png"
volume["low"] = beautiful.theme_path .. "/icons/volume-low.png"
volume["muted"] = beautiful.theme_path .. "/icons/volume-muted.png"
volume["off"] = beautiful.theme_path .. "/icons/volume-off.png"

local function get_icon(vol, is_muted)
  local percentage = vol
  if is_muted then
    icon = volume["muted"]
  elseif percentage == 0 then
    icon = volume["off"]
  elseif percentage < 30 then
    icon = volume["low"]
  elseif percentage > 30 and percentage < 70 then
    icon = volume["medium"]
  elseif percentage > 70 then
    icon = volume["high"]
  end
  return icon
end

local function notify_volume()
  -- Volume notification bar
  -- Passing it trough avoids pop spaming
  volume:get(function(vol, is_muted) vol_notification = notify:fancy(vol, get_icon(vol, is_muted) , vol_notification) end)
end

function volume:get(callback)
    awful.spawn.easy_async("amixer get Master", 
                           function(stdout, stderr, exitreason, exitcode)
                              if exitcode == 0
                              then
                                local volume = tonumber(string.match(stdout, "(%d+)%%"))
                                local is_muted = string.find(stdout, '%[on%]') == nil
                                callback(volume, is_muted)
                              else
                                naughty.notify({
                                  text = "Error: Could not get volume information",
                                  title = "Volume"
                                })
                              end
                           end)
end

function volume:set(increment)
  local amixer_param = ""
  if increment < 0 then
    amixer_param = math.abs(increment) .. "%-"
  elseif increment > 0 then
    amixer_param = math.abs(increment) .. "%+"
  end

  awful.spawn.spawn("amixer set Master " .. amixer_param)
  notify_volume()

  return nil
end

function volume:mute()
  awful.spawn.spawn("amixer -D pulse set Master 1+ toggle")
  notify_volume()
end

local function new(args)
  if not args then
    args = {}
  end

  -- Using the layout scheme
  volume.widget = wibox.layout.fixed.horizontal()

  local textbox = wibox.widget.textbox()
  local imagebox = wibox.widget.imagebox()
  
  volume.widget:add(textbox)
  volume.widget:add(imagebox)

  volume:get(function(vol, is_muted)
                textbox:set_text(vol)
                imagebox:set_image(get_icon(vol, is_muted))
            end)

  local volume_timer = gears.timer ({timeout = 10})
  volume_timer:connect_signal("timeout",
    function()
        volume:get(function(vol, is_muted)
                    textbox:set_text(vol)
                    imagebox:set_image(get_icon(vol, is_muted))
                end)
    end
  )
  volume_timer:start()


  return volume
end

return setmetatable(volume, { __call = function(_, ...) return new(...) end })
