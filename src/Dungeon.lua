Dungeon = Class{}

function Dungeon:init(player)
    self.player = player
    self.hasOpenedDoor = false

    self.height = MAP_HEIGHT
    self.width = MAP_WIDTH
    self.roomid = START_ROOM_ID
    
    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.tiles = ROOM_1
    
    self.doors = {}
    self:initializeDoors()

    self.entities = {}
    self:initializeEntities()

    self.objects = {}
    self:initializeObjects()

    self.projectiles = {}
    self:initializeProjectiles()
end

function Dungeon:update(dt)
    self:updateCurrentRoom(dt)
    self:updateDoors(dt)
    self:updateEntities(dt)
    self:updateObjects(dt)
    self:updateProjectiles(dt)
end

function Dungeon:render()
    self:renderMap()
    self:renderDoors()
    self:renderEntities()
    self:renderObjects()
    self:renderProjectiles()
end

function Dungeon:initializeDoors()
    --initialisation with direction, open, startroomid, endroomid
    table.insert(self.doors, Door('top', false, 1, 4))
    table.insert(self.doors, Door('left', false, 1, 2))
    table.insert(self.doors, Door('right', true, 1, 3)) 
    table.insert(self.doors, Door('right', true, 2, 1))
    table.insert(self.doors, Door('left', true, 3, 1))
    table.insert(self.doors, Door('bottom', true, 4, 1))
    table.insert(self.doors, Door('top', false, 4, 5))
    table.insert(self.doors, Door('bottom', true, 5, 4))
    table.insert(self.doors, Door('left', false, 5, 6))
    table.insert(self.doors, Door('top', true, 5, 7))
    table.insert(self.doors, Door('right', true, 6, 5))
    table.insert(self.doors, Door('bottom', true, 7, 5))
    table.insert(self.doors, Door('left', false, 7, 8))
    table.insert(self.doors, Door('right', false, 7, 9))
    table.insert(self.doors, Door('right', true, 8, 7))
    table.insert(self.doors, Door('left', true, 9, 7))
end

function Dungeon:initializeEntities()
    --initialisation with animations, walkspeed, x, y, width, height, health, roomid, damage and dropsHeart
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['skeleton'].animations, walkSpeed = 10, x = 50, y = 50, width = 16, height = 16, health = 1, roomid = 1, damage = 2, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['skeleton'].animations, walkSpeed = 10, x = 320, y = 50, width = 16, height = 16, health = 1, roomid = 1, damage = 1, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['bat'].animations, walkSpeed = 20, x = 250, y = 50, width = 16, height = 16, health = 1, roomid = 3, damage = 1, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['bat'].animations, walkSpeed = 20, x = 250, y = 100, width = 16, height = 16, health = 1, roomid = 3, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['bat'].animations, walkSpeed = 20, x = 250, y = 150, width = 16, height = 16, health = 1, roomid = 3, damage = 2, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['spider'].animations, walkSpeed = 15, x = 50, y = 50, width = 16, height = 16, health = 1, roomid = 2, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['spider'].animations, walkSpeed = 15, x = 250, y = 50, width = 16, height = 16, health = 1, roomid = 2, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['spider'].animations, walkSpeed = 15, x = 50, y = 150, width = 16, height = 16, health = 1, roomid = 2, damage = 2, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['spider'].animations, walkSpeed = 15, x = 250, y = 150, width = 16, height = 16, health = 1, roomid = 2, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['slime'].animations, walkSpeed = 15, x = 50, y = 50, width = 16, height = 16, health = 1, roomid = 4, damage = 1, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['slime'].animations, walkSpeed = 15, x = 50, y = 150, width = 16, height = 16, health = 1, roomid = 4, damage = 1, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['slime'].animations, walkSpeed = 15, x = 250, y = 50, width = 16, height = 16, health = 1, roomid = 4, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['slime'].animations, walkSpeed = 15, x = 250, y = 150, width = 16, height = 16, health = 1, roomid = 4, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['spider'].animations, walkSpeed = 15, x = 50, y = 50, width = 16, height = 16, health = 1, roomid = 5, damage = 2, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['slime'].animations, walkSpeed = 15, x = 100, y = 50, width = 16, height = 16, health = 1, roomid = 5, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['slime'].animations, walkSpeed = 15, x = 150, y = 50, width = 16, height = 16, health = 1, roomid = 5, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['bat'].animations, walkSpeed = 15, x = 200, y = 50, width = 16, height = 16, health = 1, roomid = 5, damage = 2, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['skeleton'].animations, walkSpeed = 15, x = 250, y = 50, width = 16, height = 16, health = 1, roomid = 5, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['bat'].animations, walkSpeed = 15, x = 50, y = 75, width = 16, height = 16, health = 1, roomid = 6, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['skeleton'].animations, walkSpeed = 15, x = 50, y = 150, width = 16, height = 16, health = 1, roomid = 6, damage = 2, dropsHeart = true})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['spider'].animations, walkSpeed = 15, x = 150, y = 50, width = 16, height = 16, health = 1, roomid = 7, damage = 2, dropsHeart = false})
    table.insert(self.entities, Entity{animations = ENTITY_DEFS['ghost'].animations, walkSpeed = 30, x = 150, y = 150, width = 16, height = 16, health = 1100, roomid = 9, damage = 4, dropsHeart = false})

    for k in pairs(self.entities) do
        self.entities[k].stateMachine = StateMachine {
            ['walk'] = function() return EntityWalkState(self.entities[k]) end,
            ['idle'] = function() return EntityIdleState(self.entities[k]) end
        }
        self.entities[k]:changeState('walk')
    end
