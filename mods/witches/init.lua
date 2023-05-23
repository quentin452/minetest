-- Witches is copyright 2022 Francisco Athens, Ramona Athens, Damon Athens and Simone Athens
-- The MIT License (MIT)
-- local mod_name = "witches"
local path = minetest.get_modpath("witches")
witches = {}

witches.version = "20221022"

-- Strips any kind of escape codes (translation, colors) from a string
-- https://github.com/minetest/minetest/blob/53dd7819277c53954d1298dfffa5287c306db8d0/src/util/string.cpp#L777
function witches.strip_escapes(input)
    local s = function(idx) return input:sub(idx, idx) end
    local out = ""
    local i = 1
    while i <= #input do
        if s(i) == "\027" then -- escape sequence
            i = i + 1
            if s(i) == "(" then -- enclosed
                i = i + 1
                while i <= #input and s(i) ~= ")" do
                    if s(i) == "\\" then
                        i = i + 2
                    else
                        i = i + 1
                    end
                end
            end
        else
            out = out .. s(i)
        end
        i = i + 1
    end
    -- print(("%q -> %q"):format(input, out))
    return out
end

local function print_s(input) print(witches.strip_escapes(input)) end

local S = minetest.get_translator("witches")
local settings = minetest.settings

print_s(S("This is Witches verison @1!", witches.version))

function witches.debug(input, debug_category)
    debug_category = debug_category or ""
    local setting_debug = settings:get_bool("witches_debug", false)
    local setting_debug_category = settings:get("witches_debug_category")

    if setting_debug then
        if setting_debug_category then

            local filters = {}
            string.gsub(setting_debug_category, "(%a+)",
                        function(w) table.insert(filters, w) end)

            for i, v in ipairs(filters) do
                if string.find(debug_category, v) then
                    print_s(debug_category .. " " .. input)
                end
            end
        else
            print_s(debug_category .. " " .. input)
        end
    end
end

function witches.mr(min, max)
    local v = 1
    if max and max < min then
        print("WARNING: max (" .. max .. ") is less than min (" .. min ..
                  ") for math.random!\n Substituting with value of 1!")
        return v
    end
    if min then
        if max then
            v = math.random(min, max)
        else
            v = math.random(min)
        end
    end
    return v
end

local witches_version = witches.version
local mobs_req = 20200515

if mobs.version then
    if tonumber(mobs.version) >= tonumber(20200516) then
        print_s(S("Mobs Redo @1 or greater found! (" .. mobs.version .. ")",
                  mobs_req))
    else
        print_s(S("You should find a more recent version of Mobs Redo!"))
        print_s(S("https://notabug.org/TenPlus1/mobs_redo"))
    end
else
    print_s(S("This mod requires Mobs Redo version @1 or greater!", mobs_req))
    print_s(S("https://notabug.org/TenPlus1/mobs_redo"))
end

if not doors then
    witches.debug("doors mod not found")
    witches.doors = false
else
    witches.doors = true
    witches.debug("doors mod found")
end

if not minetest.get_modpath("vessels") then
    witches.debug("vessels mod not found")
    witches.vessels = false
else
    witches.vessels = true
    witches.debug("vessels mod found")
end
dofile(path .. "/content.lua")
dofile(path .. "/utilities.lua")
dofile(path .. "/ui.lua")
dofile(path .. "/items.lua")
dofile(path .. "/nodes.lua")

-- This gets the list of possible sheep that an enemy can be turned into
if minetest.get_modpath("animalia") then
    witches.sheep = {"animalia:sheep"}
elseif minetest.get_modpath("mobs_animal") then
    witches.sheep = {}
    for key, value in pairs(minetest.registered_entities) do
        if string.sub(key, 1, #("mobs_animal:sheep_")) == "mobs_animal:sheep_" then
            witches.sheep[#witches.sheep + 1] = key
        end
    end
else
    dofile(path .. "/sheep.lua")
    witches.sheep = {}
    for _, col in ipairs(witches.sheep_colors) do
        witches.sheep[#witches.sheep + 1] = "witches:sheep_" .. col[1]
    end
end

dofile(path .. "/magic.lua")

witches.cottages = settings:get_bool("witches_cottages", true)
if witches.cottages then
    witches.cottages = true
    dofile(path .. "/cottages.lua")
    print_s(S("Witch cottages will be generated"))
else
    print_s(S("Witch cottages will NOT be generated"))
end

dofile(path .. "/witches.lua")

witches.debug("Generating witches! version: " .. witches.version)

--- This can build all the mobs in our mod.
-- @witch_types is a table with the key used to build the subtype with values that are unique to that subtype
-- @witch_template is the table with all params that a mob type would have defined
function witches.generate(witch_types, witch_template)
    for k, v in pairs(witch_types) do
        -- we need to get a fresh template to modify for every type or we get some carryover values:-P
        local g_template = table.copy(witch_template)
        -- g_type should be different every time so no need to freshen
        local g_type = v
        for x, y in pairs(g_type) do
            -- print_s("found template modifiers " ..dump(x).." = "..dump(y))
            g_template[x] = g_type[x]
        end

        witches.debug("Registering the " .. g_template.description ..
                          ": witches:witch_" .. k)
        if g_template.lore then print_s("  " .. g_template.lore) end
        -- print_s("resulting template: " ..dump(g_template))
        mobs:register_mob("witches:witch_" .. k, g_template)
        mobs:register_egg("witches:witch_" .. k,
                          S("@1  Egg", g_template.description),
                          "default_mossycobble.png", 1)
        g_template.spawning.name = "witches:witch_" .. k -- spawn in the name of the key!
        mobs:spawn(g_template.spawning)
        if g_template.additional_properties then
            for x, y in pairs(g_template.additional_properties) do
                minetest.registered_entities["witches:witch_" .. k][x] = y
            end
        end
        g_template = {}
    end
end

witches.generate(witches.witch_types, witches.witch_template)
