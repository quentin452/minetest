
--- MESE LORD ( BOSS 1 ) ------------------------------------------
-- sound : https://freesound.org/people/BrainClaim/sounds/267638/


mobs:register_mob("meselord:meselord", {
	nametag = "Mese Lord Boss" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "shoot",
	shoot_interval = 0.3,
	shoot_offset = 1.5,
	arrow = "meselord:meselord_arrow",
	pathfinding = true,
	reach = 4,
	damage = 4,
	hp_min = 300,
	hp_max = 300,
	armor = 80,
	visual_size = {x = 3, y = 3},
	collisionbox = {-1.0, -0.7, -1.0, 1.0, 1.0, 1.0},
	visual = "mesh",
	mesh = "mese_lord.b3d",
	rotate = 180,
	textures = {
		{"mese_lord.png"},
	},
	glow = 8,
	blood_texture = "default_mese_crystal_fragment.png",
	sounds = {
		random = "mese_lord",
	},

	fly = true ,
	fly_in = "air",
	walk_velocity = 3,
	run_velocity = 5,
	jump_height = 4,
	stepheight = 3,
	floats = 0,
	view_range = 40,
	drops = {
		{name = "default:mese", chance = 2, min = 1, max = 2},
		--{name = "skullkingsitems:meselord_trophy", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,


	animation = {

		speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		walk_start = 15,
		walk_end = 33,
		run_start = 35,
		run_end = 53,
		shoot_start = 55,
		shoot_end = 84,
	},

	on_spawn = function ()
	minetest.chat_send_all ("Mese Lord has been awakened..")
	end,
	
	--- REFERENCIA DO MINECLONE2 BOSS :)
	on_die = function(self, pos) -- POSIÇÃO
	for _,players in pairs(minetest.get_objects_inside_radius(pos,55)) do -- CONSEGUIR RADIUS ( POSIÇÃO ,64 NODES?)
			if players:is_player() then -- SE PLAYER
				awards.unlock(players:get_player_name(), "boss_1") -- DESBLOQUEAR CONQUISTAS?
			end
		end
	end



})

if not mobs.custom_spawn_monster then

mobs:spawn({
	name = "meselord:meselord",
	nodes = {"air"},
	max_light = 7,
	interval = 60,
  chance = 150000,
	max_height = -400,
	min_height = -600,
})
end

-- ARROW -----------------------------------------------------------

mobs:register_arrow("meselord:meselord_arrow", {
	visual = "sprite",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"default_mese_crystal.png"},
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	velocity = 16,
	tail = 1,
	tail_texture = "default_mese_crystal.png",
	tail_size = 10,
	glow = 5,
	expire = 0.1,

	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,

	on_punch = function(self, hitter, tflp, tool_capabilities, dir)

		if hitter and hitter:is_player() and tool_capabilities and dir then

			local damage = tool_capabilities.damage_groups and
				tool_capabilities.damage_groups.fleshy or 1

			local tmp = tflp / (tool_capabilities.full_punch_interval or 1.4)

			if damage > 6 and tmp < 4 then

				self.object:set_velocity({
					x = dir.x * self.velocity,
					y = dir.y * self.velocity,
					z = dir.z * self.velocity,
				})
			end
		end
	end,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 0.5,
			damage_groups = {fleshy = 7},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 7},
		}, nil)
	end,


	on_spawn = function ()
	minetest.chat_send_all ("Mese Lord has been awakened...")
	end,

	hit_node = function(self, pos, node)
	end,
})





mobs:register_egg("meselord:meselord", "Mese Lord", "default_mese_block.png", 1)
--core.register_alias("meselord:meselord", "spawneggs:spectrum")
