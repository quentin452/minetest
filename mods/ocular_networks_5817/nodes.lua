local nodespec=""..
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0.7,0;Source Location:]"..
"field[1,1;2,1;sourcex;x;${sourceposx}]"..
"field[4,1;2,1;sourcey;y;${sourceposy}]"..
"field[7,1;2,1;sourcez;z;${sourceposz}]"..
"label[0.7,2;positions are relative to the networking node.]"..
"field[1,4.4;8,1;power;power is at:;${ocular_power}]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,5;8,1;save;Save]"

local pumpspec=""..
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0.7,0;Source Location:]"..
"field[1,1;2,1;sourcex;x;${sourceposx}]"..
"field[4,1;2,1;sourcey;y;${sourceposy}]"..
"field[7,1;2,1;sourcez;z;${sourceposz}]"..
"label[0.7,2;positions are relative to the pump.]"..
"list[context;liq;4,2.5;2,2;]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,5;8,1;save;Save]"

local nodespec2=""..
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0.7,0;Source Location:]"..
"field[1,1;2,1;sourcex;x;${sourceposx}]"..
"field[4,1;2,1;sourcey;y;${sourceposy}]"..
"field[7,1;2,1;sourcez;z;${sourceposz}]"..
"label[0.7,1.7;positions are relative to the networking node.]"..
"field[1,2.7;8,1;draw;input amount to take:;${draw}]"..
"field[1,4.4;8,1;power;power is at:;${ocular_power}]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,5;8,1;save;Save]"

local trashspec=""..
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"field[1,2.7;8,1;items;input items to take:;${items}]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,5;8,1;save;Save]"

local meltspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[3.5,1.5;Input (input)]"..
"list[context;input;3.5,2;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local chemspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[2.5,1;Input (input)]"..
"list[context;input;2.5,1.5;1,1;Input (input)]"..
"label[2.5,2.1;Fuel (fuel)]"..
"list[context;fuel;2.5,2.5;1,1;]"..
"label[4.5,1.5;Output (output)]"..
"list[context;output;4.5,2;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local shroomspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[-0.1,-0.2;Output (output)]"..
"list[context;output;0,0;8,4;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local coolspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[3.5,0.5;Input (input)]"..
"list[context;input;3.5,1;1,1;]"..
"label[3.5,2.5;Output (output)]"..
"list[context;output;3.5,3;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local coolspec2=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[3.5,0.5;Input (input)]"..
"list[context;input;3.5,1;1,1;]"..
"label[2.5,2.5;Output (output)]"..
"list[context;output;3,3;1,1;]"..
"label[4,2.5;Buckets (dst)]"..
"list[context;dst;4,3;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local alloyspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[2,0.5;Input 1 (input1)]"..
"list[context;input1;2,1;1,1;]"..
"label[5,0.5;Input 2 (input2)]"..
"list[context;input2;5,1;1,1;]"..
"label[3,1.5;Output (output)]"..
"list[context;output;3,2;2,2;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local fusespec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[2,0.5;Input 1 (input1)]"..
"list[context;input1;2,1;1,1;]"..
"label[5,0.5;Input 2 (input2)]"..
"list[context;input2;5,1;1,1;]"..
"label[3,1.5;Output (output)]"..
"list[context;output;3,2;2,2;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local deconspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[3.5,0.5;Input (input)]"..
"list[context;input;3.5,1;1,1;]"..
"label[3.5,1.6;Fuel (fuel)]"..
"list[context;fuel;3.5,2;1,1;]"..
"label[1.5,3;Output (output)]"..
"list[context;output;1.5,3.5;5,1;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

local chestspec=""..
"size[20,10;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0,-0.2;Output (output)]"..
"list[context;output;0,0;20,5;]"..
"list[current_player;main;6,6;8,4;]"..
"listring[]"

local bufferspec=""..
"size[20,10;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0,-0.2;Main (main)]"..
"list[context;main;0,0;20,5;]"..
"list[current_player;main;6,6;8,4;]"..
"listring[]"

local omnispec=""..
"size[13,8]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0.7,0;Sending Location: (max +1, min -1, positions are relative)]"..
"field[1,1;2,1;sourcex;x;${sourceposx}]"..
"field[4,1;2,1;sourcey;y;${sourceposy}]"..
"field[7,1;2,1;sourcez;z;${sourceposz}]"..
"field[1,2;8,1;inv;Inventory to access;${ainv}]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,2.5;8,1;save;Save]"..
"list[current_player;main;0.7,3.5;8,4;]"..
"label[9,0.5;Main (main)]"..
"list[context;main;9,1;3,6;]"..
"listring[]"

local cultspec=""..
"size[8,9;]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[2.5,1;Input (input)]"..
"list[context;input;2.5,1.5;1,1;Input (input)]"..
"label[2.5,2.1;Fuel (fuel)]"..
"list[context;fuel;2.5,2.5;1,1;]"..
"label[4.5,1.5;Output (output)]"..
"list[context;output;4.5,2;1,1;]"..
"list[current_player;main;0,5;8,4;]"..
"listring[]"

ocular_networks.register_node("ocular_networks:frame", {
	description="Gold Frame\n"..minetest.colorize("#00affa", "Used as a part of most multiblock structures"),
	drawtype="glasslike_framed",
	tiles={"poly_frame.png"},
	paramtype="light",
	paramtype2="glasslikeliquidlevel",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_rightclick=function(pos, node, player, itemstack, pointed_thing)
		if itemstack:get_name() == "ocular_networks:lens" then
			minetest.set_node(pos, {name="ocular_networks:frame_lens"})
			itemstack:take_item()
			return itemstack
		end
		if itemstack:get_name() == "ocular_networks:zweinium_lens" then
			minetest.set_node(pos, {name="ocular_networks:frame_lens_z"})
			itemstack:take_item()
			return itemstack
		end
		if itemstack:get_name() == "ocular_networks:cross" then
			minetest.set_node(pos, {name="ocular_networks:frame_cross"})
			itemstack:take_item()
			return itemstack
		end
	end
})