end

function Dungeon:initializeObjects()
    -- initialisation with object, x, y, roomid
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bosskey'], 50, 75, 2))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['key'], 320, 75, 3))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['key'], 50, 50, 6))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['bomb-powerup'], 50, 75, 8))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['pot'], 150, 50, 1))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['pot'], 300, 50, 5))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['pot'], 50, 50, 9))
    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['pot'], 320, 75, 9))
end

function Dungeon:initializeProjectiles()
    --unused
end

function Dungeon:updateCurrentRoom(dt)
    if self.roomid == 1 then
        self.tiles = ROOM_1
    elseif self.roomid == 2 then
        self.tiles = ROOM_2
    elseif self.roomid == 3 then
        self.tiles = ROOM_3
    elseif self.roomid == 4 then
        self.tiles = ROOM_4
    elseif self.roomid == 5 then
        self.tiles = ROOM_5
    elseif self.roomid == 6 then
        self.tiles = ROOM_6
    elseif self.roomid == 7 then
        self.tiles = ROOM_7
    elseif self.roomid == 8 then
        self.tiles = ROOM_8
    elseif self.roomid == 9 then
        self.tiles = ROOM_9
    end
end

function Dungeon:updateDoors(dt)
    for k, door in pairs(self.doors) do
        door:update(dt, self.roomid)

        --renders open doors and brings person to next room
        if self.roomid == door.roomNr and self.player:collides(door) and door.isOpen then
            if door.direction == 'left' then
                self.player.x = VIRTUAL_WIDTH - 60
            elseif door.direction == 'right' then
                self.player.x = 40
            elseif door.direction == 'top' then
                self.player.y = VIRTUAL_HEIGHT - 60
            else
                self.player.y = 40
            end
            self.roomid = door.nextRoom
            self.hasOpenedDoor = true
        end

        --calculate entities in room for door 7 and 9
        self.entitiesInRoom = 0
        
        for i, entity in pairs(self.entities) do
            if self.roomid == entity.roomid and entity.dead == false then
                self.entitiesInRoom = self.entitiesInRoom + 1
            end
        end

        --open door 1 if key is used on door
        if k == 1 and self.player.keys > 0 and self.player:collides(door) and door.isOpen == false and love.keyboard.isDown('return') then
            door.isOpen = true
            self.player.keys = self.player.keys - 1
        --open door 2 if bomb is used on it
        elseif k == 2 and self.player:collides(door) and door.isOpen == false and self.player.bombs > 0 and love.keyboard.isDown('b') and self.player.direction == 'left' then
            Timer.after(1, 
            function() 
                self.door2NotBombed = false 
                door.isOpen = true
            end)
        --open door 7 if player killed all enemies
        elseif k == 7 and self.player:collides(door) and door.isOpen == false and self.entitiesInRoom == 0 then
            door.isOpen = true
        --open door 9 if player killed all enemies
        elseif k == 9 and self.player:collides(door) and door.isOpen == false and self.entitiesInRoom == 0 then
            door.isOpen = true
        --open door 13 if key is used on it
        elseif k == 13 and self.player.keys > 0 and self.player:collides(door) and door.isOpen == false and love.keyboard.isDown('return') then
            door.isOpen = true
            self.player.keys = self.player.keys - 1
        --open door 14 if bosskey is aquired
        elseif k == 14 and self.player.hasBossKey and self.player:collides(door) and door.isOpen == false then
            door.isOpen = true
        end
    end
end

