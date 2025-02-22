
local S = minetest.get_translator("naturalbiomes")

local modname = "naturalbiomes"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("naturalbiomes:alderswamp_litter", {
	description = S("Alder Swamp dirt with Grass"),
	tiles = {"naturalbiomes_alderswamp_litter.png", "naturalbiomes_alderswamp_dirt.png",
		{name = "naturalbiomes_alderswamp_dirt.png^naturalbiomes_alderswamp_litter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "naturalbiomes:alderswamp_dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("naturalbiomes:alderswamp_dirt", {
	description = S("Alder Swamp Dirt"),
	tiles = {"naturalbiomes_alderswamp_dirt.png"},
	groups = {crumbly = 3, soil = 1, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_biome({
    name = "naturalbiomes:alderswamp",
    node_top = "naturalbiomes:alderswamp_litter",
    depth_top = 1,
    node_filler = "naturalbiomes:alderswamp_dirt",
    depth_filler = 3,
		node_riverbed = "naturalbiomes:alderswamp_dirt",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
    y_max = 5,
    y_min = 0,
    heat_point = 55,
    humidity_point = 70,
})

--
-- Tree generation
--

-- New alder tree

local function grow_new_alder_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/naturalbiomes_aldertree_0_270.mts", "0", nil, false)

end

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"naturalbiomes:alder_sapling", grow_new_alder_tree, "soil"},
})
end

-- alder trunk
minetest.register_node("naturalbiomes:alder_trunk", {
	description = S("Alder Trunk"),
	tiles = {
		"naturalbiomes_alderswamp_alder_trunk_top.png",
		"naturalbiomes_alderswamp_alder_trunk_top.png",
		"naturalbiomes_alderswamp_alder_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- alder wood
minetest.register_node("naturalbiomes:alder_wood", {
	description = S("Alder Wood"),
	tiles = {"naturalbiomes_alderswamp_alder_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "naturalbiomes:alder_wood 4",
	recipe = {{"naturalbiomes:alder_trunk"}}
})

minetest.register_node("naturalbiomes:alder_leaves", {
  description = S("Alder Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"naturalbiomes_alderswamp_alder_leaves.png"},
  special_tiles = {"naturalbiomes_alderswamp_alder_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'naturalbiomes:alder_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'naturalbiomes:alder_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("naturalbiomes:alder_sapling", {
  description = S("Alder Sapling"),
  drawtype = "plantlike",
  tiles = {"naturalbiomes_alderswamp_sapling.png"},
  inventory_image = "naturalbiomes_alderswamp_sapling.png",
  wield_image = "naturalbiomes_alderswamp_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_alder_tree,
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
      "naturalbiomes:alder_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})






    stairs.register_stair_and_slab(
      "naturalbiomes_alderswamp_alder_wood",
      "naturalbiomes:alder_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_alderswamp_alder_wood.png"},
      S("Alder Stair"),
      S("Alder Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "naturalbiomes_alderswamp_alder_trunk",
      "naturalbiomes:alder_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_alderswamp_alder_trunk_top.png", "naturalbiomes_alderswamp_alder_trunk_top.png", "naturalbiomes_alderswamp_alder_trunk.png"},
      S("Alder Trunk Stair"),
      S("Alder Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "naturalbiomes:gate_alder_wood",
    {
      description = S("Alder Wood Fence Gate"),
      texture = "naturalbiomes_alderswamp_alder_wood.png",
      material = "naturalbiomes:alder_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "naturalbiomes:fence_alder_wood",
  {
    description = S("Alder Fence"),
    texture = "naturalbiomes_adler_fence_wood.png",
    inventory_image = "default_fence_overlay.png^naturalbiomes_alderswamp_alder_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^naturalbiomes_alderswamp_alder_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:alder_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "naturalbiomes:fence_rail_alder_wood",
  {
    description = S("Alder Fence Rail"),
    texture = "naturalbiomes_adler_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^naturalbiomes_alderswamp_alder_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^naturalbiomes_alderswamp_alder_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:alder_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "naturalbiomes:alder_tree",
    deco_type = "schematic",
    place_on = {"naturalbiomes:alderswamp_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.01115,
    biomes = {"naturalbiomes:alderswamp"},
    y_max = 5,
    y_min = 1,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_aldertree_0_270.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "naturalbiomes:alder_tree2",
    deco_type = "schematic",
    place_on = {"naturalbiomes:alderswamp_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00615,
    biomes = {"naturalbiomes:alderswamp"},
    y_max = 5,
    y_min = 1,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_aldertree2_0_270.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
    name = "naturalbiomes:alder_tree3",
    deco_type = "schematic",
    place_on = {"naturalbiomes:alderswamp_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00615,
    biomes = {"naturalbiomes:alderswamp"},
    y_max = 5,
    y_min = 1,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_aldertree3_0_270.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_node("naturalbiomes:alderswamp_reed", {
	    description = S"Alderswamp reed",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"naturalbiomes_alderswamp_reeds.png"},
	    inventory_image = "naturalbiomes_alderswamp_reeds.png",
	    wield_image = "naturalbiomes_alderswamp_reeds.png",
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
		name = "naturalbiomes:alderswamp_reed",
		deco_type = "simple",
		place_on = {"naturalbiomes:alderswamp_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 6,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:alderswamp_reed",
        spawn_by = "naturalbiomes:alderswamp_litter"
	})

minetest.register_node("naturalbiomes:alderswamp_reed", {
	    description = S"Alderswamp reed",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"naturalbiomes_alderswamp_reeds.png"},
	    inventory_image = "naturalbiomes_alderswamp_reeds.png",
	    wield_image = "naturalbiomes_alderswamp_reeds.png",
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
		name = "naturalbiomes:alderswamp_reed2",
		deco_type = "simple",
		place_on = {"naturalbiomes:alderswamp_litter"},
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
		decoration = "naturalbiomes:alderswamp_reed2",
        spawn_by = "naturalbiomes:alderswamp_litter"
	})

minetest.register_node("naturalbiomes:alderswamp_reed2", {
	    description = S"Alderswamp reed",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"naturalbiomes_alderswamp_reeds2.png"},
	    inventory_image = "naturalbiomes_alderswamp_reeds2.png",
	    wield_image = "naturalbiomes_alderswamp_reeds2.png",
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
		name = "naturalbiomes:alderswamp_reed3",
		deco_type = "simple",
		place_on = {"naturalbiomes:alderswamp_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:alderswamp_reed3",
        spawn_by = "naturalbiomes:alderswamp_litter"
	})

minetest.register_node("naturalbiomes:alderswamp_reed3", {
	    description = S"Alderswamp reed",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"naturalbiomes_alderswamp_reeds3.png"},
	    inventory_image = "naturalbiomes_alderswamp_reeds3.png",
	    wield_image = "naturalbiomes_alderswamp_reeds3.png",
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
		name = "naturalbiomes:alder_log",
		deco_type = "schematic",
		place_on = {"naturalbiomes:alderswamp_litter"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0.0012,
			scale = 0.0007,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"naturalbiomes:alderswamp"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_alder_log_0_90.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "naturalbiomes:alderswamp_litter",
		num_spawn_by = 8,
	})

	minetest.register_decoration({
		name = "naturalbiomes:alder_swamppit",
		deco_type = "schematic",
		place_on = {"naturalbiomes:alderswamp_litter"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = 0.0012,
			scale = 0.0007,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 3,
			persist = 2,
		},
		biomes = {"naturalbiomes:alderswamp"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_alderswamp_spwamphole_0_90.mts",
		flags = "place_center_x, place_center_z",
    flags = "force_placement",
		rotation = "random",
		spawn_by = "naturalbiomes:alderswamp_litter",
	})

	minetest.register_decoration({
		name = "naturalbiomes:waterlily",
		deco_type = "simple",
		place_on = {"naturalbiomes:alderswamp_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 100, y = 100, z = 100},
			seed = 33,
			octaves = 3,
			persist = 0.7
		},
		y_max = 0,
		y_min = 0,
		decoration = "naturalbiomes:waterlily",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})

minetest.register_node("naturalbiomes:waterlily", {
	description = S("Waterlily"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"naturalbiomes_alderswamp_waterlily.png", "naturalbiomes_alderswamp_waterlily_bottom.png"},
	inventory_image = "naturalbiomes_alderswamp_waterlily.png",
	wield_image = "naturalbiomes_alderswamp_waterlily.png",
	use_texture_alpha = "clip",
	liquids_pointable = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy = 3, flower = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_placement_prediction = "",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -31 / 64, -0.5, 0.5, -15 / 32, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
	},

	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under)
		local def = minetest.registered_nodes[node.name]

		if def and def.on_rightclick then
			return def.on_rightclick(pointed_thing.under, node, placer, itemstack,
					pointed_thing)
		end

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node.name, "water") > 0 then
			local player_name = placer and placer:get_player_name() or ""
			if not minetest.is_protected(pos, player_name) then
				minetest.set_node(pos, {name = "naturalbiomes:waterlily",
					param2 = math.random(0, 3)})
				if not (creative and creative.is_enabled_for
						and creative.is_enabled_for(player_name)) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, ("Node is protected."))
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
})

	minetest.register_decoration({
		name = "naturalbiomes:alderswamp_yellowflower",
		deco_type = "simple",
		place_on = {"naturalbiomes:alderswamp_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "naturalbiomes:alderswamp_yellowflower",
        spawn_by = "naturalbiomes:alderswamp_litter"
	})

minetest.register_node("naturalbiomes:alderswamp_yellowflower", {
	    description = S"Alderswamp flower",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_adler_yellowflower.png"},
	    inventory_image = "naturalbiomes_adler_yellowflower.png",
	    wield_image = "naturalbiomes_adler_yellowflower.png",
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
		name = "naturalbiomes:alderswamp_brownreed",
		deco_type = "simple",
		place_on = {"naturalbiomes:alderswamp_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.1,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 1,
		y_min = 0,
		decoration = "naturalbiomes:alderswamp_brownreed",
        spawn_by = "naturalbiomes:alderswamp_litter"
	})

minetest.register_node("naturalbiomes:alderswamp_brownreed", {
	    description = S"Alderswamp reed",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 2.0,
	    tiles = {"naturalbiomes_alderswamp_reedbrown.png"},
	    inventory_image = "naturalbiomes_alderswamp_reedbrown.png",
	    wield_image = "naturalbiomes_alderswamp_reedbrown.png",
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

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"naturalbiomes:alderswamp_litter", {"naturalbiomes:alderswamp_brownreed", "naturalbiomes:alderswamp_yellowflower", "naturalbiomes:alderswamp_reed", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed3"}, {}}
	})
end