local S = minetest.get_translator("perlin_explorer")
local F = minetest.formspec_escape

-----------------------------
-- Variable initialization --
-----------------------------

local mod_storage = minetest.get_mod_storage()

-- If true, the Perlin test nodes will support color
-- (set to false in case of performance problems)
local COLORIZE_NODES = true

-- If true, will use the grayscale color palette.
-- If false, will use the default colors.
local grayscale_colors = minetest.settings:get_bool("perlin_explorer_grayscale", false)

-- Shows a star on generating new noisechunks
local mapgen_star = minetest.settings:get_bool("perlin_explorer_mapgen_star", true)

-- The number of available test node colors.
-- Higher values lead to worse performance but a coarse color scheme.
-- This value is only used for performance reason, because Minetest
-- has a sharp performance drop when there are many different node colors on screen.
-- Consider removing this one when Minetest's performance problem has been solved.
local color_count = tonumber(minetest.settings:get("perlin_explorer_color_count")) or 64
local color_lookup = {
	[256] = 1, -- full color palette
	[128] = 2,
	[64] = 4,
	[32] = 8,
	[16] = 16,
	[8] = 32,
	[4] = 64,
	[2] = 128,
	[1] = 256,
}
-- This value is used for the calculation of the simplified color.
local color_precision = color_lookup[color_count]
if not color_precision then
	color_precision = 4 -- default: 64 colors
	minetest.log("warning", "[perlin_explorer] Invalid setting value specified for 'perlin_explorer_color_count'! Using the default ...")
end

-- Time to wait in seconds before checking and generating new nodes in autobuild mode.
local AUTOBUILD_UPDATE_TIME = 0.1

-- x/y/z size of "noisechunks" (like chunks in the Minetest mapgen, but specific to this
-- mod) to generate in autobuild mode.
local AUTOBUILD_SIZE = 16
-- Amount of noisechunks to generate around player
local AUTOBUILD_CHUNKDIST = 2


-- Color of the formspec box[] element
local FORMSPEC_BOX_COLOR = "#00000080"
-- Color for the section titles in the formspec
local FORMSPEC_HEADER_COLOR = "#000000FF"
-- Color of the diagram lines of the histogram
local FORMSPEC_HISTOGRAM_LINE_COLOR = "#FFFFFF80"
-- Color of hisogram bars
local FORMSPEC_HISTOGRAM_BAR_COLOR = "#00FF00FF"

-- Number of data buckets to use for the histogram
local HISTOGRAM_BUCKETS = 10

-- Number of values to pick in a statistics run
local STATISTICS_ITERATIONS = 1000000

-- This number is used to pick a reasonable size of the area
-- over which to calculate statistics on. The size (side length
-- of the area/volume, to be precise)
-- is the maximum spread (of the 2 or 3 axes) times this number.
-- This is needed so the randomly picked values in that
-- area are more evenly distributed and lot heavily
-- localized (which would skew the stats).
-- If this is too small, the stats will be too localized, but
-- if this is too large, it will limit the maximum supported
-- noise spread.
local STATISTICS_SPREAD_FACTOR = 69
-- Maximum size of the statistics calculation area (side length of square area /
-- cube volume). Must make sure that Minetest still accepts coordinates
-- in this range.
local STATISTICS_MAX_SIZE = math.floor((2^32-1)/1000)
-- Maximum allowed spread for statistics to still be supported.
-- Used for triggering error message.
local STATISTICS_MAX_SPREAD = math.floor(STATISTICS_MAX_SIZE / STATISTICS_SPREAD_FACTOR)

-- Hardcoded message text
local TEXT_ERROR_BAD_WAVELENGTH = S("Bad noise parameters given. At least one of the resulting wavelengths got below 1, which is not allowed. Decrease the octaves or lacunarity, or increase the spread to reach valid wavelengths. Use the “Analyze” feature to see the wavelengths.")

-- Per-player formspec states (mostly for remembering checkbox states)
local formspec_states = {}

-- List of noise parameters profiles
-- Format of a single profile:
-- * noiseparams: Noise parameters table
-- * name: Name as it appears in list (not set for user profiles)
-- * np_type: Type
--    * "active": Active noise parameters. Not deletable
--    * "mapgen": Noise parameters loaded from Minetest settings. Not deletable
--    * "user": Profiles created by user. Deletable
local np_profiles = {}

-- The default noiseparams are used as the initial noiseparams
-- or as fallback when stuff fails.
local default_noiseparams = {
	offset = 0.0,
	scale = 1.0,
	spread = vector.new(10, 10, 10),
	seed = 0,
	octaves = 2,
	persistence = 0.5,
	lacunarity = 2.0,
	flags = "defaults",
}

-- Get default noise params by setting (if available)
local np_by_setting = minetest.settings:get_np_group("perlin_explorer_default_noiseparams")
if np_by_setting then
	default_noiseparams = np_by_setting
	minetest.log("info", "[perlin_explorer] default noiseparams read from setting")
end

-- Holds the currently used Perlin noise
local current_perlin = {}
-- holds the current PerlinNoise object
current_perlin.noise = nil
current_perlin.noiseparams = table.copy(default_noiseparams)

local noise_settings = dofile(minetest.get_modpath(minetest.get_current_modname()).."/noise_settings_list.lua")

-- Add the special "active" profile
table.insert(np_profiles, {noiseparams=current_perlin.noiseparams, name=S("Active Noise Parameters"), np_type="active"})

-- Add the mapgen setting profiles
for n=1, #noise_settings do
	local np = minetest.get_mapgen_setting_noiseparams(noise_settings[n])
	-- TODO/FIXME: Make sure that ALL noise settings are gettable (not just those of the active mapgen)
	if np then
		table.insert(np_profiles, {noiseparams=np, name=noise_settings[n], np_type="mapgen"})
	end
end

-- Load user profiles from mod storage
minetest.log("info", "[perlin_explorer] Checking for user profiles in mod storage ...")
if mod_storage:contains("profiles") then
	local user_profiles_str = mod_storage:get_string("profiles")
	local user_profiles = minetest.deserialize(user_profiles_str)
	local loaded = 0
	if user_profiles then
		for p=1, #user_profiles do
			local user_profile = user_profiles[p]
			if user_profile and type(user_profile) == "table" and user_profile.noiseparams then
				table.insert(np_profiles, {
					np_type = "user",
					noiseparams = user_profiles[p].noiseparams,
				})
				loaded = loaded + 1
			else
				minetest.log("warning", "[perlin_explorer] Malformed user profile in mod storage! Skipping ...")
			end
		end
	end
	minetest.log("action", "[perlin_explorer] Loaded "..loaded.." user profile(s) from mod storage")
end

-- Updates the user profiles in the mod stroage.
-- Must be called whenever the user profiles change.
local function update_mod_stored_profiles()
	local user_profiles = {}
	for p=1, #np_profiles do
		local profile = np_profiles[p]
		if profile.np_type == "user" then
			table.insert(user_profiles, {
				noiseparams = table.copy(profile.noiseparams),
			})
		end
	end
	local serialized_profiles = minetest.serialize(user_profiles)
	mod_storage:set_string("profiles", serialized_profiles)
	minetest.log("info", "[perlin_explorer] Profiles in mod storage updated")
end

-- Options are settings that dictate how the noise is supposed
-- to be generated.
local current_options = {}
-- Side length of calculated perlin area
current_options.size = 64

-- Noise value that will be represented by the minimum color
current_options.min_color = -1.0
-- Noise value that will be represented by the maximum color
current_options.max_color = 1.0
-- Noise value that is interpreted as the midpoint for node colorization
current_options.mid_color = 0.0

-- Currently selected nodetype for the mapgen (see `nodetypes` table)
current_options.nodetype = 1

-- Currently selected build mode for the mapgen (see below)
-- These modes are available:
-- * Auto (1): same as ALL in 2D mode, same as HIGH_ONLY in 3D mode
-- * All (2): build nodes for all noise values
-- * High only (3): build nodes for high noise values only
-- * Low only (4): build nodes for low noise values only

local BUILDMODE_AUTO = 1
local BUILDMODE_ALL = 2
local BUILDMODE_HIGH_ONLY = 3
local BUILDMODE_LOW_ONLY = 4
local BUILDMODES_COUNT = 4
current_options.buildmode = BUILDMODE_AUTO

-- dimensions of current Perlin noise (2 or 3)
current_options.dimensions = 2
-- If greater than 1, the Perlin noise values are "pixelized". Noise values at
-- coordinates not divisible by sidelen will be set equal to the noise value
-- of the nearest number (counting downwards) that is divisible by sidelen.
-- This is (kind of) analogous to the "sidelen" parameter of mapgen decorations.
current_options.sidelen = 1
-- Place position of current perlin (relevant for single placing)
current_options.pos = nil

-- If enabled, automatically generate nodes around player
current_options.autogen = false

-- Remember which areas have been loaded by the autogen so far
-- Index: Hash of node position, value: true if loaded
local loaded_areas = {}

----------------------
-- Helper functions --
----------------------

-- Reduce the pos coordinates down to the closest numbers divisible by sidelen
local sidelen_pos = function(pos, sidelen)
	local newpos = {x=pos.x, y=pos.y, z=pos.z}
	if sidelen <= 1 then
		return newpos
	end
	newpos.x = newpos.x - newpos.x % sidelen
	newpos.y = newpos.y - newpos.y % sidelen
	newpos.z = newpos.z - newpos.z % sidelen
	return newpos
end

