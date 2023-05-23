local function mts(table)
    local output = minetest.serialize(table)
    return output
end

local function mtpts(table)
    local output = minetest.pos_to_string(table)
    return output
end

local function mr(...)
     return witches.mr(...)
end

local S = minetest.get_translator("witches")

local variance = witches.variance
local rnd_color = witches.rnd_color
local rnd_colors = witches.rnd_colors
local hair_colors = witches.hair_colors

local spawning = {
    cottage = {
        -- nodes = {"group:wood","group:choppy","default:cobble"},
        -- neighbors = {"witches:chest_locked", "doors:wood_witch_a"},
        nodes = {"witches:spawn_node"},
        neighbors = {"witches:chest_locked"},
        min_light = 0,
        max_light = 25,
        interval = 20,
        chance = 1, -- 1:1 chance
        -- on_map_load = true, -- on map generation
        active_object_count = 1,
        min_height = -10,
        max_height = 200,
        day_toggle = nil,
        on_spawn = function(self)
            local pos = self.object:get_pos()
            witches.debug(self.secret_name .. " spawned at " ..
                              minetest.pos_to_string(vector.round(pos)),
                          "Witch Spawning")
            local wsn = minetest.find_node_near(pos, 4,
                                                {name = "witches:spawn_node"},
                                                true)
            if wsn then
                minetest.remove_node(wsn)
                witches.debug(self.secret_name .. " found the spawn node:" ..
                                  mtpts(wsn))
            else
                witches.debug(self.secret_name ..
                                  " could not find the spawn node:" ..
                                  mtpts(pos))
            end
        end

    },
    generic = {
        nodes = {"group:wood", "default:mossycobble"},
        neighbors = {"air"},
        min_light = 5,
        max_light = 15,
        interval = 30,
        chance = 1000,
        active_object_count = 1,
        min_height = -10,
        max_height = 200,
        day_toggle = nil,
        on_spawn = function(self)
            local pos = self.object:get_pos()
            witches.debug(self.secret_name .. " spawned at " ..
                              minetest.pos_to_string(vector.round(pos)),
                          "Witch Spawning")

        end

    }
}


witches.witch_types = {
    generic = {
        description = S("Wanderling"),
        lore = S("The Wanderlings roam the land, for what do they seek?"),

        additional_properties = {
            special_follow = witches.data_get("generic_special_follow"),
            
            do_custom_addendum = function(self)
                if mr(30000) == 1 and
                    minetest.registered_nodes["fireflies:firefly"] then
                    local pos = self.object:get_pos()
                    if pos then
                        if minetest.is_protected(pos, "") then return end
                        pos.y = pos.y + 1
                        local pos1 = minetest.find_node_near(pos, 3, "air")
                        if pos1 then
                            minetest.set_node(pos1, {name = "fireflies:firefly"})
                            -- print("setting firefly"..minetest.pos_to_string(pos1))
                        end
                    end
                end

            end,

            on_spawn_addendum = function(self)
                -- print(dump(self.drops).."and"..dump(minetest.registered_tools))

                witches.firefly_mod(self)
            end
        }
    },

    cottage = {
        description = S("Eremitant"),
        lore = S("The Eremitant have found homes for themselves, who would bother them?"),
        additional_properties = {
            special_follow = witches.data_get("cottage_special_follow"),
            special_drops = witches.data_get("cottage_special_drops"),

            do_custom_addendum = function(self)
                if witches.cottages then
                    witches.claim_witches_chest(self)
                end
            end,
            on_spawn_addendum = function(self)
                witches.claim_witches_chest(self)
            end
        },
        spawning = spawning.cottage
    },

    cottage_builder = {
        description = S("Eremitant Artifician"),
        lore = S("The Eremitant Artificians scout the land for dungeons upon which their cottages may be built"),
        additional_properties = {
            special_follow = witches.data_get("cottage_special_follow"),

            do_custom_addendum = function(self)
                if witches.cottages then
                    if not self.built_house and mr(10000) == 1 then
                        witches.debug(self.secret_name .. " grounding...",
                                      "Witch Spawning")
                        local volume = witches.grounding(self.object:get_pos())
                        if volume then
                            witches.debug("volume passed: " .. dump(volume),
                                          "Witch Spawning")

                            local pos = self.object:get_pos()
                            pos.y = pos.y + 3
                            self.object:set_pos(pos)
                            self.built_house = pos
                            --[[ print("witch placing:" ..
                                      minetest.serialize(volume[1]) .. "/n" ..
                                      minetest.serialize(volume[2]))
                            --]]
                            witches.generate_cottage(volume[1], volume[2], nil,
                                                     self.secret_name)

                        end
                    end
                end
            end,
            on_spawn_addendum = function(self)
                witches.claim_witches_chest(self)
            end
        },
        spawning = spawning.generic
    }
}

