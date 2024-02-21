local health = ECS.Component("health", function(c, hp)
    c.hp = hp or 1
end)

return health