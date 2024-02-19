local love = require("love")
local scene = {}

local font = love.graphics.newFont(20)






function scene.load()
    print("[game.love] loaded menu scene")
end

function scene.modify(flags)
end

function scene.update()
end

function scene.draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Enter your twitch channel.\n\ntwitch.tv/"..Channel, font, 200, 300, 500, "center")
    -- if not pacman.eat then
    --     love.graphics.rectangle("fill", food.x, 250, 10, 10)
    -- end

    -- love.graphics.arc("fill", pacman.x, pacman.y, 30, 1, 5)


end

return scene

