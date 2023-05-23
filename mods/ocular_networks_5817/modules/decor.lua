
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

ocular_networks.register_node("ocular_networks:particle_gen", {
	description="Particle Generator\n"..minetest.colorize("#00affa", "Produces a customizable plume of particles\nTakes power from BELOW"),
	tiles={"poly_particlegen.png"},
	is_ground_content=false,
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_string("enabled", "true")
		meta:set_string("formspec", nodespec)
		meta:set_int("posx", 0)
		meta:set_int("posy", 0)
		meta:set_int("posz", 0)
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