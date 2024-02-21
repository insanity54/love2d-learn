local CannonSystem = ECS.System({
    pool = { "cannon" }
})

function CannonSystem:mousepressed(x, y, btn)
    if btn == 2 then
        self:fire(x, y)
    end
end

function CannonSystem:update(dt)

end

function CannonSystem:fire(tx, ty)

    local level = 2
    local missileSpeed = CONST.MISSILE_BASE_SPEED + (level * 2)

    -- Calculate the direction from current position to the target
    -- x, y creation pos
    -- tx, ty target pos
    -- dx, dy, direction pos
    local x = love.graphics.getWidth()/2
    local y = love.graphics.getHeight()
    local dx = tx - x
    local dy = ty - y
    local length = math.sqrt(dx * dx + dy * dy)

    -- Normalize the direction
    local vx = dx / length * missileSpeed
    local vy = dy / length * missileSpeed

    -- Introduce random spread
    local spreadAngle = math.pi / 360  -- Adjust spread angle as needed
    local randomAngle = love.math.random() * spreadAngle - spreadAngle / 2
    local cosRandomAngle = math.cos(randomAngle)
    local sinRandomAngle = math.sin(randomAngle)

    local vxFinal = vx * cosRandomAngle - vy * sinRandomAngle
    local vyFinal = vx * sinRandomAngle + vy * cosRandomAngle


    -- Calculate the time to target
    local distanceToTarget = math.sqrt((tx - x)^2 + (ty - y)^2)
    local timeToTarget = distanceToTarget / missileSpeed

    local missile = ECS.Entity(self:getWorld())
        :give('projectile')
        :give('health', 1)
        :give('position', x, y)
        :give('velocity', vxFinal, vyFinal)
        :give('explosive')
        :give('fuse', timeToTarget)
        :give('render')


    GAME:addEntities(missile)
end


return CannonSystem
