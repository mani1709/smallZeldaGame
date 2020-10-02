PlayerPotWalkState = Class{__includes = EntityWalkState}

function PlayerPotWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotWalkState:enter(params)
    self.pot = params.pot
end

function PlayerPotWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('pot-walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('pot-walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('pot-walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('pot-walk-down')
    else
        self.entity:changeState('idle-pot', {
            pot = self.pot
        })
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        table.insert(self.dungeon.projectiles, Projectile(self.pot, self.entity.direction))
        self.entity:changeState('idle')
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
    self.pot.x = self.entity.x
    self.pot.y = self.entity.y - self.pot.height / 2
end

function PlayerPotWalkState:render()
    EntityWalkState.render(self)
    self.pot:render(0, 0)
end