turtloop = {}
turtloop.waitDuration = tonumber(minetest.settings:get("turtloop_wait_duration")) or 2
local data = {}
local onPlaceQu = {}

local function isSafe(player, node)
	local registeredNode = minetest.registered_nodes[node.name]
	if registeredNode.walkable then
		minetest.chat_send_player(player:get_player_name(), "The tube ends in a solid node.")
		return false
	elseif registeredNode.drowning and registeredNode.drowning > 0 then
		minetest.chat_send_player(player:get_player_name(), "The tube ends in a drowning node.")
		return false
	elseif registeredNode.damage_per_second > 0 then
		minetest.chat_send_player(player:get_player_name(), "The tube ends in a damaging node.")
		return false
	end
	return true
end

local function travel(player, dir, node, pos)
	if not isSafe(player, node) then return false end
	-- In most games the players height is between 1 and 2. 
	local prop = player:get_properties()
	if prop.collisionbox[2] + prop.collisionbox[5] > 1 then
		local pos2 = vector.copy(pos)
		pos2.y = pos2.y + (dir.y ~= 0 and dir.y or 1)
		node = minetest.get_node(pos2)
		if not isSafe(player, node) then return false end
		player:set_pos(dir.y == -1 and pos2 or pos)
	else
		player:set_pos(pos)
	end
	return true
end

local function toPod(player)
	local name = player:get_player_name()
	if not data[name] then 
		data[name] = {prop = player:get_properties(), size = 0, phys = player:get_physics_override(),
			startPos = player:get_pos()}	
		player:set_properties({
			collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, 
			eye_height = 0, 
			stepheight = 0.5, 
			textures = {"turtloop_pod_top.png","turtloop_pod_bottom.png","turtloop_pod_side.png", 
				"turtloop_pod_side.png", "turtloop_pod_front.png","turtloop_pod_side.png",
			}, 
			visual = "cube", 
		})
		player:set_physics_override({
			speed = 0,
			jump = 0
		})
	end
end

local function fromPod(player)
	local name = player:get_player_name()
	if data[name] then
		player:set_properties(data[name].prop)
		player:set_physics_override(data[name].phys)
		data[name] = nil
	end
end

local function ticketOnPlace(_, player, pointedThing)
	if pointedThing.type ~= "node" then return end
	local pos = pointedThing.under
	local node = minetest.get_node(pos)
	if node.name ~= "turtloop:tube" then return end
	local dir
	while node.name == "turtloop:tube" do
		dir = minetest.facedir_to_dir(node.param2)
		pos = vector.add(pos, dir)
		node = minetest.get_node(pos)
	end
	if node.name == "ignore" then
		toPod(player)
		pos = vector.subtract(pos, dir)
		player:set_pos(pos)
		table.insert(onPlaceQu, {player, {type = "node", under = pos}})
		return
	end
	local plData = data[player:get_player_name()]
	fromPod(player)
	if not travel(player, dir, node, pos) and plData then
		player:set_pos(plData.startPos)
	end
end

local time = 0
local function globalstep(dtime)
	time = time + dtime
	if time > turtloop.waitDuration then
		if #onPlaceQu > 0 then
			local qu = onPlaceQu
			onPlaceQu = {}
			for _, val in ipairs(qu) do
				ticketOnPlace(nil, val[1], val[2])
			end
		end
		time = 0
	end
end

minetest.register_node("turtloop:tube", {
	description =	"Turtloop Tube",
	drawtype = "liquid",
	groups = {cracky = 3},
	is_ground_content = false,
	liquid_move_physics = true,
	liquid_range = 0,
	move_resistance = 2,
	paramtype = "light",
	paramtype2 = "facedir",
	post_effect_color = "#A7989166",
	sunlight_propagates = true,
	walkable = false,
	sounds = {
		footstep = {name = "turtloop_glass_footstep", gain = 0.3},
		dig = {name = "turtloop_glass_footstep", gain = 0.5},
		dug = {name = "turtloop_break_glass", gain = 1.0},
		place = {name = "turtloop_place_node_hard", gain = 1.0}
	},
	tiles = {"turtloop_tube_side.png^[transformR90","turtloop_tube_side.png^[transformR270",
		"turtloop_tube_side.png", "turtloop_tube_side.png^[transformR180","turtloop_tube_front.png",
		"turtloop_tube_back.png",},
})

minetest.register_craftitem("turtloop:ticket", {
	description = "Turtloop Ticket",
	inventory_image = "turtloop_ticket.png",
	on_place = ticketOnPlace
})

minetest.register_globalstep(globalstep)
