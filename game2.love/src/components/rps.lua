
-- Rounds Per Second
local rps = ECS.Component("rps", function(c, rps)
    -- how many shots can be made per second
    c.rps = rps or 5

    -- the interval timer. increments by dt every tick. once this reaches interval (1/rps) the cannon fires
    c.roundTimer = 0

end)

return rps