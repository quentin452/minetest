
-- sound : https://freesound.org/people/Legnalegna55/sounds/547558/


mobs:register_mob("spectrum:spectrum", {
	--nametag = "Spectrum" ,
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "shoot",
	shoot_interval = 2.0,
	shoot_offset = 1.5,
	arrow = "spectrum:spectrum_arrow",
	pathfinding = true,
	reach = 3,
	damage = 6,
	hp_min = 80,
	hp_max = 80,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "spectrum.b3d",
	rotate = 180,
	textures = {
		{"spectrum.png"},
	},
	glow = 8,
	blood_texture = "blood_spectrum.png",
	sounds = {
		random = "spectrum",
	},

	fly = true ,
	fly_in = "air",
	walk_velocity = 1,
	run_velocity = 5,
	jump_height = 1,
	stepheight = 1.1,
	floats = 0,
	view_range = 25,
	drops = {
		{name = "spectrum:spectrum_orb", chance = 2, min = 1, max =1},

	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,


	animation = {

		speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		walk_start = 15,
		walk_end = 33,
		run_start = 35,
		run_end = 53,
		shoot_start = 55,
		shoot_end = 84,
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
				texture = "pectrum_arrow.png",
			})
			end
		end,





})


if not mobs.custom_spawn_monster then

mobs:spawn({
	name = "spectrum:spectrum",
	nodes = {"air"},
	max_light = 7,
	interval = 60,
	chance = 60000,
	max_height = 200,
	active_object_count = 1,
})
end


-- ARROW -----------------------------------------------------------
mobs:register_arrow("spectrum:spectrum_arrow", {
	visual = "sprite",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"pectrum_arrow.png"},
	velocity = 18,
	glow = 5,


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

	hit_node = function(self, pos, node)
	end
})





mobs:register_egg("spectrum:spectrum", "Spectrum", "eggspec.png", 1)
--core.register_alias("spectrum:spectrum", "spawneggs:spectrum")




-- SPECTRUM ORB

minetest.register_craftitem("spectrum:spectrum_orb", {
    description = "Spectrum Orb",
    inventory_image = "spectrum_orb.png",
    light_source = 3,
})


-- SPECTRUM ORB BLOCK :

minetest.register_node("spectrum:spectrum_orb_block", {
	description = "Spectrum Orb Block",
	groups = {cracky = 2},
	drop = "spectrum:spectrum_orb_block",
	light_source = 6,
        sounds = default.node_sound_stone_defaults(),
	tiles = {{
		name = "anim_orb_block.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2}
	},
	},

})

minetest.register_craft({
	output = "spectrum:spectrum_orb_block",
	recipe = {
		{"spectrum:spectrum_orb", "spectrum:spectrum_orb", "spectrum:spectrum_orb"},
		{"spectrum:spectrum_orb", "spectrum:spectrum_orb", "spectrum:spectrum_orb"},
		{"spectrum:spectrum_orb", "spectrum:spectrum_orb", "spectrum:spectrum_orb"},
	}
})




-- COMPATIBILIDADE COM : Mirror of Returning (BY : Wuzzy )
if minetest.get_modpath("returnmirror") then

minetest.register_craft({
    output = "returnmirror:mirror_inactive ",
    recipe = {
		{"default:gold_ingot", "spectrum:spectrum_orb", "default:gold_ingot"},
		{"spectrum:spectrum_orb", "default:glass", "spectrum:spectrum_orb"},
		{"", "spectrum:spectrum_orb", ""},
	},
})

end
