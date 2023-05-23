
-- sound : https://freesound.org/people/diakunik/sounds/556367/
-- Sound 2 : https://freesound.org/people/TyroneBarr/sounds/594063/


local spokynods = {
"default:dirt",
"default:dirt_with_rainforest_litter",
"default:dirt_with_grass",
"default:dirt_with_dry_grass",
"default:dry_dirt_with_dry_grass",
"default:dirt_with_coniferous_litter",
"default:stone",
"default:ice",
"default:snowblock",
"default:dirt_with_snow",
"default:sand",
"default:desert_sand",
"default:desert_stone",


}

mobs:register_mob("spoky:spoky", {
	--nametag = "Spoky" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "explode",
	explosion_radius = 2,
	explosion_timer = 3,
	pathfinding = true,
	reach = 3,
	damage = 19,
	hp_min = 15,
	hp_max = 15,
	armor = 100,
	-------- atras , abaixo , ... , direita , cima , frente
	collisionbox = {-0.5, -0.4, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "spokyx.b3d",
	rotate = 180,
	textures = {
		{"spokyx.png"},
	},
	blood_texture = "tnt_smoke.png",
	--visual_size = {x = 2, y = 2 },
	makes_footstep_sound = true,
	sounds = {
		-- random = "",
		-- attack = "",
		explode = "tnt_explode",
		fuse = "chaleira2",
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump_height = 1,
	stepheight = 1.1,
	floats = 0,
	view_range = 35,
	drops = {
		--{name = "default:torch", chance = 2, min = 3, max = 5},
	--	{name = "default:iron_lump", chance = 5, min = 1, max = 2},
		{name = "default:coal_lump", chance = 1, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		stand_start = 0,
		stand_end = 0,
		speed_normal = 20,
		speed_run = 20,
		walk_start = 20,
		walk_end = 39,
		run_start = 20,
		run_end = 39,
		punch_start = 0,
		punch_end = 0,

	},
})

if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "spoky:spoky",
	nodes = spokynods,
	min_light = 0,
	max_light = 14,
	interval = 60,
	chance = 15000,
	--min_height = 0,
	--max_height = 200,
	max_height = 200,

})
end

mobs:register_egg("spoky:spoky", "spoky", "eggsspoky.png", 1)
--core.register_alias("spoky:spoky", "spawneggs:spoky")
