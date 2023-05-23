local zombienods = {
"default:dirt",
"default:dirt_with_rainforest",
"default:dirt_with_grass",
"default:dirt_with_dry_grass",
"default:dry_dirt_with_dry_grass",
"default:dirt_with_coniferous_litter",
"default:stone",
"default:ice",
"default:snowblock",
"default:dirt_with_snow",
"default:desert_sand",
"default:desert_stone",
"default:stone",
"default:desert_stone",
"default:ice",
"nodex:road",
"nodex:road2",
"nodex:road3",
}


 function poison_part (pos)  --- PARTICULAS

   minetest.add_particlespawner({
		amount = 5,
		time = 0.1,
		minpos = pos,
		maxpos = pos,
		minvel = {x = dir.x - 1, y = dir.y, z = dir.z - 1},
		maxvel = {x = dir.x + 1, y = dir.y, z = dir.z + 1},
		minacc = {x = 0, y = -5, z = 0},
		maxacc = {x = 0, y = -9, z = 0},
		minexptime = 1,
		maxexptime = 1,
		minsize = 1,
		maxsize = 2,
		texture = "stamina_poison_particle.png"
	})

	
end

----- ACID =====================================================================

--- Particules :
--[[

 function gas(pos)  --- PARTICULAS

        minetest.add_particlespawner({
        amount = 5, --- quantidade
        time = 2, -- intervalo de tempo
        minpos = {x = pos.x,z = pos.z,y =pos.y},
        maxpos = {x = pos.x,z = pos.z,y =pos.y+1},
        minvel = {x=0, y=0.1, z=-0},
        maxvel = {x=-0, y=0.1, z=0},
        minacc = {x=0, y=0.5, z=-0},
        maxacc = {x=-0, y=0.5, z=0},
        minexptime = 1,
        maxexptime = 1,
        minsize = 3,
        maxsize = 3,
        collisiondetection = false,
        vertical = false,
        texture = "gas.png",
   	 })

end


minetest.register_node("spitterzombie:acid", {
	description = "Acid",
	drawtype = "glasslike",
	visual_scale = 2.0,
	tiles = {"acid.png"},
	inventory_image = "acid.png",
	paramtype = "light",
	sunlight_propagates = true,
	use_texture_alpha = "blend",
	post_effect_color = {a = 100, r = 59, g = 144, b = 79},
	pointable = false, -- apontavel
	diggable = false, -- cavavel
	liquid_viscosity = 11,
	liquidtype = "source",
	liquid_alternative_flowing = "spitterzombie:acid",
	liquid_alternative_source = "spitterzombie:acid",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	damage_per_second = 2, -- dano
	groups = {snappy = 1, disable_jump = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function (pos, node) -- conseguir tempo do node
           minetest.get_node_timer(pos):start(5)
           gas(pos)
   	end,

   	 on_timer = function(pos,node,elapsed) -- após o tempo, o no pode ser trocado por ar
   	 minetest.swap_node(pos, {name = 'air'})
 	 end,
})

]]

---- VOMITER ZOMBIE ============================================================

mobs:register_mob("spitterzombie:spitterzombie", {
	--nametag = "Spitter Zombie" ,
	type = "monster",
	passive = false,
	attack_type = "dogshoot",
	attack_npcs = false,
	--attack_animals = true,
	--group_attack = true,
	shoot_interval = 4.5,
	arrow = "spitterzombie:spitter_arrow",
	shoot_offset = 1,
	pathfinding = true,
	reach = 3,
	damage = 6,
	hp_min = 100,
	hp_max = 100,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	mesh = "fatzombie.b3d",
	--rotate = 180,
	textures = {
		{"fatzombie.png"},
		--{"walkingzombie.png"},

	},
	--glow = 4,
	--blood_texture = " ",
	makes_footstep_sound = true,
	sounds = {
	       -- random ="zombie_angry",
		--attack = "zombie_hit",
		death = "zombie_death ",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump_height = 2,
	stepheight = 1.1,
	floats = 0,
	view_range = 35,
	drops = {
		--{name = "", chance = 2, min = 1, max = 1},
		{name = "foodx:canned_tomato", chance = 2, min = 1, max = 1},
		{name = "foodx:chocolate_bar", chance = 4, min = 1, max = 1},
		

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
		shoot_start =340,
		shoot_end = 380,
	},
})


mobs:register_arrow("spitterzombie:spitter_arrow", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"gas.png"},

	velocity = 30,--6


	hit_player = function(self, player)
		-- Quando estar de armadura , o escudo bloquei parte do dano causado por evenenamento

		 minetest.chat_send_player(player:get_player_name(), "You are poisoned!") -- msg para p player
 
		local count = 15 -- Contagem de tempo do dano era 15
		local delay = 1 -- Intervaloe entre danos

		local function countdown()
			if count > 0 then -- Se o contador ainda não chegou a 0

			---------- PARTICULAS :
				    local pos = player:get_pos()
				    local dir = player:get_look_dir()  -- direção em que o jogador está olhando
				    local distance = 1  -- distância a partir da cabeça do jogador
				    local front_player = {
				    x = pos.x + (dir.x * distance),
				    y = pos.y + (dir.y * distance) + 1.5, -- altura da cabeça do jogador
				    z = pos.z + (dir.z * distance)
				    }

				    minetest.add_particlespawner({
				        amount = 3, -- quantidade de particulas
				        time = 2, -- quanto tempo geradas
				        minpos = front_player,
				        maxpos = front_player,
				        minvel = {x = -0.1, y = 0.1, z = -0.1}, -- velocidade das particulas
				        maxvel = {x = 0.1, y = 0.3, z = 0.1},
				        minacc = {x = 0, y = -0.1, z = 0}, -- acelaração das particulas , direção
				        maxacc = {x = 0, y = -0.2, z = 0},
				        minexptime = 0, -- tempo de vida da particula
				        maxexptime = 0.5, -- tempo de vida da particula
				        minsize = 1,
				        maxsize = 2,
				        collisiondetection = true,
				        collision_removal = true,
				        object_collision = false,
				        vertical = false,
				        texture = "poison_particle.png",
				    })

				--- DANO :
				player:set_hp(player:get_hp() - 1)
				count = count - 1 -- Decrementar o contador
				minetest.after(delay, countdown) -- Chamar a função novamente após um atraso

			--else 
			end
		end
		
		minetest.after(delay, countdown) -- Iniciar a contagem regressiva


	end,



--	hit_mob = function(self, player)
--		player:punch(self.object, 1.0, {
--			full_punch_interval = 1.0,
--			damage_groups = {fleshy = 2},
--		}, nil)
--	end,

hit_node = function(self, pos)
	--local pn = {x = pos.x,z = pos.z,y =pos.y}
	--minetest.set_node(pn, {name = "spitterzombie:acid"})
end

})




mobs:spawn({
	name = "spitterzombie:spitterzombie",
	nodes = hunternods,
	min_light = 0,
	max_light = 7, -- 14
	chance = 7000,
	min_height = -20000,
	max_height = 200,
	--max_height = 200,
	active_object_count = 6,
})


mobs:register_egg("spitterzombie:spitterzombie", "Spitter Zombie", "zombies_egg.png", 0)
