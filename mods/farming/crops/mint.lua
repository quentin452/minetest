
local S = farming.intllib

-- mint seed
minetest.register_node("farming:seed_mint", {
	description = S("Mint Seeds"),
	tiles = {"farming_mint_seeds.png"},
	inventory_image = "farming_mint_seeds.png",
	wield_image = "farming_mint_seeds.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, growing = 1, flammable = 2},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	next_plant = "farming:mint_1",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:seed_mint")
	end
})

-- mint leaf
minetest.register_craftitem("farming:mint_leaf", {
	description = S("Mint Leaf"),
	inventory_image = "farming_mint_leaf.png",
	groups = {food_mint = 1, flammable = 4}
})

-- mint tea
minetest.register_craftitem("farming:mint_tea", {
	description = S("Mint Tea"),
	inventory_image = "farming_mint_tea.png",
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {flammable = 4}
})

minetest.register_craft({
	output = "farming:mint_tea",
	recipe = {
		{"group:food_mint", "group:food_mint", "group:food_mint"},
		{"group:food_water_glass", "farming:juicer", ""}
	},
	replacements = {
		{"group:food_juicer", "farming:juicer"}
	}
})


-- mint definition
local def = {
	drawtype = "plantlike",
	tiles = {"farming_mint_1.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:mint_1", table.copy(def))

-- stage 2
def.tiles = {"farming_mint_2.png"}
minetest.register_node("farming:mint_2", table.copy(def))

-- stage 3
def.tiles = {"farming_mint_3.png"}
minetest.register_node("farming:mint_3", table.copy(def))

-- stage 4 (final)
def.tiles = {"farming_mint_4.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:mint_leaf 2"}, rarity = 1},
		{items = {"farming:mint_leaf 2"}, rarity = 2},
		{items = {"farming:seed_mint 1"}, rarity = 1},
		{items = {"farming:seed_mint 2"}, rarity = 2}
	}
}
minetest.register_node("farming:mint_4", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:mint"] = {
	crop = "farming:mint",
	seed = "farming:seed_mint",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 4
}

-- mapgen
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.mint,
		spread = {x = 100, y = 100, z = 100},
		seed = 801,
		octaves = 3,
		persist = 0.6
	},
	y_min = 0,
	y_max = 75,
	decoration = "farming:mint_4",
	spawn_by = {"group:water", "group:sand"},
	num_spawn_by = 1
})
