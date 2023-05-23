local zombienods = {

"default:dirt_with_grass",
"default:stone",
"default:stone", 
"default:desert_stone",
"default:mossycobble", 


} 

mobs:register_mob("minerzombie:minerzombie", {
	--nametag = "Miner Zombie" ,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	pathfinding = true,
	attack_npcs = false,
	reach = 3,
	damage = 3,
	hp_min = 20,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	mesh = "walkingzombie.b3d",
	--rotate = 180,
	textures = {
		{"minerzombie.png"},
	},
	--glow = 4,
	--blood_texture = " ",
	makes_footstep_sound = true,
	sounds = {
		random ="zombie_angry",
		--attack = "zombie_hit",
		death = "zombie_death ",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump_height = 2,
	stepheight = 1.5,
	floats = 0,
	view_range = 35,
	drops = {
		
		{name = "default:coal 3", chance = 3, min = 1, max = 1},
		{name = "default:torch 1", chance = 4, min = 1, max = 1},
		{name = "default:pick_steel", chance = 5, min = 1, max = 1},
		
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 100,
		walk_end = 180,
		run_start = 200,
		run_end = 240,
		punch_start = 200,
		punch_end = 240,
		die_start = 280,
		die_end = 300,
	},

--[[	
on_die = function(self, pos) 
	
	end
	]]
})



mobs:spawn({
	name = "minerzombie:minerzombie",
	nodes = hunternods,
	min_light = 0,
	max_light = 8,
	chance = 7000,
	--min_height = -29000,
	max_height = -20,
	--max_height = 200,
	active_object_count = 5,
})


mobs:register_egg("minerzombie:minerzombie", "Miner Zombie", "zombies_egg.png", 0)








