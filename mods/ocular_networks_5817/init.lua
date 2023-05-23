local modpath=minetest.get_modpath("ocular_networks")
local worldpath=minetest.get_worldpath()

ocular_networks={worldpath=worldpath, modpath=modpath}

minetest.register_privilege("ocular_networks_dbg", {description="Allows players to access OcuN debug commands, Do not grant to anyone untrustworthy.", give_to_singleplayer=false})

ocular_networks.config=dofile(modpath.."/config.txt")

if loadfile(worldpath.."/ocular_networks_config.txt") then
	ocular_networks.config=dofile(worldpath.."/ocular_networks_config.txt")
end

if minetest.get_modpath("wieldview") then
	error("\nocular_networks does not currently support wieldview. Please disable it (in the 3d_armor modpack.)\n", 0)
end

dofile(modpath.."/functions.lua")
dofile(modpath.."/encscripts.lua")
dofile(modpath.."/liquids.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/items.lua")
dofile(modpath.."/tools.lua")
dofile(modpath.."/craft.lua")
dofile(modpath.."/abm.lua")

if ocular_networks.get_config("load_compat") then
	dofile(modpath.."/modules/compat.lua")
end

if ocular_networks.get_config("load_armor") then
	dofile(modpath.."/modules/armor.lua")
end

if ocular_networks.get_config("load_armor_upgrades") then
	dofile(modpath.."/modules/upgrade.lua")
end

if ocular_networks.get_config("load_probe_toolkit") and minetest.get_modpath("mesecons") then
	dofile(modpath.."/modules/probe.lua")
end

if ocular_networks.get_config("load_forceloader") then
	dofile(modpath.."/modules/chload.lua")
end

if ocular_networks.get_config("load_rifle_weapons") then
	dofile(modpath.."/modules/rifle.lua")
end

if ocular_networks.get_config("load_flight_ring") then
	dofile(modpath.."/modules/jetring.lua")
end

if ocular_networks.get_config("load_guide") and minetest.get_modpath("guidebooks") then
	dofile(modpath.."/modules/guide.lua")
end

if ocular_networks.get_config("load_decor")  then
	dofile(modpath.."/modules/decor.lua")
end