-- A hack to force a formspec to be unique.
-- Appends invisible filler content, changing
-- every time this function is called.
-- This will force the formspec to be unique.
-- Neccessary because Minetest doesn’t update
-- the formspec when the same formspec was
-- sent twice. This is a problem because the
-- player might have edited a text field, causing
-- the formspec to not properly update.
-- Only use this function for one formspec
-- type, otherwise it won’t work.
-- Workaround confirmed working for: Minetest 5.5.0
-- FIXME: Drop this when Minetest no longer does
-- this.
local unique_formspec_spaces = function(player_name, formspec)
	-- Increase the sequence number every time
	-- this thing is used, causing the number
	-- of spaces to change
	local seq = formspec_states[player_name].sequence_number
	seq = (seq + 1) % 4
	local filler = string.rep(" ", seq)
	formspec_states[player_name].sequence_number = seq
	return formspec .. filler
end

-- Takes the 3 noise flags default/eased/absvalue (either true or false)
-- and converts them to a string
local build_flags_string = function(defaults, eased, absvalue)
	local flagst = {}
	if defaults then
		table.insert(flagst, "defaults")
	end
	if eased then
		table.insert(flagst, "eased")
	else
		table.insert(flagst, "noeased")
	end
	if absvalue then
		table.insert(flagst, "absvalue")
	else
		table.insert(flagst, "noabsvalue")
	end
	local flags = table.concat(flagst, ",")
	return flags
end
-- Takes a flags string (in the noiseparams format)
-- and returns a table of the form {
-- 	defaults = true/false
-- 	eased = true/false
-- 	absvalue = true/false
-- }.
local parse_flags_string = function(flags)
	local ftable = string.split(flags, ",")
	local defaults, eased, absvalue = false, false, false
	for f=1, #ftable do
		local s = string.trim(ftable[f])
		if s == "defaults" then
			defaults = true
		elseif s == "eased" then
			eased = true
		elseif s == "absvalue" then
			absvalue = true
		end
	end
	if not defaults and not eased and not absvalue then
		defaults = true
	end
	return { defaults = defaults, eased = eased, absvalue = absvalue }
end

-- Sets the currently active Perlin noise.
-- * noiseparams: NoiseParams table (see Minetest's Lua API documentation)
local set_perlin_noise = function(noiseparams)
	current_perlin.noise = PerlinNoise(noiseparams)
	current_perlin.noiseparams = noiseparams
end

-- Register list of node types for test mapgen
local nodetypes = {
	-- { Entry name for sformspec, high value node, low value node, supports color? }
	{ S("Solid Nodes"), "perlin_explorer:node", "perlin_explorer:node_low", true },
	{ S("Grid Nodes"), "perlin_explorer:grid", "perlin_explorer:grid_low", true },
	{ S("Minibox Nodes"), "perlin_explorer:mini", "perlin_explorer:mini_low", true },
}

-- Analyze the given noiseparams for interesting properties.
-- Returns: <min>, <max>, <waves>, <bad_wavelength>
-- min = minimum possible value
-- max = maximum possible value
-- waves = table with x/y/z indices, each containing a list of effective "wavelengths" for each of the axes
-- bad_wavelength = true if any wavelength is lower than 1
local analyze_noiseparams = function(noiseparams)
	local np = noiseparams

	local flags = parse_flags_string(noiseparams.flags)
	local is_absolute = flags.absvalue == true
	-- Calculate min. and max. possible values
	-- Octaves
	local o_min, o_max = 0, 0
	for o=1, np.octaves do
		local exp = o-1
		-- Calculate the two possible extreme values
		-- with the octave value being either at 1 or -1.
		local limit1 = (1 * np.persistence ^ exp)
		local limit2
		if not is_absolute then
			limit2 = (-1 * np.persistence ^ exp)
		else
			-- If absvalue is set, one of the
			-- limits is always 0 because we
			-- can't get lower.
			limit2 = 0
		end

		-- To add to the maximum, pick the higher value
		if limit1 > limit2 then
			o_max = o_max + limit1
		else
			o_max = o_max + limit2
		end

		-- To add to the minimum, pick the LOWER value
		if limit1 > limit2 then
			o_min = o_min + limit2
		else
			o_min = o_min + limit1
		end
	end
	-- Add offset and scale to min/max value (final step)
	local min_value = np.offset + np.scale * o_min
	local max_value = np.offset + np.scale * o_max

	-- Bring the 2 values in the correct order
	-- (min_value might be bigger for negative scale)
	if min_value > max_value then
		min_value, max_value = max_value, min_value
	end

	local bad_wavelength = false
	-- Calculate "wavelengths"
	local axes = { "x", "y", "z" }
	local waves = {}
	for a=1, #axes do
		local w = axes[a]
		waves[w] = {}
		local wave = np.spread[w]
		for o=1, np.octaves do
			if wave < 1 then
				bad_wavelength = true
			end
			table.insert(waves[w], wave)
			wave = wave * (1 / np.lacunarity)
		end
	end
	return min_value, max_value, waves, bad_wavelength
end

-- Add stone node to nodetypes, if present
minetest.register_on_mods_loaded(function()
	local stone = minetest.registered_aliases["mapgen_stone"]
	if stone then
		local desc = minetest.registered_nodes[stone].description
		if not desc then
			desc = stone
		end
		table.insert(nodetypes, { desc, stone, "air", false})
	end
end)

-----------
-- Nodes --
-----------

-- Add a bunch of nodes to generate a map based on a perlin noise.
-- Used for visualization.
-- Each nodes comes in a "high" and "low" variant.
-- high/low means it represents high/low noise values.
local paramtype2, palette
if COLORIZE_NODES then
	paramtype2 = "color"
end
if grayscale_colors then
	palette = "perlin_explorer_node_palette_gray.png"
	palette_low = "perlin_explorer_node_palette_gray_low.png"
else
	palette = "perlin_explorer_node_palette.png"
	palette_low = "perlin_explorer_node_palette_low.png"
end

-- Solid nodes: Visible, walkable, opaque
minetest.register_node("perlin_explorer:node", {
	description = S("Solid Perlin Test Node (High Value)"),
	paramtype = "light",
	-- Intentionally does not cast shadow so that
	-- cave structures are always fullbright when
	-- the sun shines.
	sunlight_propagates = true,
	paramtype2 = paramtype2,
	tiles = {"perlin_explorer_node.png"},
	palette = palette,
	groups = { dig_immediate = 3 },
	-- Force-drop without metadata to avoid spamming the inventory
	drop = "perlin_explorer:node",
})
minetest.register_node("perlin_explorer:node_low", {
	description = S("Solid Perlin Test Node (Low Value)"),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = paramtype2,
	tiles = {"perlin_explorer_node_low.png"},
	palette = palette_low,
	groups = { dig_immediate = 3 },
	-- Force-drop without metadata to avoid spamming the inventory
	drop = "perlin_explorer:node_low",
})

-- Grid nodes: See-through, walkable. Looks like glass.
-- Useful to see "inside" of 3D blobs.
minetest.register_node("perlin_explorer:grid", {
	description = S("Grid Perlin Test Node (High Value)"),
	paramtype = "light",
	drawtype = "allfaces",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	paramtype2 = paramtype2,
	tiles = {"perlin_explorer_grid.png"},
	palette = "perlin_explorer_node_palette.png",
	palette = palette,
	groups = { dig_immediate = 3 },
	drop = "perlin_explorer:grid",
})
minetest.register_node("perlin_explorer:grid_low", {
	description = S("Grid Perlin Test Node (Low Value)"),
	paramtype = "light",
	drawtype = "allfaces",
	sunlight_propagates = true,
	paramtype2 = paramtype2,
	tiles = {"perlin_explorer_grid_low.png"},
	use_texture_alpha = "clip",
	palette = palette_low,
	groups = { dig_immediate = 3 },
	drop = "perlin_explorer:grid_low",
})

-- Minibox nodes: See-through, non-walkable, climbable.
-- Looks like dot clouds in large numbers.
-- Useful to see and move "inside" of 3D blobs.
minetest.register_node("perlin_explorer:mini", {
	description = S("Minibox Perlin Test Node (High Value)"),
	paramtype = "light",
	drawtype = "nodebox",
	climbable = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = { -2/16, -2/16, -2/16, 2/16, 2/16, 2/16 },
	},
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	paramtype2 = paramtype2,
	tiles = {"perlin_explorer_mini.png"},
	palette = palette,
	groups = { dig_immediate = 3 },
	drop = "perlin_explorer:mini",
})
minetest.register_node("perlin_explorer:mini_low", {
	description = S("Minibox Perlin Test Node (Low Value)"),
	paramtype = "light",
	drawtype = "nodebox",
	climbable = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = { -2/16, -2/16, -2/16, 2/16, 2/16, 2/16 },
	},
	sunlight_propagates = true,
	paramtype2 = paramtype2,
	tiles = {"perlin_explorer_mini_low.png"},
	use_texture_alpha = "clip",
	palette = palette_low,
	groups = { dig_immediate = 3 },
	drop = "perlin_explorer:mini_low",
})

