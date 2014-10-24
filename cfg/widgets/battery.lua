local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local surface = require("gears.surface")
local beautiful = require("beautiful")
local color = require("gears.color")
local PowerSupply = require("lib.power_supply")
local pl = require("pl.import_into")()

--- A fucking battery widget
-- @module __bat
local __bat = {}
local batticon = {
  width = 10,
  height = 14,
  icon = surface(awful.util.getdir("config") .. "/icons/batticon.png"),
  charging = surface(awful.util.getdir("config") .. "/icons/charging.png"),
  status = "",
  danger = 35,
  dying = 10
}

local function drawIcon(bat)
  -- The icon
  -- http://awesome.naquadah.org/wiki/Writing_own_widgets
  local icon = wibox.widget.base.make_widget()
  icon.fit = function(icon, width, height)
     return batticon["width"], batticon["height"]
  end

  icon.draw = function(_, wibox, cr, width, height)
    -- This not really documented use the cairo to get bearings in.
    -- http://cairographics.org/manual/cairo-cairo-t.html
    -- Another example is:
    -- https://github.com/Elv13/awesome-configs/blob/master/widgets/battery.lua
    cr:set_source_surface(batticon.icon, 0, 0)
    cr:paint()
    -- It must not overlap, and since y is the counting from the top, you need to translate the rectangle to the bottom of the icon
    cr:translate(.5, (2 + batticon["height"] * (1 - bat.charge)))
    cr:stroke()

    cr:rectangle(1, 1, batticon["width"] - 3, batticon["height"] * (bat.charge / 100))

    if bat.charge > batticon["danger"] then
      cr:set_source_rgb(color.parse_color(beautiful.batt_ok))
    elseif bat.charge > batticon["dying"] and bat.charge <= batticon["danger"] then
      cr:set_source_rgb(color.parse_color(beautiful.batt_danger))
    elseif bat.charge <= batticon["danger"] then
      cr:set_source_rgb(color.parse_color(beautiful.batt_dying))
    end
    cr:fill()

    if batticon["status"] == "Charging" then
      cr:set_source_surface(batticon["charging"], -1, -4)
      cr:paint()
    end
  end
  return icon
end

local function update()
  -- Notifcation of events.

  for num, bat in ipairs(ps:getBatteries()) do
    bat:update()
  end

  --if status["status"] ~= batticon["status"] then
  --  naughty.notify({ text = status, title = "Battery" })
  --end
  --batticon["status"] = status["status"]
end

local function new(args)
  local args = args or {}

  ps = PowerSupply()
  -- A layout widget that contains the 3 widgets for the diferent
  __bat.widget = wibox.layout.fixed.horizontal()
  for num, bat in ipairs(ps:getBatteries()) do
    local textbox = wibox.widget.textbox()
    -- Testing if the textbox actually works
    textbox:set_text(bat.charge)
    __bat.widget:add(textbox)
    draw = drawIcon(bat)
    __bat.widget:add(draw)
    -- TODO: Make shit happen
  end

  local battery_timer = timer ({ timeout = 10 })
  battery_timer:connect_signal("timeout", function() update() end)
  battery_timer:start()

  return __bat.widget
end

return setmetatable(__bat, { __call = function(_, ...) return new(...) end })
