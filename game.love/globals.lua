local love = require "love"

function _G.calculateDistance(x1, y1, x2, y2)
    local dx = (x2 - x1) ^ 2
    local dy = (y2 - y1) ^ 2
    return math.sqrt(dx + dy)
end

function _G.areTouching(obj1, obj2)
    -- Calculate the distance between the centers of the objects
    local distance = math.sqrt((obj1.x - obj2.x)^2 + (obj1.y - obj2.y)^2)

    -- print("obj1.collisionRadius="..obj1.collisionRadius.." ".."obj2.collisionRadius="..obj2.collisionRadius)
    -- Calculate the sum of their collision radii
    local sumOfRadii = obj1.collisionRadius + obj2.collisionRadius
    -- Check if the distance is less than or equal to the sum of the radii
    return distance <= sumOfRadii
end

function _G.hexToRgb(hex)
    hex = hex:gsub("#","")
    local r = tonumber("0x"..hex:sub(1,2)) / 255
    local g = tonumber("0x"..hex:sub(3,4)) / 255
    local b = tonumber("0x"..hex:sub(5,6)) / 255
    return r, g, b
end

function _G.lerp(a,b,t) return a + (b - a) * t end

_G.buildingPattern = "010010010"
_G.font = love.graphics.newFont(20)
_G.labelFont = love.graphics.newFont(12)
_G.MISSILE_BASE_SPEED = 250
_G.DEBUG = true
