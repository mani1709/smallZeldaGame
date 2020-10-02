StartState = Class{__includes = BaseState}

function StartState:init()
    self.rBackground = 255 
    self.gBackground = 255 
    self.bBackground = 255
    self.rText1 = 34 
    self.gText1 = 34 
    self.bText1 = 34
    self.rText2 = 175 
    self.gText2 = 53 
    self.bText2 = 53
    self.rText3 = 255 
    self.gText3 = 255 
    self.bText3 = 255
end

function StartState:enter(params)

end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        Timer.tween(1, {
            [self] = {
                rBackground = 0,
                gBackground = 0,
                bBackground = 0,
                rText1 = 0, 
                gText1 = 0,  
                bText1 = 0, 
                rText2 = 0,  
                gText2 = 0,  
                bText2 = 0, 
                rText3 = 0,  
                gText3 = 0,  
                bText3 = 0, 
            }
        }):finish(function()
            gStateMachine:change('intro')
        end)
    end
end

function StartState:render()
    love.graphics.setColor(self.rBackground, self.gBackground, self.bBackground, 255)
    love.graphics.draw(gTextures['background'], 0, 0, 0, VIRTUAL_WIDTH / gTextures['background']:getWidth(), VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setFont(gFonts['zelda'])
    love.graphics.setColor(self.rText1, self.gText1, self.bText1, 255)
    love.graphics.printf('The Legend', 2, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('of Zelda', 2, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(self.rText2, self.gText2, self.bText2, 255)
    love.graphics.printf('The Legend', 0, VIRTUAL_HEIGHT / 2 - 62, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('of Zelda', 0, VIRTUAL_HEIGHT / 2 - 12, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(self.rText3, self.gText3, self.bText3, 255)
    love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end