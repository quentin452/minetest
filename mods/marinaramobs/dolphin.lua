local S = minetest.get_translator("marinaramobs")
local random = math.random

mobs:register_mob("marinaramobs:dolphin", {
stepheight = 0.0,
	type = "animal",
	passive = true,
        attack_type = "dogfight",
	attack_animals = false,
	attack_npcs = false,
	attack_monsters = true,
        owner_loyal = true,
	reach = 1,
        damage = 4,
	hp_min = 65,
	hp_max = 145,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 0.5, 0.4},
	visual = "mesh",
	mesh = "Dolphin.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturedolphin.png"},
	},
	sounds = {
                random = "marinaramobs_dolphin",
		attack = "marinaramobs_dolphin2",
                damage = "marinaramobs_dolphin3",
		death = "marinaramobs_dolphin4",
	},
	makes_footstep_sound = false,
	walk_velocity = 3,
	run_velocity = 4,
	fly = true,
	fly_in = "default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing",
	fall_speed = 0,
	runaway = true,
        runaway_from = {"animalworld:bear", "animalworld:crocodile", "animalworld:tiger", "animalworld:spider", "animalworld:spidermale", "animalworld:shark", "animalworld:hyena", "animalworld:kobra", "animalworld:monitor", "animalworld:snowleopard", "animalworld:volverine", "livingfloatlands:deinotherium", "livingfloatlands:carnotaurus", "livingfloatlands:lycaenops", "livingfloatlands:smilodon", "livingfloatlands:tyrannosaurus", "livingfloatlands:velociraptor", "animalworld:divingbeetle", "animalworld:divingbeetle", "animalworld:scorpion", "animalworld:polarbear", "animalworld:leopardseal", "animalworld:stellerseagle", "animalworld:wolf", "animalworld:panda", "animalworld:stingray", "marinaramobs:jellyfish", "marinaramobs:octopus", "livingcavesmobs:biter", "livingcavesmobs:flesheatingbacteria"},
	jump = false,
	stepheight = 0.0,
        stay_near = {{"marinara:sand_with_alage", "marinara:sand_with_seagrass", "default:sand_with_kelp", "marinara:sand_with_kelp", "marinara:reed_root", "flowers:waterlily_waving", "naturalbiomes:waterlily", "default:clay", "marinara:softcoral_red", "marinara:softcoral_white", "marinara:softcoral_green", "marinara:softcoral_white", "marinara:softcoral_green", "default:coral_cyan", "default:coral_pink", "default:coral_green"}, 5},
        stay_near = {{"marinara:bountychest", "marinara:bountychest2", "marinara:bountychest3", "marinara:bountychest4", "marinara:bountychest5", "marinara:bountychest6", "marinara:bountychest7", "marinara:bountychest8", "marinara:bountychest9", "marinara:bountychest10", "marinara:bountychest11", "marinara:bountychest12"}, 6},
	drops = {
		{name = "mobs:meat", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
        air_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	view_range = 10,
	animation = {
		speed_normal = 50,
		stand_speed = 25,
		stand_start = 0,
		stand_end = 100,
		fly_start = 200, 
		fly_end = 300,
		fly2_start = 300, 
		fly2_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing"},
	floats = 0,
	follow = {
		"animalworld:rawmollusk", "marinaramobs:octopus_raw", "marinara:raw_oisters", "marinara:raw_athropod", "animalworld:rawfish", "fishing:fish_raw", "fishing:pike_raw", "marinaramobs:raw_exotic_fish", "nativevillages:catfish_raw", "xocean:fish_edible", "ethereal:fish_raw", "mobs:clownfish_raw", "fishing:bluewhite_raw", "fishing:exoticfish_raw", "fishing:fish_raw", "fishing:carp_raw", "fishing:perch_raw", "water_life:meat_raw", "fishing:shark_raw", "fishing:pike_raw"
	},

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 5, 15, false, nil) then return end
	end,
})


if not mobs.custom_spawn_marinaramobs then
mobs:spawn({
	name = "marinaramobs:dolphin",
	nodes = {"default:water_source"},
	neighbors = {"marinara:hardcoral_pink", "marinara:hardcoral_yellow"},
	min_light = 0,
	interval = 60,
	chance = 2, -- 15000
	active_object_count = 4,
	min_height = -30,
	max_height = 0,
	day_toggle = true,

		on_spawn = function(self, pos)

			local nods = minetest.find_nodes_in_area_under_air(
				{x = pos.x - 4, y = pos.y - 3, z = pos.z - 4},
				{x = pos.x + 4, y = pos.y + 3, z = pos.z + 4},
				{"default:water_source"})

			if nods and #nods > 0 then

				-- min herd of 4
				local iter = math.min(#nods, 3)

-- print("--- dolphin at", minetest.pos_to_string(pos), iter)

				for n = 1, iter do

					local pos2 = nods[random(#nods)]
					local kid = random(4) == 1 and true or nil

					pos2.y = pos2.y + 2

					if minetest.get_node(pos2).name == "air" then

						mobs:add_mob(pos2, {
							name = "marinaramobs:dolphin", child = kid})
					end
				end
			end
		end
	})
end

mobs:register_egg("marinaramobs:dolphin", S("Dolphin"), "adolphin.png")
