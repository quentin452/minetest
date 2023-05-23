--[[
    X Tumbleweed. Adds tumbleweeds.
    Copyright (C) 2023 SaKeL <juraj.vajda@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

local S = minetest.get_translator(minetest.get_current_modname())

---@type XTumbleweed
XTumbleweed = {
    settings = {
        abr = minetest.get_mapgen_setting('active_block_range') or 4 --[[@as number]]
    },
    spawn_reduction = 0.5,
    spawn_rate = 0.5,
    allowed_biomes = {
        'desert',
        'sandstone_desert',
        'cold_desert'
    },
    sounds = {
        neutral = 'x_tumbleweed_tumbleweed'
    }
}

---Check if indexed table contains a value
---@param table table
---@param value string|number|integer
---@return boolean
local function tableContains(table, value)
    local found = false

    if not table or type(table) ~= 'table' then
        return found
    end

    for _, v in ipairs(table) do
        if v == value then
            found = true
            break
        end
    end

    return found
end

---@diagnostic disable-next-line: unused-local
function XTumbleweed.register_entity(self, name, def)
    local _def = def or {}

    -- common props
    _def.initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
        selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = true },
        visual = 'mesh',
        mesh = 'x_tumbleweed_tumbleweed.b3d',
        textures = { 'x_tumbleweed_tumbleweed_1.png' },
        backface_culling = false,
        visual_size = { x = 1, y = 1, z = 1 },
        hp_max = 10,
        infotext = S('Tumbleweed')
    }
    _def.static_save = true
    _def.makes_footstep_sound = true
    _def.on_step = mobkit.stepfunc
    _def.on_activate = mobkit.actfunc
    _def.get_staticdata = mobkit.statfunc

    -- api props
    _def.springiness = 0
    _def.buoyancy = 0.5
    _def.max_speed = 2
    _def.jump_height = 1.3
    _def.view_range = 5
    _def.lung_capacity = 1
    _def.max_hp = 10
    _def.timeout = 600
    _def.armor_groups = { fleshy = 10 }
    _def.animation = {
        walk = { range = { x = 1, y = 30 }, speed = 30, loop = true },
        stand = { range = { x = 31, y = 32 }, speed = 0, loop = false }
    }
    _def.brainfunc = function(...)
        XTumbleweed:brainfunc(...)
    end
    _def.on_punch = function(...)
        XTumbleweed:on_punch(...)
    end

    minetest.register_entity(name, _def)
end

