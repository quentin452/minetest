----------------
-- Spiradilus --
----------------

local abs = math.abs
local deg = math.deg
local pi = math.pi

local function clamp_bone_rot(n) -- Fixes issues with bones jittering when yaw clamps
    if n < -180 then
        n = n + 360
    elseif n > 180 then
        n = n - 360
    end
    if n < -60 then
        n = -60
    elseif n > 60 then
        n = 60
    end
    return n
end

local function interp_bone_rot(a, b, w) -- Smoothens bone movement
    if abs(a - b) > deg(pi) then
        if a < b then
            return ((a + (b - a) * w) + (deg(pi) * 2))
        elseif a > b then
            return ((a + (b - a) * w) - (deg(pi) * 2))
        end
    end
    return a + (b - a) * w
end

spiradilus = {}

local path = minetest.get_modpath("spiradilus")

local storage = dofile(path.."/storage.lua")

spiradilus.global_data = {
    mob = nil,
    death_pos = storage.death_pos,
    death_time = storage.death_time,
    drops = {}
}

local clear_objects = minetest.clear_objects

function minetest.clear_objects(options)
    clear_objects(options)
    spiradilus.global_data = {
        mob = nil,
        death_pos = nil,
        death_time = nil,
        drops = spiradilus.global_data.drops
    }
end

-- Get Drops

local armor_loaded = minetest.get_modpath("3d_armor")

minetest.register_on_mods_loaded(function()
    for name, def in pairs(minetest.registered_tools) do
        if def.tool_capabilities
        and def.tool_capabilities.groupcaps then
            for _, caps in pairs(def.tool_capabilities.groupcaps) do
                if caps.maxlevel
                and caps.maxlevel > 2 then
                    table.insert(spiradilus.global_data.drops, name)
                end
            end
        end
    end
end)

dofile(path .. "/api/behaviors.lua")

local function get_tail_segments(self)
    local segments = math.ceil(self.hp * 0.01)
    if segments < 1 then segments = 1 end
    return segments
end

function spiradilus.set_tail(self)
    local tail_segments = get_tail_segments(self)
    if not self.object:get_properties().textures[1]:find(tail_segments) then
        self.object:set_properties({
            textures = {
                "spiradilus_spiradilus.png^spiradilus_spiradilus_tail_" .. tail_segments .. ".png"
            }
        })
    end
end

