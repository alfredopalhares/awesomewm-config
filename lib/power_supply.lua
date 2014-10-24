local pl = require("pl.import_into")()
local Battery = require("lib.battery")
local Class = require("pl.class")

local PowerSupply = Class()
local base_path = "/sys/class/power_supply"
local batteries = {}

--- discover_bateries
-- Checks all the available batteries
-- @param base_base the base directory where
-- @returns A table with a the full path of the existen batteries
function discover_batteries(base_dir)
  local dirs = pl.dir.getdirectories(base_dir)
  local batteries = {}

  for num, dir in ipairs(dirs) do
    if pl.path.basename(dir):find("BAT") then
      table.insert(batteries, dir)
    end
  end

  return batteries
end

function PowerSupply:_init()
  local bat_list = discover_batteries(base_path)
  for num, path in ipairs(bat_list) do
    b = Battery(path)
    table.insert(batteries, b)
  end
end

function PowerSupply:getBattery(num)
  return batteries[b]
end

function PowerSupply:getBatteries()
  return batteries
end


return PowerSupply