---@diagnostic disable-next-line: unused-local
function XTumbleweed.brainfunc(self, selfObj)
    local pos = selfObj.object:get_pos()
    mobkit.vitals(selfObj)

    -- dead
    if selfObj.hp <= 0 or selfObj.isinliquid then
        mobkit.clear_queue_high(selfObj)
        mobkit.hq_die(selfObj)

        -- multiply
        if math.random(1, 3) == 3 and not selfObj.isinliquid and not selfObj.is_child then
            local angle, posadd
            angle = math.random(0, math.pi * 2)

            for _ = 1, 4 do
                posadd = { x = math.cos(angle), y = 0, z = math.sin(angle) }
                posadd = vector.normalize(posadd)
                local mobname = 'x_tumbleweed:tumbleweed'
                local obj = minetest.add_entity(vector.add(pos, posadd), mobname)

                if obj then
                    local lua_ent = obj:get_luaentity()
                    lua_ent.is_child = true

                    obj:set_properties({
                        visual_size = {
                            x = 1 * 0.5,
                            y = 1 * 0.5,
                            z = 1 * 0.5
                        },
                        collisionbox = {
                            -0.5 * 0.5,
                            -0.5 * 0.5,
                            -0.5 * 0.5,
                            0.5 * 0.5,
                            0.5 * 0.5,
                            0.5 * 0.5
                        },
                        selectionbox = {
                            -0.5 * 0.5,
                            -0.5 * 0.5,
                            -0.5 * 0.5,
                            0.5 * 0.5,
                            0.5 * 0.5,
                            0.5 * 0.5,
                            rotate = true
                        }
                    })
                    obj:set_yaw(angle - math.pi / 2)
                    angle = angle + math.pi / 2
                end
            end
        end

        minetest.after(4.5, function()
            local pos_after = selfObj.object:get_pos()

            minetest.add_particlespawner({
                amount = 9,
                time = 1,
                minpos = pos_after,
                maxpos = pos_after,
                minvel = { x = -3, y = 2, z = -3 },
                maxvel = { x = 3, y = 3, z = 3 },
                minacc = vector.new({ x = -3, y = 2, z = -3 }),
                maxacc = vector.new({ x = 3, y = 3, z = 3 }),
                minexptime = 0.5,
                maxexptime = 1,
                minsize = 16,
                maxsize = 24,
                texture = 'x_tumbleweed_death_particle_animated.png',
                animation = {
                    type = 'vertical_frames',
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1,
                },
            })

            -- drop items
            local puncher = selfObj._puncher
            local death_by_player = puncher and puncher:is_player()
            local biome_data = minetest.get_biome_data(pos)
            local biome_name = ''

            if biome_data then
                biome_name = minetest.get_biome_name(biome_data.biome) or ''
            end

            if death_by_player and pos_after then
                -- find suitable drop items
                local registered_decorations_filtered = { 'default:stick' }

                for _, v in pairs(minetest.registered_decorations) do
                    local registered_biome_names = v.biomes

                    if type(registered_biome_names) == 'string' then
                        registered_biome_names = { registered_biome_names }
                    end

                    ---only for 'simple' decoration types
                    if v.deco_type == 'simple' then
                        ---filter based on biome name in `biomes` table and node name in `place_on` table
                        if tableContains(registered_biome_names, biome_name) then
                            local item_names = v.decoration

                            if type(item_names) == 'string' then
                                item_names = { item_names }
                            end

                            for _, item_name in ipairs(item_names) do
                                local item_name_result = item_name

                                if minetest.registered_nodes[item_name_result] and minetest.registered_nodes[item_name_result].drop then
                                    item_name_result = minetest.registered_nodes[item_name_result].drop
                                elseif minetest.registered_items[item_name_result] and minetest.registered_items[item_name_result].drop then
                                    item_name_result = minetest.registered_items[item_name_result].drop
                                end

                                if type(item_name_result) == 'table' then
                                    if item_name_result.items then
                                        local random_item = item_name_result.items[math.random(1, #item_name_result.items)]

                                        item_name_result = random_item.items[math.random(1, #random_item.items)]
                                    end
                                end

                                if not tableContains(registered_decorations_filtered, item_name_result) then
                                    table.insert(registered_decorations_filtered, item_name_result)
                                end
                            end
                        end
                    end
                end

                local wield_stack = puncher:get_wielded_item()
                local tool_capabilities = wield_stack:get_tool_capabilities()
                local chance = math.random(1, tool_capabilities.max_drop_level)

                for _ = 1, math.random(1, 3) do
                    local stack_name = registered_decorations_filtered[1]

                    if #registered_decorations_filtered > 1 then
                        local rand_num = math.random(1, #registered_decorations_filtered)
                        stack_name = registered_decorations_filtered[rand_num]
                    end

                    if type(stack_name) == 'string' then
                        local stack = ItemStack({
                            name = stack_name,
                            count = math.random(3) * chance
                        })
                        local stack_obj = minetest.add_item(
                            { x = pos_after.x, y = pos_after.y + 1, z = pos_after.z },
                            stack
                        )

                        if stack_obj then
                            stack_obj:set_velocity({
                                x = math.random(-1, 1),
                                y = 2,
                                z = math.random(-1, 1),
                            })
                        end
                    end
                end
            end
        end)

        return
    end

    -- alive
    if mobkit.is_queue_empty_low(selfObj) then
        local yaw = selfObj.object:get_yaw()

        if not yaw then
            return
        end

        local dir_x = -math.sin(yaw) * (0.5 + 0.5)
        local dir_z = math.cos(yaw) * (0.5 + 0.5)
        local ypos = pos.y - 0.5
        local will_fall = false

        local not_blocking_sight = minetest.line_of_sight(
            { x = pos.x + dir_x, y = ypos, z = pos.z + dir_z },
            { x = pos.x + dir_x, y = ypos - 1, z = pos.z + dir_z })

        if not_blocking_sight then
            will_fall = true
        end

        if will_fall then
            mobkit.animate(selfObj, 'walk')
            mobkit.go_forward_horizontal(selfObj, 2)
        else
            mobkit.lq_dumbjump(selfObj, 1.3, 'walk')

            minetest.add_particlespawner({
                amount = 6,
                time = 0.5,
                minpos = {
                    x = pos.x - 0.5,
                    y = pos.y + 0.1,
                    z = pos.z - 0.5
                },
                maxpos = {
                    x = pos.x + 0.5,
                    y = pos.y + 0.1,
                    z = pos.z + 0.5
                },
                minvel = { x = 0, y = 5, z = 0 },
                maxvel = { x = 0, y = 5, z = 0 },
                minacc = { x = 0, y = -13, z = 0 },
                maxacc = { x = 0, y = -13, z = 0 },
                minexptime = 0.5,
                maxexptime = 1,
                minsize = 0.5,
                maxsize = 1.5,
                vertical = false,
                texture = selfObj.object:get_properties().textures[1],
                collisiondetection = true
            })
        end
    end

    if mobkit.timer(selfObj, 1) then
        if (#selfObj.colinfo.collisions == 1 and selfObj.colinfo.collisions[1].axis ~= 'y')
            or #selfObj.colinfo.collisions > 1
        then
            -- turn around randomly when stuck
            selfObj.object:set_yaw(math.rad(math.random(1, 360)))
        end
    end
end

---@diagnostic disable-next-line: unused-local
function XTumbleweed.on_punch(self, selfObj, puncher, time_from_last_punch, tool_capabilities, dir)
    if mobkit.is_alive(selfObj) then
        minetest.sound_play({
            name = self.sounds.neutral
        }, {
            object = selfObj.object
        })

        local hvel = vector.multiply(vector.normalize({ x = dir.x, y = 0, z = dir.z }), 4)
        selfObj._puncher = puncher
        selfObj.object:set_velocity({ x = hvel.x, y = 2, z = hvel.z })

        local damage = tool_capabilities and tool_capabilities.damage_groups.fleshy or 1

        mobkit.hurt(selfObj, damage)

        selfObj.object:set_yaw(minetest.dir_to_yaw(dir))
    end
end

function XTumbleweed.globalstep(self, dtime)
    local abr = self.settings.abr
    local spawn_reduction = self.spawn_reduction
    local spawn_rate = self.spawn_rate
    local spawnpos, liquidflag = mobkit.get_spawn_pos_abr(dtime, 3, abr * 16, spawn_rate, spawn_reduction)

    if spawnpos and not liquidflag then
        local biome_data = minetest.get_biome_data(spawnpos)

        if not biome_data then
            return
        end

        local biome_name = minetest.get_biome_name(biome_data.biome)

        if not biome_name then
            return
        end

        local objs = minetest.get_objects_inside_radius(spawnpos, abr * 16 * 1.1)
        local tumbleweed_counter = 0

        if not tableContains(self.allowed_biomes, biome_name) then
            return
        end

        -- count mobs in abrange
        for _, obj in ipairs(objs) do
            if not obj:is_player() then
                local luaent = obj:get_luaentity()

                if luaent and luaent.name:find('x_tumbleweed:') then
                    if luaent.name == 'x_tumbleweed:tumbleweed' then
                        tumbleweed_counter = tumbleweed_counter + 1
                    end
                end
            end
        end

        if tumbleweed_counter > 1 then
            return
        end

        local mobname = 'x_tumbleweed:tumbleweed'
        local obj = minetest.add_entity({ x = spawnpos.x, y = spawnpos.y + 0.5, z = spawnpos.z }, mobname)

        -- camouflage texture
        local spawn_node = minetest.get_node(vector.new(spawnpos.x, spawnpos.y - 1, spawnpos.z))
        local spawn_node_def = minetest.registered_nodes[spawn_node.name]
        local tex = spawn_node_def.tiles

        if spawn_node_def and spawn_node_def.walkable then
            if type(tex) == 'table' then
                tex = spawn_node_def.tiles[1]
            end

            if type(tex) == 'table' and (tex[1] or tex.name) then
                tex = tex[1] and tex[1].name or tex.name
            end

            if tex then
                tex = tex .. '^[mask:x_tumbleweed_tumbleweed_mask_' .. math.random(1, 3) .. '.png'
            end
        end


        if obj then
            local yaw = math.rad(math.random(1, 360))
            local rand_num = math.random(50, 150) / 100
            local rand = PcgRandom(spawnpos.x * spawnpos.y * spawnpos.z)
            local obj_properties = {
                visual_size = {
                    x = 1 * rand_num,
                    y = 1 * rand_num,
                    z = 1 * rand_num
                },
                collisionbox = {
                    -0.5 * rand_num,
                    -0.5 * rand_num,
                    -0.5 * rand_num,
                    0.5 * rand_num,
                    0.5 * rand_num,
                    0.5 * rand_num
                },
                selectionbox = {
                    -0.5 * rand_num,
                    -0.5 * rand_num,
                    -0.5 * rand_num,
                    0.5 * rand_num,
                    0.5 * rand_num,
                    0.5 * rand_num,
                    rotate = true
                }
            }

            -- camouflage texture
            if tex and rand:next(0, 100) < 25 then
                obj_properties.textures = { tex }
            end

            obj:set_yaw(yaw)
            obj:set_properties(obj_properties)
        end

        minetest.log(
            'action',
            '[x_tumbleweed] Spawned ' .. mobname .. ' at ' .. minetest.pos_to_string(spawnpos)
        )
    end
end

function XTumbleweed.add_allowed_biomes(self, biomes)
    if not biomes or type(biomes) ~= 'table' then
        return
    end

    for _, biome_name in ipairs(biomes) do
        if not tableContains(self.allowed_biomes, biome_name) then
            table.insert(self.allowed_biomes, biome_name)
        end
    end
end
