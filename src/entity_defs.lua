ENTITY_DEFS = {
    ['player'] = {
        type = 'player',
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {1},
                interval = 0.155,
                texture = 'main-character'
            },
            ['walk-right'] = {
                frames = {1},
                interval = 0.15,
                texture = 'main-character'
            },
            ['walk-down'] = {
                frames = {1},
                interval = 0.15,
                texture = 'main-character'
            },
            ['walk-up'] = {
                frames = {1},
                interval = 0.15,
                texture = 'main-character'
            },
            ['idle-left'] = {
                frames = {1},
                texture = 'main-character'
            },
            ['idle-right'] = {
                frames = {1},
                texture = 'main-character'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'main-character'
            },
            ['idle-up'] = {
                frames = {1},
                texture = 'main-character'
            }
            
        }
    },
    ['skeleton'] = {
        texture = 'slime',
        animations = {
            ['walk-left'] = {
                frames = {1},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {1},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {1},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {1},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {1}
            },
            ['idle-right'] = {
                frames = {1}
            },
            ['idle-down'] = {
                frames = {1}
            },
            ['idle-up'] = {
                frames = {1}
            }
        }
    }
}