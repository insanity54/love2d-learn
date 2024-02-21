local explosive = ECS.Component("explosive", function(c, magnitude)
    c.magnitude = magnitude or 1
end)

return explosive