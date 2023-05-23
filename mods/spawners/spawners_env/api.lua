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

-- main tables
spawners_env = {
    registered_spawners_names = {}
}

function spawners_env.register_spawner(name, def)
    local mod_prefix = name:split(':')[1]
    local mob_name = name:split(':')[2]

    -- Entity inside the spawner
    local ent_name = 'spawners_env:dummy_' .. mod_prefix .. '_' .. mob_name
    local ent_def = {
        hp_max = 1,
        physical = true,
        collisionbox = { 0, 0, 0, 0, 0, 0 },
        visual = def.dummy_visual or 'mesh',
        visual_size = def.dummy_size,
        mesh = def.dummy_mesh,
        textures = def.dummy_texture,
        makes_footstep_sound = false,
        timer = 0,
        automatic_rotate = math.pi * -3,
        on_activate = function(self)
            self.object:set_velocity({ x = 0, y = 0, z = 0 })
            self.object:set_acceleration({ x = 0, y = 0, z = 0 })
            self.object:set_armor_groups({ immortal = 1 })
        end,
        on_step = function(self, dtime)
            -- remove dummy after dig the spawner
            self.timer = self.timer + dtime

            if self.timer > 2 then
                local n = minetest.get_node_or_nil(self.object:get_pos())
                if n and n.name ~= 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_active'
                then
                    self.object:remove()
                end
            end
        end
    }

    minetest.register_entity('spawners_env:dummy_' .. mod_prefix .. '_' .. mob_name, ent_def)

    -- Default spawner (inactive)
    local node_def = {}
    local node_name = 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner'
    node_def.description = mod_prefix .. '_' .. mob_name .. ' spawner env'
    node_def.paramtype = 'light'
    node_def.paramtype2 = 'glasslikeliquidlevel'
    node_def.drawtype = 'glasslike_framed_optional'
    node_def.walkable = true
    node_def.sounds = default.node_sound_metal_defaults()
    node_def.sunlight_propagates = true
    node_def.tiles = { 'spawners_env_spawner_16.png' }
    node_def.is_ground_content = true
    node_def.groups = {
        -- MTG
        cracky = 1,
        level = 2
    }
    node_def.stack_max = 1
    node_def.drop = ''
    node_def.on_construct = function(pos)
        spawners_env.check_for_spawning_timer(pos, mob_name, def.night_only, mod_prefix, def.sound_custom, def.boss)
    end

    local drop_item_name = 'spawners_mobs:' .. mod_prefix .. '_' .. mob_name .. '_spawner'

    if minetest.get_modpath('spawners_mobs') and minetest.registered_nodes[drop_item_name] then
        node_def.drop = {
            max_items = 1,
            items = {
                { items = { 'spawners_mobs:' .. mod_prefix .. '_' .. mob_name .. '_spawner' }, rarity = 5 }
            }
        }
    end

    minetest.register_node(node_name, node_def)

    table.insert(spawners_env.registered_spawners_names, node_name)

    -- Waiting spawner
    local node_def_waiting = table.copy(node_def)
    node_name = 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting'
    node_def_waiting.description = mod_prefix .. '_' .. mob_name .. ' spawner waiting env'
    node_def_waiting.light_source = 2
    node_def_waiting.tiles = {
        {
            name = 'spawners_env_spawner_waiting_animated_16.png',
            animation = {
                type = 'vertical_frames',
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0
            },
        }
    }
    node_def_waiting.groups = {
        -- MTG
        cracky = 1,
        level = 2,
        not_in_creative_inventory = 1
    }
    node_def_waiting.on_timer = function(pos, elapsed)
        spawners_env.check_for_spawning_timer(pos, mob_name, def.night_only, mod_prefix, def.sound_custom, def.boss)
        return false
    end
    node_def_waiting.on_construct = nil

    minetest.register_node(node_name, node_def_waiting)

    -- Active spawner
    local node_def_active = table.copy(node_def)
    node_name = 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_active'
    node_def_active.description = mod_prefix .. '_' .. mob_name .. ' spawner active env'
    node_def_active.light_source = 4
    node_def_active.damage_per_second = 4
    node_def_active.tiles = {
        {
            name = 'spawners_env_spawner_animated_16.png',
            animation = {
                type = 'vertical_frames',
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0
            },
        }
    }
    node_def_active.groups = {
        -- MTG
        cracky = 1,
        level = 2,
        igniter = 1,
        not_in_creative_inventory = 1
    }
    node_def_active.on_timer = function(pos, elapsed)
        spawners_env.check_for_spawning_timer(pos, mob_name, def.night_only, mod_prefix, def.sound_custom, def.boss)
        return false
    end
    node_def_active.on_construct = function(pos)
        pos.y = pos.y + def.dummy_offset
        minetest.add_entity(pos, ent_name)
    end

    minetest.register_node(node_name, node_def_active)

    --
    -- LBM
    --
    minetest.register_lbm({
        name = 'spawners_env:check_for_spawning_timer_' .. mob_name,
        nodenames = {
            'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner',
            'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_active',
            'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting'
        },
        action = function(pos)
            spawners_env.check_for_spawning_timer(pos, mob_name, def.night_only, mod_prefix, def.sound_custom, def.boss)
        end
    })
