highScore = 0
StartState = Class{__includes = BaseState}

function StartState:init()

    score = 0

end

function StartState:enter(params)

end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0.133, 0.133, 0.133, 1)
    love.graphics.printf('Arcade', 2, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(0.68, 0.2, 0.16, 1)
    love.graphics.printf('Arcade', 0, VIRTUAL_HEIGHT / 3 - 2, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 3 + 64, VIRTUAL_WIDTH, 'center')
end