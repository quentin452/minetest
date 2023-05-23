ocular_networks.register_item("ocular_networks:armor_pendant", {
	description="Angmallen Armor Upgrade Pendant\n"..minetest.colorize("#00affa", "Click to open your upgrade menu.\nPut Upgrade tokens in the inventory to use them."),
	inventory_image="poly_armor_angmallen_a_upgrade_pendant.png",
	stack_max=1,
	on_use=function(itemstack, user, pointed_thing)
		local inv=user:get_inventory()
		if inv:get_lists().ocn_armor_upgrades then
			minetest.show_formspec(user:get_player_name(), "ocn_armor_upgrades", "size[8,9;]background[0,0;0,0;poly_gui_formbg.png;true]list[current_player;main;0,5;8,4;]label[0,4.2;These upgrades will only take effect if you are wearing a full set of angmallen or hekatonic armor.\nShield upgrade modules will only work if you have the shield.]list[current_player;ocn_armor_upgrades;1.5,1.5;5,1;]")
		else
			inv:set_list("ocn_armor_upgrades", {})
			inv:set_size("ocn_armor_upgrades", 32)
		end
	end
})

ocular_networks.register_item("ocular_networks:performance_controller", {
	description="Performance Controller\n"..minetest.colorize("#00affa", "Click to open your tweaks menu."),
	inventory_image="poly_perf_controller.png",
	stack_max=1,
	on_use=function(itemstack, user, pointed_thing)
		local inv=user:get_inventory()
		if inv:get_lists().ocn_armor_upgrades and inv:get_lists().ocn_cyber_upgrades then
			minetest.show_formspec(user:get_player_name(), "ocn_armor_upgrades_2", "size[8,9;]background[0,0;0,0;poly_gui_formbg.png;true]list[current_player;main;0,5;8,4;]label[1.5,0.2;Armor Upgrades]list[current_player;ocn_armor_upgrades;1.5,0.6;5,1;]label[1.5,1.7;Cybernetic Upgrades]list[current_player;ocn_cyber_upgrades;1.5,2.1;5,1;]")
		else
			inv:set_list("ocn_armor_upgrades", {})
			inv:set_size("ocn_armor_upgrades", 32)
			inv:set_list("ocn_cyber_upgrades", {})
			inv:set_size("ocn_cyber_upgrades", 32)
		end
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname=="ocn_armor_upgrades" or formname=="ocn_armor_upgrades_2" then
		armor:set_player_armor(player)
	end
end)

local function has_armor_prerequisites(p)
	local inv=minetest.get_inventory({type="detached", name=p:get_player_name().."_armor"})
	return inv and inv:contains_item("armor", "ocular_networks:angmallen_helm") and inv:contains_item("armor", "ocular_networks:angmallen_boots") and inv:contains_item("armor", "ocular_networks:angmallen_chest") and inv:contains_item("armor", "ocular_networks:angmallen_legs") or inv:contains_item("armor", "ocular_networks:hekatonium_helm") and inv:contains_item("armor", "ocular_networks:hekatonium_boots") and inv:contains_item("armor", "ocular_networks:hekatonium_chest") and inv:contains_item("armor", "ocular_networks:hekatonium_legs")
end

minetest.after(0, function()
	armor:register_on_update(function(player)
			if has_armor_prerequisites(player) then
				local inv=player:get_inventory() 
				local playerPhysics=player:get_physics_override()
				if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_speed") then
					playerPhysics.speed=2
					player:set_physics_override(playerPhysics)
				elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_speed2") then
					playerPhysics.speed=2.5
					player:set_physics_override(playerPhysics)
				elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_speed3") then
					playerPhysics.speed=3.5
					player:set_physics_override(playerPhysics)
				else
					playerPhysics.speed=1
					player:set_physics_override(playerPhysics)
				end
			end
	end)

	armor:register_on_update(function(player)
			if has_armor_prerequisites(player) then
				local inv=player:get_inventory() 
				local playerPhysics=player:get_physics_override()
				if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_jump") then
					playerPhysics.jump=1.5
					player:set_physics_override(playerPhysics)
				elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_jump2") then
					playerPhysics.jump=1.7
					player:set_physics_override(playerPhysics)
				elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_jump3") then
					playerPhysics.jump=2
					player:set_physics_override(playerPhysics)
				else
					playerPhysics.jump=1
					player:set_physics_override(playerPhysics)
				end
			end
	end)

	armor:register_on_update(function(player)
			if has_armor_prerequisites(player) then
				local inv=player:get_inventory() 
				local playerPhysics=player:get_physics_override()
				if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_float") then
					playerPhysics.gravity=0.5
					player:set_physics_override(playerPhysics)
				elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_float2") then
					playerPhysics.gravity=0.3
					player:set_physics_override(playerPhysics)
				elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_float3") then
					playerPhysics.gravity=0.2
					player:set_physics_override(playerPhysics)
				else
					playerPhysics.gravity=1
					player:set_physics_override(playerPhysics)
				end
			end
	end)
end)

ocular_networks.register_item("ocular_networks:angmallen_shield", {
	description="Angmallen Shield",
	inventory_image="poly_angmallen_shield.png",
	texture="poly_angmallen_shield_real.png",
	preview="poly_angmallen_shield_preview.png",
	groups={armor_shield=1, armor_use=0, armor_heal=12},
	armor_groups={fleshy=5},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1,
})

armor:register_armor("ocular_networks:angmallen_shield1", {
	description="Angmallen Shield",
	inventory_image="poly_angmallen_shield.png",
	texture="poly_angmallen_shield_real.png",
	preview="poly_angmallen_shield_preview.png",
	groups={armor_shield=1, armor_use=0, armor_heal=12, not_in_creative_inventory=1},
	armor_groups={fleshy=10},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1,
})

armor:register_armor("ocular_networks:angmallen_shield2", {
	description="Angmallen Shield",
	inventory_image="poly_angmallen_shield.png",
	texture="poly_angmallen_shield_real.png",
	preview="poly_angmallen_shield_preview.png",
	groups={armor_shield=1, armor_use=100, armor_heal=12, not_in_creative_inventory=1},
	armor_groups={fleshy=15},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1
})

armor:register_armor("ocular_networks:angmallen_shield3", {
	description="Angmallen Shield",
	inventory_image="poly_angmallen_shield.png",
	texture="poly_angmallen_shield_real.png",
	preview="poly_angmallen_shield_preview.png",
	groups={armor_shield=1, armor_use=100, armor_heal=12, not_in_creative_inventory=1},
	armor_groups={fleshy=25},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1
})

minetest.after(0, function()
	armor:register_on_update(function(player)
			local inv2=minetest.get_inventory({type="detached", name=player:get_player_name().."_armor"})
			if not inv2 then return end
			local inv=player:get_inventory()
			if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense") then
				if inv2:contains_item("armor", "ocular_networks:angmallen_shield") or inv2:contains_item("armor", "ocular_networks:angmallen_shield2") or inv2:contains_item("armor", "ocular_networks:angmallen_shield3") then
					inv2:remove_item("armor", "ocular_networks:angmallen_shield")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
					inv2:add_item("armor", "ocular_networks:angmallen_shield1")
					armor:set_player_armor_defense(player)
				end
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense2") then
				if inv2:contains_item("armor", "ocular_networks:angmallen_shield") or inv2:contains_item("armor", "ocular_networks:angmallen_shield1") or inv2:contains_item("armor", "ocular_networks:angmallen_shield3") then
					inv2:remove_item("armor", "ocular_networks:angmallen_shield")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
					inv2:add_item("armor", "ocular_networks:angmallen_shield2")
					armor:set_player_armor_defense(player)
				end
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense3") then
				if inv2:contains_item("armor", "ocular_networks:angmallen_shield") or inv2:contains_item("armor", "ocular_networks:angmallen_shield1") or inv2:contains_item("armor", "ocular_networks:angmallen_shield2") then
					inv2:remove_item("armor", "ocular_networks:angmallen_shield")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
					inv2:add_item("armor", "ocular_networks:angmallen_shield3")
					armor:set_player_armor_defense(player)
				end
			else
				if inv2:contains_item("armor", "ocular_networks:angmallen_shield1") or inv2:contains_item("armor", "ocular_networks:angmallen_shield2") or inv2:contains_item("armor", "ocular_networks:angmallen_shield3") then
					inv2:remove_item("armor", "ocular_networks:angmallen_shield")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield1")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield2")
					inv2:remove_item("armor", "ocular_networks:angmallen_shield3")
					inv2:add_item("armor", "ocular_networks:angmallen_shield")
					armor:set_player_armor_defense(player)
				end
			end
	end) 
end)

