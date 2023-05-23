
mobs:register_mob("hungry:hungry", {
	--nametag = "Hungry" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 5,
	damage = 8,
	hp_min = 120,
	hp_max = 120,
	armor = 80,
	--  , chao ,  ,  , tag ,
	collisionbox = {-0.4, -1.0, -0.4, 0.4, 1.3, 0.5},
	visual = "mesh",
	rotate = 180,
	mesh = "hungry.b3d",
	textures = {
		{"hungry.png"},
	},
	blood_texture = "folha.png",
	makes_footstep_sound = true,
	sounds = {

		--attack = "",
		--death = "",
	},
	walk_velocity =0,
	run_velocity = 0,
	jump_height = 0,
	stepheight = 1.1,
	floats = 0,
	view_range = 20,
	drops = {
		{name = "hungry:hungry_sheet", chance = 1, min = 4, max = 4},

	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
	speed_normal = 15,
		speed_run = 0,
		stand_start = 0,
		stand_end = 0,
		--walk_start = 15,
		--walk_end = 33,
		--run_start = 35,
		--run_end = 53,
		punch_start = 15,
		punch_end = 34,
	},
})

if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "hungry:hungry",
	nodes = {"default:dirt_with_grass","default:dirt_with_rainforest_litter"},
	min_light = 14,
	--interval = 30, -- 60
	chance = 9000,
	min_height = 0,
	max_height = 200,
})
end

mobs:register_egg("hungry:hungry", "Hungry", "hungryegg.png", 1)
core.register_alias("hungry:hungry", "spawneggs:hungry")





-- FOLHA :

minetest.register_craftitem("hungry:hungry_sheet", {
    description = "Hungry Sheet",
    inventory_image = "folha.png",


})
