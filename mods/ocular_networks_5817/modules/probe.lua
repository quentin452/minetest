ocular_networks.channel_states={}

ocular_networks.netKeyWords={
	["if"]={
		name="if",
		desc="if : Conditionally execute a command. | Syntax: if <arg>==<arg> [command] <args>",
		func=function(arg, args_)
			if arg then
				local args=string.split(arg, "==")
				if #args==2 then
					if args[2]:sub(1,1) =="$" then
						if ocular_networks.channel_states[args[2]] then 
							args[2]=ocular_networks.channel_states[args[2]] 
						else
							return "Attempt to read non-exsistant channel"..args[2], false
						end
					end
					if args[1]:sub(1,1) =="$" then
						if ocular_networks.channel_states[args[1]] then 
							args[1]=ocular_networks.channel_states[args[1]] 
						else
							return "Attempt to read non-exsistant channel"..args[1], false
						end
					end
					if args[1]==args[2] then
						return "Success: ", true
					else
						return "Conditions not met", false
					end
				else
					return "Invalid argument structure", false
				end
			else
				return "No arguments specified", false
			end
			return "(This message should never show up, report immediately) [IF]["..arg.."]", false
		end,
	},
}

ocular_networks.netCommands={
	["#"]={
		name="#",
		desc="# : comment",
		func=function(arg, args_)
			return ""
		end,
	},
	["help"]={
		name="help",
		desc="help : Provide help for a specified command, or list available commands | Syntax: help <cmd>",
		func=function(arg)
			if arg and arg ~= "" then
				if ocular_networks.netCommands[arg] then
					return ocular_networks.netCommands[arg].desc
				else
					return "Command "..arg.." doesn't exist"
				end
			else
				local help=""
				for _,v in pairs(ocular_networks.netCommands) do
					help=help..v.desc.."\n\n"
				end
				for _,v in pairs(ocular_networks.netKeyWords) do
					help=help..v.desc.."\n\n"
				end
				return help
			end
			return "(This message should never show up, report immediately) [HELP]["..arg.."]"
		end,
	},
	["let"]={
		name="let",
		desc="let : Set a channel value. (The <channel> field will be prepended with '$')| Syntax: let <channel>=<val> (val can be a channel name)",
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					if args[2]:sub(1,1) =="$" then
						if ocular_networks.channel_states[args[2]] then 
							args[2]=ocular_networks.channel_states[args[2]] 
						else
							return "Attempt to read non-exsistant channel"..args[2]
						end
					end
					ocular_networks.channel_states["$"..args[1]]=tostring(args[2])
					return "Value of channel '".."$"..args[1].."' set to '"..args[2].."'."
				else
					return "Invalid argument structure"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [LET]["..arg.."]"
		end,
	},
	["get"]={
		name="get",
		desc="get : Print the content of a channel. | Syntax: get <channel>", 
		func=function(arg)
			if arg then
				if ocular_networks.channel_states[arg] then
					if type(tostring(ocular_networks.channel_states[arg]))=="string" then
						return tostring(ocular_networks.channel_states[arg])
					else
						return "Expected string, got "..type(ocular_networks.channel_states[arg])
					end
				else
					return "Channel "..arg.." does not exist"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [GET]["..arg.."]"
		end,
	},
	["list"]={
		name="list",
		desc="list : Turn a list of args into a table and write it to a channel. (The <channel> field will be prepended with '$')| Syntax: list <channel>=<arg1>,<arg2>,<arg3>", 
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					ocular_networks.channel_states["$"..args[1]]=string.split(args[2], ",")
					return "Value of channel '".."$"..args[1].."' set to '"..dump(string.split(args[2], ",")).."'."
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [LIST]["..arg.."]"
		end,
	},
	["dList"]={
		name="dList",
		desc="dList : Print the content of a channel as an array. | Syntax: dList <channel>", 
		func=function(arg)
			if arg then
				if ocular_networks.channel_states[arg] then
					if type(ocular_networks.channel_states[arg])=="table" then
						local list=""
						if ocular_networks.channel_states[arg]["OCProbeCsum_e"] and ocular_networks.channel_states[arg]["OCProbeCsum_e"]=="_proof_inventory" then
							for _,i in ipairs(ocular_networks.channel_states[arg]) do
								list=list..(i:get_name() and i:get_name()~= "" and i:get_name().." "..i:get_count()..", \n" or "")
							end
							return list
						else
							for _,i in ipairs(ocular_networks.channel_states[arg]) do
								list=list..(type(list)=="table" and dump(i) or i)..", "
							end
							return list
						end
					else
						return "Expected table, got "..type(ocular_networks.channel_states[arg])
					end
				else
					return "Channel "..arg.." does not exist"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [DLIST]["..arg.."]"
		end,
	},
	["add"]={
		name="add",
		desc="add : Add two args and write the result to a channel. (arg1 and arg2 may be channel names) (The <channel> field will be prepended with '$') | Syntax: add <channel>=<arg1>+<arg2>", 
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					local args2=string.split(args[2], "+")
					if #args2==2 then
						if args2[2]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[2]] then 
								args2[2]=ocular_networks.channel_states[args2[2]] 
							else
								return "Attempt to read non-exsistant channel"..args[2]
							end
						end
						if args2[1]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[1]] then 
								args2[1]=ocular_networks.channel_states[args2[1]] 
							else
								return "Attempt to read non-exsistant channel"..args2[1]
							end
						end
						if type(tonumber(args2[1]))=="number" and type(tonumber(args2[2]))=="number" then
							ocular_networks.channel_states["$"..args[1]]=tostring(tonumber(args2[1])+tonumber(args2[2]))
							return "Value of channel '".."$"..args[1].."' set to '"..tonumber(args2[1])+tonumber(args2[2]).."'."
						else
							return "NaN supplied"
						end
					elseif #args2>2 then
						return "Too many arguments"
					elseif #args2<2 then
						return "Too few arguments"
					end
				else
					return "Incorrect formatting"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [ADD]["..arg.."]"
		end,
	},
	["sub"]={
		name="sub",
		desc="sub : Subtract arg 2 from arg 1 and write the result to a channel. (arg1 and arg2 may be channel names) (The <channel> field will be prepended with '$') | Syntax: sub <channel>=<arg1>-<arg2>", 
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					local args2=string.split(args[2], "-")
					if #args2==2 then
						if args2[2]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[2]] then 
								args2[2]=ocular_networks.channel_states[args2[2]] 
							else
								return "Attempt to read non-exsistant channel"..args[2]
							end
						end
						if args2[1]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[1]] then 
								args2[1]=ocular_networks.channel_states[args2[1]] 
							else
								return "Attempt to read non-exsistant channel"..args2[1]
							end
						end
						if type(tonumber(args2[1]))=="number" and type(tonumber(args2[2]))=="number" then
							ocular_networks.channel_states["$"..args[1]]=tostring(tonumber(args2[1])-tonumber(args2[2]))
							return "Value of channel '".."$"..args[1].."' set to '"..tonumber(args2[1])-tonumber(args2[2]).."'."
						else
							return "NaN supplied"
						end
					elseif #args2>2 then
						return "Too many arguments"
					elseif #args2<2 then
						return "Too few arguments"
					end
				else
					return "Incorrect formatting"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [SUB]["..arg.."]"
		end,
	},
	["mult"]={
		name="mult",
		desc="mult : Multiply arg 1 by arg 2 and write the result to a channel. (arg1 and arg2 may be channel names) (The <channel> field will be prepended with '$') | Syntax: mult <channel>=<arg1>*<arg2>", 
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					local args2=string.split(args[2], "*")
					if #args2==2 then
						if args2[2]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[2]] then 
								args2[2]=ocular_networks.channel_states[args2[2]] 
							else
								return "Attempt to read non-exsistant channel"..args[2]
							end
						end
						if args2[1]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[1]] then 
								args2[1]=ocular_networks.channel_states[args2[1]] 
							else
								return "Attempt to read non-exsistant channel"..args2[1]
							end
						end
						if type(tonumber(args2[1]))=="number" and type(tonumber(args2[2]))=="number" then
							ocular_networks.channel_states["$"..args[1]]=tostring(tonumber(args2[1])*tonumber(args2[2]))
							return "Value of channel '".."$"..args[1].."' set to '"..tonumber(args2[1])*tonumber(args2[2]).."'."
						else
							return "NaN supplied"
						end
					elseif #args2>2 then
						return "Too many arguments"
					elseif #args2<2 then
						return "Too few arguments"
					end
				else
					return "Incorrect formatting"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [MULT]["..arg.."]"
		end,
	},
	["div"]={
		name="div",
		desc="div : Divide arg 1 by arg 2 and write the result to a channel. (arg1 and arg2 may be channel names) (The <channel> field will be prepended with '$') | Syntax: div <channel>=<arg1>/<arg2>", 
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					local args2=string.split(args[2], "/")
					if #args2==2 then
						if args2[2]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[2]] then 
								args2[2]=ocular_networks.channel_states[args2[2]] 
							else
								return "Attempt to read non-exsistant channel"..args[2]
							end
						end
						if args2[1]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[1]] then 
								args2[1]=ocular_networks.channel_states[args2[1]] 
							else
								return "Attempt to read non-exsistant channel"..args2[1]
							end
						end
						if type(tonumber(args2[1]))=="number" and type(tonumber(args2[2]))=="number" then
							ocular_networks.channel_states["$"..args[1]]=tostring(tonumber(args2[1])/tonumber(args2[2]))
							return "Value of channel '".."$"..args[1].."' set to '"..tonumber(args2[1])/tonumber(args2[2]).."'."
						else
							return "NaN supplied"
						end
					elseif #args2>2 then
						return "Too many arguments"
					elseif #args2<2 then
						return "Too few arguments"
					end
				else
					return "Incorrect formatting"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [DIV]["..arg.."]"
		end,
	},
	["append"]={
		name="append",
		desc="append : Concatenate arg1 witth arg2 and write the result to a channel. (arg1 and arg2 may be channel names) (The <channel> field will be prepended with '$') | Syntax: append <channel>=<arg1>+<arg2>", 
		func=function(arg)
			if arg then
				local args=string.split(arg, "=")
				if #args==2 then
					local args2=string.split(args[2], "+")
					if #args2==2 then
						if args2[2]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[2]] then 
								args2[2]=ocular_networks.channel_states[args2[2]] 
							else
								return "Attempt to read non-exsistant channel"..args[2]
							end
						end
						if args2[1]:sub(1,1) =="$" then
							if ocular_networks.channel_states[args2[1]] then 
								args2[1]=ocular_networks.channel_states[args2[1]] 
							else
								return "Attempt to read non-exsistant channel"..args2[1]
							end
						end
						if type(tostring(args2[1]))=="string" and type(tostring(args2[2]))=="string" then
							ocular_networks.channel_states["$"..args[1]]=tostring(args2[1])..tostring(args2[2])
							return "Value of channel '".."$"..args[1].."' set to '"..tostring(args2[1])..tostring(args2[2]).."'."
						else
							return "Invalid data supplied"
						end
					elseif #args2>2 then
						return "Too many arguments"
					elseif #args2<2 then
						return "Too few arguments"
					end
				else
					return "Incorrect formatting"
				end
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [APPEND]["..arg.."]"
		end,
	},
	["print"]={
		name="print",
		desc="print : Print the value <val> | Syntax: print <val>", 
		func=function(arg)
			if arg then
				return tostring(arg)
			else
				return "No arguments specified"
			end
			return "(This message should never show up, report immediately) [GET]["..arg.."]"
		end,
	},
}

