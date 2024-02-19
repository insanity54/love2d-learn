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
    love.graphics.printf("GAME OVER", _G.font, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 500, "center")
    love.graphics.printf("Press Esc to restart", _G.labelFont, 0, love.graphics.getHeight()/2+25, 500, "center")
end

return scene

