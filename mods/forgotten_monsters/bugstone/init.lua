

local bugstone_types = {

	{	nodes = { "default:stone"},
		skins = {"dude_stone.png"},
		drops = {
			{name = "default:stone", chance = 1, min = 1, max = 4},

		},
	},

	{	nodes = {"default:desert_stone"},
		skins = {"dude_stone2.png"},
		drops = {
			{name = "default:desert_stone", chance = 1, min = 1, max = 4},

		},
	}
}


local bugstonenods = {
"default:stone",
"default:desert_stone",
}

-- BUG STONE

mobs:register_mob("bugstone:bugstone", {
	-- nametag = "Bug Stone" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 3,
	hp_min = 20,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.2, -0.4, -0.2, 0.2, 0.1, 0.01},
	visual = "mesh",
	mesh = "dude_stone.b3d",
	rotate = 180,
	textures = {
		{"dude_stone.png","dude_stone2.png"},
	},
	blood_texture = "faisca.png",
	makes_footstep_sound = true,
	sounds = {
		--attack = "",
		--death = "",
	},
	walk_velocity = 1,
	run_velocity = 5,
	jump_height = 1,
	stepheight = 1.1,
	floats = 0,
	view_range = 20,
	drops = {
		{name = "default:stone", chance = 2, min = 1, max = 1},

	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		walk_start = 15,
		walk_end = 33,
		run_start = 35,
		run_end = 43,
		punch_start = 45,
		punch_end = 53,
	},
})

if not mobs.custom_spawn_monster then

mobs:spawn({
	name = "bugstone:bugstone",
	nodes = bugstonenods,
	max_light = 7,
	chance = 8000,
	--min_height = 0,
	max_height = -10,
})

end




mobs:register_egg("bugstone:bugstone", "Bug Stone", "default_stone.png", 1)
core.register_alias("bugstone:bugstone", "spawneggs:bugstone")
