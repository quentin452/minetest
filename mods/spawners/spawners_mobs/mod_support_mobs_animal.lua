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

spawners_mobs.register_spawner('mobs_animal:sheep_white', {
    dummy_size = { x = 0.52, y = 0.52 },
    dummy_offset = 0.2,
    dummy_mesh = 'mobs_sheep.b3d',
    dummy_texture = { 'mobs_sheep_wool.png^mobs_sheep_base.png' },
    night_only = false,
    sound_custom = 'mobs_sheep'
})

spawners_mobs.register_spawner('mobs_animal:cow', {
    dummy_size = { x = 0.25, y = 0.25 },
    dummy_offset = -0.3,
    dummy_mesh = 'mobs_cow.b3d',
    dummy_texture = { 'mobs_cow.png' },
    night_only = false,
    sound_custom = ''
})

spawners_mobs.register_spawner('mobs_animal:chicken', {
    dummy_size = { x = 0.9, y = 0.9 },
    dummy_offset = 0.2,
    dummy_mesh = 'mobs_chicken.b3d',
    dummy_texture = { 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png', 'mobs_chicken.png' },
    night_only = false,
    sound_custom = ''
})

spawners_mobs.register_spawner('mobs_animal:pumba', {
    dummy_size = { x = 0.62, y = 0.62 },
    dummy_offset = -0.3,
    dummy_mesh = 'mobs_pumba.b3d',
    dummy_texture = { 'mobs_pumba.png' },
    night_only = false,
    sound_custom = 'mobs_pig'
})


spawners_mobs.register_spawner('mobs_animal:bee', {
    dummy_size = { x = 1.5, y = 1.5 },
    dummy_offset = -0.5,
    dummy_mesh = 'mobs_bee.b3d',
    dummy_texture = { 'mobs_bee.png' },
    night_only = false,
    sound_custom = 'mobs_bee'
})

spawners_mobs.register_spawner('mobs_animal:bunny', {
    dummy_size = { x = 1, y = 1 },
    dummy_offset = 0.2,
    dummy_mesh = 'mobs_bunny.b3d',
    dummy_texture = { 'mobs_bunny_white.png' },
    night_only = false,
})

spawners_mobs.register_spawner('mobs_animal:kitten', {
    dummy_size = { x = 0.25, y = 0.25 },
    dummy_offset = 0,
    dummy_mesh = 'mobs_kitten.b3d',
    dummy_texture = { 'mobs_kitten_striped.png' },
    night_only = false,
    sound_custom = 'mobs_kitten'
})

spawners_mobs.register_spawner('mobs_animal:panda', {
    dummy_size = { x = 0.5, y = 0.5 },
    dummy_offset = 0,
    dummy_mesh = 'mobs_panda.b3d',
    dummy_texture = { 'mobs_panda.png' },
    night_only = false,
    sound_custom = 'mobs_panda'
})

spawners_mobs.register_spawner('mobs_animal:penguin', {
    dummy_size = { x = 0.2, y = 0.2 },
    dummy_offset = -0.15,
    dummy_mesh = 'mobs_penguin.b3d',
    dummy_texture = { 'mobs_penguin.png' },
    night_only = false,
})

spawners_mobs.register_spawner('mobs_animal:rat', {
    dummy_size = { x = 0.9, y = 0.9 },
    dummy_offset = 0.8,
    dummy_mesh = 'mobs_rat.b3d',
    dummy_texture = { 'mobs_rat.png' },
    night_only = false,
    sound_custom = 'mobs_rat'
})
