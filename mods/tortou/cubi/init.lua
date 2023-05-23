cubi = {}
cubi.maxMobs = tonumber(minetest.settings:get("cubi_max_mobs")) or 10
local activeMobs = {}
local mobCount = 0
local Rand = PcgRandom(os.clock())
local tabTextures = {{
		"cubi_moognu_side.png", "cubi_moognu_side.png", "cubi_moognu_side.png", 
		"cubi_moognu_side.png", "cubi_moognu_back.png","cubi_moognu_front.png"
	}, {
		"cubi_nyancat_side.png", "cubi_nyancat_side.png", "cubi_nyancat_side.png", 
		"cubi_nyancat_side.png", "cubi_nyancat_back.png","cubi_nyancat_front.png"
	}, {
		"cubi_pup_side.png", "cubi_pup_side.png", "cubi_pup_side.png", 
		"cubi_pup_side.png", "cubi_pup_back.png","cubi_pup_front.png"
	}, {
		"cubi_tac_side.png", "cubi_tac_side.png", "cubi_tac_side.png", 
		"cubi_tac_side.png", "cubi_tac_back.png","cubi_tac_front.png"
	}, {
		"cubi_cow_side.png", "cubi_cow_bot.png", "cubi_cow_side.png", 
		"cubi_cow_side.png", "cubi_cow_back.png","cubi_cow_front.png"
	}, {
		"cubi_pig_side.png", "cubi_pig_side.png", "cubi_pig_side.png", 
		"cubi_pig_side.png", "cubi_pig_back.png","cubi_pig_front.png"
	},
	die = {
		[0] = "cubi_die_3.png", "cubi_die_4.png", "cubi_die_5.png", 
		"cubi_die_2.png", "cubi_die_6.png","cubi_die_1.png"
	}
}

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

function cubi.yaw4(ent)
	local yaw = round(ent.object:get_rotation().y * 2 / math.pi)
	return yaw >= 0 and yaw % 4 or 4 + yaw
end

function cubi.pitch4(ent)
	return round(ent.object:get_rotation().x * 2 / math.pi)
end

function cubi.left(ent)
	local rot = ent.object:get_rotation()
	rot.y = (cubi.yaw4(ent) + 1) * math.pi / 2
	ent.object:set_rotation(rot)
end

function cubi.right(ent)
	local rot = ent.object:get_rotation()
	rot.y = (cubi.yaw4(ent) - 1) * math.pi / 2
	ent.object:set_rotation(rot)
end

function cubi.up(ent)
	local pos = vector.round(ent.object:get_pos())
	local v = cubi.pitch4(ent)
	local h = cubi.yaw4(ent)
	if v == 1 then
		pos.y = pos.y - 1
	elseif v == 0 then
		if h == 0 or h == 4 then
			pos.z = pos.z - 1	
		elseif h == 1 then
			pos.x = pos.x + 1	
		elseif h == 2 then
			pos.z = pos.z + 1	
		elseif h == 3 then
			pos.x = pos.x - 1	
		end
	elseif v == -1 then
		pos.y = pos.y + 1
	end
	local nodeDef = minetest.registered_nodes[minetest.get_node(pos).name]
	if nodeDef and not nodeDef.walkable and nodeDef.damage_per_second <= 0 
		and nodeDef.drowning <= 0 then
		ent.object:set_pos(pos)
	end
end

function cubi.jump(ent)
	local rot = ent.object:get_rotation()
	local pit4 = cubi.pitch4(ent)
	if pit4 > -1 then
		rot.x = (pit4 - 1) * math.pi / 2
		ent.object:set_rotation(rot)
	end
end

function cubi.sneak(ent)
	local rot = ent.object:get_rotation()
	local pit4 = cubi.pitch4(ent)
	if pit4 < 1 then
		rot.x = (pit4 + 1) * math.pi / 2
		ent.object:set_rotation(rot)
	end
end

local function mobOnStep(obj, dtime)
	activeMobs[obj] = activeMobs[obj] + dtime
	if activeMobs[obj] >= 5 then
		local rand = Rand:next(1, 50)
		if rand <= 20 then
			cubi.up(obj)
		elseif rand <= 30 then
			cubi.left(obj)
		elseif rand <= 40 then
			cubi.right(obj)
		elseif rand <= 45 then
			cubi.jump(obj)
		elseif rand <= 50 then
			cubi.sneak(obj)
		end
		activeMobs[obj] = 0
	end
end

local function mobAbmAction(pos)
	if mobCount < cubi.maxMobs then
		local airPos = minetest.find_node_near(pos, 1, {"air"}) 
		if airPos then
			minetest.add_entity(airPos, "cubi:mob")
		end
	end
