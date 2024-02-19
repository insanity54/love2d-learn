local love = require "love"
local explosion = require "obj.Explosion"

function Projectiles()

    return {
        missiles = {},
        explosions = {},
        update = function(self, dt)
            for index, missile in pairs(self.missiles) do
                missile.update(missile, dt)

                if (missile.remainingTime < 0) then
                    table.insert(self.explosions, explosion(missile.x, missile.y))
                    table.remove(self.missiles, index)
                end

            end
            for index, e in pairs(self.explosions) do
                if (e.update(e, dt)) then
                    table.remove(self.explosions, index)
                end
            end
        end,
        draw = function (self)
            for _, missile in pairs(self.missiles) do
                missile.draw(missile)
            end
            for _, e in pairs(self.explosions) do
                e.draw(e)
            end
        end,

        -- shoot a missile from the top of the screen
        -- targeted at one of the player's resources
        -- this shoot is only for chatters.
        -- if the player is shooting, call SiloGroup.shoot() instead
        shoot = function (self, targetName, shooterName, shooterColor)
            local x = math.random() * love.graphics.getWidth()
            local y = 0
            local tx = 200
            local ty = 200
            local r, g, b = _G.hexToRgb(shooterColor)

            -- print("chat shooterColor="..shooterColor.." shoot r="..color[1].." g="..color[2].." b="..color[3])
            -- print("chat shoot.  x="..x.." y="..y.." tx="..tx.." ty="..ty)
            local m = Missile(2, x, y, tx, ty, 20, 1, shooterName, r, g, b)
            table.insert(self.missiles, m)
        end,

        reset = function (self)
            self.missiles = {}
            self.explosions = {}
        end,
    }
end


return Projectiles