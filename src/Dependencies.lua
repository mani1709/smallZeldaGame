Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Dungeon'
require 'src/Door'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/game_objects'
require 'src/Hitbox'
require 'src/Player'
require 'src/Projectile'
require 'src/StateMachine'
require 'src/Util'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerSwingSwordState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerPotIdleState'
require 'src/states/entity/player/PlayerPotLiftState'
require 'src/states/entity/player/PlayerPotWalkState'
require 'src/states/entity/player/PlayerUseBombState'

require 'src/states/game/StartState'
require 'src/states/game/IntroState'
require 'src/states/game/PlayState'
require 'src/states/game/VictoryState'
require 'src/states/game/MapState'
require 'src/states/game/GameOverState'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character-swing-sword'] = love.graphics.newImage('graphics/character_swing_sword.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['switches'] = love.graphics.newImage('graphics/switches.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['character-pot-lift'] = love.graphics.newImage('graphics/character_pot_lift.png'),
    ['character-pot-walk'] = love.graphics.newImage('graphics/character_pot_walk.png'),
    ['map'] = love.graphics.newImage('graphics/map.png'),
    ['bomb'] = love.graphics.newImage('graphics/bomb.png'),
    ['key'] = love.graphics.newImage('graphics/key.png'),
    ['bosskey'] = love.graphics.newImage('graphics/bosskey.png'),
    ['bosskey-small'] = love.graphics.newImage('graphics/bosskey-small.png'),
    ['bomb-small'] = love.graphics.newImage('graphics/bomb-small.png'),
    ['key-small'] = love.graphics.newImage('graphics/key-small.png'),
    ['door-background'] = love.graphics.newImage('graphics/door_background.png'),
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['character-swing-sword'] = GenerateQuads(gTextures['character-swing-sword'], 32, 32),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['hearts'] = GenerateQuads(gTextures['hearts'], 16, 16),
    ['switches'] = GenerateQuads(gTextures['switches'], 16, 18),
    ['character-pot-lift'] = GenerateQuads(gTextures['character-pot-lift'], 16, 32),
    ['character-pot-walk'] = GenerateQuads(gTextures['character-pot-walk'], 16, 32),
    ['bomb'] = GenerateQuads(gTextures['bomb-small'], 16, 16),
    ['key'] = GenerateQuads(gTextures['key-small'], 16, 16),
    ['bosskey'] = GenerateQuads(gTextures['bosskey-small'], 16, 32)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['zelda'] = love.graphics.newFont('fonts/zelda.otf', 64),
    ['zelda-small'] = love.graphics.newFont('fonts/zelda.otf', 32)
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3'),
    ['ingame-music'] = love.audio.newSource('sounds/ingame_music.wav'),
    ['boss-music'] = love.audio.newSource('sounds/boss_music.mp3'),
    ['sword'] = love.audio.newSource('sounds/sword.wav'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav'),
    ['door'] = love.audio.newSource('sounds/door.wav'),
    ['regenerate'] = love.audio.newSource('sounds/regenerate.wav'),
    ['pot-hit'] = love.audio.newSource('sounds/pot_hit.wav'),
    ['explosion'] = love.audio.newSource('sounds/explosion.wav'),
    ['pickup'] = love.audio.newSource('sounds/pickupKey.wav'),
    ['victory-music'] = love.audio.newSource('sounds/victory_music.mp3')
}