end

--
-- Check for spawning
--
function spawners_env.check_for_spawning_timer(pos, mob_name, night_only, mod_prefix, sound_custom, boss)
    local random_pos = spawners_env.check_node_status(pos, mob_name, night_only, boss)
    local node = minetest.get_node_or_nil(pos)

    -- minetest.log('action', '[Mod][Spawners] checking for: ' .. mob_name .. ' at ' .. minetest.pos_to_string(pos))

    if random_pos and node then
        -- print('try to spawn another mob at: ' .. minetest.pos_to_string(random_pos))
        local mobs_counter_table = {}
        local mobs_check_radius = 10
        local mobs_max = 3
        mobs_counter_table[mob_name] = 0

        if boss then
            mobs_max = 1
            mobs_check_radius = 35
        end

        -- collect all spawned mobs around area
        for _, obj in ipairs(minetest.get_objects_inside_radius(pos, mobs_check_radius)) do
            if obj:get_luaentity() then
                -- get entity name
                local name_split = string.split(obj:get_luaentity().name, ':')

                if name_split[2] == mob_name then
                    mobs_counter_table[mob_name] = mobs_counter_table[mob_name] + 1
                end
            end
        end

        -- print(mob_name .. ' : ' .. mobs_counter_table[mob_name])

        -- enough place to spawn more mobs
        if mobs_counter_table[mob_name] < mobs_max then
            -- make sure the right node status is shown
            if node.name ~= 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_active' then
                minetest.set_node(pos, { name = 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_active' })
            end

            if boss then
                minetest.chat_send_all(minetest.colorize('#FF5722', 'Boss ' .. mob_name .. ' has spawned to this World!'))
            end

            spawners_env.start_spawning(random_pos, 1, 'spawners_env:' .. mob_name, mod_prefix, sound_custom)
        else
            -- print('too many mobs: waiting')
            -- waiting status
            if node.name ~= 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' then
                minetest.set_node(pos, { name = 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' })
            end
        end

    elseif node then
        -- print('no random_pos found: waiting')
        -- waiting status
        if node.name ~= 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' then
            minetest.set_node(pos, { name = 'spawners_env:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' })
        end
    end
    -- 6 hours = 21600 seconds
    -- 4 hours = 14400 seconds
    -- 1 hour = 3600 seconds
    if boss then
        minetest.get_node_timer(pos):start(3600)
    else
        minetest.get_node_timer(pos):start(math.random(5, 15))
    end
end

-- start spawning mobs
function spawners_env.start_spawning(pos, how_many, mob_name, mod_prefix, sound_custom)

    if not (pos or mob_name) then
        return
    end

    -- remove 'spawners_env:' from the string
    local _mob_name = string.sub(mob_name, 14)
    local sound_name

    -- use custom sounds
    if sound_custom and sound_custom ~= '' then
        sound_name = sound_custom
    else
        sound_name = mod_prefix .. '_' .. _mob_name
    end

    if not how_many then
        how_many = math.random(1, 2)
    end

    for i = 1, how_many do
        pos.y = pos.y + 1
        local obj = minetest.add_entity(pos, mod_prefix .. ':' .. _mob_name)

        if obj then
            if sound_name then
                minetest.sound_play(sound_name, {
                    pos = pos,
                    max_hear_distance = 16,
                    gain = 5,
                })
            end
        end
    end
end

function spawners_env.check_around_radius(pos)
    local player_near = false
    local radius = 21

    for _, obj in ipairs(minetest.get_objects_inside_radius(pos, radius)) do
        if obj:is_player() then
            player_near = true
            break
        end
    end

    return player_near
end

function spawners_env.check_node_status(pos, mob, night_only, boss)
    local player_near = spawners_env.check_around_radius(pos)

    if player_near or boss then
        local random_pos
        local min_node_light = 10
        local tod = minetest.get_timeofday() * 24000
        local node_light = minetest.get_node_light(pos)

        if not node_light then
            return false
        end

        local spawn_positions = {}
        local right = minetest.get_node({ x = pos.x + 1, y = pos.y, z = pos.z })
        local front = minetest.get_node({ x = pos.x, y = pos.y, z = pos.z + 1 })
        local left = minetest.get_node({ x = pos.x - 1, y = pos.y, z = pos.z })
        local back = minetest.get_node({ x = pos.x, y = pos.y, z = pos.z - 1 })
        local top = minetest.get_node({ x = pos.x, y = pos.y + 1, z = pos.z })
        local bottom = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

        -- make sure that at least one side of the spawner is open
        if right.name == 'air' then
            table.insert(spawn_positions, { x = pos.x + 1.5, y = pos.y, z = pos.z })
        end
        if front.name == 'air' then
            table.insert(spawn_positions, { x = pos.x, y = pos.y, z = pos.z + 1.5 })
        end
        if left.name == 'air' then
            table.insert(spawn_positions, { x = pos.x - 1.5, y = pos.y, z = pos.z })
        end
        if back.name == 'air' then
            table.insert(spawn_positions, { x = pos.x, y = pos.y, z = pos.z - 1.5 })
        end
        if top.name == 'air' then
            table.insert(spawn_positions, { x = pos.x, y = pos.y + 1.5, z = pos.z })
        end
        if bottom.name == 'air' then
            table.insert(spawn_positions, { x = pos.x, y = pos.y - 1.5, z = pos.z })
        end

        -- spawner is closed from all sides
        if #spawn_positions < 1 then
            return false

        else
            -- find random position in all posible places
            local possible_spawn_pos = {}
            local pick_random_key

            -- get a position value from the picked/random key
            for k, v in pairs(spawn_positions) do
                local node_above = minetest.get_node({ x = v.x, y = v.y + 1, z = v.z }).name
                local node_below = minetest.get_node({ x = v.x, y = v.y - 1, z = v.z }).name

                -- make super sure there is enough place to spawn mob and collect all possible spawn points
                if node_above == 'air' or node_below == 'air' then
                    table.insert(possible_spawn_pos, v)
                    -- print('possible pos: ' .. minetest.pos_to_string(v))
                end
            end

            -- no possible spawn points found - not enough place around the spawner
            if #possible_spawn_pos < 1 then
                return false

            elseif #possible_spawn_pos == 1 then
                -- only one possible position ?
                pick_random_key = #possible_spawn_pos

            else
                -- pick random from the possible open sides
                pick_random_key = math.random(1, #possible_spawn_pos)
            end

            random_pos = possible_spawn_pos[pick_random_key]
            -- print(minetest.pos_to_string(random_pos))
        end

        if night_only ~= 'disable' then
            -- spawn only at day
            if not night_only and node_light < min_node_light then
                return false, true
            end

            -- spawn only at night
            if night_only then
                if not (19359 > tod and tod > 5200) or node_light < min_node_light then
                    return random_pos
                else
                    return false, true
                end
            end
        end
        -- random_pos, waiting
        return random_pos, false
    else
        -- random_pos, waiting
        return false, true
    end
end
