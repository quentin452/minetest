local S = minetest.get_translator("livingfloatlands")

local modname = "livingfloatlands"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

doors.register_trapdoor("livingfloatlands:clubmoss_trapdoor", {
	description = S"Clubmoss Trapdoor",
	inventory_image = "livingfloatlands_clubmoss_trapdoor.png",
	wield_image = "livingfloatlands_clubmoss_trapdoor.png",
	tile_front = "livingfloatlands_clubmoss_trapdoor.png",
	tile_side = "livingfloatlands_clubmoss_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:clubmoss_trapdoor 2",
	recipe = {
		{"livingfloatlands:paleojungle_clubmoss_wood", "livingfloatlands:paleojungle_clubmoss_wood", "livingfloatlands:paleojungle_clubmoss_wood"},
		{"livingfloatlands:paleojungle_clubmoss_wood", "livingfloatlands:paleojungle_clubmoss_trunk", "livingfloatlands:paleojungle_clubmoss_wood"},
	}
})

doors.register("livingfloatlands_clubmoss_door", {
    tiles = {{ name = "livingfloatlands_clubmoss_door.png", backface_culling = true }},
    description = S"Clubmoss Door",
    inventory_image = "livingfloatlands_item_clubmoss_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:paleojungle_clubmoss_wood", "livingfloatlands:paleojungle_clubmoss_wood"},
		{"livingfloatlands:paleojungle_clubmoss_trunk", "livingfloatlands:paleojungle_clubmoss_trunk"},
		{"livingfloatlands:paleojungle_clubmoss_wood", "livingfloatlands:paleojungle_clubmoss_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:coldsteppe_trapdoor", {
	description = S"Red Pine Trapdoor",
	inventory_image = "livingfloatlands_coldsteppe1_trapdoor.png",
	wield_image = "livingfloatlands_coldsteppe1_trapdoor.png",
	tile_front = "livingfloatlands_coldsteppe1_trapdoor.png",
	tile_side = "livingfloatlands_coldsteppe1_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe_trapdoor 2",
	recipe = {
		{"livingfloatlands:coldsteppe_pine_wood", "livingfloatlands:coldsteppe_pine_wood", "livingfloatlands:coldsteppe_pine_wood"},
		{"livingfloatlands:coldsteppe_pine_wood", "livingfloatlands:coldsteppe_pine_trunk", "livingfloatlands:coldsteppe_pine_wood"},
	}
})

doors.register("livingfloatlands_coldsteppe_door", {
    tiles = {{ name = "livingfloatlands_coldsteppe1_door.png", backface_culling = true }},
    description = S"Red Pine Door",
    inventory_image = "livingfloatlands_item_coldsteppe1_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:coldsteppe_pine_wood", "livingfloatlands:coldsteppe_pine_wood"},
		{"livingfloatlands:coldsteppe_pine_trunk", "livingfloatlands:coldsteppe_pine_trunk"},
		{"livingfloatlands:coldsteppe_pine_wood", "livingfloatlands:coldsteppe_pine_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:coldsteppe2_trapdoor", {
	description = S"Norway Spruce Trapdoor",
	inventory_image = "livingfloatlands_coldsteppe2_trapdoor.png",
	wield_image = "livingfloatlands_coldsteppe2_trapdoor.png",
	tile_front = "livingfloatlands_coldsteppe2_trapdoor.png",
	tile_side = "livingfloatlands_coldsteppe2_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe2_trapdoor 2",
	recipe = {
		{"livingfloatlands:coldsteppe_pine2_wood", "livingfloatlands:coldsteppe_pine2_wood", "livingfloatlands:coldsteppe_pine2_wood"},
		{"livingfloatlands:coldsteppe_pine2_wood", "livingfloatlands:coldsteppe_pine2_trunk", "livingfloatlands:coldsteppe_pine2_wood"},
	}
})

doors.register("livingfloatlands_coldsteppe2_door", {
    tiles = {{ name = "livingfloatlands_coldsteppe2_door.png", backface_culling = true }},
    description = S"Norway Spruce Door",
    inventory_image = "livingfloatlands_item_coldsteppe2_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:coldsteppe_pine2_wood", "livingfloatlands:coldsteppe_pine2_wood"},
		{"livingfloatlands:coldsteppe_pine2_trunk", "livingfloatlands:coldsteppe_pine2_trunk"},
		{"livingfloatlands:coldsteppe_pine2_wood", "livingfloatlands:coldsteppe_pine2_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:coldsteppe3_trapdoor", {
	description = S"Siberian Larix Trapdoor",
	inventory_image = "livingfloatlands_coldsteppe3_trapdoor.png",
	wield_image = "livingfloatlands_coldsteppe3_trapdoor.png",
	tile_front = "livingfloatlands_coldsteppe3_trapdoor.png",
	tile_side = "livingfloatlands_coldsteppe3_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:coldsteppe3_trapdoor 2",
	recipe = {
		{"livingfloatlands:coldsteppe_pine3_wood", "livingfloatlands:coldsteppe_pine3_wood", "livingfloatlands:coldsteppe_pine3_wood"},
		{"livingfloatlands:coldsteppe_pine3_wood", "livingfloatlands:coldsteppe_pine3_trunk", "livingfloatlands:coldsteppe_pine3_wood"},
	}
})

doors.register("livingfloatlands_coldsteppe3_door", {
    tiles = {{ name = "livingfloatlands_coldsteppe3_door.png", backface_culling = true }},
    description = S"Siberian Larix Door",
    inventory_image = "livingfloatlands_item_coldsteppe3_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:coldsteppe_pine3_wood", "livingfloatlands:coldsteppe_pine3_wood"},
		{"livingfloatlands:coldsteppe_pine3_trunk", "livingfloatlands:coldsteppe_pine3_trunk"},
		{"livingfloatlands:coldsteppe_pine3_wood", "livingfloatlands:coldsteppe_pine3_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:conifere_trapdoor", {
	description = S"Conifere Trapdoor",
	inventory_image = "livingfloatlands_conifere_trapdoor.png",
	wield_image = "livingfloatlands_conifere_trapdoor.png",
	tile_front = "livingfloatlands_conifere_trapdoor.png",
	tile_side = "livingfloatlands_conifere_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:conifere_trapdoor 2",
	recipe = {
		{"livingfloatlands:paleojungle_conifere_wood", "livingfloatlands:paleojungle_conifere_wood", "livingfloatlands:paleojungle_conifere_wood"},
		{"livingfloatlands:paleojungle_conifere_wood", "livingfloatlands:paleojungle_conifere_trunk", "livingfloatlands:paleojungle_conifere_wood"},
	}
})

doors.register("livingfloatlands_conifere_door", {
    tiles = {{ name = "livingfloatlands_conifere_door.png", backface_culling = true }},
    description = S"Conifere Door",
    inventory_image = "livingfloatlands_item_conifere_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:paleojungle_conifere_wood", "livingfloatlands:paleojungle_conifere_wood"},
		{"livingfloatlands:paleojungle_conifere_trunk", "livingfloatlands:paleojungle_conifere_trunk"},
		{"livingfloatlands:paleojungle_conifere_wood", "livingfloatlands:paleojungle_conifere_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:joshua_trapdoor", {
	description = S"Joshua Trapdoor",
	inventory_image = "livingfloatlands_joshua_trapdoor.png",
	wield_image = "livingfloatlands_joshua_trapdoor.png",
	tile_front = "livingfloatlands_joshua_trapdoor.png",
	tile_side = "livingfloatlands_joshua_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:joshua_trapdoor 2",
	recipe = {
		{"livingfloatlands:paleodesert_joshua_wood", "livingfloatlands:paleodesert_joshua_wood", "livingfloatlands:paleodesert_joshua_wood"},
		{"livingfloatlands:paleodesert_joshua_wood", "livingfloatlands:paleodesert_joshua_trunk", "livingfloatlands:paleodesert_joshua_wood"},
	}
})

doors.register("livingfloatlands_joshua_door", {
    tiles = {{ name = "livingfloatlands_joshua_door.png", backface_culling = true }},
    description = S"Joshua Door",
    inventory_image = "livingfloatlands_item_joshua_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:paleodesert_joshua_wood", "livingfloatlands:paleodesert_joshua_wood"},
		{"livingfloatlands:paleodesert_joshua_trunk", "livingfloatlands:paleodesert_joshua_trunk"},
		{"livingfloatlands:paleodesert_joshua_wood", "livingfloatlands:paleodesert_joshua_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:paleooak_trapdoor", {
	description = S"Paleo Oak Trapdoor",
	inventory_image = "livingfloatlands_paleooak_trapdoor.png",
	wield_image = "livingfloatlands_paleooak_trapdoor.png",
	tile_front = "livingfloatlands_paleooak_trapdoor.png",
	tile_side = "livingfloatlands_paleooak_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:paleooak_trapdoor 2",
	recipe = {
		{"livingfloatlands:giantforest_paleooak_wood", "livingfloatlands:giantforest_paleooak_wood", "livingfloatlands:giantforest_paleooak_wood"},
		{"livingfloatlands:giantforest_paleooak_wood", "livingfloatlands:giantforest_paleooak_trunk", "livingfloatlands:giantforest_paleooak_wood"},
	}
})

doors.register("livingfloatlands_paleooak_door", {
    tiles = {{ name = "livingfloatlands_paleooak_door.png", backface_culling = true }},
    description = S"Paleo Oak Door",
    inventory_image = "livingfloatlands_item_paleooak_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:giantforest_paleooak_wood", "livingfloatlands:giantforest_paleooak_wood"},
		{"livingfloatlands:giantforest_paleooak_trunk", "livingfloatlands:giantforest_paleooak_trunk"},
		{"livingfloatlands:giantforest_paleooak_wood", "livingfloatlands:giantforest_paleooak_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:paleopalm_trapdoor", {
	description = S"Paleo Palm Trapdoor",
	inventory_image = "livingfloatlands_paleopalm_trapdoor.png",
	wield_image = "livingfloatlands_paleopalm_trapdoor.png",
	tile_front = "livingfloatlands_paleopalm_trapdoor.png",
	tile_side = "livingfloatlands_paleopalm_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:paleopalm_trapdoor 2",
	recipe = {
		{"livingfloatlands:paleojungle_paleopalm_wood", "livingfloatlands:paleojungle_paleopalm_wood", "livingfloatlands:paleojungle_paleopalm_wood"},
		{"livingfloatlands:paleojungle_paleopalm_wood", "livingfloatlands:paleojungle_paleopalm_trunk", "livingfloatlands:paleojungle_paleopalm_wood"},
	}
})

doors.register("livingfloatlands_paleopalm_door", {
    tiles = {{ name = "livingfloatlands_paleopalm_door.png", backface_culling = true }},
    description = S"Paleo Palm Door",
    inventory_image = "livingfloatlands_item_paleopalm_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:paleojungle_paleopalm_wood", "livingfloatlands:paleojungle_paleopalm_wood"},
		{"livingfloatlands:paleojungle_paleopalm_trunk", "livingfloatlands:paleojungle_paleopalm_trunk"},
		{"livingfloatlands:paleojungle_paleopalm_wood", "livingfloatlands:paleojungle_paleopalm_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:paleopine_trapdoor", {
	description = S"Paleo Pine Trapdoor",
	inventory_image = "livingfloatlands_paleopine_trapdoor.png",
	wield_image = "livingfloatlands_paleopine_trapdoor.png",
	tile_front = "livingfloatlands_paleopine_trapdoor.png",
	tile_side = "livingfloatlands_paleopine_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:paleopine_trapdoor 2",
	recipe = {
		{"livingfloatlands:paleodesert_paleopine_wood", "livingfloatlands:paleodesert_paleopine_wood", "livingfloatlands:paleodesert_paleopine_wood"},
		{"livingfloatlands:paleodesert_paleopine_wood", "livingfloatlands:paleodesert_paleopine_trunk", "livingfloatlands:paleodesert_paleopine_wood"},
	}
})

doors.register("livingfloatlands_paleopine_door", {
    tiles = {{ name = "livingfloatlands_paleopine_door.png", backface_culling = true }},
    description = S"Paleo Pine Door",
    inventory_image = "livingfloatlands_item_paleopine_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:paleodesert_paleopine_wood", "livingfloatlands:paleodesert_paleopine_wood"},
		{"livingfloatlands:paleodesert_paleopine_trunk", "livingfloatlands:paleodesert_paleopine_trunk"},
		{"livingfloatlands:paleodesert_paleopine_wood", "livingfloatlands:paleodesert_paleopine_wood"},
	} 
})

doors.register_trapdoor("livingfloatlands:paleoredwood_trapdoor", {
	description = S"Paleo Redwood Trapdoor",
	inventory_image = "livingfloatlands_redwood_trapdoor.png",
	wield_image = "livingfloatlands_redwood_trapdoor.png",
	tile_front = "livingfloatlands_redwood_trapdoor.png",
	tile_side = "livingfloatlands_redwood_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})

minetest.register_craft({
	output = "livingfloatlands:paleoredwood_trapdoor 2",
	recipe = {
		{"livingfloatlands:giantforest_paleoredwood_wood", "livingfloatlands:giantforest_paleoredwood_wood", "livingfloatlands:giantforest_paleoredwood_wood"},
		{"livingfloatlands:giantforest_paleoredwood_wood", "livingfloatlands:giantforest_paleoredwood_trunk", "livingfloatlands:giantforest_paleoredwood_wood"},
	}
})

doors.register("livingfloatlands_paleoredwood_door", {
    tiles = {{ name = "livingfloatlands_redwood_door.png", backface_culling = true }},
    description = S"Paleo Redwood Door",
    inventory_image = "livingfloatlands_item_redwood_door.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"livingfloatlands:giantforest_paleoredwood_wood", "livingfloatlands:giantforest_paleoredwood_wood"},
		{"livingfloatlands:giantforest_paleoredwood_trunk", "livingfloatlands:giantforest_paleoredwood_trunk"},
		{"livingfloatlands:giantforest_paleoredwood_wood", "livingfloatlands:giantforest_paleoredwood_wood"},
	} 
})