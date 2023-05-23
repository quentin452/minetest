armor:register_armor("ocular_networks:angmallen_helm", {
	description="Angmallen Helm",
	inventory_image="poly_armor_angmallen_inv_helmet.png",
	texture="poly_armor_helmet_angmallen",
	preview="poly_armor_helmet_angmallen_preview.png",
	groups={armor_head=1, armor_use=100, armor_heal=15},
	armor_groups={fleshy=20},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true
})

armor:register_armor("ocular_networks:angmallen_chest", {
	description="Angmallen Chestplate",
	inventory_image="poly_armor_angmallen_inv_chestplate.png",
	texture="poly_armor_chestplate_angmallen",
	preview="poly_armor_chestplate_angmallen_preview.png",
	groups={armor_torso=1, armor_use=100, armor_heal=15},
	armor_groups={fleshy=30},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true
})

armor:register_armor("ocular_networks:angmallen_legs", {
	description="Angmallen Greaves",
	inventory_image="poly_armor_angmallen_inv_leggings.png",
	texture="poly_armor_leggings_angmallen",
	preview="poly_armor_leggings_angmallen_preview.png",
	groups={armor_legs=1, armor_use=100, armor_heal=15},
	armor_groups={fleshy=30},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true
})

armor:register_armor("ocular_networks:angmallen_boots", {
	description="Angmallen Boots",
	inventory_image="poly_armor_angmallen_inv_boots.png",
	texture="poly_armor_boots_angmallen",
	preview="poly_armor_boots_angmallen_preview.png",
	groups={armor_feet=1, armor_use=100, armor_heal=15},
	armor_groups={fleshy=20},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
})

armor:register_armor("ocular_networks:hekatonium_helm", {
	description=minetest.colorize("#00affa", "Hekaton Helm"),
	inventory_image="poly_armor_hekatonic_inv_helmet.png",
	texture="poly_armor_helmet_hekatonic",
	preview="poly_armor_helmet_hekatonic_preview.png",
	groups={armor_head=1, armor_use=100, armor_heal=20},
	armor_groups={fleshy=25},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true
})

armor:register_armor("ocular_networks:hekatonium_chest", {
	description=minetest.colorize("#00affa", "Hekaton Plate"),
	inventory_image="poly_armor_hekatonic_inv_chestplate.png",
	texture="poly_armor_chestplate_hekatonic",
	preview="poly_armor_chestplate_hekatonic_preview.png",
	groups={armor_torso=1, armor_use=100, armor_heal=20},
	armor_groups={fleshy=60},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true
})

armor:register_armor("ocular_networks:hekatonium_legs", {
	description=minetest.colorize("#00affa", "Hekaton Greaves"),
	inventory_image="poly_armor_hekatonic_inv_leggings.png",
	texture="poly_armor_leggings_hekatonic",
	preview="poly_armor_leggings_hekatonic_preview.png",
	groups={armor_legs=1, armor_use=100, armor_heal=20},
	armor_groups={fleshy=40},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true
})

armor:register_armor("ocular_networks:hekatonium_boots", {
	description=minetest.colorize("#00affa", "Hekaton Boots"),
	inventory_image="poly_armor_hekatonic_inv_boots.png",
	texture="poly_armor_boots_hekatonic",
	preview="poly_armor_boots_hekatonic_preview.png",
	groups={armor_feet=1, armor_use=100, armor_heal=20},
	armor_groups={fleshy=25},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
})

-- begin non-up
local function register_armorType(name, nym, textNym, goodness_mult, goodness_add, mat, pyr)
	armor:register_armor("ocular_networks:"..nym.."_helm", {
		description=name.." Helm",
		inventory_image="poly_armor_inv_helmet_"..textNym..".png",
		texture="poly_armor_helmet_"..textNym,
		preview="poly_armor_helmet_preview_"..textNym..".png",
		groups={armor_head=1, armor_use=100+goodness_add, armor_heal=12, armor_fire=pyr},
		armor_groups={fleshy=3*goodness_mult},
		damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
		reciprocate_damage=true
	})

	armor:register_armor("ocular_networks:"..nym.."_chest", {
		description=name.." Chestplate",
		inventory_image="poly_armor_inv_chestplate_"..textNym..".png",
		texture="poly_armor_chestplate_"..textNym,
		preview="poly_armor_chestplate_preview_"..textNym..".png",
		groups={armor_torso=1, armor_use=100+goodness_add, armor_heal=12, armor_fire=pyr},
		armor_groups={fleshy=5*goodness_mult},
		damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
		reciprocate_damage=true
	})

	armor:register_armor("ocular_networks:"..nym.."_legs", {
		description=name.." Greaves",
		inventory_image="poly_armor_inv_leggings_"..textNym..".png",
		texture="poly_armor_leggings_"..textNym,
		preview="poly_armor_leggings_preview_"..textNym..".png",
		groups={armor_legs=1, armor_use=100+goodness_add, armor_heal=12, armor_fire=pyr},
		armor_groups={fleshy=5*goodness_mult},
		damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
		reciprocate_damage=true
	})

	armor:register_armor("ocular_networks:"..nym.."_boots", {
		description=name.." Boots",
		inventory_image="poly_armor_inv_boots_"..textNym..".png",
		texture="poly_armor_boots_"..textNym,
		preview="poly_armor_boots_preview_"..textNym..".png",
		groups={armor_feet=1, armor_use=100+goodness_add, armor_heal=12, armor_fire=pyr},
		armor_groups={fleshy=3*goodness_mult},
		damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
		reciprocate_damage=true,
	})

	ocular_networks.register_item("ocular_networks:"..nym.."_shield", {
		description=name.." Shield",
		inventory_image="poly_shield_inv_"..textNym..".png",
		texture="poly_shield_"..textNym..".png",
		preview="poly_shield_preview_"..textNym..".png",
		groups={armor_shield=1, armor_use=100+goodness_add, armor_heal=12, armor_fire=pyr},
		armor_groups={fleshy=2*goodness_mult},
		damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
		reciprocate_damage=true,
		stack_max=1,
	})
	
	minetest.register_craft({
	output="ocular_networks:"..nym.."_helm",
	recipe={
		{mat, mat, mat},
		{mat, "", mat},
		{"", "", ""}
	}})
	
	minetest.register_craft({
	output="ocular_networks:"..nym.."_chest",
	recipe={
		{mat, "", mat},
		{mat, mat, mat},
		{mat, mat, mat}
	}})
	
	minetest.register_craft({
	output="ocular_networks:"..nym.."_legs",
	recipe={
		{mat, mat, mat},
		{mat, "", mat},
		{mat, "", mat}
	}})
	
	minetest.register_craft({
	output="ocular_networks:"..nym.."_boots",
	recipe={
		{"", "", ""},
		{mat, "", mat},
		{mat, "", mat}
	}})
	
	minetest.register_craft({
	output="ocular_networks:"..nym.."_shield",
	recipe={
		{mat, "", mat},
		{mat, mat, mat},
		{"", mat, ""}
	}})
end

register_armorType("Luminium", "luminium", "lumi", 3, 0, "ocular_networks:luminium_bar", 0)

register_armorType("Lumigold", "lumigold", "lumig", 2.5, 50, "ocular_networks:luminium_bar_3", 0)

register_armorType("Shimmering", "shimmering", "shim", 5, -25, "ocular_networks:shimmering_bar", 65535)

register_armorType("Silicotin", "silicotin", "silic", 5, -25, "ocular_networks:silicotin_bar", 0)

register_armorType("Zweinium", "zweinium", "zwei", 4, -10, "ocular_networks:zweinium_crystal", 0)
