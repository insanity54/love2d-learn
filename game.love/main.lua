local love = require "love"
local utf8 = require "utf8"
SM = require "lib.SceneMgr"
local baton = require 'lib.baton'
-- local websocket = require "lib.websocket"
local ProjectilesLib = require "lib.Projectiles"


-- constants
local controls = {
    shoot = {
        'key:space',
        'mouse:1'
    }
}
local config = {
    controls = controls
}

-- vars
Channel = "xqc"
Player = baton.new(config)

-- script
-- Client = websocket.new("127.0.0.1", 5211)
Projectiles = ProjectilesLib()

local function parseMessage(message)
    local args = {}

    for arg in message:gmatch("%S+") do
        table.insert(args, arg)
    end

    return args
end

-- function Client:onmessage(message)
--     -- print("[game.love] we got a message="..message)
--     local parsedArgs = parseMessage(message)
--     local command = parsedArgs[1]
--     local target = parsedArgs[2]
--     local shooterName = parsedArgs[3]
--     local cRaw = parsedArgs[4]
--     local color
--     if cRaw == "null" then
--         color = "#FFFFFF"
--     else
--         color = cRaw
--     end

--     -- print("command="..command.." target="..target.." shooterName="..shooterName.." color="..color)

--     if parsedArgs[1] == 'shoot' then
--         Projectiles.shoot(
--             Projectiles,
--             target,
--             shooterName,
--             color
--         )
--     end
-- end

-- function Client:onopen()
--     print("[game.love] ws client opened.")
--     self:send("hello from love2d")
-- end

-- function Client:onclose(code, reason)
--     print("[game.love] closecode: "..code..", reason: "..reason)
-- end

function love.keypressed(key)
    if key == "backspace" and SM.cName == "menu" then
        local byteoffset = utf8.offset(Channel, -1)
        if byteoffset then
            Channel = string.sub(Channel, 1, byteoffset - 1)
        end
    end

    if key == "return" and SM.cName == "menu" then
        SM.unload('menu')
        SM.load('game')
    end

    if key == "return" and SM.cName == "game" then
        -- print("[game.love] return was pressed.")
        -- Client:send("test")

        for i=1,64 do
            Projectiles.shoot(
                Projectiles,
                3,
                "taco man",
                "#00FFCC"
            )
        end

    end


    if key == "escape" then
        if SM.cName == "menu" then
            love.event.push('quit')
        elseif SM.cName == "game" then
            SM.unload("game")
            SM.load("menu")
        elseif SM.cName == "fail" then
            SM.unload("fail")
            SM.load("game")
        end
    end
end


function love.textinput(t)
    Channel = Channel .. t
end


function love.load()
    math.randomseed(os.time())

    love.keyboard.setKeyRepeat(true)

    -- Set path of your scene files
    SM.setPath("scenes/")

    -- Add scene "menu" to scene table
    SM.load("menu")

end

function love.update(dt)
    -- Run your scene files update function
    SM.update(dt)
    -- Client:update()
end

function love.draw()
    -- Run your scene files render function
    SM.draw()
end
