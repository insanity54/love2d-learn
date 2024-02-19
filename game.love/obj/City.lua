local love = require "love"

function City(x, y, height, hp, name)


    return {
        x = x,
        y = y,
        hp = hp,
        name = name,
        collisionRadius = height/1.5,

        update = function(self, dt)

        end,

        draw = function(self)
            if (_G.DEBUG) then
                love.graphics.setColor(1, 0, 0)
                love.graphics.circle("line", self.x, self.y+(height/2), height/1.5)
                love.graphics.setColor(0.3, 0, 0)
                local text = love.graphics.newText(_G.font, self.name)
                love.graphics.draw(text, self.x, self.y-(height*2))
            end

            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", self.x-(height/2), self.y, height, height)
            -- love.graphics.printf(self.name, _G.font, self.x-100, self.y-(height*2), 500, "center")

        end,


    }
end

return City
