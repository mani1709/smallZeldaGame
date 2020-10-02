GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        consumable = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        type = 'pot',
        texture = 'tiles',
        frame = 14,
        width = 16,
        height = 16,
        solid = true,
        consumable = false,
        holdable = true,
        defaultState = 'pot',
        states = {
            ['pot'] = {
                frame = 14
            }
        }
    },
    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 1,
        width = 16,
        height = 16,
        solid = false,
        consumable = true,
        defaultState = 'heartDropped',
        states = {
            ['heartDropped'] = {
                frame = 5
            }
        }
    }, 
    ['bomb-powerup'] = {
        type = 'bomb-powerup',
        texture = 'bomb',
        width = 16,
        height = 16,
        solid = false,
        consumable = true,
        defaultState = 'bomb',
        states = {
            ['bomb'] = {
                frame = 1
            }
        }
    },
    ['bomb'] = {
        type = 'bomb',
        texture = 'bomb',
        width = 16,
        height = 16,
        solid = false,
        consumable = false,
        defaultState = 'bomb',
        states = {
            ['bomb'] = {
                frame = 1
            }
        }
    },
    ['key'] = {
        type = 'key',
        texture = 'key',
        width = 16,
        height = 32,
        solid = false,
        consumable = true,
        defaultState = 'key',
        states = {
            ['key'] = {
                frame = 1
            }
        }
    },
    ['bosskey'] = {
        type = 'bosskey',
        texture = 'bosskey',
        width = 16,
        height = 32,
        solid = false,
        consumable = true,
        defaultState = 'bosskey',
        states = {
            ['bosskey'] = {
                frame = 1
            }
        }
    }
}