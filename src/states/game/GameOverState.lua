GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.finished = false
    self.x = 100
    self.y = VIRTUAL_WIDTH
    self.dialogueTime = 10
end

function GameOverState:enter(params)

end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    Timer.tween(self.dialogueTime, {
        [self] = {
            x = -240
        }
    }):finish(function()
        finished = true
    end)

    if finished then
        if love.keyboard.wasPressed('return') then
            love.graphics.setColor(0, 0, 0, 255)
            gStateMachine:change('play')
        end
    end
end

function GameOverState:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf('You died!', 0, self.x, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Ganon took over the World by', 0, self.x+80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('using the Triforce of Power', 0, self.x+120, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('and you could not stop him!', 0, self.x+160, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to resume!', 0, self.x+240+VIRTUAL_HEIGHT/2-16, VIRTUAL_WIDTH, 'center')
end