-- Helper function for the getter tool. Gets a noise value at pos
-- and print is in user's chat.
-- * pos: Position to get
-- * user: Player object
-- * precision: Coordinate precision of output (for minetest.pos_to_string)
-- * ptype: One of ...
--          "node": Get value at node position
--          "player": Get value at player position
local print_value = function(pos, user, precision, ptype)
	local val
	local getpos = sidelen_pos(pos, current_options.sidelen)
	if current_options.dimensions == 2 then
		val = current_perlin.noise:get_2d({x=getpos.x, y=getpos.z})
	elseif current_options.dimensions == 3 then
		val = current_perlin.noise:get_3d(getpos)
	else
		error("[perlin_explorer] Unknown/invalid number of Perlin noise dimensions!")
		return
	end
	local msg
	local color_node = minetest.get_color_escape_sequence("#FFD47CFF")
	local color_player = minetest.get_color_escape_sequence("#87FF87FF")
	local color_end = minetest.get_color_escape_sequence("#FFFFFFFF")
	if ptype == "node" then
		msg = S("Value at @1node@2 pos @3: @4", color_node, color_end, minetest.pos_to_string(pos, precision), val)
	elseif ptype == "player" then
		msg = S("Value at @1player@2 pos @3: @4", color_player, color_end, minetest.pos_to_string(pos, precision), val)
	else
		error("[perlin_explorer] Invalid ptype in print_value()!")
	end
	minetest.chat_send_player(user:get_player_name(), msg)
end

-- Get Perlin value of player pos (on_use callback)
local use_getter = function(itemstack, user, pointed_thing)
	if not user then
		return
	end
	local privs = minetest.get_player_privs(user:get_player_name())
	if not privs.server then
		minetest.chat_send_player(user:get_player_name(), S("Insufficient privileges! You need the @1 privilege to use this tool.", "server"))
		return
	end
	if current_perlin.noise then
		local pos = user:get_pos()
		local ctrl = user:get_player_control()
		local precision = 1
		if not ctrl.sneak then
			pos = vector.round(pos)
			precision = 0
		end
		print_value(pos, user, precision, "player")
	else
		local msg = S("No active Perlin noise set. Set one first!")
		minetest.chat_send_player(user:get_player_name(), msg)
	end
end

-- Get Perlin value of pointed node (on_place callback)
local place_getter = function(itemstack, user, pointed_thing)
	if not user then
		return
	end
	local privs = minetest.get_player_privs(user:get_player_name())
	if not privs.server then
		minetest.chat_send_player(user:get_player_name(), S("Insufficient privileges! You need the @1 privilege to use this tool.", "server"))
		return
	end
	if current_perlin.noise then
		if pointed_thing.type ~= "node" then
			-- No-op for non-nodes
			return
		end
		local pos = pointed_thing.under
		print_value(pos, user, 0, "node")
	else
		local msg = S("No active Perlin noise set. Set one first!")
		minetest.chat_send_player(user:get_player_name(), msg)
	end
end

-- Gets perlin noise value
minetest.register_tool("perlin_explorer:getter", {
	description = S("Perlin Value Getter"),
	_tt_help = S("Place: Display Perlin noise value of the pointed node position").."\n"..
		S("Punch: Display Perlin noise value of player position (+Sneak: precise position)"),
	inventory_image = "perlin_explorer_getter.png",
	wield_image = "perlin_explorer_getter.png",
	groups = { disable_repair = 1 },
	on_use = use_getter,
	on_place = place_getter,
})

--[[ Calculate the Perlin noise value and optionally generate nodes.
* pos: Bottom front left position of where Perlin noise begins
* noise: Perlin noise object to use
* noiseparams: noise parameters table
* options: see at create_perlin function
* stats_mode: if true, will only calculate values for statistics but not place any nodes
Returns: a stats table of the form
{
	min,	-- minimum calculated noise value
	max,	-- maximum calculated noise value
	avg,    -- average calculated noise value
	value_count, -- number of values that were calculated
	histogram, -- histogram data for the stats screen. A list
		-- of "buckets", starting with the lower bounds:
		{
			[1] = <number of values in 1st bucket>,
			[2] = <number of values in 2nd bucket>,
			-- ... etc. ...
			[HISTOGRAM_BUCKETS] = <number of values in last bucket>,
		}
	histogram_points, -- List of cutoff points for each of the
			-- data buckets
	start_pos, -- lower corner of the area that the stats were calculated for
	end_pos, -- upper corner of the area that the stats were calculated for
}
Returns nil on error.
]]
local calculate_noise = function(pos, noise, noiseparams, options, stats_mode)
	-- Init
	local stats
	if not noise then
		return
	end
	local time1 = minetest.get_us_time()

	local size_v = {
		x = options.size,
		y = options.size,
		z = options.size,
	}

	local startpos = pos
	local endpos = vector.add(startpos, options.size-1)

	local y_max = endpos.y - startpos.y
	if options.dimensions == 2 then
		-- We don't need 3rd axis in 2D
		y_max = 0
		startpos.y = pos.y
		endpos.y = pos.y
		size_v.z = nil
	end

	local vmanip, emin, emax, vdata, vdata2, varea
	local content_test_node, content_test_node_low, node_needs_color
	if not stats_mode then
		-- Only needed when we want to place nodes
		vmanip = VoxelManip(startpos, endpos)
		emin, emax = vmanip:get_emerged_area()
		vdata = vmanip:get_data()
		vdata2 = vmanip:get_param2_data()
		varea = VoxelArea:new({MinEdge = emin, MaxEdge = emax})

		content_test_node = minetest.get_content_id(nodetypes[options.nodetype][2])
		content_test_node_low = minetest.get_content_id(nodetypes[options.nodetype][3])
		node_needs_color = nodetypes[options.nodetype][4]
	end

	-- Init stats
	stats = {}
	stats.avg = 0
	local sum_of_values = 0
	stats.value_count = 0

	stats.histogram = {}
	local min_possible, max_possible = analyze_noiseparams(noiseparams)
	local cutoff_points = {}
	-- Calculate the cutoff points for the histogram so we know in which data bucket
	-- to put each value into.
	for d=1,HISTOGRAM_BUCKETS do
		cutoff_points[d] = min_possible + ((max_possible-min_possible) / HISTOGRAM_BUCKETS) * d
		stats.histogram[d] = 0
	end

	local perlin_map
	if not stats_mode then
		-- Initialize Perlin map
		-- The noise values will come from this (unless in Stats Mode)
		local perlin_map_object = PerlinNoiseMap(noiseparams, size_v)
		if options.dimensions == 2 then
			perlin_map = perlin_map_object:get_2d_map({x=startpos.x, y=startpos.z})
		else
			perlin_map = perlin_map_object:get_3d_map(startpos)
		end
	end

	local x_max, z_max
	if stats_mode then
		x_max = STATISTICS_ITERATIONS - 1
		y_max = 0
		z_max = 0
	else
		x_max = endpos.x - startpos.x
		z_max = endpos.z - startpos.z
	end

	-- Main loop (time-critical!)
	for x=0, x_max do
	for y=0, y_max do
	for z=0, z_max do
		-- Note: This loop has been optimized for speed, so the code
		-- might not look pretty.
		-- Be careful of the performance implications when touching this
		-- loop

		-- Get Perlin value at current pos
		local abspos
		if not stats_mode then
			abspos = {
				x = startpos.x + x,
				y = startpos.y + y,
				z = startpos.z + z,
			}
		elseif stats_mode then
			abspos = {
				x = math.random(startpos.x, startpos.x+options.size),
				y = math.random(startpos.y, startpos.y+options.size),
				z = math.random(startpos.z, startpos.z+options.size),
			}
		end
		-- Apply sidelen transformation (pixelize)
		local abspos_get = sidelen_pos(abspos, options.sidelen)
		local indexpos = {
			x = abspos_get.x - startpos.x + 1,
			y = abspos_get.y - startpos.y + 1,
			z = abspos_get.z - startpos.z + 1,
		}

		-- Finally get the noise value
		local perlin_value
		if options.dimensions == 2 then
			if stats_mode or (indexpos.x < 1 or indexpos.z < 1) then
				-- The pixelization can move indexpos below 1, in this case
				-- we get the perlin value directly because it is outside
				-- the precalculated map. Performance impact is hopefully
				-- not too bad because this will only occur at the low
				-- edges.
				-- Ideally, for cleaner code, the precalculated map would
				-- take this into account as well but this has not
				-- been done yet.
				-- In stats mode, we always calculate the noise value directy
				-- because the values are spread out.
				perlin_value = noise:get_2d({x=abspos_get.x, y=abspos_get.z})
			else
				-- Normal case: Get value from perlin map
				perlin_value = perlin_map[indexpos.z][indexpos.x]
			end
		elseif options.dimensions == 3 then
			if stats_mode or (indexpos.x < 1 or indexpos.y < 1 or indexpos.z < 1) then
				-- See above
				perlin_value = noise:get_3d(abspos_get)
			else
				-- See above
				perlin_value = perlin_map[indexpos.z][indexpos.y][indexpos.x]
			end
		else
			error("[perlin_explorer] Unknown/invalid number of Perlin noise dimensions!")
			return
		end

		-- Statistics
		if not stats.min then
			stats.min = perlin_value
		elseif perlin_value < stats.min then
			stats.min = perlin_value
		end
		if not stats.max then
			stats.max = perlin_value
		elseif perlin_value > stats.max then
			stats.max = perlin_value
		end
		-- Histogram
		for c=1, HISTOGRAM_BUCKETS do
			if perlin_value < cutoff_points[c] or c >= HISTOGRAM_BUCKETS then
				stats.histogram[c] = stats.histogram[c] + 1
				break
			end
		end
		-- More stats
		sum_of_values = sum_of_values + perlin_value
		stats.value_count = stats.value_count + 1

		-- This section will set the node
		if not stats_mode then
			-- Calculate color (param2) for node
			local zeropoint = options.mid_color
			local min_size = zeropoint - options.min_color
			local max_size = options.max_color - zeropoint
			local node_param2 = 0
			if node_needs_color then
				if perlin_value >= zeropoint then
					node_param2 = ((perlin_value - zeropoint) / max_size) * 255
				else
					node_param2 = ((zeropoint - perlin_value) / min_size) * 255
				end
				node_param2 = math.floor(math.abs(node_param2))
				node_param2 = math.max(0, math.min(255, node_param2))
				if node_param2 < 255 then
					node_param2 = node_param2 - (node_param2 % color_precision)
				end
			end

			-- Get vmanip index
			local index = varea:indexp(abspos)
			if not index then
				return
			end

			-- Set node and param2 in vmanip
			if perlin_value >= zeropoint then
				if options.buildmode == BUILDMODE_ALL or options.buildmode == BUILDMODE_HIGH_ONLY or options.buildmode == BUILDMODE_AUTO then
					vdata[index] = content_test_node
					vdata2[index] = node_param2
				else
					vdata[index] = minetest.CONTENT_AIR
					vdata2[index] = 0
				end
			else
				if options.buildmode == BUILDMODE_ALL or options.buildmode == BUILDMODE_LOW_ONLY or (options.buildmode == BUILDMODE_AUTO and options.dimensions == 2) then
					vdata[index] = content_test_node_low
					vdata2[index] = node_param2
				else
					vdata[index] = minetest.CONTENT_AIR
					vdata2[index] = 0
				end
			end
		end
	end
	end
	end
	-- Final stats
	stats.avg = sum_of_values / stats.value_count
	stats.histogram_points = cutoff_points
	stats.start_pos = vector.new(startpos.x, startpos.y, startpos.z)
	stats.end_pos = vector.add(stats.start_pos, vector.new(options.size, options.size, options.size))

	if not stats_mode then
		-- Write all the changes to map
		vmanip:set_data(vdata)
		vmanip:set_param2_data(vdata2)
		vmanip:write_to_map()
	end

	local time2 = minetest.get_us_time()
	local timediff = time2 - time1
	minetest.log("verbose", "[perlin_explorer] Noisechunk calculated/generated in "..timediff.." µs")

	return stats