function Dungeon:updateEntities(dt)
    for  k, entity in pairs(self.entities) do
        if entity.roomid == self.roomid then
            -- remove entity from the table if health is <= 0
            if entity.health <= 0 and not entity.dead then
                entity.dead = true
                if entity.dropsHeart then 
                    table.insert(self.objects, GameObject(GAME_OBJECT_DEFS['heart'], entity.x, entity.y, entity.roomid))               
                end
                if self.roomid == 9 then
                    self.player.bossDefeated = true
                end
            elseif not entity.dead then
                entity:processAI({room = roomid}, dt)
                entity:update(dt, self.roomid)
            end
            -- collision between the player and entities in the room
            if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
                gSounds['hit-player']:play()
                self.damage = entity.dmg
                self.player:damage(self.damage)
                self.player:goInvulnerable(1.5)

                if self.player.health <= 0 then
                    gStateMachine:change('game-over')
                end
            end
        end
    end
end

function Dungeon:updateObjects()
    for k, object in pairs(self.objects) do
        if object.roomid == self.roomid then
            object:update(dt, self.roomid)
            --enemy collision with objects
            for i, entity in pairs(self.entities) do
                if entity:collides(object) then
                    if object.solid == true then 
                        object:onCollide(entity)
                        if entity.direction == 'left' and not (entity.y + entity.height / 2 >= (object.y + object.height)) and not (entity.y + entity.height <= object.y) then
                            entity.x = object.x + object.width
                        elseif entity.direction == 'right' and not (entity.y + entity.height / 2 >= (object.y + object.height)) and not (entity.y + entity.height <= object.y) then 
                            entity.x = object.x - entity.width
                        elseif entity.direction == 'down' and not (entity.x >= (object.x + object.width)) and not (entity.x + entity.width <= object.x) then
                            entity.y = object.y - entity.height
                        elseif entity.direction == 'up' and not (entity.x >= (object.x + object.width)) and not (entity.x + entity.width <= object.x) then
                            entity.y = object.y + object.height - entity.height/2
                        end
                    end
                end
            end
            --player collision with objects
            if self.player:collides(object) then
                object:onCollide(self.player)
                if object.solid then 
                    if self.player.direction == 'left' and not (self.player.y + self.player.height / 2 >= (object.y + object.height)) and not (self.player.y + self.player.height <= object.y) then
                        self.player.x = object.x + object.width
                    elseif self.player.direction == 'right' and not (self.player.y + self.player.height / 2 >= (object.y + object.height)) and not (self.player.y + self.player.height <= object.y) then 
                        self.player.x = object.x - self.player.width
                    elseif self.player.direction == 'down' and not (self.player.x >= (object.x + object.width)) and not (self.player.x + self.player.width <= object.x) then
                        self.player.y = object.y - self.player.height
                    elseif self.player.direction == 'up' and not (self.player.x >= (object.x + object.width)) and not (self.player.x + self.player.width <= object.x) then
                        self.player.y = object.y + object.height - self.player.height/2
                    end
                end

                if object.type == 'heart' then
                    gSounds['regenerate']:play()
                    self.player.health = self.player.health + 4
                    if self.player.health > 12 then
                        self.player.health = 12 
                    end
                    table.remove(self.objects, k)
                end
                if object.type == 'key' then
                    self.player.keys = self.player.keys + 1
                    table.remove(self.objects, k)
                    gSounds['pickup']:play()
                end
                if object.type == 'bomb-powerup' then
                    self.player.hasBombsUnlocked = true
                    self.player.bombs = 5
                    table.remove(self.objects, k)
                    gSounds['pickup']:play()
                end
                if object.type == 'bosskey' then
                    self.player.hasBossKey = true
                    table.remove(self.objects, k)
                    gSounds['pickup']:play()
                end
            end
        end
    end
end

function Dungeon:updateProjectiles(dt)
    for k, projectile in pairs(self.projectiles) do
        projectile:update(dt, self.roomid)

        -- check collision with entities
        for e, entity in pairs(self.entities) do
            if projectile.dead then
                break
            end

            if entity.roomid == self.roomid and not entity.dead and projectile:collides(entity) then
                entity:damage(500)
                gSounds['hit-enemy']:play()
                projectile.dead = true
            end
        end

        if projectile.dead then
            table.remove(self.projectiles, k)
        end
    end
end

function Dungeon:renderMap()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile], (x - 1) * TILE_SIZE + self.renderOffsetX, (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end
end

function Dungeon:renderDoors()
    for k, door in pairs(self.doors) do
        if k ~= 2 then
            door:render()
        end
    
        if k == 2 and self.door2NotBombed == false then
            door:render()
        end
    end
end

function Dungeon:renderEntities()
    for k, entity in pairs(self.entities) do
        if entity.roomid == self.roomid and entity.dead == false then
            entity:render()
        end
    end
end

function Dungeon:renderObjects()
    for k, object in pairs(self.objects) do
        if object.roomid == self.roomid or object.type == 'bomb' then
            object:render()
        end
    end
end

function Dungeon:renderProjectiles()
    for k, projectile in pairs(self.projectiles) do
        projectile:render()
    end
end