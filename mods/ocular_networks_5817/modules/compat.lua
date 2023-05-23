if minetest.get_modpath("wield3d") then
	if minetest.get_modpath("wieldview") then error("please disable wieldview") end

	local bone="Arm_Right"
	local pos={x=0, y=5.5, z=3}
	local scale={x=0.25, y=0.25}
	local rx=-90
	local rz=90

	wield3d.location["ocular_networks:angmallen_hammer"]={bone, {x=0, y=5.5, z=3}, {x=rx, y=225, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:angmallen_axe"]={bone, {x=0, y=5.5, z=3}, {x=rx, y=225, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:angmallen_sword"]={bone, {x=0, y=5.5, z=8.5}, {x=rx, y=225, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:blazerifle"]={bone, pos, {x=rx, y=135, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:blazerifle_c"]={bone, pos, {x=rx, y=135, z=rz}, {x=0.75, y=0.25}}
	wield3d.location["ocular_networks:blazerifle_d"]={bone, pos, {x=rx, y=135, z=rz}, {x=0.75, y=0.25}}
	wield3d.location["ocular_networks:healer"]={bone, pos, {x=rx, y=135, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:inspector"]={bone, pos, {x=rx, y=135, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:hekaton_hammer"]={bone, {x=0, y=5.5, z=3}, {x=rx, y=225, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:hekaton_axe"]={bone, {x=0, y=5.5, z=3}, {x=rx, y=225, z=rz}, {x=0.25, y=0.25}}
	wield3d.location["ocular_networks:hekaton_sword"]={bone, {x=0, y=5.5, z=8.5}, {x=rx, y=225, z=rz}, {x=0.25, y=0.25}}
end

if minetest.get_modpath("basic_machines") then
	local spec=""..
	"size[8,9;]"..
	"background[0,0;0,0;poly_gui_formbg.png;true]"..
	"list[context;dst;3.5,2;1,1;]"..
	"list[current_player;main;0,5;8,4;]"
	
	ocular_networks.register_node("ocular_networks:power_converter_BMPC", {
		description="Power Cell Packager\n"..minetest.colorize("#00affa", "Used to convert OCP into basic_machines power cells.\nTakes power from BELOW"),
		tiles={"poly_power_converter_vert.png", "poly_power_converter_vert.png", "poly_power_converter_BMPC_side.png"},

		is_ground_content=false,
		groups={cracky=3, oddly_breakable_by_hand=3},
		sounds=default.node_sound_stone_defaults(),
		on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_int("ocular_power", 0)
			meta:set_string("formspec", spec)
			local inv=meta:get_inventory()
			inv:set_size("dst", 1)
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
	
	minetest.register_craft({
		output="ocular_networks:power_converter_BMPC",
		recipe={
			{"ocular_networks:luminium_bar_3", "default:glass", "ocular_networks:luminium_bar_3"},
			{"basic_machines:power_cell", "ocular_networks:erena_sphere", "basic_machines:power_cell"},
			{"ocular_networks:luminium_bar_3", "default:glass", "ocular_networks:luminium_bar_3"}
		}
	})
	
	minetest.register_abm({
		label="power cells",
		nodenames={"ocular_networks:power_converter_BMPC"},
		interval=1,
		chance=1,
		catch_up=true,
		action=function(pos, node)
			local meta=minetest.get_meta(pos)
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if tonumber(source_power) > 9 then
						source_meta:set_int("ocular_power", tonumber(source_power)-10)
						inv:add_item("dst", "basic_machines:power_cell")
					end
				end
			end
			meta:set_string("infotext", "Owned By: "..owner)
		end,
	})
end

if minetest.get_modpath("technic") then
	
	ocular_networks.register_node("ocular_networks:power_converter_EU", {
		description="MV Electrofraction Generator\n"..minetest.colorize("#00affa", "Used to convert OCP into technic MV EU\n Takes power from BELOW"),
		tiles={"poly_power_converter_vert.png", "poly_power_converter_vert.png", "poly_power_converter_EU_side.png"},

		is_ground_content=false,
		groups={cracky=3, oddly_breakable_by_hand=3, technic_machine=1, technic_mv=1},
		sounds=default.node_sound_stone_defaults(),
		connect_sides={"front", "back", "left", "right"},
		on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_int("ocular_power", 0)
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
	})
	
	minetest.register_craft({
		output="ocular_networks:power_converter_EU",
		recipe={
			{"ocular_networks:luminium_bar_3", "default:glass", "ocular_networks:luminium_bar_3"},
			{"technic:mv_cable", "ocular_networks:erena_sphere", "technic:mv_cable"},
			{"ocular_networks:luminium_bar_3", "default:glass", "ocular_networks:luminium_bar_3"}
		}
	})
	
	technic.register_machine("MV", "ocular_networks:power_converter_EU", technic.producer)
	
	minetest.register_abm({
		label="EU",
		nodenames={"ocular_networks:power_converter_EU"},
		interval=1,
		chance=1,
		catch_up=true,
		action=function(pos, node)
			local meta=minetest.get_meta(pos)
			local owner=meta:get_string("owner")
			local inv=meta:get_inventory()
			local source_meta=minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
			local source_power=source_meta:get_int("ocular_power")
			local source_owner=source_meta:get_string("owner")
			if source_power then
				if owner == source_owner or ocular_networks.get_config("moderator_whitelist") then
					if tonumber(source_power) > 99 then
						meta:set_int("MV_EU_supply", 5000)
						source_meta:set_int("ocular_power", tonumber(source_power)-100)
						meta:set_string("infotext", "EU Supplying: 5000")
					else
						meta:set_int("MV_EU_supply", 0)
						meta:set_string("infotext", "EU Supplying: 0")
					end
				end
			end
		end,
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:zweinium_crystal"},
		output="ocular_networks:dust_zweinium"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:zweinium_crystal_chunk"},
		output="ocular_networks:dust_zweinium 2"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:silicotin_bar"},
		output="ocular_networks:dust_silicotin"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:shimmering_bar"},
		output="ocular_networks:dust_shimmering"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:angmallen_bar"},
		output="ocular_networks:dust_angmallen"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:luminium_bar_3"},
		output="ocular_networks:dust_lumigold"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:luminium_bar"},
		output="ocular_networks:dust_luminium"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:luminium_lump"},
		output="ocular_networks:dust_luminium 2"
	})
	
	technic.register_grinder_recipe({
		input={"ocular_networks:toxic_slate_chip"},
		output="ocular_networks:ocular_networks:dust_slate"
	})
end

if minetest.get_modpath("mobs") then
	ocular_networks.register_node("ocular_networks:distributor_broken", {
		description="Broken Power Collector\n"..minetest.colorize("#00affa", "A distributor whose core has been eaten by a network jammer."),
		tiles={"poly_node_coreless.png"},
		is_ground_content=false,
		groups={cracky=3, oddly_breakable_by_hand=3},
		sounds=default.node_sound_metal_defaults(),
	})
	
	minetest.register_craft({
		type="shapeless",
		output="ocular_networks:distributor",
		recipe={"ocular_networks:luminium_bar","ocular_networks:distributor_broken"}
	})
	
	mobs:register_mob("ocular_networks:drone", {
		type="monster",
		hp_min=50,
		hp_max=70,
		armor=90,
		walk_velocity=3,
		run_velocity=5,
		walk_chance=50,
		fly=true,
		fly_in="air",
		view_range=20,
		damage=4,
		knock_back=true,
		water_damage=10,
		suffocation=false,
		reach=2,
		attack_type="dogshoot",
		arrow="ocular_networks:drone_proj",
		shoot_interval=1,
		blood_amount=5,
		blood_texture="poly_damage_spark.png",
		pathfinding=1,
		drops={{name="ocular_networks:luminium_lump", chance=1, min=4, max=32}},
		visual="cube",
		collisionbox={-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		selectionbox={-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		textures={"poly_node.png", "poly_node.png", "poly_node.png", "poly_node.png", "poly_node_angry.png", "poly_node.png"},
		replace_what={
			{"ocular_networks:distributor", "ocular_networks:distributor_broken", -1}
		},
		shoot_offset=2,
	})
	
	mobs:register_spawn("ocular_networks:drone", {"default:silver_sand"}, 15, 5, 5, 1, 47)
	
	mobs:register_egg("ocular_networks:drone", "Jammer Drone Deployer", "poly_jammer.png", 0)
	
	mobs:register_arrow("ocular_networks:drone_proj", {
		visual="sprite",
		visual_size={x=0.5, y=0.5},
		textures={"poly_power_spark.png"},
		velocity=5,
		hit_player=function(self,player)
			player:punch(self.object, 1.0, {
				full_punch_interval=1.0,
				damage_groups= {fleshy=4},
			}, nil)
			self.object:remove()
		end,
	})
end

if minetest.get_modpath("farming") then
	
	farming.register_hoe(":ocular_networks:hoe_lumi", {
		description = "Luminium Hoe",
		inventory_image = "poly_hoe_lumi.png",
		max_uses = 200,
		material = "ocular_networks:luminium_bar"
	})
	
	farming.register_hoe(":ocular_networks:hoe_lumig", {
		description = "Lumigold Hoe",
		inventory_image = "poly_hoe_lumig.png",
		max_uses = 190,
		material = "ocular_networks:luminium_bar_3"
	})
	
	farming.register_hoe(":ocular_networks:hoe_silic", {
		description = "Silicotin Hoe",
		inventory_image = "poly_hoe_silic.png",
		max_uses = 190,
		material = "ocular_networks:silicotin_bar"
	})
	
	farming.register_hoe(":ocular_networks:hoe_shimmering", {
		description = "Shimmering Alloy Hoe",
		inventory_image = "poly_hoe_shimmering.png",
		max_uses = 220,
		material = "ocular_networks:shimmering_bar"
	})
	
	farming.register_hoe(":ocular_networks:hoe_zwei", {
		description = "Zweinium Hoe",
		inventory_image = "poly_hoe_zwei.png",
		max_uses = 200,
		material = "ocular_networks:zweinium_crystal"
	})
	
end
