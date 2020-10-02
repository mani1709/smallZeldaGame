IntroState = Class{__includes = BaseState}

function IntroState:init()
    self.finished = false
    self.x = 100
    self.y = VIRTUAL_WIDTH
    self.dialogueTime = 30
end

function IntroState:enter(params)

end

function IntroState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    Timer.tween(self.dialogueTime, {
        [self] = {
            x = -560
        }
    }):finish(function()
        finished = true
    end)

    if finished then
        if love.keyboard.wasPressed('return') then
            gSounds['music']:stop()
            gStateMachine:change('play')
        end
    end
end

function IntroState:render()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf('Ganon, the Demon King,', 0, self.x, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('revived and stole the', 0, self.x+40, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Triforce of Power!', 0, self.x+80, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Impa, the nursemaid of', 0, self.x+160, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('the Kingdom of Hyrule', 0, self.x+200, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('was sent by Zelda', 0, self.x+240, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('the Princess of Hyrule', 0, self.x+280, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('to find Link!', 0, self.x+320, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('His mission is to defeat Ganon', 0, self.x+400, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('and bring the Triforce', 0, self.x+440, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('back to Zelda!', 0, self.x+480, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Start!', 0, self.x+560+VIRTUAL_HEIGHT/2-16, VIRTUAL_WIDTH, 'center')
end