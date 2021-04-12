InstructionsState = Class{__includes = BaseState}

function InstructionsState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function InstructionsState:render()

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0.68, 0.2, 0.16, 1)
    love.graphics.printf('INSTRUCTIONS', 0, VIRTUAL_HEIGHT / 2 - 90, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('You play a MAGE, trying to reach the top of this tower', 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Use ARROW KEYS to move around', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Point and click using the MOUSE to slay your enemies', 0, VIRTUAL_HEIGHT / 2 - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Walk up to the stairs to ascend', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0.68, 0.2, 0.16, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('THE TOWER AWAITS...', 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    
end