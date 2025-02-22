local S = minetest.get_translator("naturalbiomes")

local modname = "naturalbiomes"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

minetest.register_node("naturalbiomes:alpine_litter", {
	description = S("Dirt with Alpine Grass"),
	tiles = {"naturalbiomes_alpine_litter.png", "default_dirt.png",
		{name = "default_dirt.png^naturalbiomes_alpine_litter_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "naturalbiomes:alpine_rock",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("naturalbiomes:alpine_rock", {
	description = S("Alpine Rock"),
	tiles = {"naturalbiomes_alpine_rock.png"},
	groups = {cracky = 3, stone = 1},
	drop = "naturalbiomes:alpine_rock",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_biome({
    name = "naturalbiomes:alpine",
    node_top = "naturalbiomes:alpine_litter",
    depth_top = 1,
    node_filler = "naturalbiomes:alpine_rock",
    depth_filler = 50,
		node_riverbed = "default:gravel",
		depth_riverbed = 2,
		node_dungeon = "default:stone",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
    y_max = 31000,
    y_min = 30,
    heat_point = 55,
    humidity_point = 60,
})

-- Tree generation
--

-- New pine tree

local function grow_new_alppine1_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 5, y = pos.y - 0, z = pos.z - 5}, modpath.."/schematics/naturalbiomes_alpine_pine1_0_90.mts", "0", nil, false)
end 

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"naturalbiomes:alppine1_sapling", grow_new_alppine1_tree, "soil"},
})
end

