local DefendSystem = ECS.System({
    pool = {"cannon", "player", "rps"}
  })

  function DefendSystem:update(dt)
      -- if love.mouse.isDown(1) then
      --     fireTimer = fireTimer + dt
      --     while fireTimer >= fireInterval do
      --         self:fireMissile()
      --         fireTimer = fireTimer - fireInterval
      --     end
      -- else
      --     fireTimer = 0
      -- end
  end


  function DefendSystem:mousepressed(tx, ty, btn)



    -- print("mousepressed x="..x.." y="..y.." btn="..btn)
    for _, e in ipairs(self.pool) do
      if btn == 1 then
        
        local tx = love.mouse.getX()
        local ty = love.mouse.getY()
      end
    end
  end

  return DefendSystem