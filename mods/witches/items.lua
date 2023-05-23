--Witches is copyright 2020 Francisco Athens, Ramona Athens, Damon Athens and Simone Athens
--The MIT License (MIT)
local variance = witches.variance

local rnd_color = witches.rnd_color
local rnd_colors = witches.rnd_colors

witches.witch_hair_styles = {"a","b","c","d","e","f","g","h","p"}
witches.witch_hat_styles = {"a_anim","b","c","d","k"}

local hat_bling = {"band","feather","veil"}
local hair_bling = {}



minetest.register_tool("witches:witch_wand_sp", {
  description = "Sparkle Parkle!",
  inventory_image = "witches_wand_sparkle_parkle.png",
  tool_capabilities = {
    full_punch_interval = 1.2,
    max_drop_level=0,
    groupcaps={
      --cracky = {times={[2]=1.8, [3]=0.90}, uses=25, maxlevel=1},
    },
    damage_groups = {fleshy=3},
  },
  sound = {breaks = "default_tool_breaks"},
  --groups = {pickaxe = 1}

})

local witch_tool_wand_sp = {}
witch_tool_wand_sp = {
  initial_properties = {
      --physical = true,
      pointable = false,
      collisionbox = {0,0,0,0,0,0},
      visual = "wielditem",

      visual_size = {x = 0.3, y = 0.3},
      wield_item = "witches:witch_wand_sp",

  },

  on_step =  function(self)
    if not self.owner or not self.owner:get_luaentity() then
      self.object:remove()
    end
  end
}

minetest.register_entity("witches:witch_tool_wand_sp",witch_tool_wand_sp)



minetest.register_tool("witches:witch_wand_btb", {
  description = "Better Than Bacon!",
  inventory_image = "witches_wand_better_than_bacon.png",
  tool_capabilities = {
    full_punch_interval = 1.2,
    max_drop_level=0,
    groupcaps={
      --cracky = {times={[2]=1.8, [3]=0.90}, uses=25, maxlevel=1},
    },
    damage_groups = {fleshy=3},
  },
  sound = {breaks = "default_tool_breaks"},
  --groups = {pickaxe = 1}

})

local witch_tool_wand_btb = {}
witch_tool_wand_btb = {
  initial_properties = {
      --physical = true,
      pointable = false,
      collisionbox = {0,0,0,0,0,0},
      visual = "wielditem",

      visual_size = {x = 0.3, y = 0.3},
      wield_item = "witches:witch_wand_btb",

  },

  on_step =  function(self)
    if not self.owner or not self.owner:get_luaentity() then
      self.object:remove()
    end
  end
}

minetest.register_entity("witches:witch_tool_wand_btb",witch_tool_wand_btb)


local function item_set_animation(self, anim, force)

	if not self.animation or not anim then return end

	self.animation.current = self.animation.current or ""

	-- only use different animation for attacks when using same set
	if force ~= true and anim ~= "punch" and anim ~= "shoot"
	and string.find(self.animation.current, anim) then
		return
	end

	-- check for more than one animation
	local num = 0

	for n = 1, 4 do

		if self.animation[anim .. n .. "_start"]
		and self.animation[anim .. n .. "_end"] then
			num = n
		end
	end

	-- choose random animation from set
	if num > 0 then
		num = math.random(0, num)
		anim = anim .. (num ~= 0 and num or "")
	end

	if anim == self.animation.current
	or not self.animation[anim .. "_start"]
	or not self.animation[anim .. "_end"] then
		return
	end

	self.animation.current = anim

	self.object:set_animation({
		x = self.animation[anim .. "_start"],
		y = self.animation[anim .. "_end"]},
		self.animation[anim .. "_speed"] or
				self.animation.speed_normal or 15,
		0, self.animation[anim .. "_loop"] ~= false)
end


--generate hair

local witch_hair = {}

for i,v in pairs(witches.witch_hair_styles) do
  witch_hair[i] = {
    initial_properties = {
        --physical = true,
        pointable = false,
        collisionbox = {0,0,0,0,0,0},
        visual = "mesh",
        mesh = "witches_witch-hair_"..v..".b3d",
        visual_size = vector.new(1, 1, 1),
        textures = {"witches_witch_hair.png"},
    },
    message = "Default message",

    on_step =  function(self)
      if not self.owner or not self.owner:get_luaentity() then
        self.object:remove()
      else
        local owner = self.owner:get_luaentity()

        if owner.state == "stand" and self.state ~= "stand" then
          self.state = "stand"
          item_set_animation(self, "stand")
        end

        if owner.state == "walk" and self.state ~= "walk" then
          self.state = "walk"
          item_set_animation(self, "walk")
        end

        if owner.state == "run" and self.state ~= "run" then
          self.state = "run"
          item_set_animation(self, "run")
        end

        -- local owner_head_bone = self.owner:get_luaentity().head_bone
        --  local position,rotation = self.owner:get_bone_position(owner_head_bone)
        --  self.object:set_attach(self.owner, owner_head_bone, vector.new(0,0,0), rotation)
      end
    end
  }

end

for i,v in pairs(witches.witch_hair_styles) do
  minetest.register_entity("witches:witch_hair_"..i,witch_hair[i])
end

-- generate hats

local witch_hats = {}

