VictoryState = Class{__includes = BaseState}

function VictoryState:init()
    self.finished = false
    self.x = 100
    self.y = VIRTUAL_WIDTH
    self.dialogueTime = 10
end

function VictoryState:enter(params)
    gSounds['music']:stop()
    gSounds['ingame-music']:stop()
    gSounds['boss-music']:stop()
    gSounds['victory-music']:setLooping(false)
    gSounds['victory-music']:play()
end

function VictoryState:update(dt)
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
            gSounds['victory-music']:stop()
            gSounds['music']:setLooping(true)
            gSounds['music']:play()
            gStateMachine:change('start')
        end
    end
end

function VictoryState:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf('Congratulations!', 0, self.x, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('You defeated Ganon', 0, self.x+80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('and brought the Triforce', 0, self.x+120, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('back to the Kingdom of Hyrule!', 0, self.x+160, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to resume!', 0, self.x+240+VIRTUAL_HEIGHT/2-16, VIRTUAL_WIDTH, 'center')
end