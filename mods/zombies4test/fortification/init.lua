



-- GRID :

minetest.register_node("fortification:grid", {
 	drawtype = "nodebox",
	description = "Grid",
	tiles = {"grid.png"},
	-- light_source = 4, -- somente para identificar o bloco
	groups = {cracky = 3},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	-- damage_per_second = 1,
        drop = "fortification:wirefence",
        sounds = default.node_sound_metal_defaults(),
        
     selection_box = {
		type = "fixed",
		--    esqueda,altura,tras..,direita ,negativo aumenta para baixo, positivo aumenta para cima
		fixed = {-0.5, -0.5, 0.3, 0.5, 0.5, 0.5},
	},
	
	node_box = {
		type = "fixed", 
		fixed = {-0.5, -0.5, 0.45, 0.5, 0.5, 0.5},
	},
	
	
})


minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:grid 6",
    recipe = {
        {"fortification:barbed_wire","fortification:barbed_wire","fortification:barbed_wire"},
        {"fortification:barbed_wire","fortification:barbed_wire","fortification:barbed_wire"},
        {"default:steel_ingot","","default:steel_ingot"}
    }
})


-- BARBED WIRE :

minetest.register_node("fortification:barbed_wire", {
 	drawtype = "plantlike",
	description = "Barbed Wire",
	tiles = {"barbed_wire.png"},
	-- light_source = 4, -- somente para identificar o bloco
	groups = {cracky = 3},
	paramtype = "light",
	walkable = true,
	damage_per_second = 3,
        drop = "fortification:barbed_wire",
        sounds = default.node_sound_metal_defaults(),
        
     selection_box = {
		type = "fixed",
		--    esqueda,altura,tras..,direita ,negativo aumenta para baixo, positivo aumenta para cima
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.2, 0.3},
	},
	
	node_box = {
		type = "fixed", 
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.2, 0.3},
	},
	
	
})

minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:barbed_wire 4",
    recipe = {
        {"","default:steel_ingot",""},
        {"default:steel_ingot","","default:steel_ingot"},
        {"","default:steel_ingot",""}
    }
})





---- SAND BAG :

minetest.register_node("fortification:sandbag", {
	description = "Sand Bag",
	tiles = {"sandbag.png"},
	-- light_source = 4, -- somente para identificar o bloco
	groups = {cracky = 3},
        drop = "fortification:sandbag",
        sounds = default.node_sound_sand_defaults(),
	
})

minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:sandbag",
    recipe = {
        {"farming:string","farming:string","farming:string"},
        {"farming:string","group:sand","farming:string"},
        {"farming:string","farming:string","farming:string"}
    }
})


---- METAL WALL :
minetest.register_node("fortification:metal_wall", {
	description = "Metal Wall",
	tiles = {"metal_wallpng.png"},
	-- light_source = 4, -- somente para identificar o bloco
	groups = {cracky = 3},
        drop = "fortification:metal_wall",
        sounds = default.node_sound_metal_defaults(),
	
})

minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:metal_wall 8",
    recipe = {
        {"default:steelblock","default:steelblock",""},
        {"default:steelblock","default:steelblock",""},
        {"","",""}
    }
})


-- BADED WIRE : ---------------------------------------------------------------
minetest.register_node("fortification:wirefence", {
	description = "Wire fence",
	drawtype = "mesh",
	mesh = "wire.obj",
	--inventory_image = "",
	--wield_image = "barbed_wire.png",
	tiles = {"barbed-wire.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	--on_place = minetest.rotate_node,
	sunlight_propagates = true,
	walkable = true, 
	floodable = false,
	damage_per_second =2,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	drop = "fortification:wirefence",
	sounds = default.node_sound_metal_defaults(),
	
	selection_box = {
		type = "fixed",
		--    esqueda,altura,tras..,direita ,negativo aumenta para baixo, positivo aumenta para cima
		fixed = {-0.3, -0.4, -0.3, 0.3, 0.2, 0.3},
	},
	
	node_box = {
		type = "fixed", 
		fixed = {-0.3, -0.4, -0.3, 0.3, 0.2, 0.3},
	},
	
	
	
	
	
})

minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:wirefence 8",
    recipe = {
        {"default:steel_ingot","fortification:barbed_wire ","default:steel_ingot"},
        {"default:steel_ingot","fortification:barbed_wire ","default:steel_ingot"},
        {"default:steel_ingot","","default:steel_ingot"}
    }
})


-- punji_sticks: --------------------------------------------------------------
minetest.register_node("fortification:punji_sticks", {
	description = "Punji Sticks",
	drawtype = "mesh",
	mesh = "punji_sticks.obj",
	--inventory_image = "",
	--wield_image = "punjisticks.png",
	tiles = {"punjisticks.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	--on_place = minetest.rotate_node,
	sunlight_propagates = true,
	walkable = false, 
	floodable = false,
	damage_per_second =2,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	drop = "fortification:punji_sticks",
	
	selection_box = {
		type = "fixed",
		--    esqueda,altura,tras..,direita ,negativo aumenta para baixo, positivo aumenta para cima
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.2, 0.3},
	},
	
	node_box = {
		type = "fixed", 
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.2, 0.3},
	},
	
	
	
	
	
})


minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:punji_sticks",
    recipe = {
        {"","",""},
        {"","",""},
        {"default:stick","default:stick","default:stick"}
    }
})





