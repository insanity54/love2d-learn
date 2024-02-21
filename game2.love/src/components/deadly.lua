local deadly = ECS.Component("deadly", function(c, radius)
    c.radius = radius or 50
end)

return deadly