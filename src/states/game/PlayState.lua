PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 16,
        height = 22,

        maxHealth = 12,
        health = 12,
        hasBombsUnlocked = false,
        bombs = 0,
        keys = 0,
        hasBossKey = false,
        bossDefeated = false,
        offsetY = 5
    }

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        ['idle'] = function() return PlayerIdleState(self.player, self.dungeon) end,
        ['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        ['lift-pot'] = function() return PlayerPotLiftState(self.player, self.dungeon) end,
        ['idle-pot'] = function() return PlayerPotIdleState(self.player, self.dungeon) end,
        ['walk-pot'] = function() return PlayerPotWalkState(self.player, self.dungeon) end,
        ['use-bomb'] = function() return PlayerUseBombState(self.player, self.dungeon) end
    }

    self.dungeon = Dungeon(self.player)

    self.backgroundOpacity = 0
    self.firstTime = true
    self.wasInBossRoom = false

    self.player:changeState('idle')

    gSounds['ingame-music']:setLooping(true)
    gSounds['ingame-music']:play()
end

function PlayState:enter(params)
    if params ~= nil then
        self.dungeon.roomid = params.roomid
        self.player = params.player
        self.dungeon = params.dungeon
    end
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('m') then
        gStateMachine:change('map', {
            roomid = self.dungeon.roomid,
            player = self.player,
            dungeon = self.dungeon
        })
    end

    if self.player.health <= 0 then
        gStateMachine:change('game-over')
    end

    if self.player.bossDefeated == true then
        gStateMachine:change('victory')
    end

    self.player:update(dt)
    self.dungeon:update(dt)

    if self.dungeon.hasOpenedDoor == true then
        if self.dungeon.roomid == 9 then
            gSounds['ingame-music']:play()
            gSounds['boss-music']:setLooping(true)
            gSounds['boss-music']:play()
            self.wasInBossRoom = true
        end

        if self.wasInBossRoom == true then
            gSounds['boss-music']:play()
            gSounds['ingame-music']:setLooping(true)
            gSounds['ingame-music']:play()
            self.wasInBossRoom = false
        end

        if self.firstTime == true then
            self.backgroundOpacity = 255
            self.firstTime = false
        end

        Timer.tween(0.5, {
            [self] = {
                backgroundOpacity = 0
            }
        })
        Timer.after(0.5, 
        function() 
            self.dungeon.hasOpenedDoor = false 
            self.firstTime = true
        end)
    end
end

function PlayState:render()

    love.graphics.push()
    self.dungeon:render()
    self.player:render()
    love.graphics.pop()

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
    
    if self.player.hasBombsUnlocked then
        love.graphics.setFont(gFonts['small'])
        love.graphics.draw(gTextures['bomb'], VIRTUAL_WIDTH - 20, 2, 0, 0.075, 0.075)
        love.graphics.printf(self.player.bombs .. 'x', VIRTUAL_WIDTH-130, 8, 100, 'center', 0, 2, 2)
    end

    love.graphics.setColor(255, 255, 255, self.backgroundOpacity)
    love.graphics.draw(gTextures['door-background'], 0, 0, 0, VIRTUAL_WIDTH / gTextures['door-background']:getWidth(), VIRTUAL_HEIGHT / gTextures['door-background']:getHeight())
end