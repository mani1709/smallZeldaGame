Entity = Class{}

function Entity:init(def)
    self.animations = self:createAnimations(def.animations)
    self.walkSpeed = def.walkSpeed
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.health = def.health
    self.roomid = def.roomid
    self.dmg = def.damage
    self.dropsHeart = def.dropsHeart

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.direction = 'down'

    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0

    self.dead = false
end

function Entity:createAnimations(animations)
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

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
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

function Entity:render()
    self.stateMachine:render()
end