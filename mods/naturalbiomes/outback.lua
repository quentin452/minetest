local S = minetest.get_translator("naturalbiomes")

local modname = "naturalbiomes"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("naturalbiomes:outback_litter", {
	description = S("Outback ground with grass"),
	tiles = {"naturalbiomes_outbacklitter.png", "naturalbiomes_outback_ground.png",
		{name = "naturalbiomes_outback_ground.png^naturalbiomes_outbacklitter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "naturalbiomes:outback_ground",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("naturalbiomes:outback_rock", {
	description = S("Outback Rock"),
	tiles = {"naturalbiomes_outback_rock.png"},
	groups = {cracky = 3, stone = 1},
legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("naturalbiomes:outback_ground", {
	description = S("Outback Ground Sand"),
	tiles = {"naturalbiomes_outback_ground.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_biome({
    name = "naturalbiomes:outback",
    node_top = "naturalbiomes:outback_litter",
    depth_top = 1,
    node_filler = "naturalbiomes:outback_ground",
    depth_filler = 50,
		node_riverbed = "default:clay",
		depth_riverbed = 2,
		node_dungeon = "default:sandstone",
		node_dungeon_alt = "default:desert_stonebrick",
		node_dungeon_stair = "stairs:stair_desert_stone",
    y_max = 40,
    y_min = 3,
    heat_point = 82,
    humidity_point = 32,
})

-- Tree generation
--

-- New outback tree

local function grow_new_outback_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 4, y = pos.y - 0, z = pos.z - 4}, modpath.."/schematics/naturalbiomes_outback_tree1_0_90.mts", "0", nil, false)
end 

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"naturalbiomes:outback_sapling", grow_new_outback_tree, "soil"},
})
end

