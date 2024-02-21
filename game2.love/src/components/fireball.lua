local fireball = ECS.Component("fireball", function(c, maxRadius)
    c.maxRadius = maxRadius or 50
    c.radius = 0
    c.duration = 0.15
    c.timer = 0
end)

return fireball