local prb="size[8,9;]background[0,0;0,0;poly_gui_formbg2.png;true]textarea[1,1;6.5,8;;;"
local ef="]field_close_on_enter[cmd;false]field[0,8.9;7.5,1;cmd;;]style[send;bgcolor=blue;textcolor=white]button[7,8.59;1.2,1;send;|==>]"

local st={
	description="Multi-Purpose Tablet\n"..minetest.colorize("#00affa", "Rightclick to output the metadata of a node.\nSneak-Click to open your performance tweaks.\nClick to open the Data Network console."),
	inventory_image="poly_disk2.png",
	not_in_creative_inventory=1,
	stack_max=1,
	on_place=function(itemstack, placer, pointed_thing)
		if pointed_thing.type=="node" then
			local meta=minetest.get_meta(minetest.get_pointed_thing_position(pointed_thing, nil))
			local pseudodata=meta:to_table().fields
			if pseudodata.formspec then
				pseudodata.formspec="omitted"
			end
			minetest.show_formspec(placer:get_player_name(), "", "size[8,9;]background[0,0;0,0;poly_gui_formbg2.png;true]textarea[0,0.5;8.5,9.5;arb;Metadata breakdown:;"..dump(pseudodata).."]")
		end	
	end,
	
	on_use=function(itemstack, placer, pointed_thing)
		minetest.show_formspec(placer:get_player_name(), "Poly_disk2IO", prb.."> type 'help' for a list of commands"..ef)
	end
}

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname=="Poly_disk2IO" then
		if fields.cmd then
			local commandElems=string.split(fields.cmd, " ")
			if #commandElems>1 then
				local con=true
				local output_=""
				if ocular_networks.netKeyWords[commandElems[1]] then
					output_, con=ocular_networks.netKeyWords[commandElems[1]].func(commandElems[2], commandElems)
				end
				
				if ocular_networks.netCommands[commandElems[#commandElems-1]] then
					local output=""
					if con then
						output=ocular_networks.netCommands[commandElems[#commandElems-1]].func(commandElems[#commandElems])
					end
					minetest.show_formspec(player:get_player_name(), "Poly_disk2IO", prb.."$ "..fields.cmd.."\n"..output_..output..ef)
				else
					minetest.show_formspec(player:get_player_name(), "Poly_disk2IO", prb.."$ "..fields.cmd.."\nCommand '"..fields.cmd.."' does not exist."..ef)
				end
			elseif fields.cmd=="help" then
				output=ocular_networks.netCommands["help"].func()
				minetest.show_formspec(player:get_player_name(), "Poly_disk2IO", prb.."$ "..fields.cmd.."\n"..output..ef)
			else
				minetest.show_formspec(player:get_player_name(), "Poly_disk2IO", prb.."$ "..fields.cmd.."\nSyntax error"..ef)
			end
		end
	end
end)

if ocular_networks.get_config("load_armor_upgrades") then
	st.on_use=function(itemstack, placer, pointed_thing)
		if placer:get_player_control().sneak == true then
			local inv=placer:get_inventory()
			if inv:get_lists().ocn_armor_upgrades and inv:get_lists().ocn_cyber_upgrades then
				minetest.show_formspec(placer:get_player_name(), "ocn_armor_upgrades_2", "size[8,9;]background[0,0;0,0;poly_gui_formbg2.png;true]list[current_player;main;0,5;8,4;]label[1.5,0.2;Armor Upgrades]list[current_player;ocn_armor_upgrades;1.5,0.6;5,1;]label[1.5,1.7;Cybernetic Upgrades]list[current_player;ocn_cyber_upgrades;1.5,2.1;5,1;]")
			else
				inv:set_list("ocn_armor_upgrades", {})
				inv:set_size("ocn_armor_upgrades", 32)
				inv:set_list("ocn_cyber_upgrades", {})
				inv:set_size("ocn_cyber_upgrades", 32)
			end
		else
			minetest.show_formspec(placer:get_player_name(), "Poly_disk2IO", prb.."> type 'help' for a list of commands"..ef)
		end
	end
end

ocular_networks.register_item("ocular_networks:probe", st)

minetest.register_craft({
	output="ocular_networks:probe",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:silicotin_bar", "ocular_networks:lens"},
		{"ocular_networks:shimmering_bar", "default:obsidian_glass", "ocular_networks:shimmering_bar"},
		{"default:steel_ingot", "ocular_networks:performance_controller", "default:steel_ingot"}
	}
})

local nodespec=""..
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0.9,0;data to read:]"..
"dropdown[1,1;4,1;mode;inventory,metadata,nodename,mesecon;${mode}]"..
"field[1,2.7;8,1;attr;Inventory name or metadata field:;${attr}]"..
"field[1,4.4;8,1;channel;channel to use:;${channel}]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,5;8,1;save;Save]"

ocular_networks.register_node("ocular_networks:networkprobe", {
	description="Data Network Uplink\n"..minetest.colorize("#00affa", "Can be configured to read fields from the node below, and send them to the Data Network."),
	tiles={"poly_uplink3.png", "poly_battery_bottom.png", "poly_uplink_side3.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_string("channel", "")
		meta:set_string("mode", "")
		meta:set_string("attr", "")
		meta:set_string("formspec", nodespec)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("channel", fields.channel or "")
			meta:set_string("mode", fields.mode)
			meta:set_string("attr", fields.attr or "")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by ".."$"..meta:get_string("owner").."!")
		end
	end,
	mesecons={effector={rules=mesecon.rules.default,
		action_on=function(pos, node)
			local meta=minetest.get_meta(pos)
			meta:set_string("MCON", "true")
		end,
		action_off=function(pos, node)
			local meta=minetest.get_meta(pos)
			meta:set_string("MCON", "false")
		end}},
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Sending data: "..meta:get_string("attr").."\nover channel:".."$"..meta:get_string("channel").."\nOwned By: "..owner)
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
					{-3 / 16, -0.5, -5 / 16, 3 / 16, -0.4, 5 / 16},
					{-1 / 16, -0.5, -1 / 16, 1 / 16, 0.4, 1 / 16}}
	}
})

