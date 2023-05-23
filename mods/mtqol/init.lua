-----------
-- MTQOL --
-----------

minetest.register_chatcommand(
  "QOL_ping",
  {
    func = function (name, params)
      minetest.chat_send_player(name, "Pong!")
      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_whatsthis",
  {
    func = function (name, params)
      local player = minetest.get_player_by_name(name)
      local item = player:get_wielded_item()

      local info = item:get_short_description() or "[Description not found.]"

      local message =
        "=== Item: ===\n" ..
        "Name: "  .. item:get_name()  .. "\n" ..
        "Count: " .. item:get_count() .. "\n" ..
        "Wear: "  .. item:get_wear()  .. "\n" ..
        "Info: "  .. info             .. "\n" ..
        "=== End ==="

      minetest.chat_send_player(name, message)

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_rename",
  {
    func = function (name, params)
      local player = minetest.get_player_by_name(name)
      local item = player:get_wielded_item()

      if item:is_empty() then
        minetest.chat_send_player(name, "Can't rename because you aren't holding anything!")
        return true
      end

      item:get_meta():set_string("description", params)
      player:set_wielded_item(item) 

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_refill",
  {
    privs = {creative = true},
    func = function (name, params)
      local player = minetest.get_player_by_name(name)
      local item = player:get_wielded_item()

      if item:is_empty() then
        minetest.chat_send_player(name, "Can't refill because you aren't holding anything!")
        return true
      end

      local new_wear = (params ~= "" and tonumber(string.match(params, "%d[%d,]*"))) or 0

      item:set_count(item:get_stack_max())
      item:set_wear(new_wear)

      if not player:set_wielded_item(item) then
        minetest.chat_send_player(name, "Failed to set wielded item!")
      end

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_nothungry",
  {
    privs = {creative = true},
    func = function (name, params)
      if hunger_ng ~= nil then
        hunger_ng.alter_hunger(name, 65536, "QOL_nothungry")
        minetest.chat_send_player(name, "You are not hungry.")
      else
        minetest.chat_send_player(name, "Command failed: Can't find hunger_ng.")
      end

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_boost",
  {
    privs = {fast = true},
    func = function (name, params)
      local axis = string.match(params, "^(%a)")
      local dist = string.match(params, "^[^%s]+%s+(-?[%d,.]+)")

      if not axis or axis == "" then axis = "y" end
      if not dist or dist == "" then dist = 10  end

      axis = string.lower(axis)
      dist = tonumber(dist)

      local player = minetest.get_player_by_name(name)

      local op = player:get_pos()
      local np =
        axis == "x" and {x = op.x + dist, y = op.y, z = op.z} or
        axis == "y" and {x = op.x, y = op.y + dist, z = op.z} or
        axis == "z" and {x = op.x, y = op.y, z = op.z + dist} or
        op

      player:set_pos(np)

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_whosthere",
  {
    func = function (name, params)
      local message = ""

      for _, p in ipairs(minetest.get_connected_players()) do
        message = message .. "- " .. p:get_player_name() .. "\n"
      end

      minetest.chat_send_player(name, "Connected players:\n" .. message .. "(End)")

      return true
    end
  }
)
