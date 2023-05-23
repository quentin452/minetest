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

-- Place spawners in dungeons
local function place_spawner(param)
    local skip = math.random(0, 1)

    -- skip spawner
    if skip == 1 then
        return
    end

    local tab = param[1]
    local gen_obj = param[2]

    local pos = tab[math.random(1, (#tab or 4))]
    pos.y = pos.y - 1

    local n = minetest.get_node_or_nil(pos)
    local n2 = minetest.get_node_or_nil({ x = pos.x, y = pos.y + 1, z = pos.z })

    if n and n.name ~= 'air' then
        pos.y = pos.y + 1

        -- pos the same as chest, putting spawner above the chest
        if n2 and n2.name == 'default:chest' then
            -- print('pos the same as chest, putting spawner above the chest')
            pos.y = pos.y + 1
        end

        local spawner_name

        if #spawners_env.registered_spawners_names > 0 then
            spawner_name = spawners_env.registered_spawners_names[math.random(1, #spawners_env.registered_spawners_names)]
        end

        if spawner_name then
            if gen_obj == 'dungeon' then
                minetest.set_node(pos, { name = spawner_name })
                minetest.log('action', '[Spawners] dungeon spawner ' .. spawner_name .. ' placed at: ' .. minetest.pos_to_string(pos))
            else
                minetest.set_node(pos, { name = spawner_name })
                minetest.log('action', '[Spawners] temple spawner ' .. spawner_name .. ' placed at: ' .. minetest.pos_to_string(pos))
            end
        end
    end
end

minetest.set_gen_notify('dungeon')
minetest.set_gen_notify('temple')

minetest.register_on_generated(function(minp, maxp, blockseed)
    local notify = minetest.get_mapgen_object('gennotify')

    if notify and notify.dungeon then
        minetest.after(3, place_spawner, { table.copy(notify.dungeon), 'dungeon' })
    end

    if notify and notify.temple then
        minetest.after(3, place_spawner, { table.copy(notify.temple), 'temple' })
    end
end)
