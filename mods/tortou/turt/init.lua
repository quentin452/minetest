turt = {}
turt.waitDuration = tonumber(minetest.settings:get("turt_wait_duration")) or 2
local turtDir = minetest.get_modpath("turt")
local scriptDir = turtDir .. "/scripts/"
local schemDir = turtDir .. "/schematics/"
local execQu = {}

local baseCmds = {
	F = tortou.up,
	P = function(player) 
		local res = cursor.RMB(player)
		if res then
			return res
		end
		tortou.up(player)
	end,
	L = tortou.left,
	R = tortou.right,
	U = tortou.jump,
	D = tortou.sneak,
	C = cursor.LMB,
	["+"] = cursor.increaseSize,
	["-"] = cursor.decreaseSize,
	["<"] = cursor.prevItem,
	[">"] = cursor.nextItem,
}
local gotoCmds = {
	I = function(script, index, tabGoto, player) 
		if player:get_wielded_item():get_name() == minetest.get_node(player:get_pos()).name then
			script:seek("set", index + tabGoto.offset)
		end
	end,
	N = function(script, index, tabGoto, player) 
		if player:get_wielded_item():get_name() ~= minetest.get_node(player:get_pos()).name then
			script:seek("set", index + tabGoto.offset)
		end
	end,
	X = function(script, index, tabGoto) 
		if tabGoto.count < tabGoto.max then
			script:seek("set", index + tabGoto.offset)
			tabGoto.count = tabGoto.count + 1
		else
			tabGoto.count = 0
		end
	end,
	A = function(script, _, tabGoto) 
		script:seek("set", tabGoto.offset - 1)
	end,
}

local function extractNumbers(out, keys, str)
	local ci = 1
	for strNum in str:gmatch("-?[0-9]+") do
		local num = tonumber(strNum)
		if not num then
			return false
		end
		out[keys[ci]] = num
		ci = ci + 1
	end
	return #keys == ci - 1
end

local offMax = {"offset", "max"}
local xyz = {"x", "y", "z"}
local function readArgs(script, typ3)
	local out = {}
	local args = ""
	local char = script:read(1)
	while char ~= ";" do
		args = args .. char
		char = script:read(1)
	end
	if typ3 == "X" then
		if not extractNumbers(out, offMax, args) then 
			return false
		end
		out.count = 0
	elseif typ3 == "T" then
		if not extractNumbers(out, xyz, args) then
			return false
		end
	elseif typ3 == "S" then
		return args
	else
		local num = tonumber(args)
		if not num then return false end
		out.offset = num
	end
	return out
end

local function relateVectors(yaw4, v1, v2, v3)
	if yaw4 == 0 then
		v1.x = v2.x + v3.x
		v1.z = v2.z + v3.z
	elseif yaw4 == 1 then
		v1.x = v2.x - v3.z
		v1.z = v2.z + v3.x
	elseif yaw4 == 2 then
		v1.x = v2.x - v3.x
		v1.z = v2.z - v3.z
	else
		v1.x = v2.x + v3.z
		v1.z = v2.z - v3.x
	end
	v1.y = v2.y + v3.y
end

local function execute(name, script, za)
	local player = minetest.get_player_by_name(name)
	if not tortou.isTurtle(player) then 
		minetest.chat_send_player(name, "You aren't a turtle.")
		return 
	end
	local char = script:read(1)
	if not za then
		--tabGotos structure: {<index> = {offset = <number>[, max = <number>, count = <number>]}}
		za = {tabGotos = {}, tabTeleportations = {}, schematics = {}, startPos = player:get_pos(),
			startDir = tortou.yaw4(player), prevIndex = 0}
		while char ~= "|" do
			char = script:read(1)
		end
	end
	while char do
		if baseCmds[char] then
			local res = baseCmds[char](player)
			if res == cursor.IGNORE then
				script:seek("cur", -1)
				table.insert(execQu, {name, script, za})
				return
			end
		elseif gotoCmds[char] then
			local index = script:seek() - 1
			if za.tabGotos[index] == nil then
				za.tabGotos[index] = readArgs(script, char)
				if za.tabGotos[index] == false then
					minetest.chat_send_player(name, "The " .. char .. " goto at index " .. index 
						.. " couldn't be parsed.")
				end
			end
			if za.tabGotos[index] then
				gotoCmds[char](script, index, za.tabGotos[index], player)
				if char == "A" then
					za.prevIndex = index
				end
			end
		elseif char == "Z" then
			script:seek("set", za.prevIndex + 3)
		elseif char == "S" then
			local index = script:seek() - 1
			if za.schematics[index] == nil then
				za.schematics[index] = readArgs(script, char)
				if za.schematics[index] == false then
					minetest.chat_send_player(name, "The schematic placement at index " .. index 
						.. " couldn't be parsed.")
				end
			end
			if za.schematics[index] then
				local schem = minetest.read_schematic(schemDir .. za.schematics[index] .. ".mts", {})
				local pos = player:get_pos()
				local min = vector.copy(pos)
				local max = vector.copy(pos)
				relateVectors(tortou.yaw4(player), max, max, vector.subtract(schem.size, 1))
				local protected = minetest.is_area_protected(min, max, name)
				if not protected then
					minetest.place_schematic(pos, schem, 360 - tortou.yaw4(player) * 90, nil, true)
				else
					minetest.chat_send_player(name, "There is a protected node at " 
						.. vector.to_string(protected) .. " in the area defined by " 
						.. vector.to_string(min) .. " and " .. vector.to_string(max) .. ".")
				end
			end
		elseif char == "T" then
			local index = script:seek() - 1
			if za.tabTeleportations[index] == nil then
				za.tabTeleportations[index] = readArgs(script, char)
				if za.tabTeleportations[index] == false then
					minetest.chat_send_player(name, "The teleportation at index " .. index 
						.. " couldn't be parsed.")
				end
			end
			if za.tabTeleportations[index] then
				local pos = player:get_pos()
				local vect = za.tabTeleportations[index]
				relateVectors(za.startDir, pos, za.startPos, vect)
				player:set_pos(pos)
			end
		end
		char = script:read(1)
	end
	script:close()
end

local time = 0
local function globalstep(dtime)
	time = time + dtime
	if time > turt.waitDuration then
		if #execQu > 0 then
			local qu = execQu
			execQu = {}
			for _, val in ipairs(qu) do
				execute(val[1], val[2], val[3])
			end
		end
		time = 0
	end
end

function turt.exe(name, params)
	local script = io.open(scriptDir .. params .. ".turt")

	if not script then 
		minetest.chat_send_player(name, "The script " .. params .. " does not exist.")
		return 
	end
	execute(name, script)
end

minetest.register_chatcommand("turt", {privs = {fly = true, noclip = true}, func = turt.exe,
	params = "<script name>", description = "Executes the script with the given name."})
minetest.register_globalstep(globalstep)