ocular_networks.register_item("ocular_networks:hekatonium_shield", {
	description=minetest.colorize("#00affa", "Hekaton Defense Matrix"),
	inventory_image="poly_hekatonic_shield.png",
	texture="poly_hekatonic_shield_real.png",
	preview="poly_hekatonic_shield_preview.png",
	groups={armor_shield=1, armor_use=0, armor_heal=12},
	armor_groups={fleshy=10},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1,
})

ocular_networks.register_item("ocular_networks:hekatonium_shield1", {
	description=minetest.colorize("#00affa", "Hekaton Defense Matrix"),
	inventory_image="poly_hekatonic_shield.png",
	texture="poly_hekatonic_shield_real.png",
	preview="poly_hekatonic_shield_preview.png",
	groups={armor_shield=1, armor_use=0, armor_heal=12, not_in_creative_inventory=1},
	armor_groups={fleshy=20},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1,
})

ocular_networks.register_item("ocular_networks:hekatonium_shield2", {
	description=minetest.colorize("#00affa", "Hekaton Defense Matrix"),
	inventory_image="poly_hekatonic_shield.png",
	texture="poly_hekatonic_shield_real.png",
	preview="poly_hekatonic_shield_preview.png",
	groups={armor_shield=1, armor_use=0, armor_heal=12, not_in_creative_inventory=1},
	armor_groups={fleshy=40},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1,
})

