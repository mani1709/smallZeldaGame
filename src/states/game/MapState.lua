MapState = Class{__includes = BaseState}

function MapState:init()

end

function MapState:enter(params)
    self.roomid = params.roomid
    self.player = params.player
    self.dungeon = params.dungeon
end

function MapState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('m') then
        gStateMachine:change('play', {
            roomid = self.roomid,
            player = self.player,
            dungeon = self.dungeon
        })
    end
end

function MapState:render()
    --map
    love.graphics.draw(gTextures['map'], 20, 0, 0, VIRTUAL_WIDTH / gTextures['map']:getWidth(), VIRTUAL_HEIGHT / gTextures['map']:getHeight())

    --player health
    local healthLeft = self.player.health
    local heartFrame = self.player.maxHealth / 4

    for i = 1, heartFrame do
        if healthLeft <= 0 then
            love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], (i - 1) * (TILE_SIZE + 1), 2)
        elseif healthLeft == 1 then
            love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], (i - 1) * (TILE_SIZE + 1), 2)
        elseif healthLeft == 2 then
            love.graphics.draw(gTextures['hearts'], gFrames['hearts'][3], (i - 1) * (TILE_SIZE + 1), 2)
        elseif healthLeft == 3 then
            love.graphics.draw(gTextures['hearts'], gFrames['hearts'][4], (i - 1) * (TILE_SIZE + 1), 2)
        else 
            love.graphics.draw(gTextures['hearts'], gFrames['hearts'][5], (i - 1) * (TILE_SIZE + 1), 2)
        end
        healthLeft = healthLeft - 4
    end
    
    --bombs
    if self.hasBombsUnlocked then
        love.graphics.draw(gTextures['bomb'], VIRTUAL_WIDTH - 20, 2, 0, 0.075, 0.075)
        love.graphics.printf(self.player.bombs .. 'x', VIRTUAL_WIDTH-130, 8, 100, 'center', 0, 2, 2)
    end

    --rectangle over curr room
    love.graphics.setColor(255, 0, 0)
    
    if self.roomid == 1 then
        love.graphics.rectangle("line", 151, 157, 88, 39)
    elseif self.roomid == 2 then
        love.graphics.rectangle("line", 58, 157, 88, 39)
    elseif self.roomid == 3 then
        love.graphics.rectangle("line", 244, 157, 88, 39)
    elseif self.roomid == 4 then
        love.graphics.rectangle("line", 151, 114, 88, 39)
    elseif self.roomid == 5 then
        love.graphics.rectangle("line", 151, 70, 88, 39)
    elseif self.roomid == 6 then
        love.graphics.rectangle("line", 58, 70, 88, 40)
    elseif self.roomid == 7 then
        love.graphics.rectangle("line", 151, 27, 88, 39)
    elseif self.roomid == 8 then
        love.graphics.rectangle("line", 58, 27, 88, 39)
    elseif self.roomid == 9 then
        love.graphics.rectangle("line", 244, 27, 88, 39)
    end
end