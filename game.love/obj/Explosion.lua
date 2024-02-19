local love = require "love"

function Explosion(x, y, duration)
    duration = duration or 0.5

    local maxRadius = 50
    local timeElapsed = 0

    return {
        x = x,
        y = y,
        collisionRadius = 0,

        update = function(self, dt)
            -- Increase the radius over time until it reaches maxRadius
            timeElapsed = timeElapsed + dt
            self.collisionRadius = math.min(maxRadius, self.collisionRadius + dt * maxRadius / duration)
            -- If the explosion has reached its maximum radius, remove it
            if timeElapsed >= duration then
                return true -- Signal to remove the explosion
            end
        end,

        draw = function(self)
            -- Draw the explosion as a circle
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", self.x, self.y, self.collisionRadius)
        end
    }
end

return Explosion