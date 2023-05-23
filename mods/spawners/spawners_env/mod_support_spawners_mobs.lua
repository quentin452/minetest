--[[
    Adds environmental spawners to the map. When enabled, the spawners will be added to newly generated Dungeons and Temples. They are dropping a real mob spawner by change (small chance).
    Copyright (C) 2016 - 2023 SaKeL <juraj.vajda@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it pos the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

spawners_env.register_spawner('spawners_mobs:mummy', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = 0,
    dummy_mesh = 'spawners_mobs_mummy.b3d',
    dummy_texture = { 'spawners_mobs_mummy.png' },
    night_only = true,
    sound_custom = 'spawners_mobs_mummy_neutral'
})

spawners_env.register_spawner('spawners_mobs:bunny_evil', {
    dummy_size = { x = 1, y = 1 },
    dummy_offset = 0.2,
    dummy_mesh = 'spawners_mobs_evil_bunny.b3d',
    dummy_texture = { 'spawners_mobs_evil_bunny.png' },
    night_only = true,
    sound_custom = 'spawners_mobs_bunny'
})

spawners_env.register_spawner('spawners_mobs:uruk_hai', {
    dummy_size = { x = 0.5, y = 0.5 },
    dummy_offset = 0,
    dummy_mesh = 'spawners_mobs_character.b3d',
    dummy_texture = { 'spawners_mobs_uruk_hai.png', 'spawners_mobs_trans.png', 'spawners_mobs_galvornsword.png', 'spawners_mobs_trans.png' },
    night_only = true,
    sound_custom = 'spawners_mobs_uruk_hai_neutral',
})

-- spawners_env.register_spawner('spawners_mobs:balrog', {
--     dummy_size = { x = 0.2, y = 0.2 },
--     dummy_offset = 0,
--     dummy_mesh = 'spawners_mobs_balrog.b3d',
--     dummy_texture = { 'spawners_mobs_balrog.png' },
--     night_only = 'disable',
--     sound_custom = 'spawners_mobs_balrog_neutral',
--     boss = true
-- })