end

local function mobCardOnPlace(_, _, pointed_thing)
	local pos = vector.round(pointed_thing.above) 
	if pos then
		minetest.add_entity(pos, "cubi:mob")
	end
end

local function extractImg(imgOTab)
	return type(imgOTab) == "string" and imgOTab or imgOTab.name
end

local function createTextures(tiles)
	if #tiles == 1 then
		local one = extractImg(tiles[1])
		return {one, one .. "^cubi_mock_bottom.png", 
			one .. "^cubi_mock_side.png", one .. "^cubi_mock_side.png", 
			one .. "^cubi_mock_back.png", one .. "^cubi_mock_front.png"}
	elseif #tiles == 3 then
		local three = extractImg(tiles[3])
		return {extractImg(tiles[1]), extractImg(tiles[2]) .. "^cubi_mock_bottom.png", 
			three .. "^cubi_mock_side.png", three .. "^cubi_mock_side.png", 
			three .. "^cubi_mock_back.png", three .. "^cubi_mock_front.png"}
	elseif #tiles == 6 then
		return {extractImg(tiles[1]), 
			extractImg(tiles[2]) .. "^cubi_mock_bottom.png", 
			extractImg(tiles[3]) .. "^cubi_mock_side.png", 
			extractImg(tiles[4]) .. "^cubi_mock_side.png", 
			extractImg(tiles[5]) .. "^cubi_mock_back.png", 
			extractImg(tiles[6]) .. "^cubi_mock_front.png"}
	end
end

local function mobOnActivate(obj)
	mobCount = mobCount + 1
	activeMobs[obj] = 0
	local rand = Rand:next(-2, #tabTextures)
	if rand == 0 then return end
	local props = obj.object:get_properties()
	if rand > 0 then
		props.textures = tabTextures[rand]
	elseif rand == -1 then
		local tmp = minetest.find_node_near(obj.object:get_pos(), 50, {"group:stone", "group:sand", 
			"group:soil", "group:tree", "group:wood", "group:wool"})
		if not tmp then return end 
		tmp = minetest.registered_nodes[minetest.get_node(tmp).name]
		if not tmp then return end
		props.textures = createTextures(tmp.tiles)
	elseif rand == -2 then
		rand = Rand:next(0, 5)
		props.textures = {tabTextures.die[(1 + rand) % 6], 
			tabTextures.die[(2 + rand) % 6] .. "^cubi_mock_bottom.png", 
			tabTextures.die[(3 + rand) % 6] .. "^cubi_mock_side.png", 
			tabTextures.die[(4 + rand) % 6] .. "^cubi_mock_side.png", 
			tabTextures.die[(5 + rand) % 6] .. "^cubi_mock_back.png", 
			tabTextures.die[(6 + rand) % 6] .. "^cubi_mock_front.png"}
	end
	obj.object:set_properties(props)
end

local function mobOnDeath(obj)
	mobCount = mobCount - 1	
	activeMobs[obj] = nil
end

local function mobOnPunch(obj, puncher)
	local tmp = puncher:get_wielded_item()
	tmp = tmp and tmp:get_definition().sound
	tmp = tmp and tmp.use
	minetest.sound_play(tmp or "cubi_damage", {object = obj.object}, true)
end

minetest.register_entity("cubi:mob", {
	initial_properties = {
		collisionbox = {-0.45, -0.5, -0.45, 0.45, 0.45, 0.45},
		visual_size = {x = 0.9, y = 0.9, z = 0.9},
		infotext = "Cubic Mob",
		is_visible = true,
		static_save = false,
		stepheight = 0.5,
		visual = "cube",
		textures = {
			"cubi_turtle_top.png", "cubi_turtle_bottom.png", "cubi_turtle_side.png", 
			"cubi_turtle_side.png", "cubi_turtle_back.png","cubi_turtle_front.png"
		}
	},
	on_activate = mobOnActivate,
	on_death = mobOnDeath,
	on_punch = mobOnPunch,
	on_step = mobOnStep,
})

minetest.register_craftitem("cubi:turtle_card", {
	description = "Cubic Mob",
	inventory_image = "cubi_turtle_card.png",
	on_place = mobCardOnPlace, 
	short_description = "Cubic Mob",
})

minetest.register_abm({
	action = mobAbmAction,
	catch_up = false,
	chance = 100 / (tonumber(minetest.settings:get("cubi_spawn_chance")) or 1),
	interval = tonumber(minetest.settings:get("cubi_spawn_interval")) or 60,
	label = "Cubic Mob Spawn",
	neighbors = {"air"},
	nodenames = {"turtloop:tube"},
})
