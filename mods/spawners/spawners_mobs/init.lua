--[[
    Let the player craft Mob Spawners. Mobs are spawning randomly in a short intervals, giving the option of creating mob farms and grinders.
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
local path = minetest.get_modpath('spawners_mobs')

-- API
dofile(path .. '/api.lua')

-- custom mobs
if minetest.get_modpath('mobs') then
    dofile(path .. '/nodes.lua')
    dofile(path .. '/mob_mummy.lua')
    dofile(path .. '/mob_bunny_evil.lua')
    dofile(path .. '/mob_uruk_hai.lua')
    dofile(path .. '/mob_balrog.lua')
end

-- Register spawners
if minetest.get_modpath('animalia') then
    dofile(path .. '/mod_support_animalia.lua')
end

if minetest.get_modpath('mobs') then
    dofile(path .. '/mod_support_spawners_mobs.lua')
end

if minetest.get_modpath('mobs_animal') then
    dofile(path .. '/mod_support_mobs_animal.lua')
end

if minetest.get_modpath('mobs_monster') then
    dofile(path .. '/mod_support_mobs_monster.lua')
end

local mod_end_time = (minetest.get_us_time() - mod_start_time) / 1000000

print('[Mod] Spawners Mobs Loaded. [' .. mod_end_time .. 's]')