minetest.register_abm({
    label="uplink probe",
	nodenames={"ocular_networks:networkprobe"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_below=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		local meta=minetest.get_meta(pos)
		local meta2=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
		local owner=meta:get_string("owner")
		meta:set_string("infotext", "Sending data: "..meta:get_string("attr").."\nover channel: ".."$"..meta:get_string("channel").."\nOwned By: "..owner)
		if meta:get_string("mode") == "inventory" then
			local inv=meta2:get_inventory()
			if inv:get_list(meta:get_string("attr")) then
				local finvr=inv:get_lists()[meta:get_string("attr")]
				finvr.OCProbeCsum_e="_proof_inventory"
				ocular_networks.channel_states["$"..meta:get_string("channel")]=finvr
			end
		elseif meta:get_string("mode") == "metadata" then
			if meta2:get_string(meta:get_string("attr")) then
				ocular_networks.channel_states["$"..meta:get_string("channel")]=meta2:get_string(meta:get_string("attr"))
			else
				ocular_networks.channel_states["$"..meta:get_string("channel")]="nil"
			end
		elseif meta:get_string("mode") == "nodename" then
			ocular_networks.channel_states["$"..meta:get_string("channel")]=node_below.name
		elseif meta:get_string("mode") == "mesecon" then
			if meta:get_string("MCON")=="true" then
				ocular_networks.channel_states["$"..meta:get_string("channel")]="true"
			else
				ocular_networks.channel_states["$"..meta:get_string("channel")]="false"
			end
		end
	end,
})

minetest.register_craft({
	output="ocular_networks:networkprobe",
	recipe={
		{"default:copper_ingot", "ocular_networks:toxic_slate_rod", "default:copper_ingot"},
		{"ocular_networks:zweinium_crystal", "ocular_networks:networknode", "ocular_networks:zweinium_crystal"},
		{"ocular_networks:shimmering_bar", "default:coal_lump", "ocular_networks:shimmering_bar"}
	}
})

local nodespec2=""..
"size[10,6]"..
"background[0,0;0,0;poly_gui_formbg.png;true]"..
"label[0.9,0;data to modify:]"..
"dropdown[1,1;4,1;mode;switch,mesecon;${mode}]"..
"field[1,2.7;8,1;attr;channel value required:;${attr}]"..
"field[1,4.4;8,1;channel;channel to use:;${channel}]"..
"style[save;bgcolor=blue;textcolor=white]"..
"button_exit[0.74,5;8,1;save;Save]"

ocular_networks.register_node("ocular_networks:networkprobe2", {
	description="Data Network Downlink\n"..minetest.colorize("#00affa", "Reads fields from the Data Network and can\ncontrol mesecon signals based on the data."),
	tiles={"poly_uplink4.png", "poly_battery_bottom.png", "poly_uplink_side4.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	mesecons= {
		receptor={
			state=mesecon.state.off,
			rules=mesecon.rules.default
		},
	},
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_string("channel", "")
		meta:set_string("mode", "")
		meta:set_string("attr", "")
		meta:set_string("formspec", nodespec2)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("channel", fields.channel or "")
			meta:set_string("mode", fields.mode)
			meta:set_string("attr", fields.attr or "")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", "Receiving data over channel:".."$"..meta:get_string("channel").."\nOwned By: "..owner)
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
					{-3 / 16, -0.5, -5 / 16, 3 / 16, -0.4, 5 / 16},
					{-1 / 16, -0.5, -1 / 16, 1 / 16, 0.4, 1 / 16}}
	}
})

