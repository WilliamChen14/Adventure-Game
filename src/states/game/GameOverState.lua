GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    if highScore < score then
        highScore = score
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(175, 53, 42, 255)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Score: ' .. tostring(score), 0, 5, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Highscore: ' .. tostring(highScore), 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    Level = 4
end