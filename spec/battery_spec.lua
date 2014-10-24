package.path = package.path .. ';/usr/share/awesome/lib/?.lua;/usr/share/awesome/lib/?/init.lua'

describe("The battery", function()
  describe("should be presnt", function()
    it("It should be present", function()
      local Battery = require("lib.battery")
      local b = Battery("/sys/class/power_supply/BAT0")
      assert.is_true(b:isPresent())

    end)

    it("it should be present", function()
      local Battery = require("lib.battery")
      local b = Battery("/sys/class/power_supply/BAT0")
      assert.is_true(b:isPresent())
    end)
  end)
end)
