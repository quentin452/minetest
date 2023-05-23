cursor = {IGNORE = 1, PROTECTED = 2}
local data = {}

local function createMenu(size)
	return table.concat({"formspec_version[5]", 
		"size[4,4]",  
		"field[1,1;2,1;cursorSize;size (uneven);", size,"]",
		"button_exit[1,2;2,1;cursorClose;close]"
	})
end

local function setNodeCube(playerName, itemName, pos, size)
	local radius = (size - 1) / 2
	if minetest.get_node(pos).name == "ignore" then
		return cursor.IGNORE
	end
	local cubeMin = {x = pos.x - radius, y = pos.y - radius, z = pos.z - radius}
	local cubeMax = {x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}
	local protected = minetest.is_area_protected(cubeMin, cubeMax, playerName)
	if not protected then
		local vm = VoxelManip()
		local p1, p2 = vm:read_from_map(cubeMin, cubeMax)
		local px, py = p2.x - p1.x + 1, p2.y - p1.y + 1
		local content = vm:get_data()
		local contentId = minetest.get_content_id(itemName)
		for cz = 0, size - 1, 1 do
			for cy = 0, size - 1, 1 do
				local min = ((cubeMin.z + cz - p1.z) * py + (cubeMin.y + cy - p1.y)) * px 
					+ (cubeMin.x - p1.x) + 1
				for cx = 0, size - 1, 1 do
					content[min + cx] = contentId
				end
			end
		end
		vm:set_data(content)
		vm:update_liquids()
		vm:write_to_map()
		minetest.check_for_falling(cubeMin)
	else 
		minetest.chat_send_player(playerName, "There is a protected node at " 
			.. vector.to_string(protected) .. " in the area defined by " .. vector.to_string(cubeMin) 
			.. " and " .. vector.to_string(cubeMax) .. ".")
		return cursor.PROTECTED
	end
end

function cursor.RMB(player)
	local itemName = player:get_wielded_item():get_name()
	local name = player:get_player_name()
	if not minetest.registered_nodes[itemName] then
		minetest.chat_send_player(name, "The wielded item is not a registered node.")
		return
	end
	if data[name].size == 1 then
		local pos = vector.round(player:get_pos())
		if minetest.is_protected(pos) then
			minetest.chat_send_player(name, "The node at position " .. vector.to_string(pos) 
				.. " is protected.")
			return cursor.PROTECTED
		end
		if minetest.get_node(pos).name == "ignore" then
			return cursor.IGNORE
		end
		local param2 = minetest.registered_nodes[itemName].paramtype2
		if param2:find("facedir") then
			param2 = minetest.dir_to_facedir(player:get_look_dir(), true)
		elseif param2:find("wallmounted") then
			param2 = minetest.dir_to_wallmounted(player:get_look_dir())
		else
			param2 = nil
		end
		minetest.set_node(pos, {name = itemName, param2 = param2})
		minetest.check_single_for_falling(pos)
	else
		return setNodeCube(name, itemName, player:get_pos(), data[name].size)
	end
end

function cursor.LMB(player)
	local node = minetest.get_node(vector.round(player:get_pos()))
	player:set_wielded_item(node.name)
end

function cursor.down(player)
	local name = player:get_player_name()
	minetest.show_formspec(name, "cursorMenu", createMenu(data[name].size))
end

function cursor.increaseSize(player)
	local plData = data[player:get_player_name()]
	if plData and plData.size < 10 then
		plData.size = plData.size + 2
	end
end

function cursor.decreaseSize(player)
	local plData = data[player:get_player_name()]
	if plData and plData.size > 2 then
		plData.size = plData.size - 2
	end
end

-- There is no "set_wield_index" :(
function cursor.nextItem(player)
	local inv = player:get_inventory()
	local strInv = "main"
	local stack1 = inv:get_stack(strInv, 1)
	for ci = 2, 8 do
		inv:set_stack(strInv, ci - 1, inv:get_stack(strInv, ci))
	end
	inv:set_stack(strInv, 8, stack1)
end

-- There is no "set_wield_index" :(
function cursor.prevItem(player)
	local inv = player:get_inventory()
	local strInv = "main"
	local stack8 = inv:get_stack(strInv, 8)
	for ci = 7, 1, -1 do
		inv:set_stack(strInv, ci + 1, inv:get_stack(strInv, ci))
	end
	inv:set_stack(strInv, 1, stack8)
end

local function cursorTick(player)
	local keys = player:get_player_control()
	if keys.RMB then
		cursor.RMB(player)
	elseif keys.LMB then
		cursor.LMB(player)
	elseif keys.down then
		cursor.down(player)
	end
end

local function onPlayerReceiveFields(player, formname, fields)
	if formname ~= "cursorMenu" then return end
	if fields.quit and fields.cursorSize then
		local size = tonumber(fields.cursorSize)
		if size then
			data[player:get_player_name()].size = size >= 0 and (size <= 11 and fields.cursorSize 
				- fields.cursorSize % 2 + 1 or 11) or 1
		end
	end
end

local function toCursor(player)
	local name = player:get_player_name()
	if not data[name] then
		data[name] = {size = 1}
	end
end

local function fromCursor(player)
	data[player:get_player_name()] = nil
end

local function onPlace(pos, newnode, placer, oldnode)
	if tortou.isTurtle(placer) then
		minetest.set_node(pos, oldnode)
		return true
	end
end

local function onDig(pos, oldnode, digger)
	if tortou.isTurtle(digger) then
		minetest.set_node(pos, oldnode)
	end
end

minetest.register_on_dignode(onDig)
minetest.register_on_placenode(onPlace)
minetest.register_on_player_receive_fields(onPlayerReceiveFields)
tortou.registerFrom(fromCursor)
tortou.registerTick(cursorTick)
tortou.registerTo(toCursor)
