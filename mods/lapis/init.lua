-- mods/lapis/init.lua
-- ===================
-- See LICENSE.txt for licensing and README.md for other information.

-- load support for intllib
local modpath = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator("lapis")

-- Lapis Lazuli Ore
minetest.register_node("lapis:stone_with_lapis", {
	description = S("Lapis Lazuli Ore"),
	tiles = {"default_stone.png^lapis_mineral_lapislazuli.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = {
		max_items = 5,
		items = {
			{
				items = {'lapis:lapis 2'},  --The first and second drops ever
			},
			{
				items = {'lapis:lapis'},    --The 3rd drops with a 1/2 chance
				rarity = 2,
			},
			{
				items = {'lapis:lapis'},    --The 4th drops with a 1/3 chance
				rarity = 3,
			},
			{
				items = {'lapis:lapis'},    --The 5th drops with a 1/8 chance
				rarity = 8,
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

-- Lapis Item
minetest.register_craftitem("lapis:lapis", {
	description = S("Lapis Lazuli"),
	inventory_image = "lapis_lapislazuli.png",
})

-- Lapis Block
minetest.register_node("lapis:lapisblock", {
	description = S("Lapis Lazuli Block"),
	tiles = {"lapis_lapislazuliblock.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- Lapis Block Crafting
minetest.register_craft({
	output = 'lapis:lapisblock',
	recipe = {
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
		{'lapis:lapis', 'lapis:lapis', 'lapis:lapis'},
	}
})

-- Lapis Items from Lapis Block Crafting
minetest.register_craft({
	output = 'lapis:lapis 9',
	recipe = {
		{'lapis:lapisblock'},
	}
})

-- Ore generation
-- -128 <-> -255
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lapis:stone_with_lapis",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 5,
	clust_size     = 3,
	height_min     = -255,
	height_max     = -128,
})

-- -256 <-> -31000
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lapis:stone_with_lapis",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 4,
	height_min     = -31000,
	height_max     = -256,
})


-- Blue dye crafting
minetest.register_craft({
	output = 'dye:blue 2',
	recipe = {
		{'lapis:lapis'},
	}
})
