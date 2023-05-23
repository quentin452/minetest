
-- sounds :
-- swoosh1 : https://freesound.org/people/lesaucisson/sounds/585257/
-- swoosh2 : https://freesound.org/people/lesaucisson/sounds/585256/


--- Cudgel 
minetest.register_tool("toolx:baseball_bat", {
	description = "Baseball bat",
	inventory_image = "Cudgel_stone.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})


--- AXE :

minetest.register_tool("toolx:fireaxe", {
	description = "Fireaxe",
	inventory_image = "axe_zombie.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

-- KNIFE:
minetest.register_tool("toolx:knife", {
	description = "Knife",
	inventory_image = "knife.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

