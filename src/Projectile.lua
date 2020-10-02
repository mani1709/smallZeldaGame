--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(obj, direction)
    self.obj = obj
    self.direction = direction
    self.distance = 0
    self.broken = false
    self.maxdistance = TILE_SIZE * MAXDISTANCEBLOCKS
    self.speed = 100
end

function Projectile:update(dt)
    if self.broken then
        return
    end

    if self.direction == 'right' then
        self.obj.x = self.obj.x + self.speed*dt
        if self.obj.x + self.obj.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.obj.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.obj.width
            self.broken = true
        end
    elseif self.direction == 'left' then
        self.obj.x = self.obj.x - self.speed*dt
        if self.obj.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
            self.obj.x = MAP_RENDER_OFFSET_X + TILE_SIZE
            self.broken = true
        end
    elseif self.direction == 'up' then
        self.obj.y = self.obj.y - self.speed*dt
        if self.obj.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.obj.height / 2 then 
            self.obj.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.obj.height / 2
            self.broken = true
        end
    elseif self.direction == 'down' then
        self.obj.y = self.obj.y + self.speed*dt
        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE
        if self.obj.y + self.obj.height >= bottomEdge then
            self.obj.y = bottomEdge - self.obj.height
            self.broken = true
        end
    end
        
    if self.broken then
        gSounds['pot-hit']:play()
        return
    end

    self.distance = self.distance + self.speed*dt

    if self.distance > self.maxdistance then
        self.broken = true
    end
end

function Projectile:render()
    if self.broken == false then
        self.obj:render(0, 0)
    end
end

function Projectile:collides(target)
    return not (self.obj.x + self.obj.width < target.x or self.obj.x > target.x + target.width or
                self.obj.y + self.obj.height < target.y or self.obj.y > target.y + target.height)
end