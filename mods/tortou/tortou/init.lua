tortou = {}
local tickFus = {}
local toFus = {}
local fromFus = {}
local data = {}
local tick = tonumber(minetest.settings:get("tick_duration")) or 0.15

--Rounding towards zero: 1, 2, 3, 4. Rounding away from zero: 5, 6, 7, 8, 9.
local function round(val)
	local sign = 1
	if val < 0 then
		sign = -1
		val = val * -1
	end
	local floor = math.floor(val)
	--The first part avoids rounding errors for integers.
	return sign * ((val == floor and floor) or math.floor(val + 0.5))
end

function tortou.registerTo(fu)
	table.insert(toFus, fu)
end

function tortou.registerTick(fu)
	table.insert(tickFus, fu)
end

function tortou.registerFrom(fu)
	table.insert(fromFus, fu)
end

function tortou.isTurtle(player)
	if not player then return false end
	if type(player) ~= "string" then
		player = player:get_player_name()
	end
	return data[player] ~= nil
end

function tortou.yaw4(player)
	local yaw = round(player:get_look_horizontal() * 2 / math.pi)
	return yaw >= 0 and yaw % 4 or 4 + yaw
end

function tortou.pitch4(player)
	return round(player:get_look_vertical() * 2 / math.pi)
end

function tortou.left(player)
	player:set_look_horizontal((tortou.yaw4(player) + 1) * math.pi / 2)
end

function tortou.right(player)
	player:set_look_horizontal((tortou.yaw4(player) - 1) * math.pi / 2)
end

function tortou.up(player)
	local pos = vector.round(player:get_pos())
	local v = tortou.pitch4(player)
	local h = tortou.yaw4(player)
	if v == 1 then
		pos.y = pos.y - 1
	elseif v == 0 then
		if h == 0 or h == 4 then
			pos.z = pos.z + 1	
		elseif h == 1 then
			pos.x = pos.x - 1	
		elseif h == 2 then
			pos.z = pos.z - 1	
		elseif h == 3 then
			pos.x = pos.x + 1	
		end
	elseif v == -1 then
		pos.y = pos.y + 1
	end
	player:set_pos(pos)
end

function tortou.jump(player)
	player:set_look_vertical((tortou.pitch4(player) - 1) * math.pi / 2)
end

function tortou.sneak(player)
	player:set_look_vertical((tortou.pitch4(player) + 1) * math.pi / 2)
end

local function move(player)
	local keys = player:get_player_control()
	if keys.up then
		tortou.up(player)
	elseif keys.left then
		tortou.left(player)
	elseif keys.right then
		tortou.right(player)
	elseif keys.jump then
		tortou.jump(player)
	elseif keys.sneak then
		tortou.sneak(player)
	end
end

local function globalstep(dt)
	local players = minetest.get_connected_players()
	for _, player in ipairs(players) do
		local plData = data[player:get_player_name()]
		if plData then
			plData.dt = plData.dt + dt
			local bits = player:get_player_control_bits()
			if bits > 0 then
				if plData.dt >= tick then
					move(player)
					for _, fu in ipairs(tickFus) do
						fu(player)
					end
					plData.dt = 0
				end
			end
		end
	end
end

function tortou.toTurtle(name)
	local player = minetest.get_player_by_name(name)
	data[name] = {prop = player:get_properties(), size = 0, phys = player:get_physics_override(),
		dt = 0}	
	player:set_properties({
		collisionbox = {-0.45, -0.5, -0.45, 0.45, 0.45, 0.45}, 
		eye_height = 0, 
		stepheight = 0.5, 
		visual = "cube", 
		visual_size = {x = 0.9, y = 0.9, z = 0.9},
		textures = {"tortou_top.png","tortou_bottom.png","tortou_right.png", "tortou_left.png",
			"tortou_front.png","tortou_back.png",
		}, 
	})
	player:set_physics_override({
		speed = 0,
		jump = 0
	})
	player:set_pos(vector.round(player:get_pos()))
	player:set_look_horizontal(0)
	player:set_look_vertical(0)
	for _, fu in ipairs(toFus) do
		fu(player)
	end
end

function tortou.fromTurtle(name)
	local player = minetest.get_player_by_name(name)
	if data[name] then
		player:set_properties(data[name].prop)
		player:set_physics_override(data[name].phys)
		data[name] = nil
	end
	for _, fu in ipairs(fromFus) do
		fu(player)
	end
end

minetest.register_globalstep(globalstep)
minetest.register_chatcommand("to-turtle", {privs = {fly = true, noclip = true}, 
	func = tortou.toTurtle, description = "Transforms the player into a turtle."})
minetest.register_chatcommand("from-turtle", {privs = {fly = true, noclip = true}, 
	func = tortou.fromTurtle, description = 
		"Transforms the player back to the model saved with to-turtle."})
minetest.register_on_leaveplayer(tortou.fromTurtle)