end

-- Initiates Perlin noise calculation and optionally node generation, too.
-- * pos: Where the Perlin noise starts
-- * noise: Perlin noise object
-- * noiseparams: noise parameters table
-- * options: table with:
-- 	* dimensions: number of Perlin noise dimensions (2 or 3)
-- 	* size: side length of area/volume to calculate)
-- 	* sidelen: pixelization
-- * stats_mode: if true, will only calculate values for statistics but not place any nodes
local create_perlin = function(pos, noise, noiseparams, options, stats_mode)
	if not noise then
		return false
	end
	local local_options = table.copy(options)
	local cpos = table.copy(pos)
	local mpos = vector.round(cpos)

	local stats = calculate_noise(mpos, noise, noiseparams, local_options, stats_mode)

	if mapgen_star and not stats_mode then
		-- Show a particle in the center of the newly generated area
		local center = vector.new()
		center.x = mpos.x + options.size/2
		if options.dimensions == 2 then
			center.y = mpos.y + 3
		else
			center.y = mpos.y + options.size/2
		end
		center.z = mpos.z + options.size/2
		minetest.add_particle({
			pos = center,
			expirationtime = 4,
			size = 16,
			texture = "perlin_explorer_new_noisechunk.png",
			glow = minetest.LIGHT_MAX,
		})
	end

	if stats then
		minetest.log("info", "[perlin_explorer] Perlin noise generated at %s! Stats: min. value=%.3f, max. value=%.3f, avg. value=%.3f", minetest.pos_to_string(mpos), stats.min, stats.max, stats.avg)
		return S("Perlin noise generated at @1!", minetest.pos_to_string(mpos)), stats
	else
		minetest.log("error", "[perlin_explorer] Could not get stats!")
		return false
	end
end

-- Seeder tool helper function.
-- * player: Player object
-- * regen: If true, force map section to regenerate (if autogen is off)
local seeder_reseed = function(player, regen)
	local msg
	if regen and (not current_options.autogen and current_options.pos) then
		msg = S("New random seed set, starting to regenerate nodes …")
		minetest.chat_send_player(player:get_player_name(), msg)
		msg = create_perlin(current_options.pos, current_perlin.noise, current_perlin.noiseparams, current_options, false)
		if msg ~= false then
			minetest.chat_send_player(player:get_player_name(), msg)
		end
	else
		msg = S("New random seed set!")
		minetest.chat_send_player(player:get_player_name(), msg)
	end
end

-- Generates a function for the seeder tool callbacks, for the
-- on_use, on_secondary_use, on_place callbacks of that tool.
-- * reseed : If true, force map section to regenerate (if autogen is off)
local function seeder_use(reseed)
	return function(itemstack, user, pointed_thing)
		if not user then
			return
		end
		local privs = minetest.get_player_privs(user:get_player_name())
		if not privs.server then
			minetest.chat_send_player(user:get_player_name(), S("Insufficient privileges! You need the @1 privilege to use this tool.", "server"))
			return
		end
		if current_perlin.noise then
			local noiseparams = table.copy(current_perlin.noiseparams)
			noiseparams.seed = math.random(0, 2^32-1)
			set_perlin_noise(noiseparams)
			loaded_areas = {}
			seeder_reseed(user, reseed)
		else
			local msg = S("No active Perlin noise set. Set one first!")
			minetest.chat_send_player(user:get_player_name(), msg)
		end
	end
end

-- Converts a sidelen (=pixelize) value to a valid one
local fix_sidelen = function(sidelen)
	return math.max(1, math.floor(sidelen))
end

-- Fix some errors in the noiseparams
local fix_noiseparams = function(noiseparams)
	noiseparams.octaves = math.floor(math.max(1, noiseparams.octaves))
	noiseparams.lacunarity = math.max(1.0, noiseparams.lacunarity)
	noiseparams.spread.x = math.floor(math.max(1, noiseparams.spread.x))
	noiseparams.spread.y = math.floor(math.max(1, noiseparams.spread.y))
	noiseparams.spread.z = math.floor(math.max(1, noiseparams.spread.z))
	return noiseparams
end

-- Tool to set new random seed of the noiseparams
minetest.register_tool("perlin_explorer:seeder", {
	description = S("Random Perlin seed setter"),
	_tt_help = S("Punch: Set a random seed for the active Perlin noise parameters").."\n"..
		S("Place: Set a random seed and regenerate nodes (if applicable)"),
	inventory_image = "perlin_explorer_seeder.png",
	wield_image = "perlin_explorer_seeder.png",
	groups = { disable_repair = 1 },
	on_use = seeder_use(false),
	on_secondary_use = seeder_use(true),
	on_place = seeder_use(true),
})

