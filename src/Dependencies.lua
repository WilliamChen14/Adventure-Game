Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/game_objects'
require 'src/Hitbox'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'

require 'src/world/Doorway'
require 'src/world/Dungeon'
require 'src/world/Room'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'

require 'src/states/game/GameOverState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/InstructionsState'

gTextures = {
    ['tiles'] = love.graphics.newImage('sprites/Floor1Tiles.png'),
    ['background'] = love.graphics.newImage('sprites/Background.png'),
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['wall'] = love.graphics.newImage('sprites/FrontWall.png'),
    ['main-character'] = love.graphics.newImage('sprites/Wizard.png'),
    ['slime'] = love.graphics.newImage('sprites/pixil-frame-0 (10).png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['hearts'] = GenerateQuads(gTextures['hearts'], 16, 16),
    ['wall'] = GenerateQuads(gTextures['wall'], 16, 16),
    ['main-character'] = GenerateQuads(gTextures['main-character'], 16, 32),
    ['slime'] = GenerateQuads(gTextures['slime'], 16, 16)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32)
}

gSounds = {
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', "static"),
    ['door'] = love.audio.newSource('sounds/door.wav', "static"),
    ['fmusic'] = love.audio.newSource('sounds/Electronic_Fantasy.ogg', "static")
}