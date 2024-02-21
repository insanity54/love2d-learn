local love = require "love"
local explosion = require "obj.Explosion"

function Projectiles()

    return {
        missiles = {},
        explosions = {},
        update = function(self, dt)
            -- detect if a missile's fuse has timed out
            for index, missile in pairs(self.missiles) do
                missile.update(missile, dt)

                if (missile.remainingTime < 0) then
                    table.insert(self.explosions, explosion(missile.x, missile.y))
                    self.missiles[index] = nil -- use this instead of table.remove which causes performance issues
                end

            end
            -- detect if an explosion has timed out
            for index, e in pairs(self.explosions) do
                if (e.update(e, dt)) then
                    self.explosions[index] = nil
                end
            end
            -- detect if an explosion is touching a missile
            for _, e in pairs(Projectiles.explosions) do
                for mIndex, m in pairs(Projectiles.missiles) do
                    if _G.areTouching(e, m) then
                        table.insert(self.explosions, explosion(m.x, m.y))
                        self.missiles[mIndex] = nil
                    end
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

            -- get the x, y of a random city
            local randomCity = Cities.cities[math.random(#Cities.cities)]
            if not randomCity then
                return
            end

            local x = math.random() * love.graphics.getWidth()
            local y = 0
            local tx = randomCity.x
            local ty = randomCity.y
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