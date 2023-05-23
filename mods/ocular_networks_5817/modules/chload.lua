ocular_networks.register_node("ocular_networks:tether", {
	description=minetest.colorize("#00affa", "Universe Tether"),
	tiles={
		{
			name="poly_hekaton_core2.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	is_ground_content=false,
	groups={cracky=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_string("enabled", "true")
		minetest.forceload_block(pos)
	end,
	on_destruct=function(pos)
		minetest.forceload_free_block(pos)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
})

minetest.register_craft({
	output="ocular_networks:tether",
	recipe={
		{"ocular_networks:hekatonium_bar", "ocular_networks:networkprobe", "ocular_networks:hekatonium_bar"},
		{"ocular_networks:angmallen_block_4", "ocular_networks:erenic_block", "ocular_networks:angmallen_block_4"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:angmallen_block_4", "ocular_networks:hekatonium_bar"}
	}
})