creatura.register_mob("spiradilus:spiradilus", {
    -- Stats
    max_health = 1300,
    armor_groups = {fleshy = 75},
    damage = 20,
    speed = 14,
	tracking_range = 64,
    despawn_after = nil,
	-- Entity Physics
	stepheight = 1.1,
	turn_rate = 3.5,
    -- Visuals
    mesh = "spiradilus_spiradilus.b3d",
	hitbox = {
		width = 0.8,
		height = 1.5
	},
    visual_size = {x = 16, y = 16},
	textures = {"spiradilus_spiradilus.png"},
	animations = {
		stand = {range = {x = 1, y = 60}, speed = 10, frame_blend = 0.3, loop = true},
		walk = {range = {x = 70, y = 110}, speed = 40, frame_blend = 0.3, loop = true},
		run = {range = {x = 70, y = 110}, speed = 40, frame_blend = 0.3, loop = true},
        basic_attack = {range = {x = 120, y = 150}, speed = 20, frame_blend = 0.2, loop = false},
        eat = {range = {x = 150, y = 180}, speed = 20, frame_blend = 0.2, loop = false},
        tail_attack = {range = {x = 320, y = 390}, speed = 40, frame_blend = 0.2, loop = false},
        dodge_attack = {range = {x = 400, y = 440}, speed = 25, frame_blend = 0.2, loop = false},
        roar = {range = {x = 180, y = 240}, speed = 20, frame_blend = 0.2, loop = false},
        sleep = {range = {x = 250, y = 310}, speed = 10, frame_blend = 1, loop = true}
	},
    -- Misc
    sounds = {
		roar = {
            name = "spiradilus_roar",
            gain = 2,
            distance = 128
        },
        slam = {
            name = "spiradilus_slam",
            gain = 2,
            distance = 64
        }
    },
	head_data = {
		offset = {x = 0, y = 0.35, z = 0},
		pitch_correction = 0,
		pivot_h = 1.75,
		pivot_v = 1
	},
    move_head = function(self, tyaw, pitch)
        local data = self.head_data
        local _, rot = self.object:get_bone_position(data.bone or "Head.CTRL")
        local yaw = self.object:get_yaw()
        local look_yaw = clamp_bone_rot(deg(yaw - tyaw))
        local look_pitch = 0
        if pitch then
            look_pitch = clamp_bone_rot(deg(pitch))
        end
        if tyaw ~= yaw then
            look_yaw = look_yaw * 1.11
        end
        yaw = interp_bone_rot(rot.z, look_yaw, 0.1)
        local ptch = interp_bone_rot(rot.x, look_pitch + data.pitch_correction, 0.1)
        self.object:set_bone_position(data.bone or "Head.CTRL", data.offset, {x = ptch, y = 0, z = yaw})
    end,
    -- Function
	utility_stack = {
		[1] = {
			utility = "spiradilus:wander",
			get_score = function(self)
				return 0.1, {self}
			end
		},
        [2] = {
			utility = "spiradilus:attack",
			get_score = function(self)
				local player = creatura.get_nearby_player(self)
				if player
                and not self.sleeping then
					return 0.8, {self, player}
				end
				return 0
			end
		},
        [3] = {
			utility = "spiradilus:sleep",
			get_score = function(self)
                return 0.2, {self}
			end
		}
	},
    activate_func = function(self)
        if not spiradilus.global_data.mob
        and (not spiradilus.global_data.death_pos
        or vector.distance(self.object:get_pos(), spiradilus.global_data.death_pos) < 1.5) then
            spiradilus.global_data.mob = self.object
            spiradilus.global_data.death_pos = nil
        else
            self.object:remove()
            return
        end
        spiradilus.set_tail(self)
        self:move_head(self.object:get_yaw())
    end,
    step_func = function(self)
        if not self:get_utility()
        or self:get_utility() ~= "spiradilus:attack" then
            self:move_head(self.object:get_yaw())
        end
    end,
    deactivate_func = function(self)
        if spiradilus.global_data.mob
        and spiradilus.global_data.mob == self.object then
            spiradilus.global_data.mob = nil
        end
    end,
    death_func = function(self)
        if spiradilus.global_data.mob
        and spiradilus.global_data.mob == self.object then
            spiradilus.global_data.mob = nil
        end
        if not spiradilus.global_data.death_pos then
            spiradilus.global_data.death_pos = self.object:get_pos()
            spiradilus.global_data.death_time = minetest.get_us_time()
        end
		if self:get_utility() ~= "spiradilus:death" then
			self:initiate_utility("spiradilus:death", self)
		end
    end,
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, direction, damage)
		creatura.basic_punch_func(self, puncher, time_from_last_punch, tool_capabilities, direction, damage)
        spiradilus.set_tail(self)
	end
})

creatura.register_spawn_egg("spiradilus:spiradilus", "4d4b35" ,"652b2b")

creatura.register_mob_spawn("spiradilus:spiradilus", {
    chance = 1000,
    min_radius = 32,
    max_radius = 64,
    min_light = 0,
    min_height = -32,
    max_height = 128,
    min_group = 1,
    max_group = 1
})

local moveable = creatura.is_pos_moveable

local function respawn_spiradilus()
    if not spiradilus.global_data.death_time then minetest.after(60, respawn_spiradilus) return end
    if minetest.get_us_time() - spiradilus.global_data.death_time >= 3600000000 then
        if spiradilus.global_data.death_pos
        and minetest.get_node_or_nil(spiradilus.global_data.death_pos) then
            if moveable(spiradilus.global_data.death_pos, 0.8, 1.5) then
                minetest.add_entity(spiradilus.global_data.death_pos, "spiradilus:spiradilus")
            end
            spiradilus.global_data.death_pos = nil
            spiradilus.global_data.death_time = nil
        end
    end
    minetest.after(60, respawn_spiradilus)
end

respawn_spiradilus()