ocular_networks.register_node("ocular_networks:silicotin_block", {
	description="Glin\n"..minetest.colorize("#00affa", "Tesselates nicely"),
	drawtype="glasslike",
	tiles={"poly_silicotin_block.png"},
	paramtype="light",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:zweinium_block", {
	description="Zweinium Crystal Block\n"..minetest.colorize("#00affa", "Tesselates nicely"),
	drawtype="glasslike",
	tiles={"poly_zweinium_crystal_block.png"},
	paramtype="light",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_glass_defaults(),
})

ocular_networks.register_node("ocular_networks:frame_lens", {
	description="Gold Frame (Lens)",
	drawtype="glasslike_framed",
	tiles={"poly_frame.png", "poly_silver_lens.png"},
	paramtype="light",
	paramtype2="glasslikeliquidlevel",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_destruct=function(pos)
		minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, "ocular_networks:lens")
	end,
	drop="ocular_networks:frame",
})

ocular_networks.register_node("ocular_networks:frame_lens_z", {
	description="Gold Frame (Zweinium Lens)",
	drawtype="glasslike_framed",
	tiles={"poly_frame.png", "poly_zweinium_crystal_lens.png"},
	paramtype="light",
	paramtype2="glasslikeliquidlevel",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_destruct=function(pos)
		minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, "ocular_networks:zweinium_lens")
	end,
	drop="ocular_networks:frame",
})

ocular_networks.register_node("ocular_networks:frame_cross", {
	description="Gold Frame (Plate Cross)",
	drawtype="glasslike_framed",
	tiles={"poly_frame.png", "poly_cross.png"},
	paramtype="light",
	paramtype2="glasslikeliquidlevel",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, level=2, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_destruct=function(pos)
		minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, "ocular_networks:cross")
	end,
	drop="ocular_networks:frame",
})

