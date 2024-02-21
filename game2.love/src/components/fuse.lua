local fuse = ECS.Component("fuse", function(c, timer)
    c.timer = timer or 1000
end)

return fuse