for i,v in pairs(witches.witch_hat_styles) do
  witch_hats[i] = {
    initial_properties = {
        --physical = true,
        pointable = false,
        collisionbox = {0,0,0,0,0,0},
        visual = "mesh",
        mesh = "witches_witch-hat_"..v..".b3d",
        visual_size = vector.new(1, 1, 1),
        textures = {"witches_witch_hat.png"},
    },
    message = "Default message",
    on_step =  function(self)

      if not self.owner or not self.owner:get_luaentity() then
        self.object:remove()
      else
        --if self.get_properties({"animation"}) then
        local owner = self.owner:get_luaentity()
        if owner.state == "stand" and self.state ~= "stand" then
          self.state = "stand"
          item_set_animation(self, "stand")
        end
        if owner.state == "walk" and self.state ~= "walk" then
          self.state = "walk"
          item_set_animation(self, "walk")
        end
        if owner.state == "run" and self.state ~= "run" then
          self.state = "run"
          item_set_animation(self, "run")
        end
        -- local owner_head_bone = self.owner:get_luaentity().head_bone
        --  local position,rotation = self.owner:get_bone_position(owner_head_bone)
        --  self.object:set_attach(self.owner, owner_head_bone, vector.new(0,0,0), rotation)
      end
    end
  }
   --print("test: ".. string.find("anim", v) )
  if string.find(v, "anim") then

    witch_hats[i].animation =   {
      stand_speed = 1,
      stand_start = 1,
      stand_end = 1,
      walk_speed = 30,
      walk_start = 1,
      walk_end = 19,
      run_speed = 45,
      run_start = 1,
      run_end = 19,
      punch_speed = 30,
      punch_start = 1,
      punch_end = 19,
    }
  end
end


for i,v in pairs(witches.witch_hat_styles) do
  minetest.register_entity("witches:witch_hat_"..i,witch_hats[i])
end

--minetest.register_entity("witches:witch_hat",witch_hat)


local witch_tool = {}
witch_tool = {
  initial_properties = {
      --physical = true,
      pointable = false,
      collisionbox = {0,0,0,0,0,0},
      visual = "wielditem",

      visual_size = {x = 0.3, y = 0.3},
      wield_item = "default:stick",
      --inventory_image = "default_tool_woodpick.png",
  },

  on_step =  function(self)
    if not self.owner or not self.owner:get_luaentity() then
      self.object:remove()
    end
  end
}


minetest.register_entity("witches:witch_tool",witch_tool)


--------
--attachment scripts
--------

function witches.attach_hair(self,item)
  self.head_bone = "Head"
  local item = item or "witches:witch_hair"
  local hair = minetest.add_entity(self.object:get_pos(), item)
  hair:set_attach(self.object, "Head", vector.new(0,4.5,0), vector.new(0,180,0))
  local hair_ent = hair:get_luaentity()
  if not hair_ent then
    print("item is: ".. item) return
  end
  hair_ent.owner = self.object
  --print("HAT: "..dump(hair_ent))
  local he_props = hair_ent.object:get_properties()
  --print("he props: "..dump(he_props))
  local hair_size = variance(95, 105)
  local hair_mods = ""
  local hair_bling = hair_bling or {}

  if not hair_ent.hair_color then
    hair_ent.hair_color = self.hair_color
    hair_ent.object:set_texture_mod("^witches_witch_hair_"..hair_ent.hair_color..".png")
  end

  --[[

  self.hair_mods = hair_mods
  --print("hair_mods: "..self.hair_mods)
  if self.color_mod ~= "none" then
    hair_ent.object:set_texture_mod("^[colorize:"..self.color_mod..":60"..self.hair_mods)
  else
    if self.hat_mods then hair_ent.object:set_texture_mod(self.hair_mods) end
  end
  --]]
  he_props.visual_size.y = hair_size
  --print("he props: "..dump(he_props))
  hair_ent.object:set_properties(he_props)
end



function witches.attach_hat(self,item)
  self.head_bone = "Head"
  local item = item or "witches:witch_hat"
  local hat = minetest.add_entity(self.object:get_pos(), item)
  hat:set_attach(self.object, "Head", vector.new(0,4.5,0), vector.new(0,180,0))
  local hat_ent = hat:get_luaentity()
  if not hat_ent then
    print("item is: ".. item) return
  end
  hat_ent.owner = self.object
  --print("HAT: "..dump(hat_ent))
  local he_props = hat_ent.object:get_properties()
  --print("he props: "..dump(he_props))
  local hat_size = variance(90, 120)
  local hat_mods = ""
  for i,v in pairs(hat_bling) do
    if v == "veil" and math.random() < 0.1 then
      hat_mods = hat_mods.."^witches_witch_hat_"..v..".png"
    else
      if v ~= "veil" and math.random() < 0.5 then
        hat_mods = hat_mods.."^witches_witch_hat_"..v..".png"
      end
    end
  end
  self.hat_mods = hat_mods
  --print("hat_mods: "..self.hat_mods)
  if self.color_mod ~= "none" then
    hat_ent.object:set_texture_mod("^[colorize:"..self.color_mod..":60"..self.hat_mods)
  else
    if self.hat_mods then hat_ent.object:set_texture_mod(self.hat_mods) end
  end
  he_props.visual_size.y = hat_size
  --print("he props: "..dump(he_props))
  hat_ent.object:set_properties(he_props)
end

function witches.attach_tool(self,item)
  item = item or "witches:witch_tool_btb"
  local tool = minetest.add_entity(self.object:get_pos(), item)
  tool:set_attach(self.object, "Arm_Right", {x=0.3, y=4.0, z=2}, {x=-100, y=225, z=90})
  tool:get_luaentity().owner = self.object
end