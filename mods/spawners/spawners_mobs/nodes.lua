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

--
-- Decorative Carved Sand Stones
--

local img = { 'eye', 'men', 'sun', 'bird' }

for i = 1, #img do
    minetest.register_node('spawners_mobs:deco_stone_' .. img[i], {
        description = 'Sandstone with ' .. img[i],
        tiles = { 'spawners_mobs_sandstone_carved_' .. img[i] .. '.png' },
        is_ground_content = false,
        groups = { cracky = 2, stone = 1 },
        sounds = default.node_sound_stone_defaults(),
    })
end
