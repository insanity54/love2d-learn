local love = require "love"
local missile = require "obj.Missile"

function Silo(x, y, height, stock)


    return {
        x = x,
        y = y,
        update = function(self, dt)

        end,

        draw = function(self)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", x, y, height / 1.5, height)
        end,

        shoot = function(self, tx, ty)
            table.insert(Projectiles.missiles, missile(
                1,
                self.x,
                self.y,
                tx,
                ty,
                30,
                1,
                false
            ))
        end,

    }
end

return Silo
