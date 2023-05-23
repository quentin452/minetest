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

local mod_start_time = minetest.get_us_time()
local path = minetest.get_modpath('spawners_env')

-- API
dofile(path .. '/api.lua')

-- Register spawners
if minetest.get_modpath('animalia') then
    dofile(path .. '/mod_support_animalia.lua')
end

if minetest.get_modpath('mobs') and minetest.get_modpath('spawners_mobs') then
    dofile(path .. '/mod_support_spawners_mobs.lua')
end

if minetest.get_modpath('mobs_animal') then
    dofile(path .. '/mod_support_mobs_animal.lua')
end

if minetest.get_modpath('mobs_monster') then
    dofile(path .. '/mod_support_mobs_monster.lua')
end

-- Generate spawners in the World
dofile(path .. '/spawners_gen.lua')

local mod_end_time = (minetest.get_us_time() - mod_start_time) / 1000000

print('[Mod] Spawners Environmental Loaded. [' .. mod_end_time .. 's]')
