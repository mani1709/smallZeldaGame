PlayerUseBombState = Class{__includes = BaseState}

function PlayerUseBombState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.time = 0
    self.player:changeAnimation('use-bomb-' .. self.player.direction)
end

function PlayerUseBombState:enter(params)
    self.player.bombs = self.player.bombs - 1
    if self.player.direction == 'right' then
        table.insert(self.dungeon.objects, GameObject(GAME_OBJECT_DEFS['bomb'], self.player.x+10, self.player.y+10, self.player.roomid))
    elseif self.player.direction == 'left' then
        table.insert(self.dungeon.objects, GameObject(GAME_OBJECT_DEFS['bomb'], self.player.x-10, self.player.y+10, self.player.roomid))
    elseif self.player.direction == 'up' then
        table.insert(self.dungeon.objects, GameObject(GAME_OBJECT_DEFS['bomb'], self.player.x, self.player.y-10, self.player.roomid))
    elseif self.player.direction == 'down' then
        table.insert(self.dungeon.objects, GameObject(GAME_OBJECT_DEFS['bomb'], self.player.x, self.player.y+20, self.player.roomid))
    end
    self:bombPlanted()
end

function PlayerUseBombState:update(dt)
    self.time = self.time + dt
    if self.time > 0.1 then
        self.player:changeState('idle')
    end
end

function PlayerUseBombState:render()
    local anim = self.player.currentAnimation
    
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end

function PlayerUseBombState:bombPlanted()
    Timer.after(1, function()
        for k, object in pairs(self.dungeon.objects) do
            if object.type == 'bomb' then
                table.remove(self.dungeon.objects, k)
                gSounds['explosion']:play()
            end
        end 
    end)
end