witches.witch_template = { -- your average witch,
    description = S("Basic Witch"),
    lore = S("This witch has a story yet to be..."),
    type = "npc",
    passive = false,
    attack_type = "dogfight",
    attack_monsters = true,
    attack_npcs = false,
    attack_players = true,
    group_attack = true,
    runaway = false,
    damage = 1,
    reach = 2,
    knock_back = true,
    hp_min = 5,
    hp_max = 10,
    armor = 100,
    visual = "mesh",
    mesh = "witches_witch.b3d",
    textures = {"witches_clothes.png"},
    -- blood_texture = "witches_blood.png",
    collisionbox = {-0.2, 0, -.2, 0.2, 1.9, 0.2},
    drawtype = "front",
    makes_footstep_sound = true,
    sounds = {
        random = "",
        war_cry = "",
        attack = "",
        damage = "",
        death = "",
        replace = "",
        teleport = "witches_magic01",
        polymorph = "witches_magic02",
        drench = "witches_water"
    },
    walk_velocity = 2,
    run_velocity = 3,
    pathfinding = 1,
    jump = true,
    jump_height = 5,
    step_height = 1.5,
    fear_height = 4,
    water_damage = 0,
    lava_damage = 2,
    light_damage = 0,
    lifetimer = 360,
    view_range = 10,
    stay_near = "",
    order = "follow",

    animation = {
        stand_speed = 30,
        stand_start = 0,
        stand_end = 80,
        walk_speed = 30,
        walk_start = 168,
        walk_end = 187,
        run_speed = 45,
        run_start = 168,
        run_end = 187,
        punch_speed = 30,
        punch_start = 200,
        punch_end = 219
    },
    drops = witches.data_get("template_drops"),

    -- follow should be left empty as it is filled from a function!
    
    follow = {},
    additional_properties = {
        special_follow = witches.data_get("template_special_follow"),
        special_drops = witches.data_get("template_special_drops"),
    },
    on_rightclick = function(self, clicker) witches.quests(self, clicker) end,

    do_custom = function(self)
        if self.do_custom_addendum then self.do_custom_addendum(self) end
        if self.attack then
            local s = self.object:get_pos()
            local objs = minetest.get_objects_inside_radius(s, 2)
            for n = 1, #objs do
                local ent = objs[n]:get_luaentity()
                if objs[n] == self.attack then
                    if self.attack:is_player() then

                        -- witches.magic.banish_underground(self,objs[n],10) 
                        witches.magic.teleport(self, objs[n], mr(3, 8),
                                               mr(2, 4))

                    else
                        if mr(5) == 1 then

                            witches.magic.teleport(self, objs[n],
                                                   mr(3, 5),
                                                   mr(2, 4))
                            witches.magic.polymorph(self, objs[n])

                        elseif mr(2) == 1 then
                            witches.magic.teleport(self, objs[n],
                                                   mr(3, 5),
                                                   mr(1, 2))
                            witches.magic.splash(self, objs[n],
                                                 vector.new(2, 2, 2),
                                                 mr(0, 1))
                            -- witches.magic.splash(self,target,volume,height,node)
                        else

                            witches.magic.teleport(self, objs[n],
                                                   mr(3, 8),
                                                   mr(2, 4))

                        end
                        -- witches.magic.teleport(self,objs[n],mr(3,8),mr(2,4))
                    end
                end
            end
        end
    end,

    on_spawn = function(self)
        -- make sure these are baseline on spawn
        -- self.animation.walk_speed = 30
        -- self.animation.run_speed = 45
        -- self.walk_velocity = 2
        -- self.run_velocity = 3
        -- then set modifiers for each individual
        if not self.speed_mod then self.speed_mod = mr(-1, 1) end
        -- print("speed mod: "..self.speed_mod)
        -- rng for testing variants
        if not self.size then
            self.size = {
                x = variance(90, 100),
                y = variance(75, 105),
                z = variance(90, 100)
            }
        end

        if not self.skin then self.skin = mr(1, 5) end

        if not self.color_mod then self.color_mod = rnd_color(rnd_colors) end

        if not self.hair_color then
            self.hair_color = rnd_color(hair_colors)
        end

        local self_properties = self.object:get_properties()
        self_properties.visual_size = self.size
        self.object:set_properties(self_properties)

        -- initial speed modifications
        self.walk_velocity = self.walk_velocity + (self.speed_mod / 10)
        self.run_velocity = self.run_velocity + (self.speed_mod / 10)
        self.animation.walk_speed = self.animation.walk_speed + self.speed_mod
        self.animation.run_speed = self.animation.run_speed + self.speed_mod
        -- no more speed mods!
        self.speed_mod = 0

        -- so many overlays!
        if self.color_mod ~= "none" then
            self.object:set_texture_mod("^[colorize:" .. self.color_mod ..
                                            ":60^witches_skin" .. self.skin ..
                                            ".png^witches_accessories.png^witches_witch_hair_" ..
                                            self.hair_color .. ".png")
        else
            self.object:set_texture_mod("^witches_skin" .. self.skin ..
                                            ".png^witches_accessories.png^witches_witch_hair_" ..
                                            self.hair_color .. ".png")
        end
        if not self.secret_name then
            self.secret_name = witches.generate_text(witches.name_parts_female)
        end
        if not self.secret_title then
            self.secret_title = witches.generate_text(witches.words_desc,
                                                      {"titles"})
        end
        if not self.secret_locale then
            if mr(2) == 1 then
                self.secret_locale = witches.generate_text(
                                         witches.name_parts_female, {
                        "syllablesStart", "syllablesEnd", "syllablesTown"
                    })
            else
                self.secret_locale = witches.generate_text(
                                         witches.name_parts_male, {
                        "syllablesStart", "syllablesEnd", "syllablesTown"
                    })
            end
        end

        -- self.item_request.text =  witches.generate_name(witches.quest_dialogs, {"item_request"})
        -- print(self.secret_name.." has spawned")
        -- print("self: "..dump(self.follow))
        -- print("self properties "..dump(self.object:get_properties()))
        -- self.follow = {}

        witches.looking_for(self)

        if self.on_spawn_addendum then self.on_spawn_addendum(self) end

    end,

    spawning = spawning.generic,

    after_activate = function(self)
        -- maddest hatter <|%\D
        self.hair_style = mr(1, #witches.witch_hair_styles)
        self.hat_style = mr(1, #witches.witch_hat_styles)
        witches.attach_hair(self, "witches:witch_hair_" .. self.hair_style)
        witches.attach_hat(self, "witches:witch_hat_" .. self.hat_style)
        if mr(2) == 1 then
            witches.attach_tool(self, "witches:witch_tool_wand_btb")
        else
            witches.attach_tool(self, "witches:witch_tool_wand_sp")
        end
    end

}
