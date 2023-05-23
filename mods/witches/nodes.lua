local S = minetest.get_translator("witches")
local function print_s(input) print(witches.strip_escapes(input)) end
if not witches.doors then
    witches.debug("doors mod not found!")
    return
else
    witches.debug(S("doors active"))
    doors.register("door_wood_witch", {
        tiles = {{name = "doors_door_wood.png", backface_culling = true}},
        description = S("Wooden Door"),
        inventory_image = "doors_item_wood.png",
        groups = {
            node = 1,
            choppy = 2,
            oddly_breakable_by_hand = 2,
            flammable = 2
        }
        --[[
    recipe = {
      {"group:wood", "group:wood"},
      {"group:wood", "group:wood"},
      {"group:wood", "group:wood"},
    }
    --]]
    })
end

if not minetest.get_modpath("beds") then
    
    print_s(S("bed mod not found! Bed not registered!"))
end

if not minetest.get_modpath("bucket") then
    minetest.register_alias("witches:bucket","default:coal")
    print_s(S("bucket mod not found! Bucket not registered!"))
else
    minetest.register_alias("witches:bucket","bucket_water")
end

if not minetest.get_modpath("vessels") then
    minetest.register_alias("witches:shelf", "ignore")
    minetest.register_alias("witches:glass_bottle", "ignore")
    print_s(S("vessels mod not found! Shelf and glass bottle not registered!"))
else
    minetest.register_alias("witches:shelf", "vessels:shelf")
    minetest.register_alias("witches:glass_bottle", "vessels:glass_bottle")
end

minetest.register_alias("witches:chest_locked", "default:chest_locked")

minetest.register_alias("witches:spawn_node", "air")

minetest.register_node("witches:tree", {
    tiles = {
        "default_tree_top.png", "default_tree_top.png", "default_tree.png",
        "default_tree.png", "default_tree.png", "default_tree.png"
    },
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),
    on_place = minetest.rotate_node,
    drawtype = "nodebox",
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.375, -0.5, -0.5, 0.375, 0.5, 0.5}, -- NodeBox1
            {-0.5, -0.5, -0.375, 0.5, 0.5, 0.375} -- NodeBox2
        }
    }
})

local flowers_types = {}
if minetest.get_modpath("flowers") and flowers.datas then
    for i, v in pairs(flowers.datas) do flowers_types[i] = "flowers:" .. v[1] end
end

function witches.flower_patch(pos)
    if not pos then
        witches.debug("no pos for flowers!")
        return
    end
    local fpos = pos
    if minetest.get_modpath("flowers") then

        -- print(dump(flowers_types))
        local r_flower = flowers_types[math.random(#flowers_types)]
        local node = r_flower
        -- print(r_flower)
        local check = minetest.get_node(pos)
        if string.find(check.name, "dirt") then
            minetest.place_node(vector.new(fpos.x, fpos.y + 1, fpos.z),
                                {name = r_flower})
            -- flowers.flower_spread(fpos, {name = r_flower}) 
            return r_flower
        elseif string.find(check.name, "sand") then
            if math.random() < 0.20 then
                minetest.set_node(vector.new(fpos.x, fpos.y + 1, fpos.z),
                                  {name = "default:large_cactus_seedling"})
            elseif minetest.get_modpath("farming") then
                minetest.set_node(vector.new(fpos.x, fpos.y + 1, fpos.z),
                                  {name = "farming:cotton_wild"})
            else
                minetest.set_node(vector.new(fpos.x, fpos.y + 1, fpos.z),
                                  {name = "default:dry_shrub"})
            end

        end

    end
end

minetest.register_node("witches:treeroots", {
    description = S("tree roots"),
    drawtype = "liquid",
    tiles = {
        {backface_culling = false, name = "default_tree.png"},
        {backface_culling = false, name = "default_tree.png"}
    },
    -- alpha = 220,
    paramtype = "light",
    walkable = true,
    pointable = true,
    diggable = true,
    buildable_to = true,
    is_ground_content = false,
    drop = "",
    drowning = 0,
    liquidtype = "source",
    liquid_alternative_flowing = "witches:treeroots_growing",
    liquid_alternative_source = "witches:treeroots",
    liquid_viscosity = 9,
    -- Not renewable to avoid horizontal spread of water sources in sloping
    -- rivers that can cause water to overflow riverbanks and cause floods.
    -- River water source is instead made renewable by the 'force renew'
    -- option used in the 'bucket' mod by the river water bucket.
    liquid_renewable = false,
    liquid_range = 1,
    post_effect_color = {a = 200, r = 5, g = 5, b = 0},
    groups = {
        liquid = 3,
        cools_lava = 1,
        tree = 1,
        choppy = 2,
        oddly_breakable_by_hand = 1,
        flammable = 2
    }
    -- sounds = default.node_sound_water_defaults(),
})