ocular_networks.register_item("ocular_networks:hekatonium_shield3", {
	description=minetest.colorize("#00affa", "Hekaton Defense Matrix"),
	inventory_image="poly_hekatonic_shield.png",
	texture="poly_hekatonic_shield_real.png",
	preview="poly_hekatonic_shield_preview.png",
	groups={armor_shield=1, armor_use=0, armor_heal=12, not_in_creative_inventory=1},
	armor_groups={fleshy=80},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=4},
	reciprocate_damage=true,
	stack_max=1,
})

minetest.after(0, function()
	armor:register_on_update(function(player)
			local inv2=minetest.get_inventory({type="detached", name=player:get_player_name().."_armor"})
			if not inv2 then return end
			local inv=player:get_inventory()
			if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense4") then
				if inv2:contains_item("armor", "ocular_networks:hekatonium_shield") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield2") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield3") then
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield1")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield2")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield3")
					inv2:add_item("armor", "ocular_networks:hekatonium_shield1")
					armor:set_player_armor_defense(player)
				end
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense5") then
				if inv2:contains_item("armor", "ocular_networks:hekatonium_shield") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield1") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield3") then
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield1")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield2")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield3")
					inv2:add_item("armor", "ocular_networks:hekatonium_shield2")
					armor:set_player_armor_defense(player)
				end
			elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_defense6") then
				if inv2:contains_item("armor", "ocular_networks:hekatonium_shield") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield1") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield2") then
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield1")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield2")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield3")
					inv2:add_item("armor", "ocular_networks:hekatonium_shield3")
					armor:set_player_armor_defense(player)
				end
			else
				if inv2:contains_item("armor", "ocular_networks:hekatonium_shield1") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield2") or inv2:contains_item("armor", "ocular_networks:hekatonium_shield3") then
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield1")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield2")
					inv2:remove_item("armor", "ocular_networks:hekatonium_shield3")
					inv2:add_item("armor", "ocular_networks:hekatonium_shield")
					armor:set_player_armor_defense(player)
				end
			end
	end)