ocular_networks.register_node("ocular_networks:battery", {
	description="Solar Cell Battery\n"..minetest.colorize("#00affa", "Place a frame on top, and\nadd a lens to the frame"),
	tiles={"poly_battery_top.png", "poly_battery_bottom.png", "poly_battery_side.png"},

	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_stone_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:boiler", {
	description="Steam Battery\n"..minetest.colorize("#00affa", "Generates power from natural steam"),
	tiles={"poly_boiler_top.png", "poly_boiler_bottom.png", "poly_boiler_side.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_stone_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:ton_core", {
	description="Hekaton Reactor Core\n"..minetest.colorize("#00affa", "Generates power from composite fuel\nRequires a multiblock structure\nCheck manual for how to build"),
	tiles={
		{
			name="poly_hekaton_core.png",
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
	sounds=default.node_sound_stone_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
		meta:set_int("heat", 0)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:bolumiary", {
	description="Photosynthesis Battery\n"..minetest.colorize("#00affa", "Generates power from plant growth"),
	tiles={"poly_bolumiary_top.png", "poly_bolumiary_bottom.png", "poly_bolumiary_side.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_stone_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})



ocular_networks.register_node("ocular_networks:distributor", {
	description="Power Collector\n"..minetest.colorize("#00affa", "Takes power from the set position\nat a fixed rate (has a range of 10)"),
	tiles={"poly_node.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", nodespec)
		meta:set_int("sourceposx", 0)
		meta:set_int("sourceposy", 0)
		meta:set_int("sourceposz", 0)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("sourceposx", tonumber(fields.sourcex) or 0)
			meta:set_int("sourceposy", tonumber(fields.sourcey) or 0)
			meta:set_int("sourceposz", tonumber(fields.sourcez) or 0)
			meta:set_string("formspec", nodespec)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:distributor_2", {
	description="Power Collector MK2\n"..minetest.colorize("#00affa", "Takes power from the set \nposition at a dynamic rate\nand has a higher range (20)"),
	tiles={"poly_node_2.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", nodespec2)
		meta:set_int("sourceposx", 0)
		meta:set_int("sourceposy", 0)
		meta:set_int("sourceposz", 0)
		meta:set_int("draw", 0)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("sourceposx", tonumber(fields.sourcex) or 0)
			meta:set_int("sourceposy", tonumber(fields.sourcey) or 0)
			meta:set_int("sourceposz", tonumber(fields.sourcez) or 0)
			meta:set_int("draw", fields.draw or 0)
			meta:set_string("formspec", nodespec2)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:distributor_3", {
	description="Power Collector MK3\n"..minetest.colorize("#00affa", "Takes power from the set \nposition at a dynamic rate\nand has a higher range (30)"),
	tiles={"poly_node_3.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", nodespec2)
		meta:set_int("sourceposx", 0)
		meta:set_int("sourceposy", 0)
		meta:set_int("sourceposz", 0)
		meta:set_int("draw", 0)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("sourceposx", tonumber(fields.sourcex) or 0)
			meta:set_int("sourceposy", tonumber(fields.sourcey) or 0)
			meta:set_int("sourceposz", tonumber(fields.sourcez) or 0)
			meta:set_int("draw", fields.draw or 0)
			meta:set_string("formspec", nodespec2)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:luminium_block", {
	description="Luminium Block",
	tiles={"poly_lumi_blk.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:hekatonium_block", {
	description=minetest.colorize("#00affa", "Hekatonium Block"),
	tiles={"poly_hekatonium_block.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:erenic_block", {
	description=minetest.colorize("#00affa", "Block of Erena"),
	tiles={"poly_power_core_block.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:lumigold_block", {
	description="Lumigold Block",
	tiles={"poly_lumig_blk.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:shimmering_block", {
	description="Shimmering Alloy Block",
	tiles={"poly_shimmering_block.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:angmallen_block", {
	description="Angmallen Block",
	tiles={"poly_angmallen_blk.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:angmallen_block_2", {
	description="Dense Angmallen Block",
	tiles={"poly_angmallen_blk_2.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:angmallen_block_3", {
	description="SuperDense Angmallen Block",
	tiles={"poly_angmallen_blk_3.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:angmallen_block_4", {
	description=minetest.colorize("#00affa", "Radiant Angmallen Core"),
	tiles={"poly_angmallen_blk_4.png"},
	is_ground_content=false,
	groups={cracky=1, level=2},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:luminium_ore", {
	description="Luminium Ore",
	tiles={"default_stone.png^poly_luminium_o.png"},
	groups={cracky=2},
	drop="ocular_networks:luminium_lump 4",
	sounds=default.node_sound_stone_defaults(),
	light_source=2
})

ocular_networks.register_node("ocular_networks:zweinium_ore", {
	description="Zweinium Ore",
	tiles={"poly_zweinium_ore.png"},
	groups={cracky=2},
	drop="ocular_networks:zweinium_crystal_chunk",
	sounds=default.node_sound_stone_defaults()
})

minetest.register_ore({
	ore_type      ="scatter",
	ore           ="ocular_networks:luminium_ore",
	wherein       ="default:stone",
	clust_scarcity=15 * 15 * 15,
	clust_num_ores=2,
	clust_size    =3,
	y_min         =-31000,
	y_max         =-1000,
})

ocular_networks.register_node("ocular_networks:toxic_slate", {
	description="Toxic Slate",
	tiles={"poly_battery_bottom.png"},
	groups={cracky=2},
	drop="ocular_networks:toxic_slate_chip 8",
	sounds=default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type      ="scatter",
	ore           ="ocular_networks:toxic_slate",
	wherein       ="default:desert_stone",
	clust_scarcity=5 * 5 * 5,
	clust_num_ores=16,
	clust_size    =5,
	y_min         =-31000,
	y_max         =-20,
})

minetest.register_ore({
	ore_type      ="scatter",
	ore           ="ocular_networks:zweinium_ore",
	wherein       ="ocular_networks:toxic_slate",
	clust_scarcity=5 * 5 * 5,
	clust_num_ores=2,
	clust_size    =3,
	y_min         =-31000,
	y_max         =31000,
})

ocular_networks.register_node("ocular_networks:hekatonium_ore", {
	description=minetest.colorize("#00affa", "Hekatonium Ore"),
	tiles={"default_stone.png^poly_hekatonium_ore.png"},
	groups={hekatonium_ore=1},
	drop="ocular_networks:hekatonium_chunk",
	sounds=default.node_sound_stone_defaults(),
	light_source=5
})

minetest.register_ore({
	ore_type      ="scatter",
	ore           ="ocular_networks:hekatonium_ore",
	wherein       ="default:stone",
	clust_scarcity=15 * 15 * 15,
	clust_num_ores=2,
	clust_size    =3,
	y_min         =-31000,
	y_max         =-10000,
})

ocular_networks.register_node("ocular_networks:reservoir", {
	description="Power Reservoir\n"..minetest.colorize("#00affa", "Provides cheap storage for power."),
	tiles={"default_wood.png^poly_frame.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
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
	
ocular_networks.register_node("ocular_networks:gearbox", {
	description="Gearbox\n"..minetest.colorize("#00affa", "'Used in many factories'"),
	tiles={"poly_gearbox.png^poly_frame.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
})

ocular_networks.register_node("ocular_networks:firebrick", {
	description="Fire bricks\n"..minetest.colorize("#00affa", "Funny that a flammable resource can make a fireproof substance."),
	tiles={"poly_peat2.png"},
	is_ground_content=false,
	groups={cracky=3},
	sounds=default.node_sound_stone_defaults(),
})

ocular_networks.register_node("ocular_networks:melter", {
	description="Metal Melter\n"..minetest.colorize("#00affa", "Melts metal into a liquid\nthat can be picked up with a bucket\nTakes Power From ABOVE"),
	tiles={"poly_battery_bottom.png^poly_frame.png", "poly_battery_bottom.png^poly_frame.png^poly_drain.png", "poly_battery_bottom.png^poly_frame.png", "poly_battery_bottom.png^poly_frame.png", "poly_battery_bottom.png^poly_frame.png", "poly_battery_bottom.png^poly_frame.png^poly_furnace.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", meltspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", meltspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:alloyer", {
	description="Mixer Centrifuge\n"..minetest.colorize("#00affa", "Spins liquid metal together to create alloys\nTakes Power From ABOVE"),
	tiles={"poly_centrifuge.png^poly_frame.png", "poly_centrifuge_side.png^poly_frame.png", "poly_centrifuge_side.png^poly_frame.png", "poly_centrifuge_side.png^poly_frame.png", "poly_centrifuge_side.png^poly_frame.png", "poly_centrifuge_side.png^poly_frame.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", alloyspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input1", {""})
		inv:set_size("input1", 1)
		inv:set_list("input2", {""})
		inv:set_size("input2", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 4)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", alloyspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:fuser", {
	description="Fusion Compressor\n"..minetest.colorize("#00affa", "Mushes stuff together to create new stuff\nand shoots waste out the bottom\nTakes Power From ABOVE"),
	tiles={"poly_centrifuge_side.png^poly_frame_2.png", "poly_compressor.png^poly_frame.png", "poly_centrifuge_side.png^poly_frame_2.png", "poly_centrifuge_side.png^poly_frame_2.png", "poly_centrifuge_side.png^poly_frame_2.png", "poly_centrifuge_side.png^poly_frame_2.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", fusespec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input1", {""})
		inv:set_size("input1", 1)
		inv:set_list("input2", {""})
		inv:set_size("input2", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 4)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", fusespec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:loomshroom", {
	description=minetest.colorize("#00affa", "LuumShroom"),
	drawtype="plantlike",
	tiles={"poly_loomshroom.png"},
	inventory_image="poly_loomshroom.png",
	wield_image="poly_loomshroom.png",
	sunlight_propagates=true,
	paramtype="light",
	walkable=false,
	sounds=default.node_sound_leaves_defaults(),
	groups={snappy=1, attached_node=1},
	selection_box={
		type="fixed",
		fixed= {-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16}
	}
})

ocular_networks.register_node("ocular_networks:loomshroom2", {
	description=minetest.colorize("#00affa", "LuumShroom"),
	drawtype="plantlike",
	tiles={"poly_loomshroom_cluster.png"},
	inventory_image="poly_loomshroom.png",
	wield_image="poly_loomshroom.png",
	sunlight_propagates=true,
	paramtype="light",
	walkable=false,
	sounds=default.node_sound_leaves_defaults(),
	groups={snappy=1, attached_node=1, not_in_creative_inventory=1},
	selection_box={
		type="fixed",
		fixed= {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}
	},
	drop="ocular_networks:loomshroom",
})

ocular_networks.register_node("ocular_networks:loomshroom3", {
	description=minetest.colorize("#00affa", "LuumShroom"),
	drawtype="plantlike",
	tiles={"poly_loomshroom_cluster_2.png"},
	inventory_image="poly_loomshroom.png",
	wield_image="poly_loomshroom.png",
	sunlight_propagates=true,
	paramtype="light",
	walkable=false,
	sounds=default.node_sound_leaves_defaults(),
	groups={snappy=1, attached_node=1, not_in_creative_inventory=1},
	selection_box={
		type="fixed",
		fixed= {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}
	},
	drop="ocular_networks:loomshroom",
})

ocular_networks.register_node("ocular_networks:loomshroom4", {
	description=minetest.colorize("#00affa", "LuumShroom"),
	drawtype="plantlike",
	tiles={"poly_loomshroom_cluster_3.png"},
	inventory_image="poly_loomshroom.png",
	wield_image="poly_loomshroom.png",
	sunlight_propagates=true,
	paramtype="light",
	walkable=false,
	sounds=default.node_sound_leaves_defaults(),
	groups={snappy=1, attached_node=1, not_in_creative_inventory=1},
	selection_box={
		type="fixed",
		fixed= {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}
	},
	drop="ocular_networks:loomshroom",
	on_rightclick=function(pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, {name="ocular_networks:loomshroom"})
		minetest.add_item(pos, "ocular_networks:luminium_lump 2")
	end
	
})

ocular_networks.register_node("ocular_networks:dirt_with_loomshroom_grass", {
	description="Dirt with Loomshroom Mycelium",
	tiles={"poly_loomshroom_grass.png", "default_dirt.png",
		{name="default_dirt.png^poly_loomshroom_grass_side.png",
			tileable_vertical=false}},
	groups={crumbly=3, soil=1, spreading_dirt_type=1},
	drop='default:dirt',
	sounds=default.node_sound_dirt_defaults({
		footstep={name="default_grass_footstep", gain=0.25},
	}),
})

ocular_networks.register_node("ocular_networks:shroom_planter", {
	description="Mycorrhizal Infuser\n"..minetest.colorize("#00affa", "Speeds up the growth of mushrooms placed on top\nCollects the crops when grown\nTakes Power From Below"),
	tiles={"poly_fertilizer_top.png", "poly_fertilizer_bottom.png", "poly_fertilizer_side.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", shroomspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("output", {""})
		inv:set_size("output", 32)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", shroomspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:networknode", {
	description="Network Node (Uplink)\n"..minetest.colorize("#00affa", "When placed on a node which has ocular power,\nit will extract the power and add it to your personal network."),
	tiles={"poly_uplink.png", "poly_battery_bottom.png", "poly_uplink_side.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.25, 4 / 16}
	},
	node_box={
		type="fixed",
		fixed= {	{-4 / 16, -0.5, -4 / 16, 4 / 16, -0.25, 4 / 16},
					{-5 / 16, -0.5, -3 / 16, 5 / 16, -0.4, 3 / 16},
					{-3 / 16, -0.5, -5 / 16, 3 / 16, -0.4, 5 / 16},}
	}
})

ocular_networks.register_node("ocular_networks:networknode2", {
	description="Network Node (Downlink)\n"..minetest.colorize("#00affa", "When placed on a node which has ocular power,\nit will insert the set amount power into the node regardless of the\nway the node operates."),
	tiles={"poly_uplink2.png", "poly_battery_bottom.png", "poly_uplink_side2.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("draw_amount", 0)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", "background[0,0;0,0;poly_gui_formbg.png;true]".."field[draw;Input Amount to insert per second:;${draw_amount}]")
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("draw_amount", tonumber(fields.draw) or 0)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
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
	selection_box={
		type="fixed",
		fixed= {-4 / 16, -0.5, -4 / 16, 4 / 16, -0.25, 4 / 16}
	},
	node_box={
		type="fixed",
		fixed= {	{-4 / 16, -0.5, -4 / 16, 4 / 16, -0.25, 4 / 16},
					{-5 / 16, -0.5, -3 / 16, 5 / 16, -0.4, 3 / 16},
					{-3 / 16, -0.5, -5 / 16, 3 / 16, -0.4, 5 / 16},}
	}
})

ocular_networks.register_node("ocular_networks:passive_cooler", {
	description="Passive Cooler\n"..minetest.colorize("#00affa", "Cools liquid metal, requrires no power."),
	tiles={"default_ice.png^poly_frame.png", "default_ice.png^poly_frame.png", "default_ice.png^poly_frame.png", "default_ice.png^poly_frame.png", "default_ice.png^poly_frame.png", "default_ice.png^poly_frame.png^poly_furnace.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", coolspec2)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		inv:set_list("dst", {""})
		inv:set_size("dst", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", coolspec2)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:charger", {
	description="Charging Station\n"..minetest.colorize("#00affa", "Charges items with OCP\nTakes power from ABOVE"),
	tiles={"default_copper_block.png^poly_frame.png^poly_gui_icon_pwr2.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", coolspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", coolspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:laserdrill", {
	description="Laser Drill Head\n"..minetest.colorize("#00affa", "When it's multiblock structure is complete,\nit will dig downwards very fast."),
	tiles={"poly_laserdrill_top.png", "poly_laserdrill_bottom.png", "poly_laserdrill_side.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_int("digDistance", 2)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	on_rightclick=function(pos, node, player, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local distance=meta:set_int("digDistance", 2)
	end
})

ocular_networks.register_node("ocular_networks:laserdrillchest", {
	description="Laser Drill Controller\n"..minetest.colorize("#00affa", "Can also be used as a normal chest."),
	tiles={"poly_laserdrill_chest_top.png", "poly_laserdrill_chest_bottom.png", "poly_laserdrill_chest_side.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
		on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", chestspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("output", {""})
		inv:set_size("output", 100)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", chestspec)
		meta:set_string("infotext", "Owned By: "..owner)
		meta:set_int("ocular_power", 0)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:pipe_E", {
	description="Horizontal Item Pipe\n"..minetest.colorize("#00affa", "The arrow on top indicates the direction.\nPunch with wrench to rotate."),
	tiles={"poly_pipe_casing_arrow_right.png", "poly_pipe_casing.png", "poly_pipe_socket.png", "poly_pipe_socket.png", "poly_pipe_casing.png", "poly_pipe_casing.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
		meta:set_string("enabled", "true")
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_S"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_S", {
	description="unav.tile",
	tiles={"poly_pipe_casing_arrow_down.png", "poly_pipe_casing2.png", "poly_pipe_casing.png", "poly_pipe_casing.png", "poly_pipe_socket.png", "poly_pipe_socket.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_E",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
		meta:set_string("enabled", "true")
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_W"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_W", {
	description="unav.tile",
	tiles={"poly_pipe_casing_arrow_left.png", "poly_pipe_casing.png", "poly_pipe_socket.png", "poly_pipe_socket.png", "poly_pipe_casing.png", "poly_pipe_casing.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	drop="ocular_networks:pipe_E",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
		meta:set_string("enabled", "true")
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_N"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_N", {
	description="unav.tile",
	tiles={"poly_pipe_casing_arrow_up.png", "poly_pipe_casing2.png", "poly_pipe_casing.png", "poly_pipe_casing.png", "poly_pipe_socket.png", "poly_pipe_socket.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_E",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
		meta:set_string("enabled", "true")
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_E"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_U", {
	description="Vertical Item Pipe\n"..minetest.colorize("#00affa", "The arrow indicates the direction.\nPunch with wrench to rotate."),
	tiles={"poly_pipe_socket.png", "poly_pipe_socket.png", "poly_pipe_casing_arrow_up.png", "poly_pipe_casing_arrow_up.png", "poly_pipe_casing_arrow_up.png", "poly_pipe_casing_arrow_up.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_U",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_D"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_D", {
	description="V",
	tiles={"poly_pipe_socket.png", "poly_pipe_socket.png", "poly_pipe_casing_arrow_down.png", "poly_pipe_casing_arrow_down.png", "poly_pipe_casing_arrow_down.png", "poly_pipe_casing_arrow_down.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_U",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_U"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_itembuffer", {
	description="Pipe-Enabled storage crate\n"..minetest.colorize("#00affa", "Pipes can send items to and from this.\nCan also be used as a normal chest."),
	tiles={"poly_centrifuge_side.png^poly_frame.png^poly_pipe_socket.png"},
	is_ground_content=false,
	drawtype="nodebox",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
		on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", bufferspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("main", {""})
		inv:set_size("main", 100)
		meta:set_string("owner", owner)
		meta:set_string("formspec", bufferspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16},
					{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16},
					{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
})

ocular_networks.register_node("ocular_networks:pipe_trashextractor", {
	description="Filter-Wise Item Destroyer\n"..minetest.colorize("#00affa", "Removes items from pipe-enabled storage crates (or chests)\nbased on filters.\nTakes items from ABOVE"),
	tiles={"poly_trash_extractor.png^poly_pipe_socket2.png", "poly_trash_extractor.png", "poly_trash_extractor.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
		on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:pipe_filtered_E", {
	description="Horizontal Filtered Item Pipe\n"..minetest.colorize("#00affa", "Arrow indicates direction,\nPunch with wrench to rotate."),
	tiles={"poly_pipe_casing_arrow_right_filtered.png", "poly_pipe_casing_filtered.png", "^poly_pipe_socket2.png", "poly_pipe_socket2.png", "poly_pipe_casing_filtered.png", "poly_pipe_casing_filtered.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_filtered_E",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate.")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_filtered_S"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_filtered_S", {
	description="Horizontal Filtered Item Pipe\n"..minetest.colorize("#00affa", "Arrow indicates direction,\nPunch with wrench to rotate."),
	tiles={"poly_pipe_casing_arrow_down_filtered.png", "poly_pipe_casing2_filtered.png", "poly_pipe_casing_filtered.png", "poly_pipe_casing_filtered.png", "poly_pipe_socket2.png", "poly_pipe_socket2.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_filtered_E",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate.")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_filtered_W"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_filtered_W", {
	description="Horizontal Filtered Item Pipe\n"..minetest.colorize("#00affa", "Arrow indicates direction,\nPunch with wrench to rotate."),
	tiles={"poly_pipe_casing_arrow_left_filtered.png", "poly_pipe_casing_filtered.png", "poly_pipe_socket2.png", "poly_pipe_socket2.png", "poly_pipe_casing_filtered.png", "poly_pipe_casing_filtered.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_filtered_E",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate.")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/2, -1/5, -1/5, 1/2, 1/5, 1/5},
					{3.5/10, -1.5/5, -1.5/5, 1/2, 1.5/5, 1.5/5},
					{-1/2, -1.5/5, -1.5/5, -3.5/10, 1.5/5, 1.5/5},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner")then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_filtered_N"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_filtered_N", {
	description="Horizontal Filtered Item Pipe\n"..minetest.colorize("#00affa", "Arrow indicates direction,\nPunch with wrench to rotate."),
	tiles={"poly_pipe_casing_arrow_up_filtered.png", "poly_pipe_casing2_filtered.png", "poly_pipe_casing_filtered.png", "poly_pipe_casing_filtered.png", "poly_pipe_socket2.png", "poly_pipe_socket2.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_filtered_E",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate.")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/5, -1/2, 1/5, 1/5, 1/2},
					{-1.5/5, -1.5/5, 3.5/10, 1.5/5, 1.5/5, 1/2},
					{-1.5/5, -1.5/5, -1/2, 1.5/5, 1.5/5, -3.5/10},
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_filtered_E"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_filtered_D", {
	description="Vertical Filtered Item Pipe\n"..minetest.colorize("#00affa", "Arrow indicates direction,\nPunch with wrench to rotate."),
	tiles={"poly_pipe_socket2.png", "poly_pipe_socket2.png", "poly_pipe_casing_arrow_down_filtered.png", "poly_pipe_casing_arrow_down_filtered.png", "poly_pipe_casing_arrow_down_filtered.png", "poly_pipe_casing_arrow_down_filtered.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_filtered_D",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	on_punch=function(pos, node, player, itemstack, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_filtered_U"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:pipe_filtered_U", {
	description="Vertical Filtered Item Pipe\n"..minetest.colorize("#00affa", "Arrow indicates direction,\nPunch with wrench to rotate."),
	tiles={"poly_pipe_socket2.png", "poly_pipe_socket2.png", "poly_pipe_casing_arrow_up_filtered.png", "poly_pipe_casing_arrow_up_filtered.png", "poly_pipe_casing_arrow_up_filtered.png", "poly_pipe_casing_arrow_up_filtered.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drop="ocular_networks:pipe_filtered_D",
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("items", fields.items or "default:cobble")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", trashspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("formspec", trashspec)
		meta:set_string("infotext", "Owned By: "..owner.."\nPunch with wrench to rotate")
		local inv=meta:get_inventory()
		inv:set_size("pipe_buffer", 10)
		inv:set_size("pipe_liquid_buffer", 10)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		meta:set_string("enabled", "true")
		return owner == player:get_player_name()
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	node_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	on_punch=function(pos, node, player, pointed_thing)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then
			if player:get_wielded_item():get_name() == "ocular_networks:pipe_wrench" or player:get_inventory():contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_wrench") then
				minetest.swap_node(pos, {name="ocular_networks:pipe_filtered_D"})
				minetest.sound_play("OCN_generic_creak", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
	end
})

ocular_networks.register_node("ocular_networks:chem_oven", {
	description="Chemical Oven\n"..minetest.colorize("#00affa", "Renders items down to their basic chemicals\nUses peat blocks\nTakes Power From ABOVE"),
	tiles={"poly_chem_oven_side.png", "poly_chem_oven_side.png", "poly_chem_oven_side.png", "poly_chem_oven_side.png", "poly_chem_oven_side.png", "poly_chem_oven_front.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", chemspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("fuel", {""})
		inv:set_size("fuel", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", chemspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:insertor", {
	description="Omni-Insertor\n"..minetest.colorize("#00affa", "Takes things from its inventory and moves them to adjacent blocks"),
	tiles={"poly_node_4.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		meta:set_string("enabled", "true")
		meta:set_string("formspec", omnispec)
		meta:set_int("sourceposx", 0)
		meta:set_int("sourceposy", 0)
		meta:set_int("sourceposz", 0)
		meta:set_string("ainv", "[_]")
		inv:set_size("main", 18)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("sourceposx", tonumber(fields.sourcex) or 0)
			meta:set_int("sourceposy", tonumber(fields.sourcey) or 0)
			meta:set_int("sourceposz", tonumber(fields.sourcez) or 0)
			meta:set_string("ainv", fields.inv or "")
			meta:set_string("formspec", omnispec)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Owned By: "..owner)
		meta:set_string("enabled", "true")
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:repairer", {
	description="Tool Reinfuser\n"..minetest.colorize("#00affa", "Repairs damaged items\nTakes power from ABOVE"),
	tiles={"default_copper_block.png^poly_frame.png^poly_repairer.png"},
	paramtype2="facedir",
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", coolspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", meltspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:grinder", {
	description="Pneumatic Pulveriser\n"..minetest.colorize("#00affa", "Crushes and grinds items.\nTakes Power From BELOW"),
	tiles={"poly_grinder_top.png", "poly_grinder_bottom.png", "poly_grinder_side.png", "poly_grinder_side.png", "poly_grinder_side.png", "poly_grinder_side.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", coolspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", coolspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
})

ocular_networks.register_node("ocular_networks:mulch", {
	description="Mulch",
	tiles={"poly_peat3.png"},
	groups={crumbly=3, soil=1, spreading_dirt_type=1},
	sounds=default.node_sound_dirt_defaults({
		footstep={name="default_grass_footstep", gain=0.25},
	}),
})

ocular_networks.register_node("ocular_networks:forge", {
	description="Panel Forge\n"..minetest.colorize("#00affa", "Smashes metal into plates.\nTakes Power From ABOVE"),
	tiles={"default_steel_block.png^poly_frame.png", "default_steel_block.png^poly_frame.png", "poly_forge_side.png"},
	is_ground_content=false,
	drawtype="nodebox",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", coolspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", coolspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	selection_box={
		type="fixed",
		fixed= {	{-1/5, -1/2, -1/5, 1/5, 1/2, 1/5},
					{-5 / 16, -0.5, -5 / 16, 5 / 16, -3.5/10, 5 / 16},
					{-5 / 16, 0.5, -5 / 16, 5 / 16, 3.5/10, 5 / 16}
					}
	},
	node_box={
		type="fixed",
		fixed= {
				{-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
				{-0.5, 4/16, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0.5, -4/16, 0.5},
				}
	},
})

ocular_networks.register_node("ocular_networks:cultivator", {
	description="Phytogenic Cultivator\n"..minetest.colorize("#00affa", "Increases the speed of plant growth using fertiliser.\nTakes power from BELOW"),
	tiles={"poly_bolumiary_top2.png", "poly_bolumiary_bottom.png", "poly_bolumiary_side2.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_stone_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		local inv=meta:get_inventory()
		meta:set_string("enabled", "true")
		meta:set_string("formspec", cultspec)
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("fuel", {""})
		inv:set_size("fuel", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end
})


ocular_networks.register_node("ocular_networks:furnace", {
	description="Fresnel Furnace\n"..minetest.colorize("#00affa", "A powerful endgame furnace using focused light.\nTakes Power From BELOW"),
	tiles={"default_obsidian.png^poly_silver_lens.png^poly_frame.png", "default_steel_block.png^poly_frame.png", "poly_shimmering_block.png^poly_frame.png", "poly_shimmering_block.png^poly_frame.png", "poly_shimmering_block.png^poly_frame.png", "poly_shimmering_block.png^poly_frame.png^poly_furnace2.png"},
	is_ground_content=false,
	drawtype="nodebox",
	paramtype2="facedir",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", coolspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", coolspec)
		meta:set_string("infotext", "Owned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end
})

local crafspec=""..
"size[14,9]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"list[current_player;main;0,5;8,4;]"..
"list[context;input;0,0;8,4;]"..
"list[context;recipe;8.5,3;3,3;]"..
"list[context;output;12,4;1,1;]"..
"listring[]"

ocular_networks.register_node("ocular_networks:crafter", {
	description="Complex Crafter\n"..minetest.colorize("#00affa", "Automatically crafts items based on a set recipe.\nTakes power from BELOW."),
	tiles={"poly_crafter_top.png", "poly_crafter.png", "poly_crafter.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_stone_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
		meta:set_string("formspec", crafspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
		local inv=meta:get_inventory()
		inv:set_list("input", {""})
		inv:set_size("input", 32)
		inv:set_list("recipe", {""})
		inv:set_size("recipe", 9)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("formspec", crafspec)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") then 
			return 65535
		else
			return 0
		end
	end
})

ocular_networks.register_node("ocular_networks:pump", {
	description="Fluid Collector\n"..minetest.colorize("#00affa", "Takes liquids from the set position"),
	tiles={"poly_pump.png", "poly_pump.png", "poly_pump.png^bucket.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		inv:set_list("liq", {""})
		inv:set_size("liq", 4)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", pumpspec)
		meta:set_int("sourceposx", 0)
		meta:set_int("sourceposy", -1)
		meta:set_int("sourceposz", 0)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("sourceposx", tonumber(fields.sourcex) or 0)
			meta:set_int("sourceposy", tonumber(fields.sourcey) or 0)
			meta:set_int("sourceposz", tonumber(fields.sourcez) or 0)
			meta:set_string("formspec", pumpspec)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		return 0
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		return 0
	end
})

ocular_networks.register_node("ocular_networks:faucet", {
	description="Fluid Depositor\n"..minetest.colorize("#00affa", "Places liquid at the set position"),
	tiles={"poly_pump.png", "poly_pump.png", "poly_pump.png^(bucket.png^[transform2)"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		inv:set_list("liq", {""})
		inv:set_size("liq", 1)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", pumpspec)
		meta:set_int("sourceposx", 0)
		meta:set_int("sourceposy", -1)
		meta:set_int("sourceposz", 0)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_int("sourceposx", tonumber(fields.sourcex) or 0)
			meta:set_int("sourceposy", tonumber(fields.sourcey) or 0)
			meta:set_int("sourceposz", tonumber(fields.sourcez) or 0)
			meta:set_string("formspec", pumpspec)
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		return 0
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		return 0
	end
})


ocular_networks.register_node("ocular_networks:tank", {
	description="Fluid Tank\n"..minetest.colorize("#00affa", "Holds a single type of fluid x"..ocular_networks.config.stack_max*5),
	drawtype="glasslike_framed",
	tiles={"poly_tank.png"},
	paramtype="light",
	paramtype2="glasslikeliquidlevel",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3, ocular_networks_tank=1},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		inv:set_list("liq", {""})
		inv:set_size("liq", 5)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		return 0
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		return 0
	end
})

for _,v in pairs(ocular_networks.pumpable_liquids) do
	local def=minetest.registered_nodes[_]
	ocular_networks.register_node("ocular_networks:tank_"..string.split(_, ":")[1].."_"..string.split(_, ":")[2], {
		description="Tank: "..def.description,
		drawtype="glasslike_framed",
		tiles={"poly_tank.png"},
		special_tiles={def.tiles[1]},
		paramtype="light",
		paramtype2="glasslikeliquidlevel",
		sunlight_propagates=true,
		is_ground_content=false,
		groups={cracky=3, oddly_breakable_by_hand=3, ocular_networks_tank=1, not_in_creative_inventory=1},
		sounds=default.node_sound_metal_defaults(),
		on_dig = function(pos, node, player)
			local m=minetest.get_meta(pos)
			local s=m:get_inventory():get_stack("liq", 1):get_count() or 0
			local is=ItemStack(node.name)
			is:get_meta():set_int("liq", s)
			is:get_meta():set_string("description", "Tank: "..def.description.." x"..s)
			player:get_inventory():add_item("main", is)
			minetest.node_dig(pos, node, player)
		end,
		on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			local inv=meta:get_inventory()
			inv:set_list("liq", {""})
			inv:set_size("liq", 1)
		end,
		after_place_node=function(pos, placer, itemstack, pointed_thing)
			local meta=minetest.get_meta(pos)
			local owner=placer:get_player_name()
			meta:set_string("owner", owner)
			local inv=meta:get_inventory()
			if itemstack:get_meta():get_int("liq") then
				inv:set_stack("liq", 1, _.." "..itemstack:get_meta():get_int("liq"))
			end
		end,
		drop="",
		can_dig=function(pos, player)
			local meta=minetest.get_meta(pos)
			local owner=meta:get_string("owner")
			return owner == player:get_player_name()
		end,
		allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
		allow_metadata_inventory_put=function(pos, listname, index, stack, player)
			return 0
		end,
		allow_metadata_inventory_take=function(pos, listname, index, stack, player)
			return 0
		end
	})
	
	minetest.register_craft({
		type="shapeless",
		output="ocular_networks:tank",
		recipe={"ocular_networks:tank_"..string.split(_, ":")[1].."_"..string.split(_, ":")[2]},
	})
end

local bucketerspec=
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[1,1;liquids]"..
"label[5,1;buckets (buckets)]"..
"label[9,1;output (output)]"..
"list[context;liq_i;1,0;1,1;]"..
"list[context;buckets;4.5,0;1,1;]"..
"list[context;output;8,0;1,1;]"..
"list[current_player;main;1,2;8,4;]"

ocular_networks.register_node("ocular_networks:bucketer", {
	description="Fluid Transposer\n"..minetest.colorize("#00affa", "Puts liquids in buckets"),
	drawtype="glasslike_framed",
	tiles={"poly_bucketer.png"},
	paramtype="light",
	paramtype2="glasslikeliquidlevel",
	sunlight_propagates=true,
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		inv:set_list("liq_i", {""})
		inv:set_size("liq_i", 1)
		inv:set_list("buckets", {""})
		inv:set_size("buckets", 1)
		inv:set_list("output", {""})
		inv:set_size("output", 1)
		meta:set_string("formspec", bucketerspec)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end,
	allow_metadata_inventory_move=function(pos, from_list, from_index, to_list, to_index, count, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") and from_list~="liq_i" and to_list~="liq_i" then 
			return count 
		else
			return 0
		end
	end,
	allow_metadata_inventory_put=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") and listname~="liq_i" then 
			return 65535
		else
			return 0
		end
	end,
	allow_metadata_inventory_take=function(pos, listname, index, stack, player)
		if player:get_player_name() == minetest.get_meta(pos):get_string("owner") and listname~="liq_i" then 
			return 65535
		else
			return 0
		end
	end
})

ocular_networks.register_node("ocular_networks:cable", {
	description = "Fibre-Optic Power Cable\n"..minetest.colorize("#00affa", "Transfers power between optical-power\nenabled devices.\nRequires an optical controller."),
	tiles = {"poly_cable.png"},
	inventory_image="poly_cable2.png",
	connects_to={"group:fiberoptic",},
	sounds = visionLib.Sound.Plastic(),
	groups={snappy=3,pipe=1,fiberoptic=1},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "connected",
		fixed = {
			{-0.155, -0.155, -0.155, 0.155, 0.155, 0.155}
		},
		connect_front = {-0.15, -0.15, -0.5, 0.15, 0.15, 0.15},
		connect_back =  {-0.15, -0.15, 0.5, 0.15, 0.15, 0.15},
		connect_left =  {-0.15, -0.15, -0.15, -0.5, 0.15, 0.15},
		connect_right =  {-0.15, -0.15, -0.15, 0.5, 0.15, 0.15},
		connect_top =  {-0.15, -0.15, -0.15, 0.15, 0.5, 0.15},
		connect_bottom =  {-0.15, -0.5, -0.15, 0.15, 0.15, 0.15},
	}
})

ocular_networks.register_node("ocular_networks:router", {
	description="Optical Power Controller\n"..minetest.colorize("#00affa", "Controls the transfer of fibre-optic power"),
	tiles={"poly_optic_router.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3,fiberoptic=1},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Power Buffer: 0".."\nOwned By: "..owner)
	end,
	can_dig=function(pos, player)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		return owner == player:get_player_name()
	end
})

ocular_networks.register_node("ocular_networks:reservoir2", {
	description="Optical Power Reservoir\n"..minetest.colorize("#00affa", "Optical power will be distributed evenly between\nall optical reservoirs when connected\nto a power controller."),
	tiles={"default_wood.png^poly_frame.png^poly_reservoir2.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3,fiberoptic=1},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_int("ocular_power", 0)
		meta:set_string("enabled", "true")
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