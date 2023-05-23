-- SOUNDS LINK :
-- Bones : https://freesound.org/people/spookymodem/sounds/202091/
-- sword : https://freesound.org/people/Merrick079/sounds/568169/


---- SKULL SWORD  ------------------------------------------------------------------------------------------------------


mobs:register_mob("frozenskulls:frozenskulls", {
	--nametag = "Frozen Skulls" ,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 3,
	damage = 15,
	hp_min = 80,
	hp_max = 80,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "skull_sword.b3d",
	rotate = 180,
	textures = {
		{"skull_sword_crystal.png"},
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
	view_range = 45,
	drops = {
		--{name = "", chance = 2, min = 1, max = 1},
		--{name = "", chance = 5, min = 1, max = 1},
		--{name = "", chance = 3, min = 1, max = 1},
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


--[[
mobs:spawn({
	name = "frozenskulls:frozenskulls",
	nodes = skullnods,
	min_light = 0,
	max_light = 14,
	chance = 6000,
	--min_height = 0,
	--max_height = 200,
	max_height = 200,
})
]]

mobs:register_egg("frozenskulls:frozenskulls", "Frozen Skulls", "eggsskullfrozen.png", 1)
--core.register_alias("frozenskulls:frozenskulls", "spawneggs:frozenskulls")
