-- LOOT CHEST : ==============================================================================================
minetest.register_node("simple_loots:loot_chest", {
    description = "Loot Chest",
     tiles = {
      "default_chest_top.png",
      "default_chest_top.png",
      "default_chest_side.png",
      "default_chest_side.png",
      "default_chest_side.png",
      "default_chest_front.png",
    },
   
    on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      meta:set_string("formspec", "size[8,9]list[current_name;main;0,0.5;8,4;]" ..
          "list[current_player;main;0,4.85;8,1;]" ..
          "list[current_player;main;0,6.08;8,3;8]" ..
          "listring[current_name;main]" ..
          "listring[current_player;main]")
      meta:set_string("infotext", "Loot Chest")
      local inv = meta:get_inventory()
      inv:set_size("main", 8*4)
    end,

    can_dig = function(pos, player)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      return inv:is_empty("main")
     
    end,

    sounds = default.node_sound_wood_defaults(),
    drop = "default:chest",
    groups = {choppy = 2, oddly_breakable_by_hand = 2,not_in_creative_inventory=1},
    paramtype2 = "facedir",
    is_ground_content = false,
  
  })

  --[[
  -- LOOT CHEST OCEAN : ===================================================================================
minetest.register_node("simple_loots:loot_chest_ocean", {
  description = "Loot Chest Ocean",
   tiles = {
    "default_chest_top.png",
    "default_chest_top.png",
    "default_chest_side.png",
    "default_chest_side.png",
    "default_chest_side.png",
    "default_chest_front.png",
  },
 
  on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      meta:set_string("formspec", "size[8,9]list[current_name;main;0,0;8,4;]list[current_player;main;0,5;8,4;]")
      meta:set_string("infotext", "Loot Chest")
      local inv = meta:get_inventory()
      inv:set_size("main", 8*4)
  end,

  can_dig = function(pos, player)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    return inv:is_empty("main")
   
  end,

  sounds = default.node_sound_wood_defaults(),
  drop = "default:chest",
  groups = {choppy = 2, oddly_breakable_by_hand = 2,not_in_creative_inventory=1},
  paramtype2 = "facedir",
  is_ground_content = false,

})
  
]]
  -- /giveme simple_loots:loot_chest
  -- /giveme simple_loots:loot_chest_ocean
