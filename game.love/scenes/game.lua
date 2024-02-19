local love = require("love")
local scene = {}


local rotation = 10
local timer = 0
local interval = 1

local missile = require "obj.Missile"
local siloGroup = require "obj.SiloGroup"
local cityGroup = require "obj.CityGroup"
local debugThing = require "obj.Debug"

local silos = siloGroup()
local debug = debugThing(500, 500)
Cities = cityGroup()

function scene.load()
    print("[game.love] Channel="..Channel)
    -- Client:send("join "..Channel)
    -- TestMissile = Missile(350, 350, 500, 500, 30, 1, true)

    silos.spawn(silos)
    Cities.spawn(Cities)
end


function scene.modify(flags)
end

function scene.update(dt)
    Player:update()
    silos.update(silos, dt)
    Cities.update(Cities, dt)
    Projectiles.update(Projectiles, dt)

    if (Player:pressed('shoot')) then
        silos.shoot(silos, love.mouse.getX(), love.mouse.getY())
    end

    if #Cities.cities == 0 then
        Projectiles.reset(Projectiles)

       SM.unload("game")
       SM.load("fail")
    end
end




function scene.draw()
    if (_G.DEBUG) then
        debug:draw()
    end
    silos:draw()
    Cities:draw()
    Projectiles:draw()
end

return scene