ocular_networks.register_node("ocular_networks:networkprobe2_MCON", {
	tiles={"poly_uplink5.png", "poly_battery_bottom.png", "poly_uplink_side5.png"},
	is_ground_content=false,
	sunlight_propagates=true,
	drawtype="nodebox",
	paramtype="light",
	groups={cracky=3, oddly_breakable_by_hand=3},
	sounds=default.node_sound_metal_defaults(),
	mesecons= {
		receptor={
			state=mesecon.state.on,
			rules=mesecon.rules.default
		},
	},
	on_construct=function(pos)
		local meta=minetest.get_meta(pos)
		meta:set_string("channel", "")
		meta:set_string("mode", "")
		meta:set_string("attr", "")
		meta:set_int("modeidx",1)
		meta:set_string("formspec", nodespec2)
	end,
	on_receive_fields=function(pos, formname, fields, sender)
		local meta=minetest.get_meta(pos)
		if sender:get_player_name() == meta:get_string("owner") then
			meta:set_string("channel", fields.channel or "")
			meta:set_string("mode", fields.mode)
			local midx={
			 ["switch"]=1,
			 ["mesecon"]=2
			 }
			if midx[fields.mode] then
				meta:set_int("modeidx", midx[fields.mode])
			else
				meta:set_int("modeidx", 1)
			end
			meta:set_string("attr", fields.attr or "")
		else
			minetest.chat_send_player(sender:get_player_name(), "This mechanism is owned by "..meta:get_string("owner").."!")
		end
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
					{-3 / 16, -0.5, -5 / 16, 3 / 16, -0.4, 5 / 16},
					{-1 / 16, -0.5, -1 / 16, 1 / 16, 0.4, 1 / 16}}
	},
	groups={not_in_creative_inventory=1, cracky=1},
	drop="ocular_networks:networkprobe2",
})

