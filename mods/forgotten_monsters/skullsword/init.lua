-- SOUNDS LINK :
-- Bones : https://freesound.org/people/spookymodem/sounds/202091/
-- sword : https://freesound.org/people/Merrick079/sounds/568169/



local skullnods = {
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
"default:stone",
"default:desert_stone",
--"default:cobble",
"default:mossycobble",
"default:chest",
"default:ice",

}


---- SKULL SWORD  ------------------------------------------------------------------------------------------------------

mobs:register_mob("skullsword:ssword", {
	--nametag = "Skull Sword" ,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 3,
	damage = 5,
	hp_min = 15,
	hp_max = 15,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "skull_sword.b3d",
	rotate = 180,
	textures = {
		{"skull_sword.png"},
	},
	--glow = 4,
	blood_texture = "bonex.png",
	makes_footstep_sound = true,
	sounds = {
		attack = "sword",
		death = "falling_bones",
	},
	walk_velocity = 1,
	run_velocity = 5,
	jump_height = 2,
	stepheight = 1.1,
	floats = 0,
	view_range = 25,
	drops = {
		{name = "skullkingsitems:bone", chance = 2, min = 1, max = 1},
		{name = "default:sword_stone", chance = 5, min = 1, max = 1},
		{name = "default:iron_lump", chance = 3, min = 1, max = 1},
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
		run_end = 53,
		--punch_start = 40,
		--punch_end = 63,
	},
})


if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "skullsword:ssword",
	nodes = skullnods,
	min_light = 0,
	max_light = 14,
	chance = 7000,
	--min_height = 0,
	--max_height = 200,
	max_height = 200,
})
end

mobs:register_egg("skullsword:ssword", "Skull Sword", "eggsskullsword.png", 1)
core.register_alias("skullsword:ssword", "spawneggs:ssword")
