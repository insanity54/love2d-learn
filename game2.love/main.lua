-- load libraries
local Concord = require("lib.concord")
local love = require("love")
require("lib.lovedebug.lovedebug")

-- load local modules
GAME = require("src.game")

-- load main ECS libs
ECS = {}
ECS.Component = require("lib.concord.component")
ECS.System = require("lib.concord.system")
ECS.World = require("lib.concord.world")
ECS.Entity = require("lib.concord.entity")

-- load ECS tables
COMPONENTS = {}
SYSTEMS = {}
WORLDS = {}
ENTITIES = {}
ASSEMBLAGES = {}
Concord.utils.loadNamespace("src/components", COMPONENTS)
Concord.utils.loadNamespace("src/systems", SYSTEMS)
Concord.utils.loadNamespace("src/worlds", WORLDS)
Concord.utils.loadNamespace("src/entities", ENTITIES)
Concord.utils.loadNamespace("src/assemblages", ASSEMBLAGES)

-- CONSTANTS
CONST = {
  MISSILE_BASE_SPEED = 300,
}

-- initial load func
function love.load()
  GAME.current = WORLDS.phalanx()
end

-- main loop
function love.update(dt)
  GAME.current:emit("update", dt)
end

-- draw loop
function love.draw()
  GAME.current:emit("draw")
end

-- function love.keypressed(key)
--   GAME.current:emit("keypressed", key)
-- end

-- function love.keyreleased(key)
--   GAME.current:emit("keyreleased", key)
-- end

function love.mousepressed(x, y, btn)
  GAME.current:emit("mousepressed", x, y, btn)
end

function love.mousereleased(x, y, btn)
  GAME.current:emit("mousereleased", x, y, btn)
end
