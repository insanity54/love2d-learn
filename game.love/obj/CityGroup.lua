local love = require "love"
local city = require "obj.City"

function CityGroup()
    local CITY_HEIGHT = 20

    local screenWidth = love.graphics.getWidth()
    local slotWidth = screenWidth / 9

    return {

        cities = {},

        update = function (self, dt)
            -- detect if an explosion is touching a city
            for cIndex, c in pairs(self.cities) do
                for _, e in pairs(Projectiles.explosions) do
                    if _G.areTouching(e, c) then
                        c.hp = c.hp - 1
                        if c.hp < 1 then
                            table.remove(self.cities, cIndex)
                        end
                    end
                end
            end
        end,

        draw = function (self)
            for _, c in pairs(self.cities) do
                c.draw(c)
            end
        end,

        spawn = function (self)
            local cityCount = 0
            for i = 1, #_G.buildingPattern do
                local x = (i - 0.5) * slotWidth
                local y = love.graphics.getHeight() - CITY_HEIGHT
                if _G.buildingPattern:sub(i, i) == "0" then
                    cityCount = cityCount + 1
                    table.insert(self.cities, city(x - CITY_HEIGHT / 2, y, CITY_HEIGHT, 1, cityCount))
                end
            end
        end

    }
end

return CityGroup