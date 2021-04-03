Room = Class{}

function Room:init(player, dungeon)
    
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self:generateWallsAndFloors()

    self.entities = {}
    self.numberOfEntities = 0
    self:generateEntities()

    self.objects = {}

    self.doorways = {}
    table.insert(self.doorways, Doorway('top', false, self))
    table.insert(self.doorways, Doorway('bottom', false, self))

    self.player = player
    self.dungeon = dungeon

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0

    Level = Level + 2

    self.bullets = {}
    self.bulletImage = love.graphics.newImage('bullet.png')

    self.mouseCounter = 0
end

function Room:generateEntities()
    local types = {'skeleton'}

    for i = 1, Level do
        local type = types[math.random(#types)]

        table.insert(self.entities, Entity {
            animations = ENTITY_DEFS[type].animations,
            walkSpeed = ENTITY_DEFS[type].walkSpeed or 50,

            x = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
            y = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
            
            width = TILE_SIZE,
            height = TILE_SIZE,

            health = 2,

            type = ENTITY_DEFS[type].type
        })

        if math.random(10) == 1  then
            self.entities[i].hasreward = true
        end

        self.entities[i].stateMachine = StateMachine {
            ['walk'] = function() return EntityWalkState(self.entities[i]) end,
            ['idle'] = function() return EntityIdleState(self.entities[i]) end
        }

        self.entities[i]:changeState('walk')

        self.numberOfEntities = self.numberOfEntities + 1
    end
end

function Room:generateWallsAndFloors()
    for y = 1, self.height do
        table.insert(self.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY

            if x == 1 and y == 1 then
                id = TILE_TOP_LEFT_CORNER
            elseif x == 1 and y == self.height then
                id = TILE_BOTTOM_LEFT_CORNER
            elseif x == self.width and y == 1 then
                id = TILE_TOP_RIGHT_CORNER
            elseif x == self.width and y == self.height then
                id = TILE_BOTTOM_RIGHT_CORNER
            
            elseif x == 1 then
                id = TILE_LEFT_WALLS[math.random(#TILE_LEFT_WALLS)]
            elseif x == self.width then
                id = TILE_RIGHT_WALLS[math.random(#TILE_RIGHT_WALLS)]
            elseif y == 1 then
                id = TILE_TOP_WALLS[math.random(#TILE_TOP_WALLS)]
            elseif y == self.height then
                id = TILE_BOTTOM_WALLS[math.random(#TILE_BOTTOM_WALLS)]
            else
                id = TILE_FLOORS[math.random(#TILE_FLOORS)]
            end
            
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function Room:update(dt)
    if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end

    self.player:update(dt)

    for i, v in ipairs(self.bullets) do
		v.x = v.x + (v.dx * dt)
		v.y = v.y + (v.dy * dt)
    end
    if love.mouse.isDown(1) then
        self.mouseCounter = self.mouseCounter + 1
    end
    if love.mouse.isDown(1) and self.mouseCounter / 15 == 1 then 
            local startX = self.player.x
            local startY = self.player.y
            local mouseX = love.mouse.getX() / 5.925 - self.player.width / 2
            local mouseY = love.mouse.getY() / 5.925 + self.player.height / 2
            local bulletDx = 0
            local bulletDy = 0
            self.mouseCounter = 0
     
            local angle = math.atan2((mouseY - startY), (mouseX - startX))
            bulletDx = FIRE_SPEED * math.cos(angle)
            bulletDy = FIRE_SPEED * math.sin(angle)
     
            table.insert(self.bullets, {x = startX + self.player.width/ 2, y = startY + self.player.height/2, dx = bulletDx, dy = bulletDy, width = 1, height = 1})
    end
            

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]

        if entity.health <= 0 then
            entity.dead = true


            if entity.hasreward == true and entity.oneTime == true then
                local heart = GameObject(GAME_OBJECT_DEFS['heart'], entity.x, entity.y)
                table.insert(self.objects, heart)
                entity.onetime = false

                heart.onCollide = function(obj)

                    for k, name in pairs(self.objects) do 
                        if name == heart then 
                            entity.hasreward = false
                            if entity.healOnce == true then
                                self.player:heal()
                                entity.healOnce = false
                            end
                            table.remove(self.objects, k)
                            break
                        end
                    end

                end
            end
                
            if entity.counter == true then
                self.numberOfEntities = self.numberOfEntities - 1
                entity.counter = false
                score = score + 100
            end
        elseif not entity.dead then
            entity:processAI({room = self}, dt)
            entity:update(dt)
        end

        if not entity.dead then
            for k, bul in ipairs(self.bullets) do
                if entity:collides(bul) then
                    entity:damage(1)
                    table.remove(self.bullets, k)
                end
            end
        end

        if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
            gSounds['hit-player']:play()
            self.player:damage(1)
            self.player:goInvulnerable(1.5)

            if self.player.health == 0 then
                gStateMachine:change('game-over')
            end
        end
    end

    for k, object in pairs(self.objects) do
        object:update(dt)

        if self.player:collides(object) then
            object:onCollide()
        end
    end
    if self.numberOfEntities == 0 then
        for k, doorway in pairs(self.doorways) do
            doorway.open = true
        end
        gSounds['door']:play()
        self.numberOfEntities = -1
    end
end

function Room:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX + self.adjacentOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY + self.adjacentOffsetY)
        end
    end

    for k, doorway in pairs(self.doorways) do
        doorway:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end

    for k, object in pairs(self.objects) do
        object:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end

    for i, v in ipairs(self.bullets) do
		love.graphics.draw(self.bulletImage, v.x, v.y)
	end

    for k, entity in pairs(self.entities) do
        if not entity.dead then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
    end

    love.graphics.stencil(function()
        -- left
        love.graphics.rectangle('fill', -TILE_SIZE - 6, MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE,
            TILE_SIZE * 2 + 6, TILE_SIZE * 2)
        
        -- right
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH * TILE_SIZE) - 6,
            MAP_RENDER_OFFSET_Y + (MAP_HEIGHT / 2) * TILE_SIZE - TILE_SIZE, TILE_SIZE * 2 + 6, TILE_SIZE * 2)
        
        -- top
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2) * TILE_SIZE - TILE_SIZE,
            -TILE_SIZE - 6, TILE_SIZE * 2, TILE_SIZE * 2 + 12)
        
        --bottom
        love.graphics.rectangle('fill', MAP_RENDER_OFFSET_X + (MAP_WIDTH / 2) * TILE_SIZE - TILE_SIZE,
            VIRTUAL_HEIGHT - TILE_SIZE - 6, TILE_SIZE * 2, TILE_SIZE * 2 + 12)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)
    
    if self.player then
        self.player:render()
    end

    love.graphics.setStencilTest()
end