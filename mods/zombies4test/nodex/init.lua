



-- GRID :
--[[
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
        drop = "fortification:barbed_wire",
        --sounds = default.node_sound_stone_defaults()
     selection_box = {
		type = "fixed",
		--    esqueda,altura,tras..,direita ,negativo aumenta para baixo, positivo aumenta para cima
		fixed = {-0.5, -0.5, 0.45, 0.5, 0.5, 0.5},
	},
	
	node_box = {
		type = "fixed", 
		fixed = {-0.5, -0.5, 0.45, 0.5, 0.5, 0.5},
	},
	
	
})


minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "fortification:grid",
    recipe = {
        {"default:steel_ingot","","default:steel_ingot"},
        {"","default:steel_ingot",""},
        {"default:steel_ingot","","default:steel_ingot"}
    }
})

]]


---- HOSPITAL BLOCK :

minetest.register_node("nodex:whiteblock", {
	description = "White Block",
	tiles = {"white_block.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:whiteblock",
        sounds = default.node_sound_stone_defaults()	
	
})

minetest.register_node("nodex:greenblock", {
	description = "Green Block",
	tiles = {"green_node.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:greenblock",
        sounds = default.node_sound_stone_defaults()	
	
})

minetest.register_node("nodex:redblock", {
	description = "Red Block",
	tiles = {"red_node.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:redblock",
        sounds = default.node_sound_stone_defaults()	
	
})

minetest.register_node("nodex:grayblock", {
	description = "Gray Block",
	tiles = {"gray_node.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:grayblock",
        sounds = default.node_sound_stone_defaults()	
	
})


---- COAL STAIR :
minetest.register_node("nodex:stair_coal", {
    description = "Stair Coal",
    tiles = {"default_coal_block.png"},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3},
    drop = "default:coal_lump",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    }
})



---- ROAD :

minetest.register_node("nodex:road", {
	description = "Road",
	tiles = {"road.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:road",
        sounds = default.node_sound_stone_defaults()	
	
})


minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "nodex:road 9",
    recipe = {
        {"default:coal_lump","default:coal_lump","default:coal_lump"},
        {"default:coal_lump","default:stone","default:coal_lump"},
        {"default:coal_lump","default:coal_lump","default:coal_lump"}
    }
})


---- ROAD 2 :

minetest.register_node("nodex:road2", {
	description = "Road 2",
	tiles = {"road_y.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:road2",
        sounds = default.node_sound_stone_defaults()	
	
})

minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "nodex:road2 12",
    recipe = {
        {"nodex:road","dye:yellow","nodex:road"},
        {"nodex:road","dye:yellow","nodex:road"},
        {"nodex:road","dye:yellow","nodex:road"}
    }
})


---- ROAD 2 :
minetest.register_node("nodex:road3", {
	description = "Road 3",
	tiles = {"curvedroad.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:road3",
        sounds = default.node_sound_stone_defaults()	
	
})

minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "nodex:road3 12",
    recipe = {
        {"nodex:road","dye:yellow","nodex:road"},
        {"nodex:road","dye:yellow","dye:yellow"},
        {"nodex:road","nodex:road","nodex:road"}
    }
})



---- Road Stop Line:
minetest.register_node("nodex:roadstopline", {
	description = "Road Stop Line",
	tiles = {"road_stop_line.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:roadstopline",
        sounds = default.node_sound_stone_defaults()	
	
})


minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "nodex:roadstopline 12",
    recipe = {
        {"nodex:road","dye:white","nodex:road"},
        {"nodex:road","dye:white","nodex:road"},
        {"nodex:road","dye:white","nodex:road"}
    }
})



---- SIDEWALK :
minetest.register_node("nodex:sidewalk", {
	description = "Sidewalk",
	tiles = {"sidewalk.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:sidewalk",
        sounds = default.node_sound_stone_defaults()	
	
})


minetest.register_craft({   ------ CRaFT
    type = "shaped",
    output = "nodex:sidewalk 6",
    recipe = {
        {"default:stone_block","default:stone_block","default:stone_block"},
        {"default:stone_block","default:stone_block","default:stone_block"},
        {"","",""}
    }
})


---- BRICK MOTEL :
minetest.register_node("nodex:brick_motel", {
	description = "Brick Motel",
	tiles = {"brick_motel.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:brick_motel",
        sounds = default.node_sound_stone_defaults()	
	
})


---- FLOOR BLOCK :
minetest.register_node("nodex:floor_block", {
	description = "Floor Block",
	tiles = {"floor_block.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:floor_block",
        sounds = default.node_sound_stone_defaults()	
	
})

---- MEDICAL TENT :
minetest.register_node("nodex:medicaltentblock", {
	description = "Medical Tent Block",
	tiles = {"medical_tent_block.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3},
        drop = "nodex:medicaltentblock",
        sounds = default.node_sound_stone_defaults()	
	
})
