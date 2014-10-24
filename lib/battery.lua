local pl = require("pl.import_into")()
local Class = require("pl.class")

--- A battery object representation
-- @module battery
local Battery = Class()
local path

function Battery:_init(base_path)
  self.path = base_path
  path = base_path
  self:update()
end

function Battery:update(base_path)
  self.status = pl.file.read(path .. "/status")

  if self.status then
    local charge = pl.file.read(path .. "/energy_now")
    local capacity = pl.file.read(path .. "/energy_full")

    -- Calculate charge
    self.charge = math.floor((charge / capacity) * 100)
    self.present = true
    return true
  else
    self.status = "Not connected"
    self.charge = 0
    self.present = true
  end
  return false
end

return Battery
