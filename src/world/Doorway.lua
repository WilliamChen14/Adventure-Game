Doorway = Class{}

function Doorway:init(direction, open, room)
    self.direction = direction
    self.open = open
    self.room = room

    if direction == 'left' then
        self.x = MAP_RENDER_OFFSET_X
        self.y = MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE
        self.height = 32
        self.width = 16
    elseif direction == 'right' then
        self.x = MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - TILE_SIZE
        self.y = MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2 * TILE_SIZE) - TILE_SIZE
        self.height = 32
        self.width = 16
    elseif direction == 'top' then
        self.x = MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2 * TILE_SIZE) - TILE_SIZE
        self.y = MAP_RENDER_OFFSET_Y
        self.height = 16
        self.width = 32
    else
        self.x = MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2 * TILE_SIZE) - TILE_SIZE
        self.y = MAP_RENDER_OFFSET_Y + (MAP_HEIGHT * TILE_SIZE) - TILE_SIZE
        self.height = 16
        self.width = 32
    end
end

function Doorway:render(offsetX, offsetY)
    local texture = gTextures['tiles']
    local quads = gFrames['tiles']

    self.x = self.x + offsetX
    self.y = self.y + offsetY
    self.doorImage = love.graphics.newImage('sprites/staircase.png')

    if self.direction == 'top' then
        if self.open then
            love.graphics.draw( self.doorImage, self.x , self.y)
        else
            love.graphics.draw( self.doorImage, self.x , self.y)
        end
    else
        if self.open then
            love.graphics.draw( self.doorImage, self.x , self.y)
        else
            love.graphics.draw( self.doorImage, self.x , self.y)
        end
    end

    self.x = self.x - offsetX
    self.y = self.y - offsetY
end