end)

ocular_networks.heal_pause=0

minetest.register_globalstep(function(dtime)
	ocular_networks.heal_pause=ocular_networks.heal_pause + dtime
	for _,player in ipairs(minetest.get_connected_players()) do
		if has_armor_prerequisites(player) then
			if ocular_networks.heal_pause > 1.99 then
				local inv=player:get_inventory() 
				local playerPhysics=player:get_physics_override()
				local power=player:get_meta():get_string("personal_ocular_power")
				if player:get_hp() < 20 then
					if power and tonumber(power) > 49 then
						if inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_heal") then	
							player:get_meta():set_string("personal_ocular_power", power-50)
							player:set_hp(player:get_hp()+1)
							ocular_networks.heal_pause=0
						elseif inv:contains_item("ocn_armor_upgrades", "ocular_networks:upgrade_heal2") then
							player:get_meta():set_string("personal_ocular_power", power-50)
							player:set_hp(player:get_hp()+2)
							ocular_networks.heal_pause=0
						end
					end
				end
			end
		end
	end
end)

minetest.register_craft({
	output="ocular_networks:upgrade_speed",
	recipe={
		{"", "ocular_networks:charged_gem", ""},
		{"default:copper_ingot", "ocular_networks:upgrade", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:upgrade_speed2",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_speed", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_speed", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_speed"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_speed", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_speed3",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_speed2", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_speed2", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_speed2"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_speed2", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_jump",
	recipe={
		{"", "ocular_networks:charged_gem", ""},
		{"default:tin_ingot", "ocular_networks:upgrade", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:upgrade_jump2",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_jump", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_jump", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_jump"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_jump", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_jump3",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_jump2", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_jump2", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_jump2"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_jump2", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_float",
	recipe={
		{"", "ocular_networks:charged_gem", ""},
		{"default:gold_ingot", "ocular_networks:upgrade", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:upgrade_float2",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_float", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_float", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_float"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_float", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_float3",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_float2", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_float2", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_float2"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_float2", "ocular_networks:angmallen_bar"}
	}
})


minetest.register_craft({
	output="ocular_networks:upgrade_defense",
	recipe={
		{"", "ocular_networks:charged_gem", ""},
		{"default:steel_ingot", "ocular_networks:upgrade", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:upgrade_defense2",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_defense", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_defense", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_defense"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_defense", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_defense3",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_defense2", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_defense2", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_defense2"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_defense2", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_defense4",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:hekatonium_bar", "ocular_networks:angmallen_bar"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:upgrade_defense3", "ocular_networks:hekatonium_bar"},
		{"ocular_networks:angmallen_bar", "ocular_networks:hekatonium_bar", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_defense5",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:hekatonium_bar", "ocular_networks:angmallen_bar"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:upgrade_defense4", "ocular_networks:hekatonium_bar"},
		{"ocular_networks:angmallen_bar", "ocular_networks:hekatonium_bar", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_defense6",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:hekatonium_bar", "ocular_networks:angmallen_bar"},
		{"ocular_networks:hekatonium_bar", "ocular_networks:upgrade_defense5", "ocular_networks:hekatonium_bar"},
		{"ocular_networks:angmallen_bar", "ocular_networks:hekatonium_bar", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade_heal",
	recipe={
		{"", "ocular_networks:charged_gem", ""},
		{"default:apple", "ocular_networks:upgrade", "default:apple"},
		{"default:apple", "default:apple", "default:apple"}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

minetest.register_craft({
	output="ocular_networks:upgrade_heal2",
	recipe={
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_heal", "ocular_networks:angmallen_bar"},
		{"ocular_networks:upgrade_heal", "ocular_networks:angmallen_bar", "ocular_networks:upgrade_heal"},
		{"ocular_networks:angmallen_bar", "ocular_networks:upgrade_heal", "ocular_networks:angmallen_bar"}
	}
})

minetest.register_craft({
	output="ocular_networks:upgrade",
	recipe={
		{"", "ocular_networks:charged_gem", ""},
		{"", "ocular_networks:angmallen_block", ""},
		{"", "", ""}
	},
	replacements={{"ocular_networks:charged_gem","ocular_networks:uncharged_gem"}}
})

ocular_networks.register_item("ocular_networks:upgrade", {
	description="Armor Upgrade Base\n"..minetest.colorize("#00affa", "Used to make upgrade tokens for the angmallen armor."),
	inventory_image="poly_upgrade.png",
})

ocular_networks.register_item("ocular_networks:upgrade_speed", {
	description="Speed Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "2x speed multiplier"),
	inventory_image="poly_upgrade_speed.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_speed2", {
	description="Speed Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "2.5x speed multiplier"),
	inventory_image="poly_upgrade_speed.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_speed3", {
	description="Speed Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "3x speed multiplier"),
	inventory_image="poly_upgrade_speed.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_jump", {
	description="Jump Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "2x jump multiplier"),
	inventory_image="poly_upgrade_jump.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_jump2", {
	description="Jump Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "3x jump multiplier"),
	inventory_image="poly_upgrade_jump.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_jump3", {
	description="Jump Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "4x jump multiplier"),
	inventory_image="poly_upgrade_jump.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_float", {
	description="Hover Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "0.5x gravity modifier"),
	inventory_image="poly_upgrade_float.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_float2", {
	description="Hover Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "0.3x gravity modifier"),
	inventory_image="poly_upgrade_float.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_float3", {
	description="Hover Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "0.2x gravity modifier"),
	inventory_image="poly_upgrade_float.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_defense", {
	description="Shield Upgrade L1 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen shield.\n")..minetest.colorize("#ff0000", "+5 defense"),
	inventory_image="poly_upgrade_defense.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_defense2", {
	description="Shield Upgrade L2 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen shield.\n")..minetest.colorize("#ff0000", "+10 defense"),
	inventory_image="poly_upgrade_defense.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_defense3", {
	description="Shield Upgrade L3 \n"..minetest.colorize("#00affa", "Upgrade token for the angmallen shield.\n")..minetest.colorize("#ff0000", "+20 defense"),
	inventory_image="poly_upgrade_defense.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_defense4", {
	description="Shield Upgrade L4 \n"..minetest.colorize("#00affa", "Upgrade token for the hekatonic shield.\n")..minetest.colorize("#ff0000", "+20 defense"),
	inventory_image="poly_upgrade_defense2.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_defense5", {
	description="Shield Upgrade L5 \n"..minetest.colorize("#00affa", "Upgrade token for the hekatonic shield.\n")..minetest.colorize("#ff0000", "+40 defense"),
	inventory_image="poly_upgrade_defense2.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_defense6", {
	description="Shield Upgrade L6 \n"..minetest.colorize("#00affa", "Upgrade token for the hekatonic shield.\n")..minetest.colorize("#ff0000", "+80 defense"),
	inventory_image="poly_upgrade_defense2.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_heal", {
	description="Healing Module\n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "+1 HP/50 OCP"),
	inventory_image="poly_upgrade_heal.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:upgrade_heal2", {
	description="Healing Module L2\n"..minetest.colorize("#00affa", "Upgrade token for the angmallen armor.\n")..minetest.colorize("#ff0000", "+2 HP/50 OCP"),
	inventory_image="poly_upgrade_heal.png",
	groups={ocp_upgrade=1},
	stack_max=1
})

ocular_networks.register_item("ocular_networks:c_arm", {
	description="Cybernetic Arm\n"..minetest.colorize("#00affa", "A pneumatic arm"),
	inventory_image="poly_cyber_arm.png",
})

ocular_networks.register_item("ocular_networks:c_core", {
	description="Cybernetic Core\n"..minetest.colorize("#00affa", "A cybernetic core"),
	inventory_image="poly_cyber_core.png",
})

minetest.register_craft({
	output="ocular_networks:c_arm",
	recipe={
		{"ocular_networks:silicotin_bar", "", ""},
		{"ocular_networks:silicotin_bar", "", ""},
		{"ocular_networks:cross", "ocular_networks:silicotin_bar", "default:tin_ingot"}
	}
})

minetest.register_craft({
	output="ocular_networks:c_core",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:toxic_slate_rod", "ocular_networks:silicotin_bar"},
		{"default:glass", "ocular_networks:erena_sphere", "default:glass"},
		{"ocular_networks:silicotin_bar", "ocular_networks:toxic_slate_rod", "ocular_networks:silicotin_bar"}
	}
})


ocular_networks.register_item("ocular_networks:c_arm_gun", {
	description="Barreled Cybernetic Arm\n"..minetest.colorize("#00affa", "A pneumatic arm with a rifle barrel.\nEquip in performance controller menu\nRightClick with empty hand to fire\nCan not be used with other arms"),
	inventory_image="poly_cyber_arm_gun.png",
	stack_max=1
})

minetest.register_craft({
	output="ocular_networks:c_arm_gun",
	recipe={
		{"ocular_networks:c_arm", "group:wood", "ocular_networks:blazerifle"}
	}
})

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if player:get_player_control().RMB then
			local inv=player:get_inventory() 
			local power=tonumber(player:get_meta():get_string("personal_ocular_power"))
			if player:get_wielded_item():get_name() == "" then
				if inv:contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_gun") and not inv:contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_blade") and not inv:contains_item("ocn_cyber_upgrades", "ocular_networks:c_arm_inspector") then
					local userPos=player:get_pos()
					local userDir=player:get_look_dir()
					if power > 99 then
						player:get_meta():set_string("personal_ocular_power", power-100)
						local pos=player:getpos()
						local dir=player:get_look_dir()
						local yaw=player:get_look_yaw()
						if pos and dir and yaw then
							pos.y=pos.y + 1.6
							local obj=minetest.add_entity(pos, "ocular_networks:power_projectile")
							if obj then
								obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
								obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
								obj:setyaw(yaw + math.pi)
								local ent=obj:get_luaentity()
								if ent then
									ent.player=ent.player or player
								end
								minetest.sound_play("OCN_shot_1", {gain = 0.3, pos = pos, max_hear_distance = 10})
							end
						end
					end
				end
			end
		end
	end
end)

ocular_networks.register_item("ocular_networks:c_arm_wrench", {
	description="Clamped Cybernetic Arm\n"..minetest.colorize("#00affa", "A pneumatic arm with a wrench.\nEquip in performance controller menu\nClick to use in place of pipe wrench\nCan be used with other arms"),
	inventory_image="poly_cyber_arm_wrench.png",
	stack_max=1
})

minetest.register_craft({
	output="ocular_networks:c_arm_wrench",
	recipe={
		{"ocular_networks:c_arm", "group:wood", "ocular_networks:pipe_wrench"}
	}
})

ocular_networks.register_item("ocular_networks:c_core_air", {
	description="Ventilated Cybernetic Core\n"..minetest.colorize("#00affa", "A cybernetic core which can synthesise oxygen from water.\nEquip in performance controller menu\nPrevents air loss for 1 OCP/step"),
	inventory_image="poly_cyber_core_air.png",
})

minetest.register_craft({
	output="ocular_networks:c_core_air",
	recipe={
		{"ocular_networks:silicotin_bar", "ocular_networks:chem_oven", "ocular_networks:silicotin_bar"},
		{"default:steel_ingot", "ocular_networks:c_core", "default:steel_ingot"},
		{"ocular_networks:cross", "ocular_networks:pipe_filtered_D", "ocular_networks:cross"}
	}
})


minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local inv=player:get_inventory() 
		local power=tonumber(player:get_meta():get_string("personal_ocular_power"))
		if player:get_wielded_item():get_name() == "" then
			if inv:contains_item("ocn_cyber_upgrades", "ocular_networks:c_core_air") then
				if power > 0 and player:get_breath() < 11 then
					player:get_meta():set_string("personal_ocular_power", power-1)
					player:set_breath(11)
				end
			end
		end
	end
end)
