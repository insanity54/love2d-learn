local MissileSystem = ECS.System({
  pool = { "explosive", "fuse", "projectile", "position", "health", "velocity" }
})



function MissileSystem:update(dt)
  for _, e in ipairs(self.pool) do
    if e.fuse.timer <= 0 then

      local explosion = ECS.Entity(self:getWorld()):assemble(ASSEMBLAGES.explosion, e.position.x, e.position.y)
      GAME:addEntities(explosion)



      e:destroy()
    else
      e.fuse.timer = e.fuse.timer - dt
    end
  end
end


return MissileSystem
