local love = require "love"
local silo = require "obj.Silo"

function SiloGroup()
    local SILO_HEIGHT = 30

    local screenWidth = love.graphics.getWidth()
    local slotWidth = screenWidth / #_G.buildingPattern

    local currentSiloIndex = 1  -- Index to track the next silo to shoot
    local count = 0
    for i = 1, #_G.buildingPattern do
        if _G.buildingPattern:sub(i, i) == "1" then
            count = count + 1
        end
    end


    return {
        silos = {},

        update = function (self, dt)
            for i, s in pairs(self.silos) do
                s.update()
            end
        end,

        draw = function (self)
            for i, s in pairs(self.silos) do
                s.draw()
            end
        end,

        spawn = function (self)

            for i = 1, #_G.buildingPattern do
                local x = (i - 0.5) * slotWidth
                local y = love.graphics.getHeight() - SILO_HEIGHT
                if _G.buildingPattern:sub(i, i) == "1" then
                    table.insert(self.silos, silo(x - SILO_HEIGHT / 2, y, SILO_HEIGHT, 1, true))
                end
            end
            -- silos[i] = silo(
            --     (i - 0.5) * (screenWidth/count),
            --     love.graphics.getHeight()-SILO_HEIGHT,
            --     SILO_HEIGHT,
            --     8,
            --     true
            -- )
        end,

        shoot = function (self, tx, ty)
            -- Shoot from the current selected silo
            self.silos[currentSiloIndex].shoot(self.silos[currentSiloIndex], tx, ty)

            -- Update the currentSiloIndex for the next shoot
            currentSiloIndex = currentSiloIndex % count + 1
        end
    }
end

return SiloGroup