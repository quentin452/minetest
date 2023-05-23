-- SOUNDS :
-- https://freesound.org/people/MadamVicious/sounds/218185/
-- https://freesound.org/people/satchdev/sounds/325411/

mobs:register_mob("frostyqueen:frostyqueen", {
	nametag = "Frosty Queen Boss" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "shoot",
	shoot_interval = 15.0,
	shoot_offset = 1.5,
	arrow = "frostyqueen:spectrum_arrow",
	pathfinding = true,
	reach = 1,
	damage = 5,
	hp_min = 1600,
	hp_max = 1600,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "frostyqueen.b3d",
	rotate = 180,
	textures = {
		{"frostyqueen.png"},
	},
	glow = 8,
	blood_texture = "fqp.png",
	makes_footstep_sound = true,
	sounds = {
		random = "girlsmile",
		death = "gameover",
	},

	--fly = true ,
	--fly_in = "air",
	walk_velocity = 1,
	run_velocity = 5,
	jump_height = 1,
	stepheight = 1.1,
	floats = 0,
	view_range = 35,
	drops = {
		-- {name = "ebitems:frostyqueen_trophy", chance = 1, min = 1, max =1},
		{name = "ethereal:crystal_gilly_staff", chance = 3, min = 1, max =1},
		{name = "ethereal:crystal_ingot", chance = 1, min = 1, max =2},

	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,


	animation = {

		speed_run = 15,
		stand_start = 1,
		stand_end = 20,
		walk_start = 30,
		walk_end = 50,
		run_start = 30,
		run_end = 50,
		shoot_start =60,
		shoot_end = 90,
	},

	-- ESSA PARTE FOI RETIRADA DO MOD DE ENDERMAN DO MOBS MINECLONE :)
	do_custom = function(self, dtime)
		-- PARTICLE BEHAVIOUR HERE.
		local specpos = self.object:get_pos()
		local chanceOfParticle = math.random(0, 1)
		if chanceOfParticle == 1 then
			minetest.add_particle({
				pos = {x=specpos.x+math.random(-1,1)*math.random()/2,y=specpos.y+math.random(0,3),z=specpos.z+math.random(-1,1)*math.random()/2},
				velocity = {x=math.random(-.25,.25), y=math.random(-.25,.25), z=math.random(-.25,.25)},
				acceleration = {x=math.random(-.5,.5), y=math.random(-.5,.5), z=math.random(-.5,.5)},
				expirationtime = math.random(),
				size = math.random(),
				collisiondetection = true,
				vertical = false,
				texture = "fqp.png",
			})
			end
		end,
		
		
		on_die = function(self, pos) -- POSIÇÃO
		for _,players in pairs(minetest.get_objects_inside_radius(pos,55)) do -- CONSEGUIR RADIUS ( POSIÇÃO ,55 NODES?)
			if players:is_player() then -- SE PLAYER
				awards.unlock(players:get_player_name(), "frostyqueenboss") -- DESBLOQUEAR CONQUISTAS?
			end
			end
		end





})


if not mobs.custom_spawn_monster then
mobs:spawn({
	name = {"frostyqueen:frostyqueen","ethereal:gray_dirt"},
	nodes = {"ethereal:crystal","ethereal:frost_leaves"},
	max_light = 7,
	interval = 60,
  chance = 300000,
	max_height = 200,
})
end

-- ARROW -----------------------------------------------------------
mobs:register_arrow("frostyqueen:spectrum_arrow", {
	visual = "sprite",
	visual_size = {x = 0.5, y = 0.5},
	velocity = 18,
	textures = {"fqp.png"},
	tail = 1,
	tail_texture = "fqp.png",
	tail_size = 10,
	glow = 5,
	expire = 0.1,

--[[
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object,1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,
]]

	hit_node = function(self, pos) -- self e pos
	-- Ajuste de posição das caveiras apos ser adicinadas 
	local pos = {x = pos.x,z = pos.z,y =pos.y +2,}
	minetest.add_entity ( pos , "frozenskulls:frozenskulls")
	end
})





mobs:register_egg("frostyqueen:frostyqueen", "frostyqueen", "eggsfrostyqueen.png", 1)
--.register_alias("frostyqueen:frostyqueen", "spawneggs:frostyqueen")
