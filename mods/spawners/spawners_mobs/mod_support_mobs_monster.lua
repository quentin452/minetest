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

spawners_mobs.register_spawner('mobs_monster:spider', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = 0.1,
    dummy_mesh = 'mobs_spider.b3d',
    dummy_texture = { 'mobs_spider_orange.png' },
    night_only = true,
    sound_custom = 'mobs_spider_neutral'
})

spawners_mobs.register_spawner('mobs_monster:stone_monster', {
    dummy_size = { x = 0.5, y = 0.5 },
    dummy_offset = 0.05,
    dummy_mesh = 'mobs_stone_monster.b3d',
    dummy_texture = { 'mobs_stone_monster.png' },
    night_only = true,
    sound_custom = 'mobs_stonemonster_neutral'
})

spawners_mobs.register_spawner('mobs_monster:oerkki', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = 0.05,
    dummy_mesh = 'mobs_oerkki.b3d',
    dummy_texture = { 'mobs_oerkki.png' },
    night_only = true,
    sound_custom = ''
})

spawners_mobs.register_spawner('mobs_monster:tree_monster', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = 0.05,
    dummy_mesh = 'mobs_tree_monster.b3d',
    dummy_texture = { 'mobs_tree_monster.png' },
    night_only = true,
    sound_custom = 'mobs_treemonster_neutral'
})

spawners_mobs.register_spawner('mobs_monster:dirt_monster', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = 0.05,
    dummy_mesh = 'mobs_stone_monster.b3d',
    dummy_texture = { 'mobs_dirt_monster.png' },
    night_only = true,
    sound_custom = 'mobs_dirtmonster'
})

spawners_mobs.register_spawner('mobs_monster:dungeon_master', {
    dummy_size = { x = 0.3, y = 0.3 },
    dummy_offset = -0.1,
    dummy_mesh = 'mobs_dungeon_master.b3d',
    dummy_texture = { 'mobs_dungeon_master.png' },
    night_only = true,
    sound_custom = 'mobs_dungeonmaster'
})

spawners_mobs.register_spawner('mobs_monster:land_guard', {
    dummy_size = { x = 0.3, y = 0.3 },
    dummy_offset = -0.1,
    dummy_mesh = 'mobs_dungeon_master.b3d',
    dummy_texture = { 'mobs_land_guard.png' },
    night_only = true,
    sound_custom = 'mobs_dungeonmaster'
})

spawners_mobs.register_spawner('mobs_monster:lava_flan', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = -0.1,
    dummy_mesh = 'zmobs_lava_flan.x',
    dummy_texture = { 'zmobs_lava_flan.png' },
    night_only = true,
    sound_custom = 'mobs_lavaflan'
})

spawners_mobs.register_spawner('mobs_monster:mese_monster', {
    dummy_size = { x = 2.5, y = 2.5 },
    dummy_offset = -0.3,
    dummy_mesh = 'mobs_mese_monster.b3d',
    dummy_texture = { 'mobs_mese_monster_purple.png' },
    night_only = true,
    sound_custom = 'mobs_mesemonster'
})

spawners_mobs.register_spawner('mobs_monster:sand_monster', {
    dummy_size = { x = 0.4, y = 0.4 },
    dummy_offset = 0.05,
    dummy_mesh = 'mobs_sand_monster.b3d',
    dummy_texture = { 'mobs_sand_monster.png' },
    night_only = true,
    sound_custom = 'mobs_sandmonster'
})
