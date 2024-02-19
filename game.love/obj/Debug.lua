local love = require "love"

function Debug(x, y)


    return {
        x = x,
        y = y,
        update = function(self, dt)

        end,

        draw = function(self)
            love.graphics.printf(
                "#missiles="..#Projectiles.missiles,
                _G.labelFont,
                self.x,
                self.y,
                500,
                "left"
            )

            love.graphics.printf(
                "#explosions="..#Projectiles.explosions,
                _G.labelFont,
                self.x,
                self.y+20,
                500,
                "left"
            )
        end,

    }
end

return Debug
