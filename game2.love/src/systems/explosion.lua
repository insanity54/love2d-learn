local ExplosionSystem = ECS.System({
    pool = { "fireball", "position" }
})


function ExplosionSystem:update(dt)
    for _, e in ipairs(self.pool) do

        -- increment the timer
        e.fireball.timer = e.fireball.timer + dt

        -- Increase the radius over time until it reaches maxRadius
        -- e.fireball.radius = math.min(e.fireball.maxRadius, e.fireball.radius + dt * e.fireball.maxRadius / e.fireball.duration)

        -- Calculate the progress of the explosion from 0 to 1 based on the current timer and the total duration
        local progress = math.min(e.fireball.timer / e.fireball.duration, 1)

        -- Use easeOutExpo function to control the rate of change of the explosion radius over time
        e.fireball.radius = e.fireball.maxRadius * (progress == 1 and 1 or 1 - 2 ^ (-10 * progress))
        
        -- e.fireball.radius = x == 1 and 1 or 1 - 2 ^ (-10 * x)

        -- If the explosion has reached its maximum radius, remove it
        if e.fireball.timer >= e.fireball.duration then
            e:destroy()
        end
    end
end

function ExplosionSystem:draw()
    for _, e in ipairs(self.pool) do
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", e.position.x, e.position.y, e.fireball.radius)
    end
end

return ExplosionSystem
