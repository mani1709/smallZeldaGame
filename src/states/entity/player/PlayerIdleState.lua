--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    EntityIdleState.update(self, dt)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('b') then
        if self.entity.bombs > 0 then
            self.entity:changeState('use-bomb')
        end
    end

    if love.keyboard.wasPressed('return') then
        for k, obj in pairs(self.dungeon.objects) do
            if obj.type == 'pot' and self.entity:checkIfClose(obj) == true then
                local o = obj
                table.remove(self.dungeon.objects, k)
                self.entity:changeState('lift-pot', {
                    pot = o
                })
            end
        end
    end
end