table.insert(armor.elements, "ocun_acessory")

armor:register_armor("ocular_networks:jetring", {
	description="Jet Propelling Ring\n"..minetest.colorize("#00affa", "hold space while wearing (armor) to float up,\nuses 10 power per second"),
	inventory_image="poly_jet_ring.png",
	texture="poly_ocn_blank.png",
	preview="poly_ocn_blank.png",
	groups={armor_ocun_acessory=1, armor_use=0, flammable=1},
	armor_groups={fleshy=10, radiation=10},
	damage_groups={cracky=3, snappy=3, choppy=3, crumbly=3, level=1},
})

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local inv=minetest.get_inventory({type="detached", name=player:get_player_name().."_armor"})
		local playerPower=0
		if player:get_meta():get_string("personal_ocular_power") then
			playerPower=tonumber(player:get_meta():get_string("personal_ocular_power"))
		end
		if inv:contains_item("armor", "ocular_networks:jetring") then
			if player:get_player_control().jump == true then
				if player:get_player_control().sneak then
					if playerPower > 0 then
						player:get_meta():set_string("personal_ocular_power", playerPower-1)
						local vel=player:get_player_velocity()
						if vel.y<0 then
							player:add_player_velocity({x=0, y=0-vel.y, z=0})
						end
					end
				elseif player:get_player_control().aux1 then
					if playerPower > 40 then
						player:get_meta():set_string("personal_ocular_power", playerPower-40)
						local vel=player:get_player_velocity()
						player:add_player_velocity({x=0, y=3, z=0})
					end
				else
					if playerPower > 0 then
						player:get_meta():set_string("personal_ocular_power", playerPower-1)
						local vel=player:get_player_velocity()
						if vel.y < 6 then
							player:add_player_velocity({x=0, y=2.7, z=0})
						end
					end
				end
			end
		end
	end
end)
