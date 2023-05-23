
minetest.register_craft({
	output="ocular_networks:guide",
	type="shapeless",
	recipe={"default:book", "default:copper_ingot", "ocular_networks:fibre"},
})

minetest.register_craft({
	output="ocular_networks:fibre 6",
	type="shapeless",
	recipe={"default:grass_1", "default:grass_1"},
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:silver_dust",
	recipe={"default:silver_sand","default:stick"},
	replacements={{"default:silver_sand","default:sand"}}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:lens 3",
	recipe={"ocular_networks:silver_dust","vessels:glass_fragments"}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:luminium_bar_3",
	recipe="ocular_networks:luminium_bar_2",
	cooktime=21
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:luminium_bar",
	recipe="ocular_networks:luminium_lump",
	cooktime=11
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:luminium_bar_2",
	recipe={"ocular_networks:luminium_bar","default:gold_ingot"}
})

minetest.register_craft({
	output="ocular_networks:frame 8",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:luminium_bar_3", "", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:battery",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar_3"},
		{"default:clay", "default:copper_ingot", "default:clay"},
		{"ocular_networks:toxic_slate", "dye:black", "ocular_networks:toxic_slate"}
	}
})

minetest.register_craft({
	output="ocular_networks:distributor 4",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:luminium_bar", "ocular_networks:gearbox", "ocular_networks:luminium_bar"},
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:melter",
	recipe={
		{"ocular_networks:lumigold_rod", "ocular_networks:toxic_slate", "ocular_networks:lumigold_rod"},
		{"ocular_networks:toxic_slate", "default:furnace", "ocular_networks:toxic_slate"},
		{"ocular_networks:lumigold_rod", "ocular_networks:gearbox", "ocular_networks:lumigold_rod"}
	}
})

minetest.register_craft({
	output="ocular_networks:cross 9",
	recipe={
		{"default:tin_ingot", "", "default:tin_ingot"},
		{"", "ocular_networks:luminium_bar_3", ""},
		{"default:tin_ingot", "", "default:tin_ingot"}
	}
})

minetest.register_craft({
	output="ocular_networks:gearbox 5",
	recipe={
		{"ocular_networks:lumigold_rod", "ocular_networks:cross", "ocular_networks:lumigold_rod"},
		{"ocular_networks:cross", "ocular_networks:toxic_slate_chip", "ocular_networks:cross"},
		{"ocular_networks:lumigold_rod", "ocular_networks:cross", "ocular_networks:lumigold_rod"}
	}
})

minetest.register_craft({
	output="ocular_networks:inspector",
	recipe={
		{"ocular_networks:luminium_bar_3", "default:gold_ingot", ""},
		{"default:gold_ingot", "ocular_networks:lens", ""},
		{"", "", "default:stick"}
	}
})

	
minetest.register_craft({
	output="ocular_networks:toxic_slate",
	recipe={
		{"ocular_networks:toxic_slate_chip", "ocular_networks:toxic_slate_chip", "ocular_networks:toxic_slate_chip"},
		{"ocular_networks:toxic_slate_chip", "ocular_networks:toxic_slate_chip", "ocular_networks:toxic_slate_chip"},
		{"ocular_networks:toxic_slate_chip", "ocular_networks:toxic_slate_chip", "ocular_networks:toxic_slate_chip"}
	}
})

