---- SKULL KING  ( BOSS FINAL ) ------------------------------------------------------------------------------------------------------
-- sound attack : https://freesound.org/people/TomRonaldmusic/sounds/607201/

mobs:register_mob("skullking:sking", {
	nametag = "Skull King Boss" ,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 8,
	damage = 15,
	hp_min = 700,
	hp_max = 700,
	armor = 80,
	visual_size = {x = 1.3, y = 1.3},
	collisionbox = {-0.5, -1.67, -0.4, 0.5, 2.3, 0.5},
	visual = "mesh",
	mesh = "skull_king_deep.b3d",
	rotate = 180,
	textures = {
		{"skull_king_deep.png"},
	},
	--glow = 4,
	blood_texture = "bonex.png",
	makes_footstep_sound = true,
	sounds = {
		attack = "skullking",
		death = "falling_bones",
	},
	walk_velocity = 2, --2
	run_velocity = 7,  --5
	jump_height = 3,   -- 8
	stepheight = 3,
	floats = 0,
	view_range = 35,
	drops = {
		{name = "skullkingsitems:helmet_skullking", chance = 1, min = 1, max = 1},
		{name = "skullkingsitems:hammer", chance = 1, min = 1, max = 1},
		--{name = "skullkingsitems:skullking_trophy", chance = 1, min = 1, max = 1},
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
		walk_end = 34,
		run_start = 35,
		run_end = 44,
		punch_start = 45,
		punch_end =84,
		punch_speed = 23,


	},

	on_spawn = function ()
	minetest.chat_send_all ("The Skull King is reborn...")
	end,
	
	--- REFERENCIA DO MINECLONE2 BOSS :)
	on_die = function(self, pos) -- POSIÇÃO
	for _,players in pairs(minetest.get_objects_inside_radius(pos,55)) do -- CONSEGUIR RADIUS ( POSIÇÃO ,64 NODES?)
			if players:is_player() then -- SE PLAYER
				awards.unlock(players:get_player_name(), "boss_3") -- DESBLOQUEAR CONQUISTAS?
			end
		end
	end


})


if not mobs.custom_spawn_monster then

mobs:spawn({
	name = "skullking:sking",
	nodes = {"default:cobble","default:mossycobble", "default:chest"},
	max_light = 7,
	interval = 60,
  chance = 150000,
	max_height = -1100,

})
end



mobs:register_egg("skullking:sking", "Skull King", "eggsking.png", 1)
--core.register_alias("skullking:sking", "spawneggs:sking")
