return function()
    local world = ECS.World()

    -- Systems
    world:addSystems(
      SYSTEMS.move,
      SYSTEMS.render,
      SYSTEMS.player,
      SYSTEMS.attack,
      SYSTEMS.defend,
      SYSTEMS.throttle,
      SYSTEMS.cannon,
      SYSTEMS.missile,
      SYSTEMS.explosion
    )

    -- print("welcome in the world of Phalanx")
    -- Entities
    local entities = {
      -- city = ECS.Entity(world)
      --   :give("position", 100, 100)
      --   :give("health", 1)
      --   :give("render"),

      playerCannon = ECS.Entity(world)
        :give("position", love.graphics.getWidth()/2, love.graphics.getHeight()-16)
        :give("cannon")
        :give("player")
        :give("rps", 24),
        -- :give("render"),

      chatCannon = ECS.Entity(world)
        :give("position", 100, 100)
        :give("cannon")
        :give("chat"),
    }

    for _, e in ipairs(entities) do
      GAME:addEntities(e)
    end

    return world
  end