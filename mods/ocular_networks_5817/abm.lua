minetest.register_abm({
    label="ocular battery charging",
	nodenames={"ocular_networks:battery"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_above=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			meta:set_string("infotext", "Power Buffer: "..power.."\nOwned By: "..meta:get_string("owner"))
			if node_above.name == "ocular_networks:frame_lens" then
				local node_above_light=minetest.get_node_light({x=pos.x, y=pos.y+2, z=pos.z})
				if not minetest.find_node_near(pos, 11, ocular_networks.disallowed) then
					meta:set_int("ocular_power", power+node_above_light)
				end
			elseif node_above.name == "ocular_networks:frame_lens_z" then
				local node_above_light=minetest.get_node_light({x=pos.x, y=pos.y+2, z=pos.z})
				if not minetest.find_node_near(pos, 11, ocular_networks.disallowed) then
					meta:set_int("ocular_power", power+(node_above_light*5))
				end
			end
		end
	end,
})

minetest.register_abm({
    label="steam battery charging",
	nodenames={"ocular_networks:boiler"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_above=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		local node_below=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		local nodes_around={a=minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}), b=minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}), c=minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}), d=minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1})}
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			meta:set_string("infotext", "Power Buffer: "..power.."\nOwned By: "..meta:get_string("owner"))
			if node_above.name == "default:lava_source" then
				if node_below.name == "default:river_water_source" then
					if nodes_around.a.name == "ocular_networks:frame_cross" and nodes_around.b.name == "ocular_networks:frame_cross" and nodes_around.c.name == "ocular_networks:frame_cross" and nodes_around.d.name == "ocular_networks:frame_cross" then
						meta:set_int("ocular_power", power+150)
						minetest.sound_play("OCN_steam_puff", {gain = 0.3, pos = pos, max_hear_distance = 10})
					end
				end
			end
		end
	end,
})