-------------------
-- Chat commands --
-------------------
minetest.register_chatcommand("perlin_set_options", {
	privs = { server = true },
	description = S("Set Perlin map generation options"),
	params = S("<dimensions> <pixelize> <midpoint> <low_color> <high_color> [<node_type> <build_mode>]"),
	func = function(name, param)
		local dimensions, sidelen, mid, min, max, nodetype, buildmode = string.match(param, "([23]) ([0-9]+) ([0-9.-]+) ([0-9.-]+) ([0-9.-]+) ([0-9]) ([0-9])")
		if not dimensions then
			dimensions, sidelen, mid, min, max = string.match(param, "([0-9]+) ([0-9]+) ([0-9.-]+) ([0-9.-]+) ([0-9.-]+)")
			if not dimensions then
				return false
			end
		end
		dimensions = tonumber(dimensions)
		sidelen = tonumber(sidelen)
		min = tonumber(min)
		mid = tonumber(mid)
		max = tonumber(max)
		nodetype = tonumber(nodetype)
		buildmode = tonumber(buildmode)
		if not dimensions or not sidelen or not min or not mid or not max then
			return false, S("Invalid parameter type! (only numbers are allowed)")
		end
		dimensions = math.floor(dimensions)
		if dimensions ~= 2 and dimensions ~= 3 then
			return false, S("Invalid dimensions! (must be 2 or 3)")
		end

		-- Update current options
		if nodetype and buildmode then
			-- Check nodetype and buildmode
			nodetype = math.floor(nodetype)
			buildmode = math.floor(buildmode)
			if not nodetypes[nodetype] then
				return false, S("Invalid node type! (must be between 1 and @1)", #nodetypes)
			end
			if buildmode < 1 or buildmode > BUILDMODES_COUNT then
				return false, S("Invalid build mode! (must be between 1 and @1)", BUILDMODES_COUNT)
			end
			current_options.nodetype = nodetype
			current_options.buildmode = buildmode
		end
		current_options.dimensions = dimensions
		current_options.sidelen = fix_sidelen(sidelen)
		current_options.min_color = min
		current_options.mid_color = mid
		current_options.max_color = max

		-- Force mapgen to update
		loaded_areas = {}

		return true, S("Perlin map generation options set!")
	end,
})

minetest.register_chatcommand("perlin_set_noise", {
	privs = { server = true },
	description = S("Set active Perlin noise parameters"),
	params = S("<offset> <scale> <seed> <spread_x> <spread_y> <spread_z> <octaves> <persistence> <lacunarity> [<flags>]"),
	func = function(name, param)
		local offset, scale, seed, sx, sy, sz, octaves, persistence, lacunarity, flags = string.match(param, string.rep("([0-9.-]+) ", 9) .. "([a-zA-Z, ]+)")
		if not offset then
			offset, scale, seed, sx, sy, sz, octaves, persistence, lacunarity = string.match(param, string.rep("([0-9.-]+) ", 8) .. "([0-9.-]+)")
			if not offset then
				return false
			end
		end
		if not flags then
			flags = ""
		end
		octaves = tonumber(octaves)
		offset = tonumber(offset)
		sx = tonumber(sx)
		sy = tonumber(sy)
		sz = tonumber(sz)
		persistence = tonumber(persistence)
		lacunarity = tonumber(lacunarity)
		seed = tonumber(seed)
		if not octaves or not offset or not sx or not sy or not sz or not persistence or not lacunarity or not seed then
			return false, S("Invalid parameter type.")
		end
		local noiseparams = {
			octaves = octaves,
			offset = offset,
			scale = scale,
			spread = { x = sx, y = sy, z = sz },
			persistence = persistence,
			lacunarity = lacunarity,
			seed = seed,
			flags = flags,
		}
		noiseparams = fix_noiseparams(noiseparams)
		local _, _, _, badwaves = analyze_noiseparams(noiseparams)
		if badwaves then
			return false, TEXT_ERROR_BAD_WAVELENGTH
		end
		set_perlin_noise(noiseparams)
		loaded_areas = {}
		return true, S("Active Perlin noise parameters set!")
	end,
})

minetest.register_chatcommand("perlin_generate", {
	privs = { server = true },
	description = S("Generate active Perlin noise"),
	params = S("<pos> <size>"),
	func = function(name, param)
		local x, y, z, size = string.match(param, "([0-9.-]+) ([0-9.-]+) ([0-9.-]+) ([0-9]+)")
		if not x then
			return false
		end
		x = tonumber(x)
		y = tonumber(y)
		z = tonumber(z)
		size = tonumber(size)
		if not x or not y or not z or not size then
			return false
		end
		if not x or not y or not z or not size then
			return false, S("Invalid parameter type.")
		end
		local pos = vector.new(x, y, z)

		minetest.chat_send_player(name, S("Creating Perlin noise, please wait …"))
		local opts = table.copy(current_options)
		opts.size = size
		local msg = create_perlin(pos, current_perlin.noise, current_perlin.noiseparams, opts, false)
		if msg == false then
			return false, S("No active Perlin noise set. Set one first!")
		end
		return true, msg
	end,
})

minetest.register_chatcommand("perlin_toggle_mapgen", {
	privs = { server = true },
	description = S("Toggle the automatic Perlin noise map generator"),
	params = "",
	func = function(name, param)
		if not current_perlin.noise then
			return false, S("No active Perlin noise set. Set one first!")
		end
		current_options.autogen = not current_options.autogen
		if current_options.autogen then
			loaded_areas = {}
		end
		minetest.log("action", "[perlin_explorer] Autogen state is now: "..tostring(current_options.autogen))
		local msg
		if current_options.autogen then
			msg = S("Mapgen enabled!")
		else
			msg = S("Mapgen disabled!")
		end
		return true, msg
	end,
})

-- Show an error window to player with the given message.
-- Set analyze_button to true to add a button "Analyze now"
-- to open the analyze window.
local show_error_formspec = function(player, message, analyze_button)
	local buttons
	if analyze_button then
		buttons = "button[1.5,2.5;3,0.75;done;"..F(S("Return")).."]"..
			"button[5.5,2.5;3,0.75;analyze;"..F(S("Analyze now"))
	else
		buttons = "button[3.5,2.5;3,0.75;done;"..F(S("Return")).."]"
	end

	local form = [[
		formspec_version[4]size[10,3.5]
		container[0.25,0.25]
		box[0,0;9.5,2;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;9.5,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.25,0.2;]]..F(S("Error"))..[[]
		container[0.25,0.5]
		textarea[0,0;9,1.4;;]]..F(message)..[[;]
		container_end[]
		container_end[]
		]]..buttons
	minetest.show_formspec(player:get_player_name(), "perlin_explorer:error", form)
end

-- Stats loading screen
local show_histogram_loading_formspec = function(player)
	local form = [[
		formspec_version[4]size[11,2]
		container[0.25,0.25]
		box[0,0;10.5,1.5;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;10.5,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.25,0.2;]]..F(S("Statistical analysis in progress"))..[[]
		container[0.25,0.8]
		label[0,0;]]..F(S("Collecting data, please wait …"))..[[]
		container_end[]
		container_end[]
		]]
	minetest.show_formspec(player:get_player_name(), "perlin_explorer:histogram_loading", form)
end

-- Stats screen
local show_histogram_formspec = function(player, options, stats)
	local txt = ""
	local maxh = 6.0
	local histogram
	histogram = "vertlabel[0.1,0.1;"..F(S("Relative frequency")).."]"..
		"label[1.1,8.15;"..F(S("Noise values")).."]"..
		"label[0,7.0;"..F(S("Max.")).."\n"..F(S("Min.")).."]"..
		"tooltip[0,6.8;0.7,1;"..F(S("Upper bounds (exclusive) and lower bounds (inclusive) of the noise value data bucketing")).."]"..
		"box[0.75,0;0.025,8.5;"..FORMSPEC_HISTOGRAM_LINE_COLOR.."]"..
		"box[0,6.65;"..HISTOGRAM_BUCKETS..",0.025;"..FORMSPEC_HISTOGRAM_LINE_COLOR.."]"..
		"box[0,7.8;"..HISTOGRAM_BUCKETS..",0.025;"..FORMSPEC_HISTOGRAM_LINE_COLOR.."]"
	local hstart = 1
	-- Special case: If bucket sizes are equal, only show the last bucket
	-- (can happen if scale=0)
	if HISTOGRAM_BUCKETS > 1 and stats.histogram_points[1] == stats.histogram_points[2] then
		hstart = HISTOGRAM_BUCKETS
	end
	local max_value = 0
	for h=hstart, HISTOGRAM_BUCKETS do
		local value = stats.histogram[h]
		if value > max_value then
			max_value = value
		end
	end
	-- Drawn histogram bars, tooltips and labels
	for h=hstart, HISTOGRAM_BUCKETS do
		local count = stats.histogram[h]
		local ratio = (stats.histogram[h] / stats.value_count)
		local bar_ratio = (stats.histogram[h] / max_value)
		local perc = ratio * 100
		local perc_f = string.format("%.1f", perc)
		local x = h * 0.9
		local bar_height = math.max(maxh * bar_ratio, 0.001)
		local coords = x..","..maxh-bar_height..";0.8,"..bar_height
		local box = ""
		if count > 0 then
			box = box .. "box["..coords..";"..FORMSPEC_HISTOGRAM_BAR_COLOR.."]"
			box = box .. "tooltip["..coords..";"..count.."]"
		end
		box = box .. "label["..x..",6.4;"..F(S("@1%", perc_f)).."]"
		box = box .. "tooltip["..x..",6.2;0.9,0.3;"..count.."]"

		local min, max, min_v, max_v
		if h <= 1 then
			min = ""
		else
			min = F(string.format("%.1f", stats.histogram_points[h-1]))
		end
		if h >= HISTOGRAM_BUCKETS then
			max = ""
		else
			max = F(string.format("%.1f", stats.histogram_points[h]))
		end

		box = box .. "label["..x..",7.0;"..max.."\n"..min.."]"

		local tt
		if h == 1 then
			tt = F(S("value < @1", stats.histogram_points[h]))
		elseif h == HISTOGRAM_BUCKETS then
			tt = F(S("@1 <= value", stats.histogram_points[h-1]))
		else
			tt = F(S("@1 <= value < @2", stats.histogram_points[h-1], stats.histogram_points[h]))
		end
		box = box .. "tooltip["..x..",6.8;0.9,1;"..tt.."]"

		histogram = histogram .. box
	end
	local vmin, vmax
	if options.dimensions == 2 then
		vmin = S("(@1,@2)", stats.start_pos.x, stats.start_pos.z)
		vmax = S("(@1,@2)", stats.end_pos.x, stats.end_pos.z)
	else
		vmin = S("(@1,@2,@3)", stats.start_pos.x, stats.start_pos.y, stats.start_pos.z)
		vmax = S("(@1,@2,@3)", stats.end_pos.x, stats.end_pos.y, stats.end_pos.z)
	end
	local labels = "textarea[0,0;"..HISTOGRAM_BUCKETS..",2;;;"..
		F(S("Values were picked randomly between noise coordinates @1 and @2.", vmin, vmax)).."\n"..
		F(S("Values calculated: @1", stats.value_count)).."\n"..
		F(S("Minimum calculated value: @1", stats.min)).."\n"..
		F(S("Maximum calculated value: @1", stats.max)).."\n"..
		F(S("Average calculated value: @1", stats.avg)).."]\n"

	local form = [[
		formspec_version[4]size[]]..(HISTOGRAM_BUCKETS+1)..[[,12.5]
		container[0.25,0.25]
		box[0,0;]]..(HISTOGRAM_BUCKETS+0.5)..[[,2.5;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;]]..(HISTOGRAM_BUCKETS+0.5)..[[,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.25,0.2;]]..F(S("Noise Value Statistics"))..[[]
		container[0.25,0.5]
		]]..labels..[[
		container_end[]
		container[0,2.75]
		box[0,0;]]..(HISTOGRAM_BUCKETS+0.5)..[[,9.25;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;]]..(HISTOGRAM_BUCKETS+0.5)..[[,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.25,0.2;]]..F(S("Noise Value Histogram"))..[[]
		container[0.25,0.6]
		]]..histogram..[[
		container_end[]
		container_end[]
		button[7.25,11.35;3,0.5;done;]]..F(S("Done"))..[[]
		container_end[]
		]]
	minetest.show_formspec(player:get_player_name(), "perlin_explorer:histogram", form)
end

-- Analyzes the given noise params and shows the result in a pretty-printed formspec to player
local analyze_noiseparams_and_show_formspec = function(player, noiseparams)
	local min, max, waves = analyze_noiseparams(noiseparams)
	local print_waves = function(waves_a)
		local stringified_waves = {}
		for w=1, #waves_a do
			local strwave
			local is_bad = false
			if minetest.is_nan(waves_a[w]) or waves_a[w] == math.huge or waves_a[w] == -math.huge then
				strwave = minetest.colorize("#FF0000FF", waves_a[w])
			elseif waves_a[w] < 1  then
				strwave = minetest.colorize("#FF0000FF", "0")
			else
				strwave = string.format("%.0f", waves_a[w])
			end
			table.insert(stringified_waves, strwave)
		end
		return table.concat(stringified_waves, ", ")
	end
	local form = [[
		formspec_version[4]size[10,5]
		container[0.25,0.25]
		box[0,0;9.5,3.5;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;9.5,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.25,0.2;]]..F(S("Noise Parameters Analysis"))..[[]

		label[0.25,0.75;]]..F(S("Minimum possible value: @1", min))..[[]
		label[0.25,1.25;]]..F(S("Maximum possible value: @1", max))..[[]

		label[0.25,1.75;]]..F(S("X wavelengths: @1", print_waves(waves.x)))..[[]
		label[0.25,2.25;]]..F(S("Y wavelengths: @1", print_waves(waves.y)))..[[]
		label[0.25,2.75;]]..F(S("Z wavelengths: @1", print_waves(waves.z)))..[[]

		button[3.5,3.75;3,0.75;done;]]..F(S("Done"))..[[]

		container_end[]
	--]]
	minetest.show_formspec(player:get_player_name(), "perlin_explorer:analyze", form)
end

-- Show the formspec of the Perlin Noise Creator tool to player.
-- The main formspec of this mod!
-- * player: Player object
-- * noiseparams: Initialize formspec with these noiseparams (optional)
-- * profile_id: Preselect this profile (by table index of np_profiles)
-- * f_dimensions: Set to force dimensions (optional)
-- * f_sidelen: Set to force sidelen (optional)
local show_noise_formspec = function(player, noiseparams, profile_id, f_dimensions, f_sidelen)
	local player_name = player:get_player_name()
	local np
	if noiseparams then
		np = noiseparams
	else
		np = current_perlin.noiseparams
	end
	if not profile_id then
		profile_id = 1
	end
	local offset = tostring(np.offset or "")
	local scale = tostring(np.scale or "")
	local seed = tostring(np.seed or "")
	local sx, sy, sz = "", "", ""
	if np.spread then
		sx = tostring(np.spread.x or "")
		sy = tostring(np.spread.y or "")
		sz = tostring(np.spread.z or "")
	end
	local octaves = tostring(np.octaves or "")
	local persistence = tostring(np.persistence or "")
	local lacunarity = tostring(np.lacunarity or "")

	local size = tostring(current_options.size or "")
	local buildmode = tostring(current_options.buildmode or 1)

	local sidelen
	if f_sidelen then
		sidelen = tostring(f_sidelen)
	else
		sidelen = tostring(current_options.sidelen or "")
	end
	local dimensions = f_dimensions
	if not dimensions then
		dimensions = current_options.dimensions or 2
	end
	local dimensions_index = dimensions - 1

	local pos_x, pos_y, pos_z = "", "", ""
	if current_options.pos then
		pos_x = tostring(current_options.pos.x or "")
		pos_y = tostring(current_options.pos.y or "")
		pos_z = tostring(current_options.pos.z or "")
	end
	local value_min = tostring(current_options.min_color or "")
	local value_mid = tostring(current_options.mid_color or "")
	local value_max = tostring(current_options.max_color or "")

	local flags = np.flags
	local flags_table = parse_flags_string(flags)
	local flag_defaults = tostring(flags_table.defaults)
	local flag_eased = tostring(flags_table.eased)
	local flag_absvalue = tostring(flags_table.absvalue)
	formspec_states[player_name].default = flags_table.defaults == true
	formspec_states[player_name].absvalue = flags_table.absvalue == true
	formspec_states[player_name].eased = flags_table.eased == true

	local noiseparams_list = {}
	local counter = 1
	for i=1, #np_profiles do
		local npp = np_profiles[i]
		local name = npp.name
		-- Automatic naming for user profiles
		if npp.np_type == "user" then
			name = S("Profile @1", counter)
			counter = counter + 1
		end
		table.insert(noiseparams_list, F(name))
	end
	local noiseparams_list_str = table.concat(noiseparams_list, ",")

	local nodetype_index = (current_options.nodetype)

	local nodetypes_list = {}
	for i=1, #nodetypes do
		table.insert(nodetypes_list, F(nodetypes[i][1]))
	end
	local nodetypes_list_str = table.concat(nodetypes_list, ",")

	local delete_btn = ""
	if #np_profiles > 1 then
		delete_btn = "button[7.25,0;2.0,0.5;delete_np_profile;"..F(S("Delete")).."]"
	end
	local autogen_label
	local create_btn = ""
	local xyzsize = ""
	if current_options.autogen then
		autogen_label = S("Disable mapgen")
	else
		autogen_label = S("Enable mapgen")
		create_btn = "button[3.50,0;3,1;create;"..F(S("Apply and create")).."]"..
			"tooltip[create;"..F(S("Set these noise parameters and noise options as the “active noise” and create nodes at the given X/Y/Z coordinates with the given size")).."]"
		xyzsize = [[
		field[0.25,1.95;1.75,0.75;pos_x;]]..F(S("X"))..[[;]]..pos_x..[[]
		field[2.10,1.95;1.75,0.75;pos_y;]]..F(S("Y"))..[[;]]..pos_y..[[]
		field[3.95,1.95;1.75,0.75;pos_z;]]..F(S("Z"))..[[;]]..pos_z..[[]
		tooltip[pos_x;]]..F(S("Coordinate for “Apply and create”"))..[[]
		tooltip[pos_y;]]..F(S("Coordinate for “Apply and create”"))..[[]
		tooltip[pos_z;]]..F(S("Coordinate for “Apply and create”"))..[[]

		field[5.95,1.95;1.5,0.75;size;]]..F(S("Size"))..[[;]]..size..[[]
		tooltip[size;]]..F(S("Size of area of nodes to generate (as a sidelength), used by “Apply and create”"))..[[]

		field_close_on_enter[pos_x;false]
		field_close_on_enter[pos_y;false]
		field_close_on_enter[pos_z;false]
		field_close_on_enter[size;false]
		]]
	end
	local form = [[
		formspec_version[4]size[10,12.5]
		container[0.25,0.25]
		box[0,0;9.5,5.5;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;9.5,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.15,0.2;]]..F(S("Noise parameters"))..[[]
		container[0.0,0.5]
		dropdown[0.25,0;3,0.5;np_profiles;]]..noiseparams_list_str..[[;]]..profile_id..[[;true]
		button[3.25,0;2.0,0.5;add_np_profile;]]..F(S("Add"))..[[]
		button[5.25,0;2.0,0.5;load_np_profile;]]..F(S("Load"))..[[]
		]]..delete_btn..[[
		container_end[]
		container[0.0,1.5]
		field[0.25,0;2,0.75;offset;]]..F(S("Offset"))..[[;]]..offset..[[]
		field[3.25,0;2,0.75;scale;]]..F(S("Scale"))..[[;]]..scale..[[]
		field[6.25,0;2,0.75;seed;]]..F(S("Seed"))..[[;]]..seed..[[]
		image_button[8.35,0.0;0.75,0.75;perlin_explorer_seeder.png;set_random_seed;]
		field[0.25,1.2;2,0.75;spread_x;]]..F(S("X Spread"))..[[;]]..sx..[[]
		field[3.25,1.2;2,0.75;spread_y;]]..F(S("Y Spread"))..[[;]]..sy..[[]
		field[6.25,1.2;2,0.75;spread_z;]]..F(S("Z Spread"))..[[;]]..sz..[[]
		field[0.25,2.4;2,0.75;octaves;]]..F(S("Octaves"))..[[;]]..octaves..[[]
		field[3.25,2.4;2,0.75;persistence;]]..F(S("Persistence"))..[[;]]..persistence..[[]
		field[6.25,2.4;2,0.75;lacunarity;]]..F(S("Lacunarity"))..[[;]]..lacunarity..[[]
		checkbox[0.25,3.55;defaults;]]..F(S("defaults"))..[[;]]..flag_defaults..[[]
		checkbox[2.25,3.55;eased;]]..F(S("eased"))..[[;]]..flag_eased..[[]
		checkbox[4.25,3.55;absvalue;]]..F(S("absvalue"))..[[;]]..flag_absvalue..[[]
		button[6.25,3.35;2.0,0.5;analyze;]]..F(S("Analyze"))..[[]
		container_end[]

		field_close_on_enter[offset;false]
		field_close_on_enter[scale;false]
		field_close_on_enter[seed;false]
		field_close_on_enter[spread_x;false]
		field_close_on_enter[spread_y;false]
		field_close_on_enter[spread_z;false]
		field_close_on_enter[octaves;false]
		field_close_on_enter[persistence;false]
		field_close_on_enter[lacunarity;false]
		field_close_on_enter[sidelen;false]

		tooltip[set_random_seed;]]..F(S("Random seed"))..[[]
		tooltip[add_np_profile;]]..F(S("Add the current noise parameter as a new profile into the profile list"))..[[]
		tooltip[load_np_profile;]]..F(S("Load the selected profile from the profile list to replace the noise parameters"))..[[]
		tooltip[delete_np_profile;]]..F(S("Delete the selected profile from the profile list (only works for user profiles)"))..[[]
		tooltip[analyze;]]..F(S("Perform some basic mathematical analysis about these noise parameters"))..[[]
		container_end[]


		container[0.25,6.0]
		box[0,0;9.5,1.6;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;9.5,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.15,0.2;]]..F(S("Noise options"))..[[]
		dropdown[0.25,0.7;1,0.75;dimensions;]]..F(S("2D"))..[[,]]..F(S("3D"))..[[;]]..dimensions_index..[[;true]
		field[2.25,0.7;2,0.75;sidelen;]]..F(S("Pixelization"))..[[;]]..sidelen..[[]
		button[6.25,0.7;2.0,0.6;statistics;]]..F(S("Statistics"))..[[]
		tooltip[statistics;]]..F(S("Calculate a large amount of noise values under the current settings and show a statistical analysis of these values"))..[[]
		tooltip[sidelen;]]..F(S("If higher than 1, Perlin values will be repeated along all axes every x nodes, for a ‘pixelized’ effect."))..[[]
		container_end[]


		container[0.25,7.85]
		box[0,0;9.5,2.9;]]..FORMSPEC_BOX_COLOR..[[]
		box[0,0;9.5,0.4;]]..FORMSPEC_HEADER_COLOR..[[]
		label[0.15,0.2;]]..F(S("Node generation"))..[[]
		field[0.25,0.75;1.75,0.75;value_mid;]]..F(S("Midpoint"))..[[;]]..value_mid..[[]
		field[2.10,0.75;1.75,0.75;value_min;]]..F(S("Low color at"))..[[;]]..value_min..[[]
		field[3.95,0.75;1.75,0.75;value_max;]]..F(S("High color at"))..[[;]]..value_max..[[]
		button[5.95,0.75;1.00,0.75;autocolor;]]..F(S("Auto"))..[[]
		dropdown[7.55,0.75;1.9,0.75;nodetype;]]..nodetypes_list_str..[[;]]..nodetype_index..[[;true]
		tooltip[nodetype;]]..F(S("Node type: Specify the type of node that you want to generate here"))..[[]
		]]..xyzsize..[[
		dropdown[7.55,1.95;1.9,0.75;buildmode;]]..F(S("Auto"))..","..F(S("All"))..","..F(S("High only"))..","..F(S("Low only"))..[[;]]..buildmode..[[;true]
		tooltip[buildmode;]]..F(S("Build mode: Specify whether to place nodes for high or low noise values, or all values. Auto = “All” in 2D mode or “Low only” in 3D mode"))..[[]
		tooltip[value_mid;]]..F(S("Noise values equal to or higher than the midpoint are treated as high values, otherwise as low values. Used for node colorization."))..[[]
		tooltip[value_min;]]..F(S("The lowest noise value to be represented by the node color gradient."))..[[]
		tooltip[value_max;]]..F(S("The highest noise value to be represented by the node color gradient."))..[[]
		tooltip[autocolor;]]..F(S("Set the midpoint and low and high color values automatically according to the theoretical noise value boundaries."))..[[]
		field_close_on_enter[value_mid;false]
		field_close_on_enter[value_min;false]
		field_close_on_enter[value_max;false]
		container_end[]


		container[0,10.95]
		button[0.25,0;3.15,1;apply;]]..F(S("Apply"))..[[]
		tooltip[apply;]]..F(S("Set these noise parameters and noise options as the “active noise”")).."]"..
		create_btn..[[
		button[6.60,0;3.15,1;toggle_autogen;]]..F(autogen_label)..[[]
		tooltip[toggle_autogen;]]..F(S("Toggle the automatic map generator"))..[[]
		container_end[]
	]]
	-- Hack to fix Minetest issue (see function comment)
	form = unique_formspec_spaces(player_name, form)
	minetest.show_formspec(player_name, "perlin_explorer:creator", form)
end

-- Formspec handling
minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- Require 'server' priv
	local privs = minetest.get_player_privs(player:get_player_name())
	if not privs.server then
		return
	end

	-- Analysis window
	if formname == "perlin_explorer:analyze" or formname == "perlin_explorer:error" then
		if fields.done then
			local noiseparams = formspec_states[player:get_player_name()].noiseparams
			show_noise_formspec(player, noiseparams)
		elseif fields.analyze then
			local noiseparams = formspec_states[player:get_player_name()].noiseparams
			analyze_noiseparams_and_show_formspec(player, noiseparams)
		end
		return
	end

	-- Histogram window
	if formname == "perlin_explorer:histogram" then
		if fields.done then
			local noiseparams = formspec_states[player:get_player_name()].noiseparams
			local dimensions = formspec_states[player:get_player_name()].dimensions
			local sidelen = formspec_states[player:get_player_name()].sidelen
			show_noise_formspec(player, noiseparams, nil, dimensions, sidelen)
		end
		return
	end

	-- Creator window
	if formname ~= "perlin_explorer:creator" then
		return
	end

	-- Handle checkboxes
	local player_name = player:get_player_name()
	local flags_touched = false
	if fields.defaults == "true" then
		formspec_states[player_name].defaults = true
		return
	elseif fields.defaults == "false" then
		formspec_states[player_name].defaults = false
		return
	end
	if fields.eased == "true" then
		formspec_states[player_name].eased = true
		return
	elseif fields.eased == "false" then
		formspec_states[player_name].eased = false
		return
	end
	if fields.absvalue == "true" then
		formspec_states[player_name].absvalue = true
		return
	elseif fields.absvalue == "false" then
		formspec_states[player_name].absvalue = false
		return
	end

	-- Deleting a profile does not require any other field
	if fields.delete_np_profile then
		if #np_profiles <= 1 then
			return
		end
		local profile_to_delete = tonumber(fields.np_profiles)
		-- Can only delete user profiles
		if np_profiles[profile_to_delete].np_type ~= "user" then
			return
		end
		table.remove(np_profiles, profile_to_delete)
		update_mod_stored_profiles()
		local new_id = math.max(1, profile_to_delete - 1)
		show_noise_formspec(player, default_noiseparams, new_id)
		return
	end
	-- Handle other fields
	local enter_pressed = fields.key_enter_field ~= nil
	local do_apply = fields.apply ~= nil or fields.toggle_autogen ~= nil
	local do_create = fields.create ~= nil
	if current_options.autogen then
		do_apply = do_apply or enter_pressed
	else
		do_create = do_create or enter_pressed
	end
	local do_analyze = fields.analyze ~= nil
	if (do_create or do_apply or do_analyze or fields.add_np_profile or fields.np_profiles) then
		if fields.offset and fields.scale and fields.seed and fields.spread_x and fields.spread_y and fields.spread_z and fields.octaves and fields.persistence and fields.lacunarity then

			local offset = tonumber(fields.offset)
			local scale = tonumber(fields.scale)
			local seed = tonumber(fields.seed)
			local sx = tonumber(fields.spread_x)
			local sy = tonumber(fields.spread_y)
			local sz = tonumber(fields.spread_z)
			if not sx or not sy or not sz then
				return
			end
			local spread = vector.new(sx, sy, sz)
			local octaves = tonumber(fields.octaves)
			local persistence = tonumber(fields.persistence)
			local lacunarity = tonumber(fields.lacunarity)
			local dimensions = tonumber(fields.dimensions)
			local sidelen = tonumber(fields.sidelen)
			local px = tonumber(fields.pos_x)
			local py = tonumber(fields.pos_y)
			local pz = tonumber(fields.pos_z)
			local size = tonumber(fields.size)
			local value_min = tonumber(fields.value_min)
			local value_mid = tonumber(fields.value_mid)
			local value_max = tonumber(fields.value_max)
			local nodetype = tonumber(fields.nodetype)
			local buildmode = tonumber(fields.buildmode)
			if (offset and scale and spread and octaves and persistence) then
				local defaults = formspec_states[player_name].defaults
				local eased = formspec_states[player_name].eased
				local absvalue = formspec_states[player_name].absvalue
				local noiseparams = {
					offset = offset,
					scale = scale,
					seed = seed,
					spread = spread,
					octaves = octaves,
					persistence = persistence,
					lacunarity = lacunarity,
					flags = build_flags_string(defaults, eased, absvalue),
				}
				noiseparams = fix_noiseparams(noiseparams)
				-- Open analyze window
				if do_analyze then
					formspec_states[player_name].noiseparams = noiseparams
					analyze_noiseparams_and_show_formspec(player, noiseparams)
					return
				-- Change NP profile selection
				elseif fields.load_np_profile and fields.np_profiles then
					local profile = tonumber(fields.np_profiles)
					local loaded_np
					if np_profiles[profile].np_type == "active" then
						-- The "active" profile is a special profile
						-- that reads from the active noiseparams.
						loaded_np = current_perlin.noiseparams
					else
						-- Normal case: Read noiseparams from profile itself.
						loaded_np = np_profiles[profile].noiseparams
					end
					-- Load new profile
					show_noise_formspec(player, loaded_np, profile)
					minetest.log("action", "[perlin_explorer] Loaded perlin noise profile "..profile)
					return
				-- Add new profile and save current noiseparams to it
				elseif fields.add_np_profile then
					table.insert(np_profiles, {
						np_type = "user",
						noiseparams = noiseparams,
					})
					update_mod_stored_profiles()
					local new_profile = #np_profiles
					minetest.log("action", "[perlin_explorer] Perlin noise profile "..new_profile.." added!")
					show_noise_formspec(player, noiseparams, new_profile)
					return
				elseif fields.set_random_seed then
					-- Randomize seed
					local profile = tonumber(fields.np_profiles)
					noiseparams.seed = math.random(0, 2^32-1)
					show_noise_formspec(player, noiseparams, profile)
					return
				elseif fields.autocolor then
					-- Set color fields automatically
					local min, max = analyze_noiseparams(noiseparams)
					current_options.min_color = min
					current_options.max_color = max
					current_options.mid_color = min + ((max - min) / 2)
					local profile = tonumber(fields.np_profiles)
					show_noise_formspec(player, noiseparams, profile)
					return
				end

				if not (dimensions and sidelen and value_min and value_mid and value_max and nodetype and buildmode) then
					return
				end
				-- Convert dropdown index to actual dimensions number
				dimensions = dimensions + 1
				-- Spread is used differently in 2D
				if dimensions == 2 then
					spread.y = spread.z
				end
				local _, _, _, badwaves = analyze_noiseparams(noiseparams)
				if badwaves then
					formspec_states[player_name].noiseparams = noiseparams
					show_error_formspec(player, TEXT_ERROR_BAD_WAVELENGTH, true)
					return
				end

				-- Start statistics calculation
				if fields.statistics then
					formspec_states[player_name].noiseparams = noiseparams
					formspec_states[player_name].dimensions = dimensions
					formspec_states[player_name].sidelen = sidelen
					local max_spread = 0
					max_spread = math.max(max_spread, noiseparams.spread.x)
					max_spread = math.max(max_spread, noiseparams.spread.y)
					max_spread = math.max(max_spread, noiseparams.spread.z)
					local ssize = max_spread * STATISTICS_SPREAD_FACTOR
					-- A very large size is not allowed because the Minetest functions start to fail and would start to distort the statistics.
					if ssize > STATISTICS_MAX_SIZE or max_spread > STATISTICS_MAX_SPREAD then
						show_error_formspec(player, S("Sorry, but Perlin Explorer doesn’t support calculating statistics if the spread of any axis is larger than @1.", STATISTICS_MAX_SPREAD), false)
						return
					end
					-- Enforce a minimum size as well to at least 1 million values are in the area
					if dimensions == 2 and ssize < 1000 then
						ssize = 1000
					elseif dimensions == 3 and ssize < 100 then
						ssize = 100
					end
					local start = -math.floor(ssize/2)

					local pos = vector.new(start, start, start)
					local noise = PerlinNoise(noiseparams)
					local options = {
						dimensions = dimensions,
						size = ssize,
						sidelen = sidelen,
					}
					-- Show a loading formspec
					show_histogram_loading_formspec(player)
					-- This takes long
					local _, stats = create_perlin(pos, noise, noiseparams, options, true)
					if stats then
						-- Update the formspec to show the result
						show_histogram_formspec(player, options, stats)
					else
						minetest.log("error", "[perlin_explorer] Error while creating stats from Perlin noise!")
					end
					return
				end


				set_perlin_noise(noiseparams)
				minetest.log("action", "[perlin_explorer] Perlin noise set!")
				current_options.dimensions = dimensions
				current_options.sidelen = fix_sidelen(sidelen)
				current_options.min_color = value_min
				current_options.mid_color = value_mid
				current_options.max_color = value_max
				current_options.nodetype = nodetype
				current_options.buildmode = buildmode
				if fields.toggle_autogen then
					current_options.autogen = not current_options.autogen
					if current_options.autogen then
						loaded_areas = {}
					end
					local profile = tonumber(fields.np_profiles)
					show_noise_formspec(player, noiseparams, profile)
					minetest.log("action", "[perlin_explorer] Autogen state is now: "..tostring(current_options.autogen))
				elseif do_create then
					if not px or not py or not pz or not size then
						return
					end
					if current_options.autogen then
						loaded_areas = {}
					end
					current_options.size = size
					local place_pos = vector.new(px, py, pz)
					current_options.pos = place_pos
					local msg = S("Creating Perlin noise, please wait …")
					minetest.chat_send_player(player_name, msg)
					msg = create_perlin(place_pos, current_perlin.noise, current_perlin.noiseparams, current_options, false)
					if msg then
						minetest.chat_send_player(player_name, msg)
					elseif msg == false then
						minetest.log("error", "[perlin_explorer] Error generating Perlin noise nodes!")
					end
				elseif do_apply and current_options.autogen then
					loaded_areas = {}
				elseif do_apply and not current_options.autogen then
					if not px or not py or not pz then
						return
					end
					local place_pos = vector.new(px, py, pz)
					current_options.pos = place_pos
				end
			end
		end
	end
end)

-- The main tool of this mod. Opens the Perlin noise creation window.
minetest.register_tool("perlin_explorer:creator", {
	description = S("Perlin Noise Creator"),
	_tt_help = S("Punch to open the Perlin noise creation menu"),
	inventory_image = "perlin_explorer_creator.png",
	wield_image = "perlin_explorer_creator.png",
	groups = { disable_repair = 1 },
	on_use = function(itemstack, user, pointed_thing)
		if not user then
			return
		end
		local privs = minetest.get_player_privs(user:get_player_name())
		if not privs.server then
			minetest.chat_send_player(user:get_player_name(), S("Insufficient privileges! You need the @1 privilege to use this tool.", "server"))
			return
		end
		show_noise_formspec(user)
	end,
})

-- Automatic map generation (autogen).
-- The autogen is kind of a mapgen, but it doesn't use Minetest's
-- mapgen, instead it writes directly to map. The benefit is
-- that this will instantly update when the active noiseparams
-- are changed.
-- This will generate so-called noisechunks, which are like
-- Minetest mapchunks, except with respect to this mod only.
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < AUTOBUILD_UPDATE_TIME then
		return
	end
	timer = 0
	if current_perlin.noise and current_options.autogen then
	local players = minetest.get_connected_players()
	-- Generate close to all connected players
	for p=1, #players do
		local player = players[p]
		local player_name = player:get_player_name()
		-- Helper function for building
		local build = function(pos, pos_hash, player_name)
			if not pos or not pos.x or not pos.y or not pos.z then
				minetest.log("error", "[perlin_explorer] build(): Invalid pos!")
				return
			end
			if not pos_hash then
				minetest.log("error", "[perlin_explorer] build(): Invalid pos_hash!")
				return
			end
			if not loaded_areas[pos_hash] then
				local opts = table.copy(current_options)
				opts.size = AUTOBUILD_SIZE
				-- This actually builds the nodes
				create_perlin(pos, current_perlin.noise, current_perlin.noiseparams, opts, false)
				-- Built chunks are marked so they don't get generated over and over
				-- again
				loaded_areas[pos_hash] = true
			end
		end

		-- Build list of coordinates to generate nodes in
		local pos = vector.round(player:get_pos())
		pos = sidelen_pos(pos, AUTOBUILD_SIZE)
		local neighbors = { vector.new(0, 0, 0) }
		local c = AUTOBUILD_CHUNKDIST
		local cc = c
		if current_options.dimensions == 2 then
			cc = 0
		end
		for cx=-c, c do
		for cy=-cc, cc do
		for cz=-c, c do
			table.insert(neighbors, vector.new(cx, cy, cz))
		end
		end
		end
		local noisechunks = {}
		for n=1, #neighbors do
			local offset = vector.multiply(neighbors[n], AUTOBUILD_SIZE)
			local npos = vector.add(pos, offset)
			-- Check of position is still within the valid map
			local node = minetest.get_node_or_nil(npos)
			if node ~= nil then
				local hash = minetest.hash_node_position(npos)
				if not loaded_areas[hash] then
					table.insert(noisechunks, {npos, hash})
				end
			end
		end
		if #noisechunks > 0 then
			minetest.log("verbose", "[perlin_explorer] Started building "..#noisechunks.." noisechunk(s)")
		end
		-- Build the nodes!
		for c=1, #noisechunks do
			local npos = noisechunks[c][1]
			local nhash = noisechunks[c][2]
			build(npos, nhash, player_name)
		end
		if #noisechunks > 0 then
			minetest.log("verbose", "[perlin_explorer] Done building "..#noisechunks.." noisechunk(s)")
		end
	end
	end
end)

-- Player variable init and cleanup
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local flags = default_noiseparams.flags
	local flags_table = parse_flags_string(flags)
	formspec_states[name] = {
		defaults = flags_table.defaults,
		eased = flags_table.eased,
		absvalue = flags_table.absvalue,
		sidelen = 1,
		dimensions = 2,
		noiseparams = table.copy(default_noiseparams),

		-- This is used by the `unique_formspec_spaces` hack
		sequence_number = 0,
	}
end)
minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	formspec_states[name] = nil
end)
