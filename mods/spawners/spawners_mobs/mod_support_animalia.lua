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

spawners_mobs.register_spawner('animalia:chicken', {
    dummy_size = { x = 7, y = 7 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_chicken.b3d',
    dummy_texture = { 'animalia_chicken_1.png' },
    night_only = false,
    sound_custom = 'animalia_chicken'
})

spawners_mobs.register_spawner('animalia:cow', {
    dummy_size = { x = 3, y = 3 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_cow.b3d',
    dummy_texture = { 'animalia_cow_1.png' },
    night_only = false,
    sound_custom = 'animalia_cow'
})

spawners_mobs.register_spawner('animalia:fox', {
    dummy_size = { x = 7, y = 7 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_fox.b3d',
    dummy_texture = { 'animalia_fox_1.png' },
    night_only = false,
    sound_custom = 'animalia_fox'
})

spawners_mobs.register_spawner('animalia:horse', {
    dummy_size = { x = 2.5, y = 2.5 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_horse.b3d',
    dummy_texture = { 'animalia_horse_1.png' },
    night_only = false,
    sound_custom = 'animalia_horse'
})

spawners_mobs.register_spawner('animalia:frog', {
    dummy_size = { x = 7, y = 7 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_frog.b3d',
    dummy_texture = { 'animalia_tree_frog.png' },
    night_only = false,
    sound_custom = 'animalia_frog'
})

spawners_mobs.register_spawner('animalia:pig', {
    dummy_size = { x = 6, y = 6 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_pig.b3d',
    dummy_texture = { 'animalia_pig_1.png' },
    night_only = false,
    sound_custom = 'animalia_pig'
})

spawners_mobs.register_spawner('animalia:sheep', {
    dummy_size = { x = 4.5, y = 4.5 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_sheep.b3d',
    dummy_texture = { 'animalia_sheep.png^animalia_sheep_wool.png' },
    night_only = false,
    sound_custom = 'animalia_sheep'
})

spawners_mobs.register_spawner('animalia:bat', {
    dummy_size = { x = 8, y = 8 },
    dummy_offset = -0.1,
    dummy_mesh = 'animalia_bat.b3d',
    dummy_texture = { 'animalia_bat_1.png' },
    night_only = true,
    sound_custom = 'animalia_bat'
})

spawners_mobs.register_spawner('animalia:cat', {
    dummy_size = { x = 5.5, y = 5.5 },
    dummy_offset = -0.2,
    dummy_mesh = 'animalia_cat.b3d',
    dummy_texture = { 'animalia_cat_1.png' },
    night_only = false,
    sound_custom = 'animalia_cat'
})

spawners_mobs.register_spawner('animalia:owl', {
    dummy_size = { x = 5, y = 5 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_owl.b3d',
    dummy_texture = { 'animalia_owl.png' },
    night_only = true,
})

spawners_mobs.register_spawner('animalia:rat', {
    dummy_size = { x = 8, y = 8 },
    dummy_offset = -0.1,
    dummy_mesh = 'animalia_rat.b3d',
    dummy_texture = { 'animalia_rat_1.png' },
    night_only = false,
})

spawners_mobs.register_spawner('animalia:reindeer', {
    dummy_size = { x = 3, y = 3 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_reindeer.b3d',
    dummy_texture = { 'animalia_reindeer.png' },
    night_only = false,
})

spawners_mobs.register_spawner('animalia:song_bird', {
    dummy_size = { x = 8, y = 8 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_bird.b3d',
    dummy_texture = { 'animalia_cardinal.png' },
    night_only = false,
    sound_custom = 'animalia_cardinal'
})

spawners_mobs.register_spawner('animalia:turkey', {
    dummy_size = { x = 4.5, y = 4.5 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_turkey.b3d',
    dummy_texture = { 'animalia_turkey_tom.png' },
    night_only = false,
    sound_custom = 'animalia_turkey'
})

spawners_mobs.register_spawner('animalia:wolf', {
    dummy_size = { x = 4.5, y = 4.5 },
    dummy_offset = -0.3,
    dummy_mesh = 'animalia_wolf.b3d',
    dummy_texture = { 'animalia_wolf_1.png' },
    night_only = true,
})
