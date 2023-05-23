-- LOOTS ===================================================================================================
local items = {
	      {name = "default:torch", chance = 1, count = 3},
        {name = "default:apple", chance =2, count = 5},
        {name = "default:coal_lump", chance = 1, count = 3},
        {name = "default:iron_lump", chance =1, count = 1},
        {name = "farming:bread", chance =1, count =5},
        {name = "farming:cotton", chance = 1, count = 3},
        {name = "default:gold_lump", chance =1, count = 1},
        {name = "bucket:bucket_empty", chance = 1, count = 1},
         {name = "default:copper_lump", chance =1, count = 2},
        {name = "default:obsidian_shard", chance = 1, count = 2},
        {name = "default:paper", chance = 1, count = 3},
			
		}

 
---====================== MUDANDO OS NODES : ================================================================
minetest.register_on_generated(function(minp, maxp, seed)
    --local chest_pos = {x = 0, y = 0, z = 0}
    --local target_node = "default:chest"
    --local result_node = "simple_loots:loot_chest"
    --local MIN_CHEST_HEIGHT = 0
    --local MAX_CHEST_HEIGHT = 200
   
    for x = minp.x, maxp.x do
      for y = minp.y, maxp.y do
        for z = minp.z, maxp.z do
  
          local pos = {x = x, y = y, z = z}
          local node = minetest.get_node(pos)
          local param2 = node.param2
  
  -- CHEST : ==============================================================
 
          if node.name == "default:chest" then
            --minetest.set_node(pos, {name = "default:chest",param2=node.param2})
            --minetest.set_node(pos, {name = "simple_loots:loot_chest",param2=node.param2})
          
            --local meta = minetest.get_meta(pos)
            --local inv = meta:get_inventory()
            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Chest")
            local inv = meta:get_inventory()
            inv:set_size("main", 32)
            -- adicionando intems   
            for i = 2,4 do -- Quantidade de itens no baú
            local item = items[math.random(1, #items)] --  itens
            local stack =math.random(1, 8) -- Local slot
               inv:set_stack("main", stack, item)
                end
          end
       

  -- BOOKSHELF : =============================================================
          if node.name == "default:bookshelf" then
            minetest.set_node(pos, { name="default:bookshelf",param2=node.param2})
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("books", 8 * 2)
          end
  
  -- VESSELS : =============================================================
          if node.name == "vessels:shelf" then
            minetest.set_node(pos, {name="vessels:shelf",param2=node.param2})
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("vessels", 8 * 2)
          end
  
  -- FURNANCE : ================================================================
        if node.name == "default:furnace" then
          minetest.set_node(pos, { name="default:furnace",param2=node.param2})
          local meta = minetest.get_meta(pos)
          local inv = meta:get_inventory()
          inv:set_size('src', 1)
          inv:set_size('fuel', 1)
          inv:set_size('dst', 4)
        end
  
  
  -- nativevillages : ================================================================
        if minetest.get_modpath("nativevillages") ~= nil then
         
          if node.name == "nativevillages:lootchest" then
            --minetest.set_node(pos, {name = "default: chest",param2=node.param2})
            minetest.set_node(pos, {name = "simple_loots:loot_chest",param2=node.param2})
          
            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "loot Chest")
            local inv = meta:get_inventory()
            inv:set_size("main", 32)
            -- adicionando intems   
            for i = 2,4 do -- Quantidade de itens no baú
            local item = items[math.random(1, #items)] --  itens
            local stack =math.random(1, 8) -- Local slot
               inv:set_stack("main", stack, item)
                 end
            end
          
          end
  
  
  -- LOOP END =========================================================================
        end
      end
    end
    
   
    
  end)
  

  -- SUPORTES :==============================================================================================
  -- MOREORES -------------------------------------------------------------------------------------------------------------
  if minetest.get_modpath("moreores") then
    table.insert(items, {name="moreores:silver_lump",  chance = 1, count = 2})
    end
  
  -- 3D ARMOR --------------------------------------------------------------------------------------------------------------
  --[[
  if minetest.get_modpath("shields") then
  table.insert(items, {name="shields:shield_enhanced_wood",  chance = 1, count = 1})
  end
  ]]
  
  -- rangedweapons --------------------------------------------------------------------------------------------------------
  if minetest.get_modpath("rangedweapons") then
  table.insert(items, {name="rangedweapons:45acp",  chance =1, count = 3})
  table.insert(items, {name="rangedweapons:357",  chance = 1, count = 3})
  table.insert(items, {name="rangedweapons:9mm",  chance = 1, count = 3})
  table.insert(items, {name="rangedweapons:762mm",  chance = 1, count = 3})
  table.insert(items, {name="rangedweapons:steel_shuriken",  chance = 1, count = 1})
  table.insert(items, {name="rangedweapons:m1991",  chance = 1, count = 1})
  table.insert(items, {name="rangedweapons:beretta",  chance = 1, count = 1})
  table.insert(items, {name="rangedweapons:python",  chance = 1, count = 1})
  table.insert(items, {name="rangedweapons:ak47",  chance = 1, count = 1})
  end
  
  -- ZOMBIES4TEST ---------------------------------------------------------------------------------------------------------
  if minetest.get_modpath("foodx") then
  table.insert(items, {name="foodx:canned_tomato",  chance = 1, count = 3})
  table.insert(items, {name="foodx:canned_beans",  chance = 1, count = 3})
  end
  
  if minetest.get_modpath("itemx") then
  table.insert(items, {name="itemx:bandaid",  chance = 1, count = 1})
  end

  
  
  
  