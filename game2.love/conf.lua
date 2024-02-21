local love = require("love")

function love.conf(t)
    t.identity = "data/saves"
    t.gammacorrect = true
    t.window.title = "My Cool Game"
    t.window.icon = "icon/icon_light.png"
    t.window.resizable = true
    t.console = true
end

