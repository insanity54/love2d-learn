local love = require "love"
require "globals"


function Missile(team, x, y, tx, ty, size, level, name, r, g, b)
    r = r or 1
    g = g or 1
    b = b or 1
    name = name or ""

    -- print("missile created.  x="..x.." y="..y.." tx="..tx.." ty="..ty)

    local MISSILE_SIZE = size
    local MISSILE_LINE_WEIGHT = 10
    local missileSpeed = _G.MISSILE_BASE_SPEED + (level * 2)

    local velocity = -1

    if math.random() < 0.5 then
        velocity = 1
    end



    -- Calculate the direction from current position to the target
    local direction_x = tx - x
    local direction_y = ty - y
    local length = math.sqrt(direction_x * direction_x + direction_y * direction_y)

    -- Normalize the direction
    direction_x = direction_x / length
    direction_y = direction_y / length

    -- Calculate the time to target
    local distanceToTarget = math.sqrt((tx - x)^2 + (ty - y)^2)
    local timeToTarget = distanceToTarget / missileSpeed

    

    return {
        x = x,
        y = y,
        tx = tx,
        ty = ty,
        r = r,
        g = g,
        b = b,
        name = name,
        x_velocity = math.random() * missileSpeed * velocity,
        y_velocity = math.random() * missileSpeed * velocity,
        direction_x = direction_x, -- Store the direction
        direction_y = direction_y,
        collisionRadius = 16,
        fuseDuration = timeToTarget,
        remainingTime = timeToTarget,
        startTime = love.timer.getTime(),
        update = function(self, dt)
            -- Move the missile towards the target at constant speed

            -- local lerpAmount = missileSpeed * dt / distanceToTarget -- this shit is faulty. missile doesn't reach target (pre-mature explosion)
            -- self.x = _G.lerp(self.x, self.tx, lerpAmount)           -- this shit is faulty. missile doesn't reach target (pre-mature explosion)
            -- self.y = _G.lerp(self.y, self.ty, lerpAmount)           -- this shit is faulty. missile doesn't reach target (pre-mature explosion)
            self.x = self.x + self.direction_x * missileSpeed * dt
            self.y = self.y + self.direction_y * missileSpeed * dt

            self.remainingTime = self.remainingTime - dt
            -- print("missile.startTime="..self.startTime.." missile.fuseDuration="..self.fuseDuration.." missile flight time="..self.remainingTime)
        end,

        draw = function (self)
            -- love.graphics.setColor() -- @todo match with player color
            if _G.DEBUG then
                love.graphics.setColor(0, 1, 0)
                love.graphics.circle("line", self.x, self.y, self.collisionRadius)
                -- love.graphics.circle("fill", self.x, self.y, 4, 4)
            end
            love.graphics.setColor(r, g, b)
            love.graphics.setPointSize(2)
            love.graphics.points(self.x, self.y)

            -- text label
            love.graphics.printf(self.name, _G.labelFont, self.x+20, self.y-6, 500, "left")

        end,

    }
end

return Missile