-- Pine1 trunk
minetest.register_node("naturalbiomes:alppine1_trunk", {
	description = S("Silver Fir Trunk"),
	tiles = {
		"naturalbiomes_alpine_pine1_trunk_top.png",
		"naturalbiomes_alpine_pine1_trunk_top.png",
		"naturalbiomes_alpine_pine1_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- Pine wood
minetest.register_node("naturalbiomes:alppine1_wood", {
	description = S("Silver Fir Wood"),
	tiles = {"naturalbiomes_alpine_pine1_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "naturalbiomes:alppine1_wood 4",
	recipe = {{"naturalbiomes:alppine1_trunk"}}
})

minetest.register_node("naturalbiomes:alppine1_leaves", {
  description = S("Silver Fir Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"naturalbiomes_alpine_pine1_leaves.png"},
  special_tiles = {"naturalbiomes_alpine_pine1_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'naturalbiomes:alppine1_sapling'},
        rarity = 50,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'naturalbiomes:alppine1_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("naturalbiomes:alppine1_sapling", {
  description = S("Silver Fir Sapling"),
  drawtype = "plantlike",
  tiles = {"naturalbiomes_alpine_pine1_sapling.png"},
  inventory_image = "naturalbiomes_alpine_pine1_sapling.png",
  wield_image = "naturalbiomes_alpine_pine1_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_alppine1_tree,
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
      "naturalbiomes:alppine1_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "naturalbiomes_alpine_pine1_wood",
      "naturalbiomes:alppine1_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_alpine_pine1_wood.png"},
      S("Silver Fir Stair"),
      S("Silver Fir Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "naturalbiomes_alpine_pine1_trunk",
      "naturalbiomes:alppine1_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_alpine_pine1_trunk_top.png", "naturalbiomes_alpine_pine1_trunk_top.png", "naturalbiomes_alpine_pine1_trunk.png"},
      S("Silver Fir Trunk Stair"),
      S("Silver Fir Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "naturalbiomes:gate_alppine1_wood",
    {
      description = S("Silver Fir Wood Fence Gate"),
      texture = "naturalbiomes_alpine_pine1_wood.png",
      material = "naturalbiomes:alppine1_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "naturalbiomes:fence_alppine1_wood",
  {
    description = S("Silver Fir Fence"),
    texture = "naturalbiomes_pine_fence_wood.png",
    inventory_image = "default_fence_overlay.png^naturalbiomes_alpine_pine1_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^naturalbiomes_alpine_pine1_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:alppine1_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "naturalbiomes:fence_rail_alppine1_wood",
  {
    description = S("Silver Fir Fence Rail"),
    texture = "naturalbiomes_pine_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^naturalbiomes_alpine_pine1_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^naturalbiomes_alpine_pine1_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:alppine1_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "naturalbiomes:alppine1_tree",
    deco_type = "schematic",
    place_on = {"naturalbiomes:alpine_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00315,
    biomes = {"naturalbiomes:alpine"},
    y_max = 31000,
    y_min = 30,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_alpine_pine1_0_90.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- Tree generation
--

-- New alppine2 tree

local function grow_new_alppine2_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 0, z = pos.z - 3}, modpath.."/schematics/naturalbiomes_alpine_pine2_0_90.mts", "0", nil, false)
end 

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"naturalbiomes:alppine2_sapling", grow_new_alppine2_tree, "soil"},
})
end

-- Pine2 trunk
minetest.register_node("naturalbiomes:alppine2_trunk", {
	description = S("Jack Pine Trunk"),
	tiles = {
		"naturalbiomes_alpine_pine2_trunk_top.png",
		"naturalbiomes_alpine_pine2_trunk_top.png",
		"naturalbiomes_alpine_pine2_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- Pine2 wood
minetest.register_node("naturalbiomes:alppine2_wood", {
	description = S("Jack Pine Wood"),
	tiles = {"naturalbiomes_alpine_pine2_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "naturalbiomes:alppine2_wood 4",
	recipe = {{"naturalbiomes:alppine2_trunk"}}
})

minetest.register_node("naturalbiomes:alppine2_leaves", {
  description = S("Jack Pine Leaves"),
  drawtype = "allfaces_optional",
  waving = 1,
  tiles = {"naturalbiomes_alpine_pine2_leaves.png"},
  special_tiles = {"naturalbiomes_alpine_pine2_leaves.png"},
  paramtype = "light",
  is_ground_content = false,
  groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, winleafdecay = 3},
  drop = {
    max_items = 1,
    items = {
      {
        -- player will get sapling with 1/50 chance
        items = {'naturalbiomes:alppine2_sapling'},
        rarity = 15,
      },
      {
        -- player will get leaves only if he get no saplings,
        -- this is because max_items is 1
        items = {'naturalbiomes:alppine2_leaves'},
      }
    }
  },
  sounds = default.node_sound_leaves_defaults(),

  after_place_node = default.after_place_leaves,
})

minetest.register_node("naturalbiomes:alppine2_sapling", {
  description = S("Jack Pine Sapling"),
  drawtype = "plantlike",
  tiles = {"naturalbiomes_alpine_pine2_sapling.png"},
  inventory_image = "naturalbiomes_alpine_pine2_sapling.png",
  wield_image = "naturalbiomes_alpine_pine2_sapling.png",
  paramtype = "light",
  sunlight_propagates = true,
  walkable = false,
  on_timer = grow_new_alppine2_tree,
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
      "naturalbiomes:alppine2_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

    return itemstack
  end,
})


    stairs.register_stair_and_slab(
      "naturalbiomes_alpine_pine2_wood",
      "naturalbiomes:alppine2_wood",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_alpine_pine2_wood.png"},
      S("Jack Pine Stair"),
      S("Jack Pine Slab"),
      default.node_sound_wood_defaults()
    )

    stairs.register_stair_and_slab(
      "naturalbiomes_alpine_pine2_trunk",
      "naturalbiomes:alppine2_trunk",
      {choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
      {"naturalbiomes_alpine_pine2_trunk_top.png", "naturalbiomes_alpine_pine2_trunk_top.png", "naturalbiomes_alpine_pine2_trunk.png"},
      S("Jack Pine Trunk Stair"),
      S("Jack Pine Trunk Slab"),
      default.node_sound_wood_defaults()
    )

  doors.register_fencegate(
    "naturalbiomes:gate_alppine2_wood",
    {
      description = S("Jack Pine Wood Fence Gate"),
      texture = "naturalbiomes_alpine_pine2_wood.png",
      material = "naturalbiomes:alppine2_wood",
      groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults()
    }
  )


default.register_fence(
  "naturalbiomes:fence_pine2_wood",
  {
    description = S("Jack Pine Fence"),
    texture = "naturalbiomes_pine2_fence_wood.png",
    inventory_image = "default_fence_overlay.png^naturalbiomes_alpine_pine2_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^naturalbiomes_alpine_pine2_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:alppine2_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

default.register_fence_rail(
  "naturalbiomes:fence_rail_pine2_wood",
  {
    description = S("Jack Pine Fence Rail"),
    texture = "naturalbiomes_pine2_fence_wood.png",
    inventory_image = "default_fence_rail_overlay.png^naturalbiomes_alpine_pine2_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^naturalbiomes_alpine_pine2_wood.png^" ..
      "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "naturalbiomes:alppine2_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
  }
)

minetest.register_decoration({
    name = "naturalbiomes:alppine2_tree",
    deco_type = "schematic",
    place_on = {"naturalbiomes:alpine_litter"},
    place_offset_y = 0,
    sidelen = 16,
    fill_ratio = 0.00715,
    biomes = {"naturalbiomes:alpine"},
    y_max = 31000,
    y_min = 30,
    schematic = minetest.get_modpath("naturalbiomes").."/schematics/naturalbiomes_alpine_pine2_0_90.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

-- Tree generation
--

-- New cowberry bush

local function grow_new_outback_bush(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 0, z = pos.z - 2}, modpath.."/schematics/naturalbiomes_alpine_cowberrybush.mts", "0", nil, false)
end 

if minetest.get_modpath("bonemeal") then
bonemeal:add_sapling({
	{"naturalbiomes:alpine_cowberrybush_sapling", grow_new_outback_bush, "soil"},
})
end

	minetest.register_decoration({
		name = "naturalbiomes:cowberry_bush",
		deco_type = "schematic",
		place_on = {"naturalbiomes:alpine_litter"},
    place_offset_y = 1,
		sidelen = 16,
		noise_params = {
offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 697,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"naturalbiomes:alpine"},
    y_max = 31000,
    y_min = 30,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_alpine_cowberrybush.mts",
		flags = "place_center_x, place_center_z",
	})

minetest.register_node("naturalbiomes:alpine_cowberrybush_stem", {
	description = S("Cowberry Bush Stem"),
	drawtype = "plantlike",
	visual_scale = 1.41,
	tiles = {"naturalbiomes_alpine_cowberry_stem.png"},
	inventory_image = "naturalbiomes_alpine_cowberry_stem.png",
	wield_image = "naturalbiomes_alpine_cowberry_stem.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
	},
})

minetest.register_node("naturalbiomes:alpine_cowberrybush_leaves", {
	description = S("Cowberry Bush Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"naturalbiomes_alpine_cowberry_leaves.png"},
	paramtype = "light",
	groups = {snappy = 3, flammable = 2, leaves = 1, winleafdecay = 3},
	drop = {
		max_items = 1,
		items = {
			{items = {"naturalbiomes:alpine_cowberrybush_sapling"}, rarity = 20},
			{items = {"naturalbiomes:cowberry"}, rarity = 2},
			{items = {"naturalbiomes:alpine_cowberrybush_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("naturalbiomes:alpine_cowberrybush_sapling", {
	description = S("Cowberry Bush Sapling"),
	drawtype = "plantlike",
	tiles = {"naturalbiomes_alpine_cowberry_sapling.png"},
	inventory_image = "naturalbiomes_alpine_cowberry_sapling.png",
	wield_image = "naturalbiomes_alpine_cowberry_sapling.png",
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
			"naturalbiomes:alpine_cowberrybush_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -1, y = 0, z = -1},
			{x = 1, y = 1, z = 1},
			-- maximum interval of interior volume check
			2)

		return itemstack
	end,
})

minetest.register_node("naturalbiomes:cowberry", {
	description = S("Cowberry"),
	drawtype = "torchlike",
	tiles = {"naturalbiomes_alpine_cowberry_fruit.png"},
	inventory_image = "naturalbiomes_alpine_cowberry_fruit.png",
	wield_image = "naturalbiomes_alpine_cowberry_fruit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1, winleafdecay_drop = 1, winleafdecay = 3
	},
	drop = "naturalbiomes:cowberry",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "naturalbiomes:cowberry", param2 = 1})
		end
	end
})

	minetest.register_decoration({
		name = "naturalbiomes:alpine_mushroom",
		deco_type = "simple",
		place_on = {"naturalbiomes:alpine_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.04,
			spread = {x = 100, y = 100, z = 100},
			seed = 7133,
			octaves = 3,
			persist = 0.6
		},
		y_max = 31000,
		y_min = 30,
		decoration = "naturalbiomes:alpine_mushroom",
		spawn_by = "naturalbiomes:alpine_litter",

})


minetest.register_node("naturalbiomes:alpine_mushroom", {
	description = S("Alpine Mushroom"),
	tiles = {"naturalbiomes_alpine_mushroom.png"},
	inventory_image = "naturalbiomes_alpine_mushroom.png",
	wield_image = "naturalbiomes_alpine_mushroom.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {mushroom = 1, food_mushroom = 1, snappy = 3, attached_node = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1),
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
	}
})


	minetest.register_decoration({
		name = "naturalbiomes:alpine_grass1",
		deco_type = "simple",
		place_on = {"naturalbiomes:alpine_litter"},
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
		decoration = "naturalbiomes:alpine_grass1",
        spawn_by = "naturalbiomes:alpine_litter"
	})

minetest.register_node("naturalbiomes:alpine_grass1", {
	    description = S"Alpine Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_alpine_grass1.png"},
	    inventory_image = "naturalbiomes_alpine_grass1.png",
	    wield_image = "naturalbiomes_alpine_grass1.png",
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
		name = "naturalbiomes:alpine_grass2",
		deco_type = "simple",
		place_on = {"naturalbiomes:alpine_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 8,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "naturalbiomes:alpine_grass2",
        spawn_by = "naturalbiomes:alpine_litter"
	})

minetest.register_node("naturalbiomes:alpine_grass2", {
	    description = S"Alpine Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_alpine_grass2.png"},
	    inventory_image = "naturalbiomes_alpine_grass2.png",
	    wield_image = "naturalbiomes_alpine_grass2.png",
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
		name = "naturalbiomes:alpine_grass3",
		deco_type = "simple",
		place_on = {"naturalbiomes:alpine_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 3602,
			octaves = 7,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "naturalbiomes:alpine_grass3",
        spawn_by = "naturalbiomes:alpine_litter"
	})

minetest.register_node("naturalbiomes:alpine_grass3", {
	    description = S"Alpine Grass",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_alpine_grass3.png"},
	    inventory_image = "naturalbiomes_alpine_grass3.png",
	    wield_image = "naturalbiomes_alpine_grass3.png",
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
		name = "naturalbiomes:alpine_dandelion",
		deco_type = "simple",
		place_on = {"naturalbiomes:alpine_litter"},
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
		decoration = "naturalbiomes:alpine_dandelion",
        spawn_by = "naturalbiomes:alpine_litter"
	})

minetest.register_node("naturalbiomes:alpine_dandelion", {
	    description = S"Alpine Dandelion Flower",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_alpine_dandelion.png"},
	    inventory_image = "naturalbiomes_alpine_dandelion.png",
	    wield_image = "naturalbiomes_alpine_dandelion.png",
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
		name = "naturalbiomes:alpine_edelweiss",
		deco_type = "simple",
		place_on = {"naturalbiomes:alpine_litter"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4602,
			octaves = 8,
			persist = 1,
		},
		y_max = 31000,
		y_min = 1,
		decoration = "naturalbiomes:alpine_edelweiss",
        spawn_by = "naturalbiomes:mediterran_litter"
	})

minetest.register_node("naturalbiomes:alpine_edelweiss", {
	    description = S"Edelweiss Flower",
	    drawtype = "plantlike",
	    waving = 1,
	    visual_scale = 1.0,
	    tiles = {"naturalbiomes_alpine_edelweiss.png"},
	    inventory_image = "naturalbiomes_alpine_edelweiss.png",
	    wield_image = "naturalbiomes_alpine_edelweiss.png",
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
		name = "naturalbiomes:alpine_log",
		deco_type = "schematic",
		place_on = {"naturalbiomes:alpine_litter"},
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
		biomes = {"naturalbiomes:alpine"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes__alpine_pine1_log_0_90.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "naturalbiomes:alpine_litter",
		num_spawn_by = 4,
	})

	minetest.register_decoration({
		name = "naturalbiomes:alpine_log2",
		deco_type = "schematic",
		place_on = {"naturalbiomes:alpine_litter"},
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
		biomes = {"naturalbiomes:alpine"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("naturalbiomes") .. "/schematics/naturalbiomes_alpine_pine2_log_0_90.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "naturalbiomes:alpine_litter",
		num_spawn_by = 4,
	})

if minetest.get_modpath("bonemeal") then
	bonemeal:add_deco({
		{"naturalbiomes:alpine_litter", {"naturalbiomes:alpine_edelweiss", "naturalbiomes:alpine_dandelion", "naturalbiomes:alpine_grass3", "naturalbiomes:alpine_grass2", "naturalbiomes:alpine_grass1", "naturalbiomes:alpine_mushroom"}, {}}
	})
end