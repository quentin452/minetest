-- SOUND :
-- https://freesound.org/people/NicknameLarry/sounds/489901/

mobs:register_mob("heated:heated", {

	nametag = "Heated Boss" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 8,
	damage = 20,
	hp_min = 1400,
	hp_max = 1400,
	armor = 80,
	collisionbox = {-1.0, -1.5, -1.0, 1.0, 2.0, 1.0},
	visual = "mesh",
	mesh = "heated.b3d",
	rotate = 180,
	textures = {
		{"heated.png"},
	},
	glow = 2,
	blood_texture = "default_obsidian_shard.png",
	makes_footstep_sound = true,
	sounds = {
		random = "monsterhot",
		--attack = "monster",
		--death = "",
	},

	fly = true ,
	fly_in = "air",
	walk_velocity = 2,
	run_velocity = 4,
	jump_height = 2,
	stepheight = 3.0,
	floats = 0,
	view_range = 35,
	drops = {
		{name = "ebitems:sword_obsidian", chance = 1, min = 1, max = 1},
		--{name = "ebitems:heated_trophy", chance = 1, min = 1, max = 1},
		--{name = "", chance = 2, min = 1, max = 2},

	},
	water_damage = 1,
	lava_damage = 0,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 30,
		speed_punch = 50,
		stand_start = 1,
		stand_end = 20,
		walk_start = 30,
		walk_end = 70,
		run_start = 80,
		run_end = 100,
		punch_start = 110,
		punch_end = 130,
	},
	
	--- REFERENCIA DO MINECLONE2 BOSS?
	on_die = function(self, pos) -- POSIÇÃO
	for _,players in pairs(minetest.get_objects_inside_radius(pos,55)) do -- CONSEGUIR RADIUS ( POSIÇÃO ,55 NODES?)
			if players:is_player() then -- SE PLAYER
				awards.unlock(players:get_player_name(), "heatedboss") -- DESBLOQUEAR CONQUISTAS?
			end
		end
	end



})

if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "heated:heated",
	nodes = {"ethereal:fiery_dirt"},
	max_light = 7,
	interval = 60,
  chance = 300000,
	max_height = 200,
	min_height = 0,
})
end

mobs:register_egg("heated:heated", "heated", "eggsheated.png", 1)
core.register_alias("heated:heated", "spawneggs:heated")
mobs:alias_mob("heated:heated", "mobs:heated") -- compatibility
