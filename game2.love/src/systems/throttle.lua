local ThrottleSystem = ECS.System({
    pool = { "rps" }
})


function ThrottleSystem:update(dt)
    -- print("update ThrottleSystem "..#self.pool)
    for _, e in ipairs(self.pool) do
        -- print(e)
        -- incr rps timer
        -- print("rountTimer="..e.rps.roundTimer.." interval="..(1/e.rps.rps))
        e.rps.roundTimer = e.rps.roundTimer + dt

        -- is it time to fire?
        if e.rps.roundTimer >= (1/e.rps.rps) then
            if love.mouse.isDown(1) then
                e.rps.roundTimer = 0 -- reset interval timer
                local x = love.mouse.getX()
                local y = love.mouse.getY()
                GAME.current:emit("fire", x, y) -- fire missile
            end
        end
    end
end

return ThrottleSystem