minetest.register_abm({
    label="downlink probe",
	nodenames={"ocular_networks:networkprobe2"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_below=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		local meta=minetest.get_meta(pos)
		local meta2=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
		local owner=meta:get_string("owner")
		meta:set_string("infotext", "Receiving data over channel:".."$"..meta:get_string("channel").."\nOwned By: "..owner)
		if meta:get_string("mode") == "switch" then
			local verifstates={
				["on"]=true,
				["HIGH"]=true,
				["true"]=true,
				["1"]=true,
			}
			if verifstates[ocular_networks.channel_states["$"..meta:get_string("channel")]] then
				meta2:set_string("enabled", "false")
			else
				meta2:set_string("enabled", "true")
			end
		elseif meta:get_string("mode") == "mesecon" then
			if ocular_networks.channel_states["$"..meta:get_string("channel")] == meta:get_string("attr") then
				minetest.swap_node(pos, {name="ocular_networks:networkprobe2_MCON"})
				mesecon.receptor_on(pos, mesecon.rules.default)
			end
		end
	end,
})

minetest.register_abm({
    label="downlink probe",
	nodenames={"ocular_networks:networkprobe2_MCON"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_below=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		local meta=minetest.get_meta(pos)
		local meta2=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
		local owner=meta:get_string("owner")
		meta:set_string("infotext", "Receiving data over channel:".."$"..meta:get_string("channel").."\nOwned By: "..owner)
		if ocular_networks.channel_states["$"..meta:get_string("channel")] ~= meta:get_string("attr") then
			minetest.swap_node(pos, {name="ocular_networks:networkprobe2"})
			mesecon.receptor_off(pos, mesecon.rules.default)
		end
	end,
})

minetest.register_craft({
	output="ocular_networks:networkprobe2",
	recipe={
		{"default:copper_ingot", "ocular_networks:toxic_slate_rod", "default:copper_ingot"},
		{"ocular_networks:zweinium_crystal", "ocular_networks:networknode2", "ocular_networks:zweinium_crystal"},
		{"ocular_networks:shimmering_bar", "default:coal_lump", "ocular_networks:shimmering_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:computer",
	recipe={
		{"ocular_networks:zweinium_crystal", "ocular_networks:plate_shimmering", "ocular_networks:zweinium_crystal"},
		{"ocular_networks:plate_shimmering", "default:obsidian_glass", "ocular_networks:plate_shimmering"},
		{"ocular_networks:shimmering_bar", "ocular_networks:plate_shimmering", "ocular_networks:shimmering_bar"}
	}
})

local prb2="size[10,10;]background[0,0;0,0;poly_gui_formbg2.png;true]textarea[1,0.75;8.65,10;cmd;;${code}]field_close_on_enter[cmd;false]style[send;bgcolor=blue;textcolor=white]button_exit[3,9.5;4,1;send;Submit]"

ocular_networks.register_node("ocular_networks:computer", {
	description="Data Network Processor\n"..minetest.colorize("#00affa", "Repeatedly runs a series of Data Network commands.\n(Supports storage)"),
	tiles={"poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png^poly_screen.png"},
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
		
		if fields.cmd then
			meta:set_string("code", fields.cmd)
		end
		
		meta:set_string("formspec", prb2)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("code", "")
		meta:set_string("formspec", prb2)
		meta:set_string("infotext", "Owned By: "..owner)
		local timer=minetest.get_node_timer(pos)
		timer:set(0.5, 0)
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
	on_timer = function(pos, elapsed)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local code=meta:get_string("code").."\n"
		for line in code:gmatch("([^\r\n]*)[\r\n]") do
			local commandElems=string.split(line, " ")
			if #commandElems>1 then
				local con=true
				local output_=""
				if ocular_networks.netKeyWords[commandElems[1]] then
					output_, con = ocular_networks.netKeyWords[commandElems[1]].func(commandElems[2], commandElems)
				end
				if con then
					if ocular_networks.netCommandsExtended[commandElems[#commandElems-1]] then
						meta:set_string("infotext", ocular_networks.netCommandsExtended[commandElems[#commandElems-1]].func(commandElems[#commandElems], pos))
					end
				end
			end
		end
		local timer=minetest.get_node_timer(pos)
		timer:set(0.5, 0)
	end
})


ocular_networks.register_node("ocular_networks:terminal", {
	description="Data Network Terminal\n"..minetest.colorize("#00affa", "Open access point for the Data Network.\n(Records history, supports storage)"),
	tiles={"poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png", "poly_shimmering_block.png^poly_frame_3.png^poly_screen2.png"},
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
		
		if fields.cmd then
			meta:set_string("code", fields.cmd)
		end
		
		meta:set_string("formspec", prb2)
	end,
	after_place_node=function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		local owner=placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("enabled", "true")
		meta:set_string("code", "")
		meta:set_string("infotext", "Owned By: "..owner)
		local timer=minetest.get_node_timer(pos)
		timer:set(0.5, 0)
		meta:set_string("history", "")
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
	on_timer = function(pos, elapsed)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local code=meta:get_string("code").."\n"
		for line in code:gmatch("([^\r\n]*)[\r\n]") do
			local commandElems=string.split(line, " ")
			if #commandElems>1 then
				local con=true
				local output_=""
				if ocular_networks.netKeyWords[commandElems[1]] then
					output_, con = ocular_networks.netKeyWords[commandElems[1]].func(commandElems[2], commandElems)
				end
				if con then
					if ocular_networks.netCommands[commandElems[#commandElems-1]] then
						meta:set_string("infotext", ocular_networks.netCommands[commandElems[#commandElems-1]].func(commandElems[#commandElems]))
					end
				end
			end
		end
		local timer=minetest.get_node_timer(pos)
		timer:set(0.5, 0)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		clicker:get_meta():set_string("OCNcurrTermPos", pos.x.." "..pos.y.." "..pos.z)
		minetest.show_formspec(clicker:get_player_name(), "Poly_term", prb..meta:get_string("history")..ef)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname=="Poly_term" then
		if fields.cmd then
			local pos=string.split(player:get_meta():get_string("OCNcurrTermPos"), " ")
			pos2={}
			pos2.x=tonumber(pos[1])
			pos2.y=tonumber(pos[2])
			pos2.z=tonumber(pos[3])
			local meta=minetest.get_meta(pos2)
			local hist=meta:get_string("history")
			local commandElems=string.split(fields.cmd, " ")
			if #commandElems>1 then
				local con=true
				local output_=""
				if ocular_networks.netKeyWords[commandElems[1]] then
					output_, con=ocular_networks.netKeyWords[commandElems[1]].func(commandElems[2], commandElems)
				end
				
				if ocular_networks.netCommandsExtended[commandElems[#commandElems-1]] then
					local output=""
					if con then
						output=ocular_networks.netCommandsExtended[commandElems[#commandElems-1]].func(commandElems[#commandElems], pos2)
					end
					hist="\n$ "..fields.cmd.."\n"..output_..output.."\n"..hist
					minetest.show_formspec(player:get_player_name(), "Poly_term", prb..hist..ef)
					meta:set_string("history", hist)
				else
					minetest.show_formspec(player:get_player_name(), "Poly_term", prb.."$ "..fields.cmd.."\nCommand '"..fields.cmd.."' does not exist."..ef)
				end
			else
				local con=true
				local output_=""
				if ocular_networks.netKeyWords[commandElems[1]] then
					output_, con=ocular_networks.netKeyWords[commandElems[1]].func()
				end
				
				if ocular_networks.netCommandsExtended[commandElems[1]] then
					local output=""
					if con then
						output=ocular_networks.netCommandsExtended[commandElems[1]].func()
					end
					hist="\n$ "..fields.cmd.."\n"..output_..output.."\n"..hist
					minetest.show_formspec(player:get_player_name(), "Poly_term", prb..hist..ef)
					meta:set_string("history", hist)
				else
					minetest.show_formspec(player:get_player_name(), "Poly_term", prb.."$ "..fields.cmd.."\nCommand '"..fields.cmd.."' does not exist."..ef)
				end
			end
		end
	end
end)

ocular_networks.netCommandsExtended=table.copy(ocular_networks.netCommands)

ocular_networks.netCommandsExtended["state"]={
	name="state",
	desc="append : Set the environment option <elem> to the value <val> | Syntax: state <elem>:<val>", 
	func=function(arg, pos)
		if arg then
			local args=string.split(arg, ":")
			if #args==2 then
				minetest.get_meta(pos):set_string("SETTING0_"..args[1], args[2])
				return "Value of setting "..args[1].." set to "..args[2]
			else
				return "Incorrect formatting"
			end
		else
			return "No arguments specified"
		end
		return "(This message should never show up, report immediately) [STATE]["..arg.."]"
	end,
}

ocular_networks.netCommandsExtended["store"]={
	name="store",
	desc="store : Store the value <val> in the local address <addr> (<val> can be a channel name) | Syntax: store <val>=><addr>", 
	func=function(arg, pos)
		if arg then
			local args=string.split(arg, "=>")
			if #args==2 then
				if args[1]:sub(1,1) =="$" then
					if ocular_networks.channel_states[args[1]] then 
						args[1]=ocular_networks.channel_states[args[1]] 
					else
						return "Attempt to read non-exsistant channel"..args[1]
					end
				end
				minetest.get_meta(pos):set_string("ADDR_"..args[2], args[1])
				return "Value of address "..args[2].." set to "..args[1]
			else
				return "Incorrect formatting"
			end
		else
			return "No arguments specified"
		end
		return "(This message should never show up, report immediately) [STORE]["..arg.."]"
	end,
}

ocular_networks.netCommandsExtended["read"]={
	name="read",
	desc="read : Print  the value of the local address <addr> | Syntax: read <addr>", 
	func=function(arg, pos)
		if arg then
			return minetest.get_meta(pos):get_string("ADDR_"..arg)
		else
			return "No arguments specified"
		end
		return "(This message should never show up, report immediately) [STORE]["..arg.."]"
	end,
}

ocular_networks.netCommandsExtended["send"]={
	name="send",
	desc="send : Send the value of the local address <addr> to the channel <channel> (The <channel> field will be prepended with '$')| Syntax: send <addr>=><channel>", 
	func=function(arg, pos)
		if arg then
			local args=string.split(arg, "=>")
			if #args==2 then
				ocular_networks.channel_states["$"..args[2]]=minetest.get_meta(pos):get_string("ADDR_"..args[1])
				return "Value of channel ".."$"..args[2].." set to "..minetest.get_meta(pos):get_string("ADDR_"..args[1])
			else
				return "Incorrect formatting"
			end
		else
			return "No arguments specified"
		end
		return "(This message should never show up, report immediately) [STORE]["..arg.."]"
	end,
}

ocular_networks.netCommandsExtended["help"]={
	name="help",
	desc="help : Provide help for a specified command, or list available commands | Syntax: help <cmd>",
	func=function(arg)
		if arg and arg ~= "" then
			if ocular_networks.netCommands[arg] then
				return ocular_networks.netCommandsExtended[arg].desc
			else
				return "Command "..arg.." doesn't exist"
			end
		else
			local help=""
			for _,v in pairs(ocular_networks.netCommandsExtended) do
				help=help..v.desc.."\n\n"
			end
			for _,v in pairs(ocular_networks.netKeyWords) do
				help=help..v.desc.."\n\n"
			end
			return help
		end
		return "(This message should never show up, report immediately) [HELP]["..arg.."]"
	end,
}

minetest.register_craft({
	output="ocular_networks:terminal",
	recipe={
		{"ocular_networks:zweinium_crystal", "default:copper_ingot", "ocular_networks:zweinium_crystal"},
		{"ocular_networks:plate_shimmering", "default:obsidian_glass", "ocular_networks:plate_shimmering"},
		{"ocular_networks:zweinium_crystal", "default:copper_ingot", "ocular_networks:zweinium_crystal"}
	}
})
