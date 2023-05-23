
-- Override minimap update function

function map.update_hud_flags(player)
	if not player or player.is_fake_player then
		return  -- Can't be used by a fake player
	end
	local creative_enabled = minetest.is_creative_enabled(player:get_player_name())
	local inv = player:get_inventory()
	local has_map = inv:contains_item("main", "map:mapping_kit")
	local has_radar = inv:contains_item("main", "minimap_radar:radar")
	player:hud_set_flags({
		minimap = creative_enabled or has_map or has_radar,  -- Radar needs to enable the minimap too
		minimap_radar = creative_enabled or has_radar
	})
end


-- Radar item

minetest.register_craftitem("minimap_radar:radar", {
	description = "Radar\nUse with 'Minimap' key",
	inventory_image = "minimap_radar_radar.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		map.update_hud_flags(user)
	end
})


-- Crafting

if minetest.get_modpath("technic") then
	minetest.register_craft({
		output = "minimap_radar:radar",
		recipe = {
			{"technic:stainless_steel_ingot", "default:diamond", "technic:stainless_steel_ingot"},
			{"dye:green", "technic:prospector", "dye:black"},
			{"technic:stainless_steel_ingot", "default:diamond", "technic:stainless_steel_ingot"},
		}
	})
elseif minetest.get_modpath("moreores") then
	minetest.register_craft({
		output = "minimap_radar:radar",
		recipe = {
			{"moreores:silver_ingot", "default:diamond", "moreores:silver_ingot"},
			{"dye:green", "moreores:mithril_block", "dye:black"},
			{"moreores:silver_ingot", "default:diamond", "moreores:silver_ingot"},
		}
	})
else
	minetest.register_craft({
		output = "minimap_radar:radar",
		recipe = {
			{"default:steel_ingot", "default:diamond", "default:steel_ingot"},
			{"dye:green", "default:mese", "dye:black"},
			{"default:steel_ingot", "default:diamond", "default:steel_ingot"},
		}
	})
end
