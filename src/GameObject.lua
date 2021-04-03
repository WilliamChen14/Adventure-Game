GameObject = Class{}

function GameObject:init(def, x, y)

    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    self.consumable = def.consumable
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.onCollide = function() end

    self.projecting = false
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame or self.states[self.state].frame],
    self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end