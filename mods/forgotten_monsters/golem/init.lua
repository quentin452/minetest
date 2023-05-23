---- GOLEM   ( BOSS 2 )------------------------------------------------------------------------------------------------------
-- sound : https://freesound.org/people/Debsound/sounds/250148/

mobs:register_mob("golem:golem", {
	nametag = "Golem Boss" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 6,
	damage = 12,
	hp_min = 500,
	hp_max = 500,
	armor = 80,
	collisionbox = {-1.0, -2.0, -1.0, 1.0, 1.2, 1.0},
	visual = "mesh",
	mesh = "golem.b3d",
	rotate = 180,
	textures = {
		{"golem.png"},
	},
	glow = 2,
	blood_texture = "faisca.png",
	makes_footstep_sound = true,
	sounds = {
		attack = "monster",
		--death = "",
	},
	walk_velocity = 2,
	run_velocity = 4,
	jump_height = 5,
	stepheight = 3.0,
	floats = 0,
	view_range = 35,
	drops = {
		--{name = " ", chance = 2, min = 1, max = 1},
		--{name = "skullkingsitems:golem_trophy", chance = 1, min = 1, max = 1},
		{name = "default:diamondblock", chance = 2, min = 1, max = 2},

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
		punch_start = 55,
		punch_end = 63,
	},

	on_spawn = function ()
	minetest.chat_send_all ("Golem Summoned ...")
	end,
	
	--- REFERENCIA DO MINECLONE2 BOSS :)
	on_die = function(self, pos) -- POSIÇÃO
	for _,players in pairs(minetest.get_objects_inside_radius(pos,55)) do -- CONSEGUIR RADIUS ( POSIÇÃO ,64 NODES?)
			if players:is_player() then -- SE PLAYER
				awards.unlock(players:get_player_name(), "boss_2") -- DESBLOQUEAR CONQUISTAS?
			end
		end
	end


})


mobs:spawn({
	name = "golem:golem",
	nodes = {"default:stone"},
	max_light = 7,
	interval = 60,
  chance = 150000,
	max_height = -700,
	min_height = -900,
})


mobs:register_egg("golem:golem", "Golem", "egggoelm.png", 1)
--core.register_alias("golem:golem", "spawneggs:golem")
