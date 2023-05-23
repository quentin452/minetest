
-- Sound :
-- https://freesound.org/people/missozzy/sounds/169985/
-- https://freesound.org/people/zglar/sounds/232289/

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

---- SKULL SWORD  ------------------------------------------------------------------------------------------------------

mobs:register_mob("tankzombie:tankzombie", {
	--nametag = "Tank Zombie" ,
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	--attack_animals = true,
	pathfinding = 1,
	reach = 5,
	damage = 12,
	hp_min = 250,
	hp_max = 250,
	armor = 60,
	collisionbox = {-0.4, 0, -0.4, 0.4, 3.0, 0.4},
	visual = "mesh",
	mesh = "ztank.b3d",
	visual_size = {x=12, y=12},
	--rotate = 180,
	textures = {
		{"tankzombiex.png"},
		--{""},
		
	},
	--glow = 4,
	--blood_texture = " ",
	makes_footstep_sound = true,
	sounds = {
		random ="missozzy",
		--attack = "zombie_hit",
		death = "roar ",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump_height = 7,
	stepheight = 1.7,
	floats = 0,
	view_range = 35,
	drops = {
		
		{name = "default:diamondblock", chance = 2, min = 1, max = 1},
		
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	immune_to = {
	
	{"fortification:wirefence",  -10} ,
	{"fortification:barbed_wire",  -10} ,
	{"fortification:punji_sticks",  -10} ,
	
	},
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 100,
		walk_end = 180,
		run_speed = 45,
		run_start = 100,
		run_end = 180,
		punch_speed = 25,
		punch_start = 200,
		punch_end = 250,
		die_speed = 15,
		die_start = 260,
		die_end = 399,
				
	},

	
		on_spawn = function(self)
        --local pos = self.object:get_pos()
        -- Adicionar animação
        self.object:set_animation({x=430, y=490},30, 0, false)

        -- Pós animação
		minetest.after(3, function()
			mobs:set_animation(self, "walk")
        end)
    end,
	
	
	--[[
	on_die = function(self, pos) -- POSIÇÃO

  self.object:set_animation({x=260, y=380}, 20, 0)
	for _,players in pairs(minetest.get_objects_inside_radius(pos,64)) do -- CONSEGUIR RADIUS ( POSIÇÃO ,64 NODES?)
			if players:is_player() then -- SE PLAYER
				awards.unlock(players:get_player_name(), "tank") -- DESBLOQUEAR CONQUISTAS?
			end
		end
	end
	--custom_attack = function()	
	--end,

	]]


})

-- ADICIONANDO ATAQUE QUE MUDA O POSIÇÃO
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir)
  if hitter:get_luaentity().name == "tankzombie:tankzombie" then
    player:set_pos({x=player:get_pos().x+5,y=player:get_pos().y+5,z=player:get_pos().z})
  end
end)




mobs:spawn({
	name = "tankzombie:tankzombie",
	nodes = hunternods,
	min_light = 0,
	max_light = 7, -- 14
	chance = 16000,
	min_height = 0,
	max_height = 200,
	--max_height = 200,
	active_object_count =1,
})


mobs:register_egg("tankzombie:tankzombie", "Tank Zombie", "zombies_egg.png", 0)








