score = 0

PlayState = Class{__includes = BaseState}

function PlayState:init()
    cursor = love.mouse.newCursor('target.png', 0, 0)
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 16,
        height = 22,

        health = 6,

        offsetY = 5,
        type = 'player',
        carryingPot = nil
    }

    self.dungeon = Dungeon(self.player)
    self.currentRoom = Room(self.player, self.dungeon)
    
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        ['pot-walk'] = function() return PlayerPotWalkState(self.player, self.dungeon) end,
        ['pot-walk-idle'] = function() return PlayerPotWalkIdleState(self.player, self.dungeon) end,
        ['pot-lift'] = function() return PlayerPotLiftState(self.player, self.dungeon) end,
        ['pot-throw'] = function() return PlayerPotThrowState(self.player, self.dungeon) end
    }
    self.player:changeState('idle')
end

function PlayState:enter(params)

end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.dungeon:update(dt)
    love.mouse.setCursor(cursor)
end

function PlayState:render()
    love.graphics.push()
    self.dungeon:render()
    love.graphics.pop()

    local healthLeft = self.player.health
    local heartFrame = 1

    for i = 1, 3 do
        if healthLeft > 1 then
            heartFrame = 5
        elseif healthLeft == 1 then
            heartFrame = 3
        else
            heartFrame = 1
        end

        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][heartFrame],
            (i - 1) * (TILE_SIZE + 1) * 4 , 2 , 0, 4, 4)
        
        healthLeft = healthLeft - 2
    end
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0.68, 0.2, 42, 1)
    love.graphics.printf('Score: ' .. tostring(score), 216, 5, VIRTUAL_WIDTH, 'right', 0, 4, 4)
end