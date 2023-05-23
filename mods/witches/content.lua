local witches_db = minetest.get_mod_storage()

witches.data_check = witches_db:to_table()["fields"]

function witches.data_get(table)
    local data = minetest.parse_json(witches_db:to_table()["fields"][table])
    return data
end

function witches.data_set(key, table)
    local data = minetest.write_json(table)

    witches_db:set_string(key, data)
    return key, data
end

-- ITEM DATABASE SETUP FOLLOWS - once the mod is run for the first time
-- server admins can then edit the worlds/<world>mod_storage.<type> database entries for the quest items
-- change or delete them in the DB at your pleasure
-- *** please do not edit this code, it will not overwrite the database ***

if not witches.data_check["generic_special_follow"] then
    witches.data_set("generic_special_follow", {

        {name = "default:diamond", min = 1, max = 2},
        {name = "default:gold_lump", min = 1, max = 2},
        {name = "default:apple", min = 1, max = 10},
        {name = "default:blueberries", min = 1, max = 10},
        {name = "default:torch", min = 1, max = 10},
        {name = "default:stick", min = 1, max = 20},
        {name = "flowers:mushroom_brown", min = 1, max = 10},
        {name = "flowers:mushroom_red", min = 1, max = 10}
    })
end

if not witches.data_check["cottage_special_follow"] then
    witches.data_set("cottage_special_follow", {

        {name = "default:diamond", min = 1, max = 2},
        {name = "default:gold_lump", min = 1, max = 2},
        {name = "default:apple", min = 1, max = 10},
        {name = "default:blueberries", min = 1, max = 10},
        {name = "default:torch", min = 1, max = 10},
        {name = "default:stick", min = 1, max = 20},
        {name = "flowers:mushroom_brown", min = 1, max = 10},
        {name = "flowers:mushroom_red", min = 1, max = 10}
    })
end

if not witches.data_check["cottage_special_drops"] then
    witches.data_set("cottage_special_drops", {
        {name = "default:pick_steel", chance = 1024, min = 1, max = 1 },
        {name = "default:shovel_steel", chance = 1024, min = 1, max = 1},
        {name = "default:axe_steel", chance = 1024, min = 1, max = 1 },
        {name = "default:pick_diamond", chance = 2048, min = 1, max = 1},
        {name = "default:shovel_diamond", chance = 2048, min = 1, max = 1},
        {name = "default:axe_diamond", chance = 2048, min = 1, max = 1}
    })

end

if not witches.data_check["template_drops"] then
    witches.data_set("template_drops", {
        {name = "default:torch", chance = 2, min = 5, max = 20},
        {name = "default:steel_ingot", chance = 4, min = 2, max = 5},
        {name = "default:pick_stone", chance = 8, min = 1, max = 1},
        {name = "default:shovel_stone", chance = 8, min = 1, max = 1},
        {name = "default:axe_stone", chance = 8, min = 1, max = 1},
        {name = "mobs:shears", chance = 16, min = 1, max = 1}
    })
end

if not witches.data_check["template_special_follow"] then
    witches.data_set("template_special_follow", {
        {name = "default:diamond", min = 1, max = 2},
        {name = "default:gold_lump", min = 1, max = 2},
        {name = "default:apple", min = 1, max = 10},
        {name = "default:blueberries", min = 1, max = 10},
        {name = "default:torch", min = 1, max = 10},
        {name = "default:stick", min = 1, max = 20},
        {name = "flowers:mushroom_brown", min = 1, max = 10},
        {name = "flowers:mushroom_red", min = 1, max = 10}
    })
end

if not witches.data_check["template_special_drops"] then
    witches.data_set("template_special_drops", {
        {name = "default:pick_steel", chance = 1024, min = 1, max = 1},
        {name = "default:shovel_steel", chance = 1024, min = 1, max = 1},
        {name = "default:axe_steel", chance = 1024, min = 1, max = 1},
        {name = "default:pick_diamond", chance = 2048, min = 1, max = 1},
        {name = "default:shovel_diamond", chance = 2048, min = 1, max = 1},
        {name = "default:axe_diamond", chance = 2048, min = 1, max = 1}
    })

end

if not witches.data_check["cottage_chest_items"] then
    witches.data_set("cottage_chest_items", {
        {name = "witches:bucket", chance = 1, min = 1, max = 1},
        {name = "mobs:shears", chance = 2, min = 1, max = 1},
        {name = "default:steel_ingot", chance = 2, min = 5, max = 10},
        {name = "default:gold_ingot", chance = 2, min = 5, max = 10},
        {name = "default:diamond", chance = 3, min = 3, max = 10},
        {name = "default:meselamp", chance = 3, min = 1, max = 5},
        {name = "default:shovel_diamond", chance = 10, min = 1, max = 1},
        {name = "default:axe_diamond", chance = 10, min = 1, max = 1}
    })

end

-- protecting these additional furniture nodes is not currently supported, but set here for future use
-- note that container node inventories are tables and they must be named as defined in their node definitions (main, books, vessels, etc)!
-- items placed in node inventories must each be tables (only {name = "mod:item_name"} is required, all else is optional)
-- mind the brackets!

if not witches.data_check["cottage_add_furniture"] then
    witches.data_set("cottage_add_furniture", {
        {name = "fireflies:firefly_bottle"},
        {name = "witches:shelf", chance = 1, min = 1, max = 1, inv = {vessels = {{name = "fireflies:firefly_bottle"},{name = "witches:glass_bottle", min = 1, max = 2}}}, protected = true, infotext = "Bottle Shelf"},
        {name = "default:bookshelf", chance = 1, min = 1, max = 1, inv = {books = {{name = "default:book", chance = 1, min = 2, max = 4}}}, protected = true, infotext = "Book Shelf"},
    })
end