-- outback trunk
minetest.register_node("naturalbiomes:outback_trunk", {
	description = S("Outback Eucalyptus Trunk"),
	tiles = {
		"naturalbiomes_outbackeukalyptus_trunk_top.png",
		"naturalbiomes_outbackeukalyptus_trunk_top.png",
		"naturalbiomes_outbackeucalyptus_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- outback wood
minetest.register_node("naturalbiomes:outback_wood", {
	description = S("Outback Eucalyptus Wood"),
	tiles = {"naturalbiomes_outback_eukalyptus_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "naturalbiomes:outback_wood 4",
	recipe = {{"naturalbiomes:outback_trunk"}}
})

minetest.register_node("naturalbiomes:outback_leaves", {
  description = S("Outback Eucalyptus Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"naturalbiomes_outbackeukalyptus_leaves.png"},
  special_tiles = {"naturalbiomes_outbackeukalyptus_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'naturalbiomes:outback_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'naturalbiomes:outback_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("naturalbiomes:outback_sapling", {
  description = S("Outback Eucalyptus Sapling"),
  drawtype = "plantlike",
  tiles = {"naturalbiomes_outbackeukaplyptus_sapling.png"},
  inventory_image = "naturalbiomes_outbackeukaplyptus_sapling.png",
  wield_image = "naturalbiomes_outbackeukaplyptus_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_outback_tree,
  selection_box = {
    type = "fixed",
    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
  },
  groups = {snappy = 2, dig_immediate = 3, flammable = 2,
    attached_node = 1, sapling = 1},
  sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

  on_place = function(itemstack, placer, pointed_thing)
    itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
      "naturalbiomes:outback_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "naturalbiomes_outback_eukalyptus_wood",
      "naturalbiomes:outback_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_outback_eukalyptus_wood.png"},
      S("Outback Eucalyptus Stair"),
      S("Outback Eucalyptus Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "naturalbiomes_outbackeucalyptus_trunk",
      "naturalbiomes:outback_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_outbackeukalyptus_trunk_top.png", "naturalbiomes_outbackeukalyptus_trunk_top.png", "naturalbiomes_outbackeucalyptus_trunk.png"},
      S("Outback Eucalyptus Trunk Stair"),
      S("Outback Eucalyptus Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "naturalbiomes:gate_outback_wood",
    {
      description = S("Outback Eucalyptus Wood Fence Gate"),
      texture = "naturalbiomes_outback_eukalyptus_wood.png",
      material = "naturalbiomes:outback_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "naturalbiomes:fence_outback_wood",
  {
    description = S("Outback Eucalyptus Fence"),
    texture = "naturalbiomes_eukalyptus_fence_wood.png",
    inventory_image = "default_fence_overlay.png^naturalbiomes_outback_eukalyptus_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^naturalbiomes_outback_eukalyptus_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:outback_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "naturalbiomes:fence_rail_outback_wood",
  {
    description = S("Outback Eucalyptus Fence Rail"),
    texture = "naturalbiomes_eukalyptus_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^naturalbiomes_outback_eukalyptus_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^naturalbiomes_outback_eukalyptus_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:outback_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "naturalbiomes:outback_tree",
    deco_type = "schematic",
    place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00115,
    biomes = {"naturalbiomes:outback"},
    y_max = 31,
    y_min = 1,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_outback_tree1_0_90.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "naturalbiomes:outback_tree2",
    deco_type = "schematic",
    place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00115,
    biomes = {"naturalbiomes:outback"},
    y_max = 31,
    y_min = 1,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_outback_tree2_0_90.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

	minetest.register_decoration({
		name = "naturalbiomes:outback_log",
		deco_type = "schematic",
		place_on = {"naturalbiomes:outback_litter"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0.0002,
			scale = 0.0005,
			spread = {x = 550, y = 550, z = 550},
			seed = 2,
			octaves = 3,
			persist = 0.36
		},
		biomes = {"naturalbiomes:outback"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_outback_log_0_90.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "naturalbiomes:outback_litter",
		num_spawn_by = 2,
	})

	-- Outback Bush

-- New outback bush

local function grow_new_outback_bush(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 0, z = pos.z - 2}, modpath.."/schematics/naturalbiomes_outback_bush_small2_0_270.mts", "0", nil, false)
end 

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"naturalbiomes:outback_bush_sapling", grow_new_outback_bush, "soil"},
})
end
	minetest.register_decoration({
		name = "naturalbiomes:outback_bush",
		deco_type = "schematic",
		place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = 1,
		sidelen = 16,
		noise_params = {
offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 391,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"naturalbiomes:outback"},
		y_max = 31000,
		y_min = 3,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_outback_bush_small2_0_270.mts",
		flags = "place_center_x, place_center_z",
	})

minetest.register_node("naturalbiomes:outback_bush_stem", {
	description = S("Outback Bush Stem"),
	drawtype = "plantlike",
	visual_scale = 1.41,
	tiles = {"naturalbiomes_outback_bush_stem.png"},
	inventory_image = "naturalbiomes_outback_bush_stem.png",
	wield_image = "naturalbiomes_outback_bush_stem.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
	},
})

minetest.register_node("naturalbiomes:outback_bush_leaves", {
	description = S("Outback Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"naturalbiomes_outbackbush_leaves.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1, winleafdecay = 3},
	drop = {
		max_items = 1,
		items = {
			{items = {"naturalbiomes:outback_bush_sapling"}, rarity = 50},
			{items = {"naturalbiomes:outback_bush_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("naturalbiomes:outback_bush_sapling", {
	description = S("Outback Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"naturalbiomes_outback_bush_stem.png"},
	inventory_image = "naturalbiomes_outback_bush_stem.png",
	wield_image = "naturalbiomes_outback_bush_stem.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_outback_bush,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"naturalbiomes:outback_bush_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

		return itemstack
	end,
})

	minetest.register_decoration({
		name = "naturalbiomes:outback_grass",
		deco_type = "simple",
		place_on = {"naturalbiomes:outback_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 8,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:outback_grass",
        spawn_by = "naturalbiomes:outback_litter"
	})

minetest.register_node("naturalbiomes:outback_grass", {
	    description = S"Outback Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_outbackgrass.png"},
	    inventory_image = "naturalbiomes_outbackgrass.png",
	    wield_image = "naturalbiomes_outbackgrass.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "naturalbiomes:outback_grass2",
		deco_type = "simple",
		place_on = {"naturalbiomes:outback_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 687,
			octaves = 3,
			persist = 2,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:outback_grass2",
        spawn_by = "naturalbiomes:outback_litter"
	})

minetest.register_node("naturalbiomes:outback_grass2", {
	    description = S"Outback Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_outbackgrass2.png"},
	    inventory_image = "naturalbiomes_outbackgrass2.png",
	    wield_image = "naturalbiomes_outbackgrass2.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "naturalbiomes:outback_grass3",
		deco_type = "simple",
		place_on = {"naturalbiomes:outback_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 500, y = 500, z = 500},
			seed = 6072,
			octaves = 2,
			persist = 3,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:outback_grass3",
        spawn_by = "naturalbiomes:outback_litter"
	})

minetest.register_node("naturalbiomes:outback_grass3", {
	    description = S"Outback Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_outbackgrass3.png"},
	    inventory_image = "naturalbiomes_outbackgrass3.png",
	    wield_image = "naturalbiomes_outbackgrass3.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "naturalbiomes:outback_grass4",
		deco_type = "simple",
		place_on = {"naturalbiomes:outback_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.15,
			spread = {x = 500, y = 500, z = 500},
			seed = 457,
			octaves = 3,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "naturalbiomes:outback_grass4",
        spawn_by = "naturalbiomes:outback_litter"
	})

minetest.register_node("naturalbiomes:outback_grass4", {
	    description = S"Outback Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_outbackgrass4.png"},
	    inventory_image = "naturalbiomes_outbackgrass4.png",
	    wield_image = "naturalbiomes_outbackgrass4.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "naturalbiomes:outback_grass5",
		deco_type = "simple",
		place_on = {"naturalbiomes:outback_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 6,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "naturalbiomes:outback_grass5",
        spawn_by = "naturalbiomes:outback_litter"
	})

minetest.register_node("naturalbiomes:outback_grass5", {
	    description = S"Outback Grass",
	    drawtype = "plantlike",
	    waving = 1,
		noise_params = {
			offset = -0.03,
			scale = 0.15,
			spread = {x = 500, y = 500, z = 500},
			seed = 457,
			octaves = 3,
			persist = 1,
		},
	    tiles = {"naturalbiomes_outbackgrass5.png"},
	    inventory_image = "naturalbiomes_outbackgrass5.png",
	    wield_image = "naturalbiomes_outbackgrass5.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

	minetest.register_decoration({
		name = "naturalbiomes:outback_grass6",
		deco_type = "simple",
		place_on = {"naturalbiomes:outback_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 5,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:outback_grass6",
        spawn_by = "naturalbiomes:outback_litter"
	})

minetest.register_node("naturalbiomes:outback_grass6", {
	    description = S"Outback Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_outbackgrass6.png"},
	    inventory_image = "naturalbiomes_outbackgrass6.png",
	    wield_image = "naturalbiomes_outbackgrass6.png",
	    paramtype = "light",
	    sunlight_propagates = true,
	    walkable = false,
	    buildable_to = true,
	    groups = {snappy = 3, flower = 1, flora = 1, attached_node = 1, flammable = 1, beautiflowers = 1},
	    sounds = default.node_sound_leaves_defaults(),
	    selection_box = {
		    type = "fixed",
		    fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.0, 4 / 16},
	    },
    })

minetest.register_node("naturalbiomes:outback_rockformation1", {
	description = S("Outback Rock Formation"),
	tiles = {"naturalbiomes_beach_rock.png"},
	groups = {cracky = 3, stone = 1},
	drop = "naturalbiomes:palmbeach_rock",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

	minetest.register_decoration({
		name = "naturalbiomes:outback_rockformation1",
		deco_type = "schematic",
		place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = -1,
		sidelen = 16,
    fill_ratio = 0.00005,
		biomes = {"naturalbiomes:outback"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_outback_rock1_0_90.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})


	minetest.register_decoration({
		name = "naturalbiomes:outback_rockformation2",
		deco_type = "schematic",
		place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = -2,
		sidelen = 16,
    fill_ratio = 0.00005,
		biomes = {"naturalbiomes:outback"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_outback_rock2_0_90.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})



	minetest.register_decoration({
		name = "naturalbiomes:outback_rockformation3",
		deco_type = "schematic",
		place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = -3,
		sidelen = 16,
    fill_ratio = 0.00005,
		biomes = {"naturalbiomes:outback"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_outback_rock3_0_90.mts",
		flags = "place_center_x, place_center_z",
    rotation = "random",
	})


-- Outback Bush 3

	minetest.register_decoration({
		name = "naturalbiomes:outback_bush2",
		deco_type = "schematic",
		place_on = {"naturalbiomes:outback_litter"},
    place_offset_y = 1,
		sidelen = 16,
		noise_params = {
offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 391,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"naturalbiomes:outback"},
		y_max = 31000,
		y_min = 3,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_outback_bush2_0_90.mts",
		flags = "place_center_x, place_center_z",
	})

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"naturalbiomes:outback_litter", {"naturalbiomes:outback_grass", "naturalbiomes:outback_grass2", "naturalbiomes:outback_grass3", "naturalbiomes:outback_grass4", "naturalbiomes:outback_grass5", "naturalbiomes:outback_grass6"}, {}}
	})
end