minetest.register_craft({
	output="ocular_networks:lumigold_rod 3",
	recipe={
		{"", "ocular_networks:luminium_bar_3", ""},
		{"", "ocular_networks:luminium_bar_3", ""},
		{"", "ocular_networks:luminium_bar_3", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:hammer",
	recipe={
		{"", "ocular_networks:silicotin_bar", "ocular_networks:toxic_slate_chip"},
		{"", "ocular_networks:lumigold_rod", "ocular_networks:silicotin_bar"},
		{"ocular_networks:lumigold_rod", "", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:luminium_block",
	recipe={
		{"ocular_networks:luminium_bar", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar"},
		{"ocular_networks:luminium_bar", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar"},
		{"ocular_networks:luminium_bar", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:luminium_bar 9",
	recipe={"ocular_networks:luminium_block"}
})

minetest.register_craft({
	output="ocular_networks:hekatonium_block",
	recipe={
		{"ocular_networks:hekatonium_bar", "ocular_networks:hekatonium_bar", "ocular_networks:hekatonium_bar"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:hekatonium_bar", "ocular_networks:hekatonium_bar"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:hekatonium_bar", "ocular_networks:hekatonium_bar"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:hekatonium_bar 9",
	recipe={"ocular_networks:hekatonium_block"}
})

minetest.register_craft({
	output="ocular_networks:lumigold_block",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:luminium_bar_3 9",
	recipe={"ocular_networks:lumigold_block"}
})

minetest.register_craft({
	output="ocular_networks:shimmering_block",
	recipe={
		{"ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar"},
		{"ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar"},
		{"ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:shimmering_bar 9",
	recipe={"ocular_networks:shimmering_block"}
})

minetest.register_craft({
	output="ocular_networks:distributor_2",
	recipe={
		{"default:mese_crystal", "", "default:mese_crystal"},
		{"", "ocular_networks:distributor", ""},
		{"default:mese_crystal", "", "default:mese_crystal"}
	}
})

minetest.register_craft({
	output="ocular_networks:distributor_3",
	recipe={
		{"ocular_networks:angmallen_bar", "default:diamond", "ocular_networks:angmallen_bar"},
		{"", "ocular_networks:distributor_2", ""},
		{"ocular_networks:angmallen_bar", "", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:alloyer",
	recipe={
		{"ocular_networks:lumigold_rod", "ocular_networks:gearbox", "ocular_networks:lumigold_rod"},
		{"ocular_networks:toxic_slate", "default:chest_locked", "ocular_networks:toxic_slate"},
		{"default:mese_crystal", "ocular_networks:gearbox", "default:mese_crystal"}
	}
})

minetest.register_craft({
	output="ocular_networks:fuser",
	recipe={
		{"ocular_networks:toxic_slate", "ocular_networks:frame", "ocular_networks:toxic_slate"},
		{"ocular_networks:piston", "default:furnace", "ocular_networks:piston"},
		{"ocular_networks:gearbox", "default:steel_ingot", "ocular_networks:gearbox"}
	}
})

minetest.register_craft({
	output="ocular_networks:fuel 9",
	recipe={
		{"ocular_networks:crud", "ocular_networks:crud", "ocular_networks:crud"},
		{"ocular_networks:crud", "default:coalblock", "ocular_networks:crud"},
		{"ocular_networks:crud", "ocular_networks:crud", "ocular_networks:crud"}
	}
})

minetest.register_craft({
	type="fuel",
	recipe="ocular_networks:fuel",
	burntime=120
})

minetest.register_craft({
	output="ocular_networks:luminium_lump",
	recipe={
		{"ocular_networks:luminium_chip", "ocular_networks:luminium_chip", "ocular_networks:luminium_chip"},
		{"ocular_networks:luminium_chip", "ocular_networks:luminium_chip", "ocular_networks:luminium_chip"},
		{"ocular_networks:luminium_chip", "ocular_networks:luminium_chip", "ocular_networks:luminium_chip"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:piston",
	recipe={"ocular_networks:lumigold_rod","default:steel_ingot"},
})

ocular_networks.register_meltable({
	input="ocular_networks:luminium_block",
	output="ocular_networks:luminium_source",
	cost=100
})

ocular_networks.register_meltable({
	input="ocular_networks:lumigold_block",
	output="ocular_networks:lumigold_source",
	cost=100
})

ocular_networks.register_meltable({
	input="default:goldblock",
	output="ocular_networks:gold_source",
	cost=50
})

ocular_networks.register_meltable({
	input="default:steelblock",
	output="ocular_networks:steel_source",
	cost=500
})

ocular_networks.register_meltable({
	input="default:copperblock",
	output="ocular_networks:copper_source",
	cost=70
})

ocular_networks.register_meltable({
	input="default:bronzeblock",
	output="ocular_networks:bronze_source",
	cost=80
})

ocular_networks.register_meltable({
	input="default:tinblock",
	output="ocular_networks:tin_source",
	cost=90
})

ocular_networks.register_meltable({
	input="ocular_networks:angmallen_block",
	output="ocular_networks:angmallen_source",
	cost=1000
})

ocular_networks.register_meltable({
	input="ocular_networks:hekatonium_block",
	output="ocular_networks:hekatonium_source",
	cost=1000
})

ocular_networks.register_alloyable({
	metal_1="bucket:bucket_lava",
	metal_2="bucket:bucket_water",
	output="default:obsidian 2",
	give_back="bucket:bucket_empty 2",
	cost=100
})

ocular_networks.register_alloyable({
	metal_1="ocular_networks:bucket_luminium",
	metal_2="ocular_networks:bucket_gold",
	output="ocular_networks:bucket_lumigold 2",
	give_back="",
	cost=20
})

ocular_networks.register_alloyable({
	metal_1="ocular_networks:bucket_tin",
	metal_2="ocular_networks:bucket_copper",
	output="ocular_networks:bucket_bronze 2",
	give_back="default:bronze_ingot 2",
	cost=20
})

ocular_networks.register_meltable({
	input="default:stone",
	output="default:lava_source",
	cost=30
})

ocular_networks.register_meltable({
	input="default:snowblock",
	output="default:river_water_source",
	cost=30
})

ocular_networks.register_meltable({
	input="default:ice",
	output="default:water_source",
	cost=10
})

ocular_networks.register_fusion({
	item_1="flowers:mushroom_red",
	item_2="ocular_networks:luminium_lump",
	output="ocular_networks:loomshroom",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="ocular_networks:loomshroom",
	item_2="ocular_networks:loomshroom",
	output="ocular_networks:luminium_chip",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:diamond",
	item_2="default:gold_ingot",
	output="default:mese_crystal",
	give_back="vessels:glass_fragments",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:dirt",
	item_2="default:grass_1",
	output="default:dirt_with_grass",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:dirt",
	item_2="default:dry_grass_1",
	output="default:dirt_with_dry_grass",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:stone",
	item_2="default:gold_ingot",
	output="default:stone_with_gold",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:stone",
	item_2="default:copper_ingot",
	output="default:stone_with_copper",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:stone",
	item_2="default:steel_ingot",
	output="default:stone_with_iron",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="default:stone",
	item_2="default:tin_ingot",
	output="default:stone_with_tin",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="ocular_networks:silver_dust",
	item_2="default:steel_ingot",
	output="ocular_networks:shimmering_bar",
	give_back="",
	cost=1000
})

ocular_networks.register_fusion({
	item_1="default:dirt",
	item_2="default:leaves",
	output="default:dirt 2",
	give_back="",
	cost=100
})

minetest.register_craft({
	output="ocular_networks:reservoir 4",
	recipe={
		{"", "default:copper_ingot", ""},
		{"", "default:chest_locked", ""},
		{"", "default:gold_ingot", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:networknode",
	recipe={
		{"", "ocular_networks:emitter", ""},
		{"", "ocular_networks:luminium_bar", ""},
		{"", "ocular_networks:toxic_slate_chip", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:networknode",
	recipe={
		{"ocular_networks:networknode2"}
	}
})

minetest.register_craft({
	output="ocular_networks:networknode2",
	recipe={
		{"ocular_networks:networknode"}
	}
})

minetest.register_craft({
	output="ocular_networks:peat 9",
	recipe={
		{"ocular_networks:fuel", "ocular_networks:fuel", "ocular_networks:fuel"},
		{"ocular_networks:fuel", "default:coalblock", "ocular_networks:fuel"},
		{"ocular_networks:fuel", "ocular_networks:fuel", "ocular_networks:fuel"}
	}
})

minetest.register_craft({
	output="ocular_networks:blazerifle",
	recipe={
		{"ocular_networks:distributor", "ocular_networks:luminium_bar_3", ""},
		{"ocular_networks:luminium_bar_3", "ocular_networks:lumigold_rod", ""},
		{"", "ocular_networks:gun_stock", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:gun_stock",
	recipe={
		{"default:acacia_wood", "default:junglewood", "default:junglewood"},
		{"", "default:acacia_wood", "default:acacia_wood"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:blazerifle_c",
	recipe={
		{"", "default:copper_ingot", ""},
		{"ocular_networks:angmallen_bar", "ocular_networks:blazerifle", "ocular_networks:angmallen_bar"},
		{"", "ocular_networks:charged_gem", ""}},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:jetring",
	recipe={
		{"default:gold_lump", "ocular_networks:charged_gem", "default:gold_lump"},
		{"ocular_networks:emitter", "ocular_networks:pipe_socket", "ocular_networks:reservoir"},
		{"default:gold_lump", "ocular_networks:charged_gem", "default:gold_lump"}
	}
})

minetest.register_craft({
	output="ocular_networks:healer",
	recipe={
		{"default:acacia_wood", "default:apple", ""},
		{"flowers:mushroom_red", "default:acacia_wood", ""},
		{"", "", "ocular_networks:inspector"}
	}
})

minetest.register_craft({
	output="ocular_networks:firebrick 9",
	recipe={
		{"default:brick", "ocular_networks:peat", "default:brick"},
		{"ocular_networks:peat", "default:brick", "ocular_networks:peat"},
		{"default:brick", "ocular_networks:peat", "default:brick"}
	}
})

ocular_networks.register_alloyable({
	metal_1="ocular_networks:bucket_gold",
	metal_2="ocular_networks:bucket_steel",
	output="ocular_networks:bucket_angmallen",
	give_back="default:steel_ingot",
	cost=5000
})

minetest.register_craft({
	output="ocular_networks:angmallen_block",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:angmallen_bar", "ocular_networks:angmallen_bar"},
		{"ocular_networks:angmallen_bar", "ocular_networks:angmallen_bar", "ocular_networks:angmallen_bar"},
		{"ocular_networks:angmallen_bar", "ocular_networks:angmallen_bar", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_block_2",
	recipe={
		{"ocular_networks:angmallen_block", "ocular_networks:angmallen_block", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:angmallen_block", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:angmallen_block", "ocular_networks:angmallen_block"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:angmallen_bar 9",
	recipe={"ocular_networks:angmallen_block"}
})

minetest.register_craft({
	output="ocular_networks:passive_cooler",
	recipe={
		{"default:ice", "ocular_networks:firebrick", "default:ice"},
		{"ocular_networks:firebrick", "default:chest_locked", "ocular_networks:firebrick"},
		{"default:ice", "ocular_networks:firebrick", "default:ice"}
	}
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_gold",
	output="default:goldblock",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_copper",
	output="default:copperblock",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_tin",
	output="default:tinblock",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_steel",
	output="default:steelblock",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_bronze",
	output="default:bronzeblock",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_luminium",
	output="ocular_networks:luminium_block",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_lumigold",
	output="ocular_networks:lumigold_block",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_angmallen",
	output="ocular_networks:angmallen_block",
})

ocular_networks.register_passive_cool({
	item="ocular_networks:bucket_hekatonium",
	output="ocular_networks:hekatonium_block",
})

ocular_networks.register_fusion({
	item_1="default:diamondblock",
	item_2="default:mese",
	output="ocular_networks:uncharged_gem",
	give_back="",
	cost=10000
})

ocular_networks.register_chargeable({
	item="ocular_networks:uncharged_gem",
	output="ocular_networks:charged_gem",
	cost=300
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:angmallen_block_4",
	recipe={"ocular_networks:angmallen_block_2", "ocular_networks:charged_gem"},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:furnace",
	recipe={
		{"ocular_networks:lumigold_rod", "ocular_networks:lens", "ocular_networks:lumigold_rod"},
		{"ocular_networks:plate_shimmering", "default:furnace", "ocular_networks:plate_shimmering"},
		{"ocular_networks:hekatonium_bar", "default:obsidian", "ocular_networks:hekatonium_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_hammer",
	recipe={
		{"ocular_networks:angmallen_block_4", "ocular_networks:angmallen_block_4", "ocular_networks:angmallen_block_4"},
		{"", "ocular_networks:lumigold_rod", ""},
		{"ocular_networks:rubber", "ocular_networks:lumigold_rod", "ocular_networks:rubber"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_axe",
	recipe={
		{"ocular_networks:angmallen_block_4", "ocular_networks:angmallen_block_4", ""},
		{"ocular_networks:angmallen_block_4", "ocular_networks:lumigold_rod", ""},
		{"ocular_networks:rubber", "ocular_networks:lumigold_rod", "ocular_networks:rubber"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_sword",
	recipe={
		{"", "ocular_networks:angmallen_block_4", ""},
		{"ocular_networks:angmallen_bar", "ocular_networks:angmallen_block_4", "ocular_networks:angmallen_bar"},
		{"ocular_networks:rubber", "ocular_networks:lumigold_rod", "ocular_networks:rubber"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_helm",
	recipe={
		{"ocular_networks:angmallen_block", "ocular_networks:angmallen_block_4", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:charged_gem", "ocular_networks:angmallen_block"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_legs",
	recipe={
		{"ocular_networks:angmallen_block", "ocular_networks:angmallen_block_4", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:charged_gem", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "", "ocular_networks:angmallen_block"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_chest",
	recipe={
		{"ocular_networks:angmallen_block", "", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:charged_gem", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:angmallen_block_4", "ocular_networks:angmallen_block"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_boots",
	recipe={
		{"ocular_networks:angmallen_block", "", "ocular_networks:angmallen_block"},
		{"ocular_networks:angmallen_block", "ocular_networks:charged_gem", "ocular_networks:angmallen_block"},
		{"ocular_networks:piston", "ocular_networks:angmallen_block_4", "ocular_networks:piston"}
	}
})

minetest.register_craft({
	output="ocular_networks:hekatonium_helm",
	recipe={
		{"ocular_networks:hekatonium_block", "ocular_networks:angmallen_helm", "ocular_networks:hekatonium_block"},
		{"ocular_networks:hekatonium_block", "ocular_networks:charged_gem", "ocular_networks:hekatonium_block"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:hekatonium_legs",
	recipe={
		{"ocular_networks:hekatonium_block", "ocular_networks:angmallen_legs", "ocular_networks:hekatonium_block"},
		{"ocular_networks:hekatonium_block", "ocular_networks:charged_gem", "ocular_networks:hekatonium_block"},
		{"ocular_networks:hekatonium_block", "", "ocular_networks:hekatonium_block"}
	}
})

minetest.register_craft({
	output="ocular_networks:hekatonium_chest",
	recipe={
		{"ocular_networks:hekatonium_block", "", "ocular_networks:hekatonium_block"},
		{"ocular_networks:hekatonium_block", "ocular_networks:charged_gem", "ocular_networks:hekatonium_block"},
		{"ocular_networks:hekatonium_block", "ocular_networks:angmallen_chest", "ocular_networks:hekatonium_block"}
	}
})

minetest.register_craft({
	output="ocular_networks:hekatonium_boots",
	recipe={
		{"ocular_networks:hekatonium_block", "", "ocular_networks:hekatonium_block"},
		{"ocular_networks:hekatonium_block", "ocular_networks:charged_gem", "ocular_networks:hekatonium_block"},
		{"ocular_networks:piston", "ocular_networks:angmallen_boots", "ocular_networks:piston"}
	}
})

minetest.register_craft({
	output="ocular_networks:performance_controller",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:hekatonium_bar", "ocular_networks:silicotin_bar"},
		{"ocular_networks:rubber", "ocular_networks:inspector", "ocular_networks:rubber"},
		{"default:diamond", "ocular_networks:armor_pendant", "default:diamond"}
	}
})

minetest.register_craft({
	output="ocular_networks:armor_pendant",
	recipe={
		{"farming:cotton", "farming:cotton", "farming:cotton"},
		{"farming:cotton", "", "farming:cotton"},
		{"", "ocular_networks:angmallen_bar", "ocular_networks:charged_gem"}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:charger",
	recipe={
		{"ocular_networks:cross", "default:copperblock", "ocular_networks:cross"},
		{"ocular_networks:frame", "ocular_networks:distributor_3", "ocular_networks:frame"},
		{"ocular_networks:cross", "ocular_networks:gearbox", "ocular_networks:cross"}
	}
})

minetest.register_craft({
	output="ocular_networks:angmallen_shield",
	recipe={
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "ocular_networks:angmallen_block", "default:bronze_ingot"},
		{"", "default:bronze_ingot", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:pipe_socket 10",
	recipe={
		{"ocular_networks:luminium_bar_3", "default:tin_ingot", "ocular_networks:luminium_bar_3"},
		{"default:tin_ingot", "", "default:tin_ingot"},
		{"ocular_networks:luminium_bar_3", "default:tin_ingot", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:pipe_socket_filter 5",
	recipe={
		{"ocular_networks:luminium_bar_3", "default:tin_ingot", "ocular_networks:luminium_bar_3"},
		{"default:tin_ingot", "default:glass", "default:tin_ingot"},
		{"ocular_networks:luminium_bar_3", "default:tin_ingot", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:pipe_E 10",
	recipe={
		{"", "ocular_networks:pipe_socket", ""},
		{"ocular_networks:plate_silicotin", "default:chest_locked", "ocular_networks:plate_silicotin"},
		{"", "ocular_networks:pipe_socket", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:laserdrill",
	recipe={
		{"ocular_networks:toxic_slate", "ocular_networks:pipe_socket", "ocular_networks:toxic_slate"},
		{"ocular_networks:silicotin_block", "ocular_networks:charged_gem", "ocular_networks:silicotin_block"},
		{"ocular_networks:frame", "ocular_networks:charged_gem", "ocular_networks:frame"}
	}
})

minetest.register_craft({
	output="ocular_networks:laserdrillchest",
	recipe={
		{"default:diamondblock", "ocular_networks:distributor", "default:diamondblock"},
		{"ocular_networks:plate_silicotin", "default:chest_locked", "ocular_networks:plate_silicotin"},
		{"ocular_networks:silicotin_block", "ocular_networks:pipe_socket", "ocular_networks:silicotin_block"}
	}
})

minetest.register_craft({
	output="ocular_networks:pipe_itembuffer 9",
	recipe={
		{"ocular_networks:lumigold_block", "ocular_networks:pipe_socket", "ocular_networks:lumigold_block"},
		{"ocular_networks:pipe_socket", "default:chest_locked", "ocular_networks:pipe_socket"},
		{"ocular_networks:lumigold_block", "ocular_networks:pipe_socket", "ocular_networks:lumigold_block"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:pipe_E",
	recipe={"ocular_networks:pipe_U"},
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:pipe_U",
	recipe={"ocular_networks:pipe_E"},
})

ocular_networks.register_fusion({
	item_1="default:tin_ingot",
	item_2="default:glass",
	output="ocular_networks:silicotin_bar",
	give_back="",
	cost=1000
})

minetest.register_craft({
	output="ocular_networks:pipe_wrench",
	recipe={
		{"", "ocular_networks:pipe_socket", "ocular_networks:silicotin_bar"},
		{"", "ocular_networks:silicotin_bar", ""},
		{"ocular_networks:silicotin_bar", "", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:silicotin_block",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar"},
		{"ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar"},
		{"ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:silicotin_bar 9",
	recipe={"ocular_networks:silicotin_block"},
})

minetest.register_craft({
	output="ocular_networks:pipe_trashextractor",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:pipe_socket_filter", "ocular_networks:silicotin_bar"},
		{"ocular_networks:silicotin_bar", "ocular_networks:melter", "ocular_networks:silicotin_bar"},
		{"ocular_networks:frame", "ocular_networks:silicotin_bar", "ocular_networks:frame"}
	}
})

minetest.register_craft({
	output="ocular_networks:pipe_filtered_E 5",
	recipe={
		{"", "ocular_networks:pipe_socket_filter", ""},
		{"ocular_networks:silicotin_bar", "ocular_networks:pipe_E", "ocular_networks:silicotin_bar"},
		{"", "", ""}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:pipe_filtered_E",
	recipe={"ocular_networks:pipe_filtered_D"},
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:pipe_filtered_D",
	recipe={"ocular_networks:pipe_filtered_E"},
})

ocular_networks.register_fusion({
	item_1="default:dirt_with_grass",
	item_2="ocular_networks:loomshroom",
	output="ocular_networks:dirt_with_loomshroom_grass",
	give_back="",
	cost=100
})

ocular_networks.register_fusion({
	item_1="ocular_networks:hekatonium_chunk",
	item_2="ocular_networks:hekatonium_chunk",
	output="ocular_networks:hekatonium_bar",
	give_back="",
	cost=1000
})

minetest.register_craft({
	output="ocular_networks:hekaton_hammer",
	recipe={
		{"", "ocular_networks:hekatonium_bar", ""},
		{"ocular_networks:hekatonium_block", "ocular_networks:angmallen_hammer", "ocular_networks:hekatonium_block"},
		{"", "ocular_networks:erena_sphere", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:hekaton_axe",
	recipe={
		{"", "ocular_networks:hekatonium_bar", ""},
		{"ocular_networks:hekatonium_block", "ocular_networks:angmallen_axe", "ocular_networks:hekatonium_block"},
		{"", "ocular_networks:erena_sphere", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:hekaton_sword",
	recipe={
		{"", "ocular_networks:hekatonium_bar", ""},
		{"ocular_networks:hekatonium_block", "ocular_networks:angmallen_sword", "ocular_networks:hekatonium_block"},
		{"", "ocular_networks:erena_sphere", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:erena_sphere",
	recipe={
		{"ocular_networks:angmallen_bar", "default:stick", "ocular_networks:angmallen_bar"},
		{"default:stick", "ocular_networks:charged_gem", "default:stick"},
		{"ocular_networks:angmallen_bar", "default:stick", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:barrel",
	recipe={
		{"ocular_networks:silicotin_bar", "default:steel_ingot", "ocular_networks:silicotin_bar"},
		{"ocular_networks:silicotin_block", "ocular_networks:lens", "ocular_networks:pipe_socket"},
		{"ocular_networks:silicotin_bar", "default:steel_ingot", "ocular_networks:silicotin_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:gun_stock2",
	recipe={
		{"ocular_networks:rubber", "ocular_networks:rubber", "ocular_networks:rubber"},
		{"", "ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar"},
		{"", "", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:scope",
	recipe={
		{"ocular_networks:plate_silicotin", "ocular_networks:hekatonium_bar", "ocular_networks:plate_silicotin"},
		{"ocular_networks:lens", "ocular_networks:cross", "ocular_networks:lens"},
		{"ocular_networks:plate_silicotin", "ocular_networks:hekatonium_bar", "ocular_networks:plate_silicotin"}
	}
})
minetest.register_craft({
	output="ocular_networks:erena_blaster",
	recipe={
		{"ocular_networks:hekatonium_bar", "ocular_networks:scope", "ocular_networks:gearbox"},
		{"ocular_networks:barrel", "ocular_networks:blazerifle_c", "ocular_networks:gun_stock2"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:pipe_wrench", "ocular_networks:erena_sphere"}
	}
})

minetest.register_craft({
	type="cooking",
	output="bucket:bucket_river_water",
	recipe="bucket:bucket_water",
	cooktime=11
})

minetest.register_craft({
	output="ocular_networks:boiler",
	recipe={
		{"ocular_networks:plate_lumigold", "ocular_networks:pipe_socket", "ocular_networks:plate_lumigold"},
		{"default:bronze_ingot", "ocular_networks:gearbox", "default:bronze_ingot"},
		{"ocular_networks:plate_lumigold", "ocular_networks:pipe_socket", "ocular_networks:plate_lumigold"}
	}
})

minetest.register_craft({
	output="ocular_networks:bolumiary",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:lens", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:toxic_slate", "dye:green", "ocular_networks:toxic_slate"},
		{"ocular_networks:luminium_bar_3", "ocular_networks:cross", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:shroom_planter",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:loomshroom", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:toxic_slate", "ocular_networks:luminium_bar", "ocular_networks:toxic_slate"},
		{"ocular_networks:frame", "ocular_networks:cross", "ocular_networks:frame"}
	}
})

--

minetest.register_craft({
	output="ocular_networks:luminium_pick",
	recipe={
		{"ocular_networks:luminium_bar", "ocular_networks:luminium_bar", "ocular_networks:luminium_bar"},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:lumigold_pick",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3"},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:silicotin_pick",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar"},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:shimmering_pick",
	recipe={
		{"ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar"},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:luminium_axe",
	recipe={
		{"ocular_networks:luminium_bar", "ocular_networks:luminium_bar", ""},
		{"ocular_networks:luminium_bar", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:lumigold_axe",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar_3", ""},
		{"ocular_networks:luminium_bar_3", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:silicotin_axe",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar", ""},
		{"ocular_networks:silicotin_bar", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:shimmering_axe",
	recipe={
		{"ocular_networks:shimmering_bar", "ocular_networks:shimmering_bar", ""},
		{"ocular_networks:shimmering_bar", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:luminium_shovel",
	recipe={
		{"", "ocular_networks:luminium_bar", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:lumigold_shovel",
	recipe={
		{"", "ocular_networks:luminium_bar_3", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:silicotin_shovel",
	recipe={
		{"", "ocular_networks:silicotin_bar", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:shimmering_shovel",
	recipe={
		{"", "ocular_networks:shimmering_bar", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:luminium_sword",
	recipe={
		{"", "ocular_networks:luminium_bar", ""},
		{"", "ocular_networks:luminium_bar", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:lumigold_sword",
	recipe={
		{"", "ocular_networks:luminium_bar_3", ""},
		{"", "ocular_networks:luminium_bar_3", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:silicotin_sword",
	recipe={
		{"", "ocular_networks:silicotin_bar", ""},
		{"", "ocular_networks:silicotin_bar", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:shimmering_sword",
	recipe={
		{"", "ocular_networks:shimmering_bar", ""},
		{"", "ocular_networks:shimmering_bar", ""},
		{"", "group:stick", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:composite_scythe",
	recipe={
		{"ocular_networks:shimmering_bar", "ocular_networks:luminium_bar_3", "ocular_networks:luminium_bar"},
		{"", "ocular_networks:lumigold_rod", ""},
		{"ocular_networks:silicotin_bar", "", ""}
	}
})

ocular_networks.register_shroomable({
	node="ocular_networks:loomshroom",
	output="ocular_networks:luminium_lump",
	cost=5000,
})

ocular_networks.register_shroomable({
	node="flowers:mushroom_red",
	output="flowers:mushroom_red",
	cost=500,
})

ocular_networks.register_shroomable({
	node="flowers:mushroom_brown",
	output="flowers:mushroom_brown",
	cost=500,
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:zweinium_crystal",
	recipe="ocular_networks:zweinium_crystal_chunk",
})

ocular_networks.register_fusion({
	item_1="ocular_networks:lens",
	item_2="ocular_networks:zweinium_crystal",
	output="ocular_networks:zweinium_lens",
	give_back="",
	cost=1000
})

minetest.register_craft({
	output="ocular_networks:zweinium_block",
	recipe={
		{"ocular_networks:zweinium_crystal", "ocular_networks:zweinium_crystal", "ocular_networks:zweinium_crystal"},
		{"ocular_networks:zweinium_crystal", "ocular_networks:zweinium_crystal", "ocular_networks:zweinium_crystal"},
		{"ocular_networks:zweinium_crystal", "ocular_networks:zweinium_crystal", "ocular_networks:zweinium_crystal"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:zweinium_crystal 9",
	recipe={"ocular_networks:zweinium_block"}
})


ocular_networks.register_meltable({
	input="ocular_networks:zweinium_block",
	output="ocular_networks:zweinium_source",
	cost=10
})

minetest.register_craft({
	output="ocular_networks:bucket_coolant",
	recipe={
		{"ocular_networks:freeElem_nitrogen", "ocular_networks:freeElem_nitrogen", "ocular_networks:freeElem_nitrogen"},
		{"ocular_networks:freeElem_nitrogen", "ocular_networks:bucket_zweinium", "ocular_networks:freeElem_nitrogen"},
		{"ocular_networks:freeElem_nitrogen", "ocular_networks:freeElem_nitrogen", "ocular_networks:freeElem_nitrogen"}
	}
})

ocular_networks.register_dessicable({
	material="default:dirt",
	cost=100,
	output="ocular_networks:freeElem_nitrogen 10"
})

minetest.register_craft({
	output="ocular_networks:ton_core",
	recipe={
		{"ocular_networks:hekatonium_block", "ocular_networks:frame", "ocular_networks:hekatonium_block"},
		{"ocular_networks:gearbox", "ocular_networks:erenic_block", "ocular_networks:gearbox"},
		{"ocular_networks:hekatonium_block", "ocular_networks:distributor_3", "ocular_networks:hekatonium_block"}
	}
})

minetest.register_craft({
	output="ocular_networks:erenic_block",
	recipe={
		{"ocular_networks:erena_sphere", "ocular_networks:erena_sphere", "ocular_networks:erena_sphere"},
		{"ocular_networks:erena_sphere", "ocular_networks:erena_sphere", "ocular_networks:erena_sphere"},
		{"ocular_networks:erena_sphere", "ocular_networks:erena_sphere", "ocular_networks:erena_sphere"}
	}
})

ocular_networks.register_dessicable({
	material="default:coal_lump",
	cost=100,
	output="ocular_networks:freeElem_carbon 30"
})

ocular_networks.register_fusion({
	item_1="ocular_networks:freeElem_carbon 8",
	item_2="ocular_networks:fuel",
	output="ocular_networks:superfuel",
	give_back="",
	cost=100
})

ocular_networks.register_dessicable({
	material="ocular_networks:placeholder_any_item",
	cost=10,
	output="ocular_networks:crud"
})

ocular_networks.register_dessicable({
	material="default:leaves",
	cost=10,
	output="ocular_networks:freeElem_hydrogen 20"
})

ocular_networks.register_dessicable({
	material="default:obsidian_shard",
	cost=10,
	output="ocular_networks:freeElem_sulfur 15"
})

ocular_networks.register_dessicable({
	material="default:iron_lump",
	cost=10,
	output="ocular_networks:freeElem_iron 30"
})

ocular_networks.register_dessicable({
	material="default:gold_lump",
	cost=10,
	output="ocular_networks:freeElem_gold 30"
})

ocular_networks.register_dessicable({
	material="default:copper_lump",
	cost=10,
	output="ocular_networks:freeElem_copper 30"
})

ocular_networks.register_dessicable({
	material="default:tin_lump",
	cost=10,
	output="ocular_networks:freeElem_tin 99"
})


ocular_networks.register_dessicable({
	material="default:silver_sand",
	cost=10,
	output="ocular_networks:freeElem_silicon 15"
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_luminium",
	recipe={"ocular_networks:luminium_bar","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:luminium_bar",
	recipe="ocular_networks:dust_luminium",
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_lumigold",
	recipe={"ocular_networks:luminium_bar_3","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:luminium_bar_3",
	recipe="ocular_networks:dust_lumigold",
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_angmallen",
	recipe={"ocular_networks:angmallen_bar","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:angmallen_bar",
	recipe="ocular_networks:dust_angmallen",
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_shimmering",
	recipe={"ocular_networks:shimmering_bar","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:shimmering_bar",
	recipe="ocular_networks:dust_shimmering",
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_silicotin",
	recipe={"ocular_networks:silicotin_bar","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:silicotin_bar",
	recipe="ocular_networks:dust_silicotin",
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_zweinium",
	recipe={"ocular_networks:zweinium_crystal","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:zweinium_crystal",
	recipe="ocular_networks:dust_zweinium",
})

ocular_networks.register_fusion({
	item_1="ocular_networks:toxic_slate_chip",
	item_2="ocular_networks:toxic_slate_chip",
	output="ocular_networks:toxic_slate_rod",
	give_back="",
	cost=100
})

minetest.register_craft({
	output="ocular_networks:chem_oven",
	recipe={
		{"ocular_networks:shimmering_bar", "ocular_networks:firebrick", "ocular_networks:shimmering_bar"},
		{"ocular_networks:firebrick", "ocular_networks:melter", "ocular_networks:firebrick"},
		{"ocular_networks:shimmering_bar", "ocular_networks:zweinium_crystal", "ocular_networks:shimmering_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:insertor 4",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:toxic_slate_chip", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:lumigold_rod", "ocular_networks:distributor", "ocular_networks:lumigold_rod"},
		{"ocular_networks:luminium_bar_3", "default:chest", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:repairer",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:emitter", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:silicotin_bar", "ocular_networks:zweinium_lens", "ocular_networks:silicotin_bar"},
		{"ocular_networks:luminium_bar_3", "ocular_networks:charger", "ocular_networks:luminium_bar_3"}
	}
})

minetest.register_craft({
	output="ocular_networks:emitter 8",
	recipe={
		{"ocular_networks:luminium_bar_3", "default:diamond", "ocular_networks:luminium_bar_3"},
		{"default:copper_ingot", "ocular_networks:luminium_bar_3", "default:copper_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"}
	}
})

minetest.register_craft({
	output="ocular_networks:grinder",
	recipe={
		{"ocular_networks:lumigold_rod", "ocular_networks:pipe_itembuffer", "ocular_networks:lumigold_rod"},
		{"ocular_networks:piston", "ocular_networks:frame", "ocular_networks:piston"},
		{"default:steel_ingot", "ocular_networks:gearbox", "default:steel_ingot"}
	}
})

ocular_networks.register_grindable({
	input="default:stone",
	output="default:gravel 5",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:cobble",
	output="default:gravel 4",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:sandstone",
	output="default:sand 4",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:desert_sandstone",
	output="default:desert_sand 4",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:silver_sandstone",
	output="default:silver_sand 4",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:wood",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:acacia_wood",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:junglewood",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:pine_wood",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:aspen_wood",
	output="ocular_networks:mulch",
	cost="350"
})


ocular_networks.register_grindable({
	input="default:leaves",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:acacia_leaves",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:jungleleaves",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:pine_needles",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:aspen_leaves",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:acacia_bush_leaves",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="default:bush_leaves",
	output="ocular_networks:mulch",
	cost="350"
})

ocular_networks.register_grindable({
	input="ocular_networks:zweinium_crystal",
	output="ocular_networks:dust_zweinium",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:zweinium_crystal_chunk",
	output="ocular_networks:dust_zweinium 2",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:silicotin_bar",
	output="ocular_networks:dust_silicotin",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:shimmering_bar",
	output="ocular_networks:dust_shimmering",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:angmallen_bar",
	output="ocular_networks:dust_angmallen",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:luminium_bar",
	output="ocular_networks:dust_luminium",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:luminium_lump",
	output="ocular_networks:dust_luminium 2",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:luminium_bar_3",
	output="ocular_networks:dust_lumigold",
	cost="700"
})

ocular_networks.register_grindable({
	input="ocular_networks:toxic_slate_chip",
	output="ocular_networks:dust_slate",
	cost="700"
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:dust_slate",
	recipe={"ocular_networks:toxic_slate_chip","ocular_networks:hammer"},
	replacements={{"ocular_networks:hammer","ocular_networks:hammer"}}
})

minetest.register_craft({
	type="cooking",
	output="ocular_networks:toxic_slate_chip",
	recipe="ocular_networks:dust_slate",
})

minetest.register_craft({
	output="ocular_networks:forge",
	recipe={
		{"ocular_networks:luminium_bar_3", "default:steel_ingot", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:piston", "ocular_networks:pipe_socket", "ocular_networks:piston"},
		{"ocular_networks:luminium_bar_3", "default:steel_ingot", "ocular_networks:luminium_bar_3"}
	}
})

ocular_networks.register_forgable({
	input="ocular_networks:luminium_bar",
	output="ocular_networks:plate_luminium",
	cost="500"
})

ocular_networks.register_forgable({
	input="ocular_networks:luminium_bar_3",
	output="ocular_networks:plate_lumigold",
	cost="500"
})

ocular_networks.register_forgable({
	input="ocular_networks:silicotin_bar",
	output="ocular_networks:plate_silicotin",
	cost="500"
})

ocular_networks.register_forgable({
	input="ocular_networks:shimmering_bar",
	output="ocular_networks:plate_shimmering",
	cost="500"
})

ocular_networks.register_forgable({
	input="default:sand_with_kelp",
	output="default:paper",
	cost="150"
})

minetest.register_craft({
	output="ocular_networks:wire 10",
	recipe={
		{"ocular_networks:rubber", "", "ocular_networks:rubber"},
		{"ocular_networks:luminium_bar", "ocular_networks:zweinium_crystal", "ocular_networks:luminium_bar"},
		{"ocular_networks:rubber", "", "ocular_networks:rubber"}
	}
})

minetest.register_craft({
	output="ocular_networks:rubber 6",
	recipe={
		{"ocular_networks:freeElem_silicon", "ocular_networks:freeElem_hydrogen", "ocular_networks:freeElem_silicon"},
		{"ocular_networks:freeElem_carbon", "ocular_networks:freeElem_sulfur", "ocular_networks:freeElem_carbon"},
		{"ocular_networks:freeElem_silicon", "ocular_networks:freeElem_hydrogen", "ocular_networks:freeElem_silicon"}
	}
})

ocular_networks.register_forgable({
	input="ocular_networks:erena_blaster",
	output="ocular_networks:ruined_gun",
	cost="10000"
})


minetest.register_craft({
	output="ocular_networks:aurometer",
	recipe={
		{"", "ocular_networks:luminium_bar_3", ""},
		{"default:stick", "default:copper_ingot", "default:stick"},
		{"", "ocular_networks:luminium_bar_3", ""}
	}
})

ocular_networks.register_grindable({
	input="default:papyrus",
	output="ocular_networks:gum",
	cost="200"
})

minetest.register_craft({
	output="ocular_networks:cultivator",
	recipe={
		{"ocular_networks:luminium_bar_3", "ocular_networks:mulch", "ocular_networks:luminium_bar_3"},
		{"ocular_networks:toxic_slate", "default:diamond", "ocular_networks:toxic_slate"},
		{"", "ocular_networks:bolumiary", ""}
	}
})

minetest.register_craft({
	output="ocular_networks:fertiliser 20",
	recipe={
		{"ocular_networks:mulch", "ocular_networks:gum", "ocular_networks:freeElem_nitrogen"},
		{"default:clay_lump", "ocular_networks:freeElem_nitrogen", "ocular_networks:freeElem_nitrogen"}
	}
})

ocular_networks.register_cultivateable({
	plant="default:grass_1",
	output="default:grass_1",
	cost=250,
})

ocular_networks.register_cultivateable({
	plant="default:junglegrass",
	output="default:junglegrass",
	cost=250,
})

ocular_networks.register_cultivateable({
	plant="default:papyrus",
	output="default:papyrus",
	cost=250,
})

if minetest.get_modpath("farming") then
	ocular_networks.register_cultivateable({
		plant="farming:seed_cotton",
		output="farming:cotton",
		cost=500,
	})
	
	ocular_networks.register_cultivateable({
		plant="farming:seed_wheat",
		output="farming:wheat",
		cost=500,
	})
end

if minetest.get_modpath("flowers") then
	ocular_networks.register_cultivateable({
		plant="flowers:rose",
		output="flowers:rose",
		cost=500,
	})
	
	ocular_networks.register_cultivateable({
		plant="flowers:dandelion_yellow",
		output="flowers:dandelion_yellow",
		cost=500,
	})
	
	ocular_networks.register_cultivateable({
		plant="flowers:dandelion_white",
		output="flowers:dandelion_white",
		cost=500,
	})
	
	ocular_networks.register_cultivateable({
		plant="flowers:geranium",
		output="flowers:geranium",
		cost=500,
	})
	
	ocular_networks.register_cultivateable({
		plant="flowers:tulip",
		output="flowers:tulip",
		cost=500,
	})
	
	ocular_networks.register_cultivateable({
		plant="flowers:viola",
		output="flowers:viola",
		cost=500,
	})
end

ocular_networks.register_cultivateable({
	plant="default:acacia_sapling",
	output="default:acacia_leaves 5",
	cost=1000,
})

ocular_networks.register_cultivateable({
	plant="default:aspen_sapling",
	output="default:aspen_leaves 5",
	cost=1000,
})

ocular_networks.register_cultivateable({
	plant="default:junglesapling",
	output="default:jungleleaves 10",
	cost=1000,
})

ocular_networks.register_cultivateable({
	plant="default:sapling",
	output="default:leaves 5",
	cost=1000,
})

ocular_networks.register_cultivateable({
	plant="default:pine_sapling",
	output="default:pine_needles 5",
	cost=1000,
})

minetest.register_craft({
	output="ocular_networks:crafter",
	recipe={
		{"ocular_networks:plate_silicotin", "default:paper", "ocular_networks:plate_silicotin"},
		{"ocular_networks:plate_silicotin", "default:chest_locked", "ocular_networks:plate_silicotin"},
		{"ocular_networks:plate_silicotin", "ocular_networks:pipe_socket", "ocular_networks:plate_silicotin"}
	}
})

minetest.register_craft({
	output="ocular_networks:pump",
	recipe={
		{"ocular_networks:plate_silicotin", "bucket:bucket_empty", "ocular_networks:plate_silicotin"},
		{"ocular_networks:tank", "ocular_networks:tank", "ocular_networks:tank"},
		{"ocular_networks:plate_silicotin", "ocular_networks:pipe_socket", "ocular_networks:plate_silicotin"}
	}
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:faucet",
	recipe={"ocular_networks:pump"},
})

minetest.register_craft({
	type="shapeless",
	output="ocular_networks:pump",
	recipe={"ocular_networks:faucet"},
})

minetest.register_craft({
	output="ocular_networks:tank 4",
	recipe={
		{"ocular_networks:firebrick", "default:glass", "ocular_networks:firebrick"},
		{"default:glass", "ocular_networks:frame", "default:glass"},
		{"ocular_networks:firebrick", "default:glass", "ocular_networks:firebrick"}
	}
})

minetest.register_craft({
	output="ocular_networks:bucketer",
	recipe={
		{"ocular_networks:firebrick", "default:copper_ingot", "ocular_networks:firebrick"},
		{"ocular_networks:tank", "ocular_networks:frame", "bucket:bucket_empty"},
		{"ocular_networks:firebrick", "ocular_networks:plate_silicotin", "ocular_networks:firebrick"}
	}
})

minetest.register_craft({
	output="ocular_networks:cable 15",
	recipe={
		{"ocular_networks:rubber", "ocular_networks:rubber", "ocular_networks:rubber"},
		{"ocular_networks:emitter", "ocular_networks:luminium_bar_2", "ocular_networks:lens"},
		{"ocular_networks:rubber", "ocular_networks:rubber", "ocular_networks:rubber"}
	}
})

minetest.register_craft({
	output="ocular_networks:router",
	recipe={
		{"ocular_networks:rubber", "ocular_networks:plate_luminium", "ocular_networks:rubber"},
		{"ocular_networks:plate_luminium", "ocular_networks:frame", "ocular_networks:plate_luminium"},
		{"ocular_networks:rubber", "ocular_networks:cable", "ocular_networks:rubber"}
	}
})


minetest.register_craft({
	output="ocular_networks:reservoir2",
	recipe={
		{"ocular_networks:rubber", "", "ocular_networks:rubber"},
		{"ocular_networks:plate_luminium", "ocular_networks:reservoir", "ocular_networks:plate_luminium"},
		{"", "ocular_networks:cable", ""}
	}
})
