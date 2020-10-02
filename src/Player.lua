Player = Class{}

function Player:init(params)
    self.x = params.x
    self.y = params.y
    self.width = params.width
    self.height = params.height
    self.maxHealth = params.maxHealth
    self.health = params.health
    self.hasBombsUnlocked = params.hasBombsUnlocked
    self.bombs = params.bombs
    self.keys = params.keys
    self.hasBossKey = params.hasBossKey
    self.bossDefeated = params.bossDefeated
    self.offsetX = 0
    self.offsetY = params.offsetY
    self.direction = 'down'
    self.animations = self:createAnimations(ENTITY_DEFS['player'].animations)
    self.walkSpeed = params.walkSpeed
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0
    self.dead = false
end

function Player:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Player:checkIfClose(obj)

    local playerY = self.y + self.height / 2
    local playerHeight = self.height - self.height / 2
    
    local playerXCenter = self.x + self.width / 2
    local playerYCenter = playerY + playerHeight / 2
    local objXCenter = obj.x + obj.width / 2
    local objYCenter = obj.y + obj.height / 2

    local playerCol = math.floor(playerXCenter / TILE_SIZE)
    local playerRow = math.floor(playerYCenter / TILE_SIZE)
    local objCol = math.floor(objXCenter / TILE_SIZE)
    local objRow = math.floor(objYCenter / TILE_SIZE)

    if (self.direction == 'right') and (objRow == playerRow) and (objCol == (playerCol + 1)) then
        return true
    end

    if (self.direction == 'left') and (objRow == playerRow) and (objCol == (playerCol - 1)) then
        return true
    end

    if (self.direction == 'up') and (objCol == playerCol) and (objRow == (playerRow - 1)) then
        return true
    end

    if (self.direction == 'down') and (objCol == playerCol) and (objRow == (playerRow + 1)) then
        return true
    end

    return false
end

function Player:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Player:damage(dmg)
    self.health = self.health - dmg
end

function Player:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

function Player:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Player:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Player:useBomb()
    self.bombs = self.bombs - 1
    
end

function Player:update(dt)
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Player:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Player:render(adjacentOffsetX, adjacentOffsetY)
    -- draw sprite slightly transparent if invulnerable every 0.04 seconds
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(255, 255, 255, 64)
    end

    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    self.stateMachine:render()
    love.graphics.setColor(255, 255, 255, 255)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
end

function Player:useBomb()
    self.bombs = self.bombs - 1
end