minetest.register_abm({
        label="plant battery charging",
	nodenames={"ocular_networks:bolumiary"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_above=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		local node_below=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			meta:set_string("infotext", "Power Buffer: "..power.."\nOwned By: "..meta:get_string("owner"))
			if node_below.name == "ocular_networks:gearbox" then
				if node_above.name == "default:grass_1" then
					meta:set_int("ocular_power", power+10)
				end
				if node_above.name == "default:grass_2" then
					meta:set_int("ocular_power", power+20)
				end
				if node_above.name == "default:grass_3" then
					meta:set_int("ocular_power", power+30)
				end
				if node_above.name == "default:grass_4" then
					meta:set_int("ocular_power", power+40)
				end
				if node_above.name == "default:grass_5" then
					meta:set_int("ocular_power", power+50)
				end
			end
		end
	end,
})

minetest.register_abm({
    label="ocular node network distribution (draw)",
	nodenames={"ocular_networks:distributor"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			local owner=meta:get_string("owner")
			local x, y, z=meta:get_int("sourceposx"), meta:get_int("sourceposy"), meta:get_int("sourceposz")
			local source_meta=minetest.get_meta({x=pos.x+x, y=pos.y+y, z=pos.z+z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if source_power > 4 then
					if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
						if x > -11 and x < 11 and y > -11 and y < 11 and z > -11 and z < 11 then
							local nom=1
							if x == 0 or x == nil then
								nom=nom+1
							end
							if y == 0 or y == nil then
								nom=nom+1
							end
							if z == 0 or z == nil then
								nom=nom+1
							end
							if nom < 4 then
								source_meta:set_int("ocular_power", source_power-5)
								meta:set_int("ocular_power", power+5)
							end
						end
					end
				end
			end
			meta:set_string("infotext", "Power Buffer: "..meta:get_int("ocular_power").."\nOwned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocular node network distribution 2 (draw)",
	nodenames={"ocular_networks:distributor_2"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			local owner=meta:get_string("owner")
			local draw=meta:get_int("draw")
			local x, y, z=meta:get_int("sourceposx"), meta:get_int("sourceposy"), meta:get_int("sourceposz")
			local source_meta=minetest.get_meta({x=pos.x+x, y=pos.y+y, z=pos.z+z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if source_power > draw-1 then
					if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
						if x > -21 and x < 21 and y > -21 and y < 21 and z > -21 and z < 21 then
							local nom=1
							if x == 0 or x == nil then
								nom=nom+1
							end
							if y == 0 or y == nil then
								nom=nom+1
							end
							if z == 0 or z == nil then
								nom=nom+1
							end
							if nom < 4 then
								source_meta:set_int("ocular_power", source_power-draw)
								meta:set_int("ocular_power", power+draw)
							end
						end
					end
				end
			end
			meta:set_string("infotext", "Power Buffer: "..meta:get_int("ocular_power").."\nOwned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocular node network distribution 3 (draw)",
	nodenames={"ocular_networks:distributor_3"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			local owner=meta:get_string("owner")
			local draw=meta:get_int("draw")
			local x, y, z=meta:get_int("sourceposx"), meta:get_int("sourceposy"), meta:get_int("sourceposz")
			local source_meta=minetest.get_meta({x=pos.x+x, y=pos.y+y, z=pos.z+z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if source_power > draw-1 then
					if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
						if x > -31 and x < 31 and y > -31 and y < 31 and z > -31 and z < 31 then
							local nom=1
							if x == 0 or x == nil then
								nom=nom+1
							end
							if y == 0 or y == nil then
								nom=nom+1
							end
							if z == 0 or z == nil then
								nom=nom+1
							end
							if nom < 4 then
								source_meta:set_int("ocular_power", source_power-draw)
								meta:set_int("ocular_power", power+draw)
							end
						end
					end
				end
			end
			meta:set_string("infotext", "Power Buffer: "..meta:get_int("ocular_power").."\nOwned By: "..owner)
		end

	end,
})

minetest.register_abm({
    label="melting furnace",
	nodenames={"ocular_networks:melter"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_meltables) do
						if inv:contains_item("input", recipe.input) then
							if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "air" then
								if source_power > recipe.cost-1 then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:remove_item("input", recipe.input)
									minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name=recipe.output})
									minetest.sound_play("OCN_melter_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="shroom infusing",
	nodenames={"ocular_networks:shroom_planter"},
	interval=10,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=tonumber(source_meta:get_int("ocular_power")) 
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_shrooms) do
						if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == recipe.input then
							if source_power > recipe.cost-1 then
								source_meta:set_int("ocular_power", source_power-recipe.cost)
								inv:add_item("output", recipe.output)
								minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="alloyer",
	nodenames={"ocular_networks:alloyer"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_alloys) do
						if inv:contains_item("input1", recipe.input1) and inv:contains_item("input2", recipe.input2) then
							if source_power > recipe.cost-1 then
								if inv:room_for_item("output", recipe.output) then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:add_item("output", recipe.output)
									if inv:room_for_item("output", recipe._return) then
										inv:add_item("output", recipe._return)
										inv:remove_item("input2", recipe.input2)
										inv:remove_item("input1", recipe.input1)
										minetest.sound_play("OCN_alloyer_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
									else
										inv:remove_item("output", recipe.output)
									end
								end
							end
						elseif inv:contains_item("input1", recipe.input2) and inv:contains_item("input2", recipe.input1) then
							if source_power > recipe.cost-1 then
								if inv:room_for_item("output", recipe.output) then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:add_item("output", recipe.output)
									if inv:room_for_item("output", recipe._return) then
										inv:add_item("output", recipe._return)
										inv:remove_item("input1", recipe.input2)
										inv:remove_item("input2", recipe.input1)
										minetest.sound_play("OCN_alloyer_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
									else
										inv:remove_item("output", recipe.output)
									end
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="fusion",
	nodenames={"ocular_networks:fuser"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_fusions) do
						if inv:contains_item("input1", recipe.input1) and inv:contains_item("input2", recipe.input2) then
							if source_power > recipe.cost-1 then
								if inv:room_for_item("output", recipe.output) then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:add_item("output", recipe.output)
									if inv:room_for_item("output", recipe._return) then
										inv:add_item("output", recipe._return)
										inv:remove_item("input2", recipe.input2)
										inv:remove_item("input1", recipe.input1)
										minetest.add_item({x=pos.x, y=pos.y-1, z=pos.z}, "ocular_networks:crud")
										minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
									else
										inv:remove_item("output", recipe.output)
									end
								end
							end
						elseif inv:contains_item("input1", recipe.input2) and inv:contains_item("input2", recipe.input1) then
							if source_power > recipe.cost-1 then
								if inv:room_for_item("output", recipe.output) then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:add_item("output", recipe.output)
									if inv:room_for_item("output", recipe._return) then
										inv:add_item("output", recipe._return)
										inv:remove_item("input1", recipe.input2)
										inv:remove_item("input2", recipe.input1)
										minetest.add_item({x=pos.x, y=pos.y-1, z=pos.z}, "ocular_networks:crud")
										minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
									else
										inv:remove_item("output", recipe.output)
									end
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

ocular_networks.cools={}

minetest.register_abm({
    label="metal cooling",
	nodenames={"group:metal_liquid_source"},
	neighbors={"group:cools_lava"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		minetest.set_node(pos, ocular_networks.cools[node.name])
		minetest.sound_play("OCN_steam_puff", {gain = 0.3, pos = pos, max_hear_distance = 10})
	end,
})

minetest.register_abm({
    label="player personal network loading",
	nodenames={"ocular_networks:networknode"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if minetest.get_player_by_name(owner) then
						if minetest.get_player_by_name(owner):is_player_connected(owner) then
							local player=minetest.get_player_by_name(owner)
							if player:get_meta():get_string("personal_ocular_power") then
								local playerPower=tonumber(player:get_meta():get_string("personal_ocular_power"))
								player:get_meta():set_string("personal_ocular_power", tostring(playerPower+source_power))
								source_meta:set_int("ocular_power", 0)
							else
								player:get_meta():set_string("personal_ocular_power", tostring(source_power))
								source_meta:set_int("ocular_power", 0)
							end
						end
					end
				end
			end
		local function b()	meta:set_string("infotext", "Owned By: "..owner) end
		minetest.after(1, b)
		end
	end,
})

minetest.register_abm({
    label="player personal network unloading",
	nodenames={"ocular_networks:networknode2"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			local rate=meta:get_int("draw_amount")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if minetest.get_player_by_name(owner) then
						if minetest.get_player_by_name(owner):is_player_connected(owner) then
							local player=minetest.get_player_by_name(owner)
							if player:get_meta():get_string("personal_ocular_power") then
								local playerPower=tonumber(player:get_meta():get_string("personal_ocular_power"))
								if playerPower < rate-1 then
									source_meta:set_int("ocular_power", source_power+playerPower)
									player:get_meta():set_string("personal_ocular_power", tostring(0))
								else
									player:get_meta():set_string("personal_ocular_power", tostring(playerPower-rate))
									source_meta:set_int("ocular_power", source_power+rate)
								end
							else
								return 0
							end
						end
					end
				end
			end 
		local function b()	meta:set_string("infotext", "Owned By: "..owner) end
		minetest.after(1, b)
		end
		
	end,
})

minetest.register_abm({
    label="reservoir updating",
	nodenames={"ocular_networks:reservoir", "ocular_networks:reservoir2"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		meta:set_string("infotext", "Owned By: "..owner.."\nContains "..meta:get_int("ocular_power").." power")
	end,
})

minetest.register_abm({
    label="ocn_cooling",
	nodenames={"ocular_networks:passive_cooler"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
			for _,recipe in ipairs(ocular_networks.registered_passivecools) do
				if inv:contains_item("input", recipe.input) then
					if inv:room_for_item("output", recipe.output) and inv:room_for_item("dst", "bucket:bucket_empty") then
						inv:remove_item("input", recipe.input)
						inv:add_item("output", recipe.output)
						inv:add_item("dst", "bucket:bucket_empty")
						minetest.sound_play("OCN_steam_puff", {gain = 0.3, pos = pos, max_hear_distance = 10})
					end
				end
			end
	meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocn charging",
	nodenames={"ocular_networks:charger"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_chargeables) do
						if inv:contains_item("input", recipe.input) then
							if inv:room_for_item("output", recipe.output) then
								if source_power > recipe.cost-1 then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:remove_item("input", recipe.input)
									inv:add_item("output", recipe.output)
									minetest.sound_play("OCN_generic_zap", {gain = 0.3, pos = pos, max_hear_distance = 10})
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="laserdrill core",
	nodenames={"ocular_networks:laserdrillchest"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local source_power=meta:get_int("ocular_power")
			if source_power then
				meta:set_string("infotext", "Owned By: "..owner.."\nPower: "..source_power)
			end
		end
	end,
})

minetest.register_abm({
    label="laserdrill projector",
	nodenames={"ocular_networks:laserdrill"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local distance=meta:get_int("digDistance")
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "ocular_networks:laserdrillchest" then
						if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "ocular_networks:frame_lens" then
							local inv=source_meta:get_inventory()
							if minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name == "air" then
								meta:set_int("digDistance", distance+1)
							elseif not ocular_networks.get_config("laserDrill_blacklist")[minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name] then
								if source_power and source_power > 599 then
									if inv:room_for_item("output", minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name].drop) then
										minetest.emerge_area({x=pos.x, y=pos.y-distance, z=pos.z}, {x=pos.x, y=pos.y-distance+10, z=pos.z})
										source_meta:set_int("ocular_power", source_power-500)
										inv:add_item("output", minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name].drop or minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name)
										minetest.set_node({x=pos.x, y=pos.y-distance, z=pos.z}, {name="air"})
									end
								end
							end
						elseif minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "ocular_networks:frame_lens_z" then
							local inv=source_meta:get_inventory()
							for i=1,5 do
								distance=meta:get_int("digDistance")
								if minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name == "air" then
									meta:set_int("digDistance", distance+1)
								elseif not ocular_networks.get_config("laserDrill_blacklist")[minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name] then
									if source_power and source_power > 599 then
										if inv:room_for_item("output", minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name].drop) then
											minetest.emerge_area({x=pos.x, y=pos.y-distance, z=pos.z}, {x=pos.x, y=pos.y-distance+10, z=pos.z})
											source_meta:set_int("ocular_power", source_power-500)
											inv:add_item("output", minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name].drop or minetest.get_node({x=pos.x, y=pos.y-distance, z=pos.z}).name)
											minetest.set_node({x=pos.x, y=pos.y-distance, z=pos.z}, {name="air"})
											meta:set_int("digDistance", distance+1)
										end
									end
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="east-facing pipe",
	nodenames={"ocular_networks:pipe_E"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
		local source_meta=minetest.get_meta({x=pos.x-1, y=pos.y, z=pos.z})
		local source_owner=source_meta:get_string("owner")
		local target_meta=minetest.get_meta({x=pos.x+1, y=pos.y, z=pos.z})
		local target_owner=target_meta:get_string("owner")
		local source_inv=source_meta:get_inventory()
		local target_inv=target_meta:get_inventory()
		local source_node=minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name
		local target_node=minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name
		if meta:get_string("enabled")=="true" then
		if owner == source_owner or source_owner=="" then
			if source_inv:get_list("output") then
				for i,stack in ipairs(source_inv:get_list("output")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("output", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("dst") then
				for i,stack in ipairs(source_inv:get_list("dst")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("dst", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("main") then
				for i,stack in ipairs(source_inv:get_list("main")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("main", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if target_node == "ocular_networks:pipe_E" then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("pipe_buffer", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("pipe_buffer", stack)
					end
				end
			elseif target_inv:get_list("main") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("main", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("main", stack)
					end
				end
			elseif target_inv:get_list("input") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("input", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("input", stack)
					end
				end
			elseif target_inv:get_list("src") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("src", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("src", stack)
					end
				end
			end
			
			if source_inv:get_list("liq") then
				for i,stack in ipairs(source_inv:get_list("liq")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("liq", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq", stack)
					end
				end
			end
			if source_inv:get_list("pipe_liquid_buffer") then
				for i,stack in ipairs(source_inv:get_list("pipe_liquid_buffer")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("pipe_liquid_buffer", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq_i") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq_i", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq_i", stack)
					end
				end
			end
		end
		end
	end,
})

minetest.register_abm({
    label="west-facing pipe",
	nodenames={"ocular_networks:pipe_W"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
		local source_meta=minetest.get_meta({x=pos.x+1, y=pos.y, z=pos.z})
		local source_owner=source_meta:get_string("owner")
		local target_meta=minetest.get_meta({x=pos.x-1, y=pos.y, z=pos.z})
		local target_owner=target_meta:get_string("owner")
		local source_inv=source_meta:get_inventory()
		local target_inv=target_meta:get_inventory()
		local source_node=minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name
		local target_node=minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name
		if meta:get_string("enabled")=="true" then
		if owner == source_owner or source_owner == "" then
			if source_inv:get_list("output") then
				for i,stack in ipairs(source_inv:get_list("output")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("output", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("dst") then
				for i,stack in ipairs(source_inv:get_list("dst")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("dst", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("main") then
				for i,stack in ipairs(source_inv:get_list("main")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("main", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if target_node == "ocular_networks:pipe_W" then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("pipe_buffer", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("pipe_buffer", stack)
					end
				end
			elseif target_inv:get_list("main") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("main", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("main", stack)
					end
				end
			elseif target_inv:get_list("input") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("input", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("input", stack)
					end
				end
			elseif target_inv:get_list("src") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("src", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("src", stack)
					end
				end
			end
			
			if source_inv:get_list("liq") then
				for i,stack in ipairs(source_inv:get_list("liq")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("liq", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq", stack)
					end
				end
			end
			if source_inv:get_list("pipe_liquid_buffer") then
				for i,stack in ipairs(source_inv:get_list("pipe_liquid_buffer")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("pipe_liquid_buffer", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq_i") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq_i", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq_i", stack)
					end
				end
			end
		end
		end
	end,
})

minetest.register_abm({
    label="south-facing pipe",
	nodenames={"ocular_networks:pipe_S"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
		local source_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z+1})
		local source_owner=source_meta:get_string("owner")
		local target_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z-1})
		local target_owner=target_meta:get_string("owner")
		local source_inv=source_meta:get_inventory()
		local target_inv=target_meta:get_inventory()
		local source_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name
		local target_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name
		if meta:get_string("enabled")=="true" then
		if owner == source_owner or source_owner == "" then
			if source_inv:get_list("output") then
				for i,stack in ipairs(source_inv:get_list("output")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("output", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("dst") then
				for i,stack in ipairs(source_inv:get_list("dst")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("dst", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("main") then
				for i,stack in ipairs(source_inv:get_list("main")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("main", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if target_node == "ocular_networks:pipe_S" then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("pipe_buffer", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("pipe_buffer", stack)
					end
				end
			elseif target_inv:get_list("main") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("main", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("main", stack)
					end
				end
			elseif target_inv:get_list("input") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("input", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("input", stack)
					end
				end
			elseif target_inv:get_list("src") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("src", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("src", stack)
					end
				end
			end
			
			if source_inv:get_list("liq") then
				for i,stack in ipairs(source_inv:get_list("liq")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("liq", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq", stack)
					end
				end
			end
			if source_inv:get_list("pipe_liquid_buffer") then
				for i,stack in ipairs(source_inv:get_list("pipe_liquid_buffer")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("pipe_liquid_buffer", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq_i") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq_i", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq_i", stack)
					end
				end
			end
		end
		end
	end,
})

minetest.register_abm({
    label="north-facing pipe",
	nodenames={"ocular_networks:pipe_N"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
		local source_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z-1})
		local source_owner=source_meta:get_string("owner")
		local target_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z+1})
		local target_owner=target_meta:get_string("owner")
		local source_inv=source_meta:get_inventory()
		local target_inv=target_meta:get_inventory()
		local source_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name
		local target_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name
		if meta:get_string("enabled")=="true" then
		if owner == source_owner or source_owner == "" then
			if source_inv:get_list("output") then
				for i,stack in ipairs(source_inv:get_list("output")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("output", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("dst") then
				for i,stack in ipairs(source_inv:get_list("dst")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("dst", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("main") then
				for i,stack in ipairs(source_inv:get_list("main")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("main", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if target_node == "ocular_networks:pipe_N" then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("pipe_buffer", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("pipe_buffer", stack)
					end
				end
			elseif target_inv:get_list("main") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("main", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("main", stack)
					end
				end
			elseif target_inv:get_list("input") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("input", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("input", stack)
					end
				end
			elseif target_inv:get_list("src") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("src", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("src", stack)
					end
				end
			end
			
			if source_inv:get_list("liq") then
				for i,stack in ipairs(source_inv:get_list("liq")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("liq", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq", stack)
					end
				end
			end
			if source_inv:get_list("pipe_liquid_buffer") then
				for i,stack in ipairs(source_inv:get_list("pipe_liquid_buffer")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("pipe_liquid_buffer", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq_i") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq_i", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq_i", stack)
					end
				end
			end
		end
		end
	end,
})

minetest.register_abm({
    label="up-facing pipe",
	nodenames={"ocular_networks:pipe_U"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
		local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
		local source_owner=source_meta:get_string("owner")
		local target_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
		local target_owner=target_meta:get_string("owner")
		local source_inv=source_meta:get_inventory()
		local target_inv=target_meta:get_inventory()
		local source_node=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local target_node=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		if owner == source_owner or source_owner == "" then
			if source_inv:get_list("output") then
				for i,stack in ipairs(source_inv:get_list("output")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("output", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("dst") then
				for i,stack in ipairs(source_inv:get_list("dst")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("dst", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("main") then
				for i,stack in ipairs(source_inv:get_list("main")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("main", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if target_node == "ocular_networks:pipe_U" then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("pipe_buffer", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("pipe_buffer", stack)
					end
				end
			elseif target_inv:get_list("main") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("main", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("main", stack)
					end
				end
			elseif target_inv:get_list("input") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("input", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("input", stack)
					end
				end
			elseif target_inv:get_list("src") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("src", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("src", stack)
					end
				end
			end
			
			if source_inv:get_list("liq") then
				for i,stack in ipairs(source_inv:get_list("liq")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("liq", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq", stack)
					end
				end
			end
			if source_inv:get_list("pipe_liquid_buffer") then
				for i,stack in ipairs(source_inv:get_list("pipe_liquid_buffer")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("pipe_liquid_buffer", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq_i") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq_i", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq_i", stack)
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="down-facing pipe",
	nodenames={"ocular_networks:pipe_D"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local owner=meta:get_string("owner")
		local inv=meta:get_inventory()
		local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
		local source_owner=source_meta:get_string("owner")
		local target_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
		local target_owner=target_meta:get_string("owner")
		local source_inv=source_meta:get_inventory()
		local target_inv=target_meta:get_inventory()
		local source_node=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		local target_node=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		if owner == source_owner or source_owner == "" then
			if source_inv:get_list("output") then
				for i,stack in ipairs(source_inv:get_list("output")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("output", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("dst") then
				for i,stack in ipairs(source_inv:get_list("dst")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("dst", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if source_inv:get_list("main") then
				for i,stack in ipairs(source_inv:get_list("main")) do
					if inv:room_for_item("pipe_buffer", stack) then
						source_inv:set_stack("main", i, {})
						inv:add_item("pipe_buffer", stack)
					end
				end
			end
			if target_node == "ocular_networks:pipe_D" then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("pipe_buffer", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("pipe_buffer", stack)
					end
				end
			elseif target_inv:get_list("main") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("main", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("main", stack)
					end
				end
			elseif target_inv:get_list("input") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("input", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("input", stack)
					end
				end
			elseif target_inv:get_list("src") then
				for i,stack in ipairs(inv:get_list("pipe_buffer")) do
					if target_inv:room_for_item("src", stack) then
						inv:set_stack("pipe_buffer", i, {})
						target_inv:add_item("src", stack)
					end
				end
			end
			
			if source_inv:get_list("liq") then
				for i,stack in ipairs(source_inv:get_list("liq")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("liq", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq", stack)
					end
				end
			end
			if source_inv:get_list("pipe_liquid_buffer") then
				for i,stack in ipairs(source_inv:get_list("pipe_liquid_buffer")) do
					if inv:room_for_item("pipe_liquid_buffer", stack) then
						source_inv:set_stack("pipe_liquid_buffer", i, {})
						inv:add_item("pipe_liquid_buffer", stack)
					end
				end
			end
			if target_inv:get_list("liq_i") then
				for i,stack in ipairs(inv:get_list("pipe_liquid_buffer")) do
					if target_inv:room_for_item("liq_i", stack) then
						inv:set_stack("pipe_liquid_buffer", i, {})
						target_inv:add_item("liq_i", stack)
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_filtered_D"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_owner=source_meta:get_string("owner")
			local target_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local target_owner=target_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			local target_inv=target_meta:get_inventory()
			local source_node=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
			local target_node=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								if target_inv:room_for_item("main", item) then
									source_inv:set_stack("main", i, {})
									target_inv:add_item("main", stack)
								end
							end
						end
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_filtered_U"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_owner=source_meta:get_string("owner")
			local target_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local target_owner=target_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			local target_inv=target_meta:get_inventory()
			local source_node=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
			local target_node=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								if target_inv:room_for_item("main", item) then
									source_inv:set_stack("main", i, {})
									target_inv:add_item("main", stack)
								end
							end
						end
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_filtered_N"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z-1})
			local source_owner=source_meta:get_string("owner")
			local target_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z+1})
			local target_owner=target_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			local target_inv=target_meta:get_inventory()
			local source_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name
			local target_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name
			if meta:get_string("enabled")=="true" then
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								if target_inv:room_for_item("main", item) then
									source_inv:set_stack("main", i, {})
									target_inv:add_item("main", stack)
								end
							end
						end
					end
				end
			end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_filtered_S"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z+1})
			local source_owner=source_meta:get_string("owner")
			local target_meta=minetest.get_meta({x=pos.x, y=pos.y, z=pos.z-1})
			local target_owner=target_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			local target_inv=target_meta:get_inventory()
			local source_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name
			local target_node=minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name
			if meta:get_string("enabled")=="true" then
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								if target_inv:room_for_item("main", item) then
									source_inv:set_stack("main", i, {})
									target_inv:add_item("main", stack)
								end
							end
						end
					end
				end
			end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_filtered_E"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x-1, y=pos.y, z=pos.z})
			local source_owner=source_meta:get_string("owner")
			local target_meta=minetest.get_meta({x=pos.x+1, y=pos.y, z=pos.z})
			local target_owner=target_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			local target_inv=target_meta:get_inventory()
			local source_node=minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name
			local target_node=minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name
			if meta:get_string("enabled")=="true" then
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								if target_inv:room_for_item("main", item) then
									source_inv:set_stack("main", i, {})
									target_inv:add_item("main", stack)
								end
							end
						end
					end
				end
			end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_filtered_W"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x+1, y=pos.y, z=pos.z})
			local source_owner=source_meta:get_string("owner")
			local target_meta=minetest.get_meta({x=pos.x-1, y=pos.y, z=pos.z})
			local target_owner=target_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			local target_inv=target_meta:get_inventory()
			local source_node=minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name
			local target_node=minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								if target_inv:room_for_item("main", item) then
									source_inv:set_stack("main", i, {})
									target_inv:add_item("main", stack)
								end
							end
						end
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="trash extracting",
	nodenames={"ocular_networks:pipe_trashextractor"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
			if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local destroyList=string.split(meta:get_string("items"), " ")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_owner=source_meta:get_string("owner")
			local source_inv=source_meta:get_inventory()
			if owner == source_owner or source_owner == "" then
				if source_inv:get_list("main") then
					for _,item in ipairs(destroyList) do
						for i, stack in ipairs(source_inv:get_list("main")) do
							if stack:get_name()==item then
								source_inv:set_stack("main", i, {})
							end
						end
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="growth",
	nodenames={"ocular_networks:loomshroom"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "ocular_networks:dirt_with_loomshroom_grass" then
			local chance=math.random(1,100)
			if chance == 37 then
				minetest.set_node(pos, {name="ocular_networks:loomshroom2"})
			end
		end
	end,
})

minetest.register_abm({
    label="growth",
	nodenames={"ocular_networks:loomshroom2"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "ocular_networks:dirt_with_loomshroom_grass" then
			local chance=math.random(1,1000)
			if chance == 37 then
				minetest.set_node(pos, {name="ocular_networks:loomshroom3"})
			end
		end
	end,
})

minetest.register_abm({
    label="growth",
	nodenames={"ocular_networks:loomshroom3"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "ocular_networks:dirt_with_loomshroom_grass" then
			local chance=math.random(1,1000)
			if chance == 3 then
				minetest.set_node(pos, {name="ocular_networks:loomshroom4"})
			end
		end
	end,
})

minetest.register_abm({
    label="chemical oven",
	nodenames={"ocular_networks:chem_oven"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_dessicables) do
						if inv:contains_item("input", recipe.input) then
							if inv:contains_item("fuel", "ocular_networks:peat") then
								if source_power > recipe.cost-1 then
									if inv:room_for_item("output", recipe.output) then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:remove_item("input", recipe.input)
									inv:remove_item("fuel", "ocular_networks:peat")
									inv:add_item("output", recipe.output)
									minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
									end
								end
							else
								if source_power > (recipe.cost*2)-1 then
									if inv:room_for_item("output", recipe.output) then
									source_meta:set_int("ocular_power", source_power-(recipe.cost*2))
									inv:remove_item("input", recipe.input)
									inv:add_item("output", recipe.output)
									minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
									end
								end
							end
						end
					end
					if not inv:get_stack("input", 1):is_empty() then
						if source_power > 9 and inv:contains_item("fuel", "ocular_networks:peat") then
							source_meta:set_int("ocular_power", source_power-10)
							inv:remove_item("fuel", "ocular_networks:peat")
							inv:add_item("output", "ocular_networks:crud "..inv:get_stack("input", 1):get_count())
							inv:set_stack("input", 1, "")
							minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="heka battery charging",
	nodenames={"ocular_networks:ton_core"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local node_above=minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		local node_below=minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		local inv=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z}):get_inventory()
		local nodes_around={a=minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}), b=minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}), c=minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}), d=minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1})}
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local power=meta:get_int("ocular_power")
			meta:set_string("infotext", "Power Buffer: "..power.."\nHeat: "..meta:get_int("heat").."\nOwned By: "..meta:get_string("owner"))
			if node_above.name == "ocular_networks:pipe_itembuffer" then
				if node_below.name == "ocular_networks:firebrick" then
					if inv:contains_item("main", "ocular_networks:superfuel") then
						if nodes_around.a.name == "ocular_networks:firebrick" and nodes_around.b.name == "ocular_networks:firebrick" and nodes_around.c.name == "ocular_networks:firebrick" and nodes_around.d.name == "ocular_networks:firebrick" then
							meta:set_int("ocular_power", power+500)
							inv:remove_item("main", "ocular_networks:superfuel")
							meta:set_int("heat", meta:get_int("heat")+1)
							if meta:get_int("heat") > 49 then
								if inv:contains_item("main", "ocular_networks:bucket_coolant") then
									inv:remove_item("main", "ocular_networks:bucket_coolant")
									inv:add_item("main", "bucket:bucket_empty")
									meta:set_int("heat", 0)
								else
									tnt.boom(pos, {10, 30})
									meta:set_int("heat", 0)
								end
							end
						end
					end
				end
			end
		end
	end,
})

minetest.register_abm({
    label="omni-insertion",
	nodenames={"ocular_networks:insertor"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local x, y, z=meta:get_int("sourceposx"), meta:get_int("sourceposy"), meta:get_int("sourceposz")
			local source_meta=minetest.get_meta({x=pos.x+x, y=pos.y+y, z=pos.z+z})
			local source_owner=source_meta:get_string("owner")
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if x > -2 and x < 2 and y > -2 and y < 2 and z > -2 and z < 2 then
						local nom=1
						if x == 0 or x == nil then
							nom=nom+1
						end
						if y == 0 or y == nil then
							nom=nom+1
						end
						if z == 0 or z == nil then
							nom=nom+1
						end
						if nom < 4 then
							if source_meta:get_inventory():get_list(meta:get_string("ainv")) and meta:get_string("ainv")~="liq" then
								local subinv=source_meta:get_inventory()
								for i, stack in ipairs(meta:get_inventory():get_list("main")) do
									if subinv:room_for_item(meta:get_string("ainv"), stack) then
										meta:get_inventory():set_stack("main", i, {})
										subinv:add_item(meta:get_string("ainv"), stack)
									end
								end
							end
						end
					end
				end
			meta:set_string("infotext", "\nOwned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocn charging",
	nodenames={"ocular_networks:repairer"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if inv:get_stack("input",1):get_wear() >0 then
						if source_power > 9999+inv:get_stack("input",1):get_wear() then
							source_meta:set_int("ocular_power", source_power-(10000+inv:get_stack("input",1):get_wear()) )
							local stacke=inv:get_stack("input",1)
							stacke:set_wear(0)
							inv:set_stack("input",1,stacke)
							minetest.sound_play("OCN_melter_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocn grinding",
	nodenames={"ocular_networks:grinder"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_grindables) do
						if inv:contains_item("input", recipe.input) then
							if inv:room_for_item("output", recipe.output) then
								if source_power > recipe.cost-1 then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:remove_item("input", recipe.input)
									inv:add_item("output", recipe.output)
									minetest.sound_play("OCN_generic_crunch", {gain = 0.3, pos = pos, max_hear_distance = 10})
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocn grinding",
	nodenames={"ocular_networks:forge"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_forgables) do
						if inv:contains_item("input", recipe.input) then
							if inv:room_for_item("output", recipe.output) then
								if source_power > recipe.cost-1 then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:remove_item("input", recipe.input)
									inv:add_item("output", recipe.output)
									minetest.sound_play("OCN_forge_clang", {gain = 0.3, pos = pos, max_hear_distance = 10})
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
	label="cultivator",
	nodenames={"ocular_networks:cultivator"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					for _,recipe in ipairs(ocular_networks.registered_cultivables) do
						if inv:contains_item("input", recipe.input) then
							if inv:contains_item("fuel", "ocular_networks:fertiliser") then
								if source_power > recipe.cost-1 then
									source_meta:set_int("ocular_power", source_power-recipe.cost)
									inv:remove_item("fuel", "ocular_networks:fertiliser")
									inv:add_item("output", recipe.output)
									minetest.sound_play("OCN_fuser_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
								end
							end
						end
					end
				end
			end
		meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="ocn_smelting",
	nodenames={"ocular_networks:furnace"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					local inv=meta:get_inventory()
					if source_power  and source_power >499 then
						local result,dec=minetest.get_craft_result({method="cooking", width=1, items={inv:get_stack("input", 1)}})
						if result and result.item and result.item ~= "" and inv:get_stack("input", 1) and inv:get_stack("input", 1):get_name() and inv:get_stack("input", 1):get_name() ~= "" then
							if inv:room_for_item("output", result.item) then
								inv:add_item("output", result.item)
								inv:remove_item("input", inv:get_stack("input", 1):get_name())
								minetest.sound_play("OCN_melter_hum", {gain = 0.3, pos = pos, max_hear_distance = 10})
								source_meta:set_int("ocular_power", source_power-500)
							end
						end
					end
				end
			end
			meta:set_string("infotext", "Owned By: "..owner)
		end
	end
})

minetest.register_abm({
    label="ocn_crafting",
	nodenames={"ocular_networks:crafter"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					local inv=meta:get_inventory()
					if source_power  and source_power >49 then
						local result,dec=minetest.get_craft_result({method="normal", width=3, items=inv:get_list("recipe")})
						if result and result.item and result.item:get_name() ~= "" then
							if inv:room_for_item("output", result.item) then
								for _,v in ipairs(inv:get_list("recipe")) do
									if v and ItemStack(v) and v ~= "" then
										if not inv:contains_item("input", ItemStack(v):get_name().." 2") then
											return
										end
									end
								end
								inv:add_item("output", result.item)
								
								for _,v in ipairs(inv:get_list("recipe")) do
									inv:remove_item("input", ItemStack(v):get_name())
								end
								
								--minetest.sound_play("OCN", {gain = 0.3, pos = pos, max_hear_distance = 10})
								source_meta:set_int("ocular_power", source_power-50)
							end
						end
					end
				end
			end
			meta:set_string("infotext", "Owned By: "..owner)
		end
	end
})


minetest.register_abm({
    label="pumping fluids",
	nodenames={"ocular_networks:pump"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local x, y, z=meta:get_int("sourceposx"), meta:get_int("sourceposy"), meta:get_int("sourceposz")
			local source_node=minetest.get_node({x=pos.x+x, y=pos.y+y, z=pos.z+z})
			local source_meta=minetest.get_meta({x=pos.x+x, y=pos.y+y, z=pos.z+z})
				if x > -2 and x < 2 and y > -2 and y < 2 and z > -2 and z < 2 then
					local nom=1
					if x == 0 or x == nil then
						nom=nom+1
					end
					if y == 0 or y == nil then
						nom=nom+1
					end
					if z == 0 or z == nil then
						nom=nom+1
					end
					if nom < 4 then
						if ocular_networks.pumpable_liquids[source_node.name] then
							if inv:room_for_item("liq", source_node.name) then
								inv:add_item("liq", source_node.name)
								minetest.set_node({x=pos.x+x, y=pos.y+y, z=pos.z+z},{name="air"})
							end
						end
					end
				end
			meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="pumping fluids",
	nodenames={"ocular_networks:faucet"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local x, y, z=meta:get_int("sourceposx"), meta:get_int("sourceposy"), meta:get_int("sourceposz")
			local source_node=minetest.get_node({x=pos.x+x, y=pos.y+y, z=pos.z+z})
			local source_meta=minetest.get_meta({x=pos.x+x, y=pos.y+y, z=pos.z+z})
				if x > -2 and x < 2 and y > -2 and y < 2 and z > -2 and z < 2 then
					local nom=1
					if x == 0 or x == nil then
						nom=nom+1
					end
					if y == 0 or y == nil then
						nom=nom+1
					end
					if z == 0 or z == nil then
						nom=nom+1
					end
					if nom < 4 then
						if source_node.name=="air" then
							if ocular_networks.pumpable_liquids[inv:get_stack("liq", 1):get_name()] then
								minetest.set_node({x=pos.x+x, y=pos.y+y, z=pos.z+z},{name=inv:get_stack("liq", 1):get_name()})
								local s=inv:get_stack("liq", 1)
								s:take_item(1)
								inv:set_stack("liq", 1, s)
								return
							end
						end
					end
				end
			meta:set_string("infotext", "Owned By: "..owner)
		end
	end,
})

minetest.register_abm({
    label="tank visual",
	nodenames={"group:ocular_networks_tank"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		if ocular_networks.pumpable_liquids[inv:get_stack("liq", 1):get_name()] then
			local _=inv:get_stack("liq", 1):get_name()
			local cc=inv:get_stack("liq", 1):get_count()%64
			local def=minetest.registered_nodes[_]
			minetest.swap_node(pos, {name = "ocular_networks:tank_"..string.split(_, ":")[1].."_"..string.split(_, ":")[2], param2=cc })
		else
			minetest.swap_node(pos, {name = "ocular_networks:tank", param2=0 })
		end
	end,
})

minetest.register_abm({
    label="pumping fluids",
	nodenames={"ocular_networks:bucketer"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		if meta:get_string("enabled")=="true" then
			local inv=meta:get_inventory()
			if ocular_networks.pumpable_liquids[inv:get_stack("liq_i", 1):get_name()] then
				if inv:get_stack("buckets", 1):get_name()=="bucket:bucket_empty" then
					local b=ocular_networks.pumpable_liquids[inv:get_stack("liq_i", 1):get_name()]
					if inv:room_for_item("output", ItemStack(b)) then
						local s=inv:get_stack("liq_i", 1)
						s:take_item(1)
						inv:set_stack("liq_i",1, s)
						inv:remove_item("buckets", "bucket:bucket_empty")
						inv:add_item("output", ItemStack(b))
					end
				end
			end
		end
	end,
})


minetest.register_abm({
    label="routing cables",
	nodenames={"ocular_networks:router"},
	interval=1,
	chance=1,
	catch_up=true,
	action=function(pos, node)
		local meta=minetest.get_meta(pos)
		local power=meta:get_int("ocular_power")
		local owner=meta:get_string("owner")
		
		local nw=visionLib.Schem.GetConnected(pos, {["ocular_networks:reservoir2"]=1, ["ocular_networks:router"]=1, ["ocular_networks:cable"]=1})
		local k=1
		
		for _,v in pairs(nw) do
			local vpos={x=tonumber(string.split(_," ")[1]),y=tonumber(string.split(_," ")[2]),z=tonumber(string.split(_," ")[3])}
			local vmeta=minetest.get_meta(vpos)
			local vowner=vmeta:get_string("owner")
			if v.name=="ocular_networks:reservoir2" and owner==vowner then
				k=k+1
			end
		end
		
		local d=math.floor(power/k)
		
		for _,v in pairs(nw) do
			local vpos={x=tonumber(string.split(_," ")[1]),y=tonumber(string.split(_," ")[2]),z=tonumber(string.split(_," ")[3])}
			local vmeta=minetest.get_meta(vpos)
			local vowner=vmeta:get_string("owner")
			if v.name=="ocular_networks:reservoir2" and owner==vowner then
				power=power-d
				vmeta:set_int("ocular_power",vmeta:get_int("ocular_power")+d)
			end
		end
		meta:set_int("ocular_power", power)
		meta:set_string("infotext", "Owned By: "..owner.."\nContains "..power.." power")
	end,
})