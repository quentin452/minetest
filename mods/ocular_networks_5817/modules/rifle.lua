minetest.register_tool("ocular_networks:blazerifle", {
	description="OCP Blaze Rifle\n"..minetest.colorize("#00affa", "uses 100 power from your personal network\n(displayed in the top left)\n")..minetest.colorize("#ff0000", "15 Ranged Damage"),
	wield_scale={x=0.75,y=0.75,z=0.85},
	inventory_image="poly_blazerifle.png",
	on_secondary_use=function(itemstack, user, pointed_thing)
		local userPower=0
		if user:get_meta():get_string("personal_ocular_power") then
			userPower=tonumber(user:get_meta():get_string("personal_ocular_power"))
		end
		local pos=user:getpos()
		local dir=user:get_look_dir()
		local yaw=user:get_look_yaw()
		if pos and dir and yaw and userPower > 99 then
			pos.y=pos.y + 1.6
			local obj=minetest.add_entity(pos, "ocular_networks:power_projectile")
			if obj then
				obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent=obj:get_luaentity()
				if ent then
					ent.player=ent.player or user
				end
				user:get_meta():set_string("personal_ocular_power", userPower-100)
				minetest.sound_play("OCN_shot_1", {gain = 0.3, pos = pos, max_hear_distance = 10})
			end
		end
		return itemstack
	end,
})

local proj={
	physical=false,
	timer=0,
	visual="sprite",
	visual_size={x=0.3, y=0.3},
	textures={"poly_power_spark.png"},
	lastpos= {},
	collisionbox={0, 0, 0, 0, 0, 0},
}
proj.on_step=function(self, dtime)
	self.timer=self.timer + dtime
	local pos=self.object:getpos()
	local node=minetest.get_node(pos)

	if self.timer > 0.065 then
		local objs=minetest.get_objects_inside_radius({x=pos.x, y=pos.y, z=pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "ocular_networks:power_projectile" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage=15
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups= {fleshy=damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage=15
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups= {fleshy=damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x=pos.x, y=pos.y, z=pos.z}
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=0, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=1,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark.png",
	})
end

minetest.register_entity("ocular_networks:power_projectile", proj )

minetest.register_tool("ocular_networks:blazerifle_c", {
	description="Supercharged OCP Blaze Rifle\n"..minetest.colorize("#00affa", "uses 500 power from your personal network\n(displayed in the top left)\n")..minetest.colorize("#ff0000", "45 Ranged Damage"),
	wield_scale={x=0.75,y=0.75,z=0.85},
	inventory_image="poly_blazerifle_c.png",
	on_secondary_use=function(itemstack, user, pointed_thing)
		local userPower=0
		if user:get_meta():get_string("personal_ocular_power") then
			userPower=tonumber(user:get_meta():get_string("personal_ocular_power"))
		end
		local pos=user:getpos()
		local dir=user:get_look_dir()
		local yaw=user:get_look_yaw()
		if pos and dir and yaw and userPower > 499 then
			pos.y=pos.y + 1.6
			local obj=minetest.add_entity(pos, "ocular_networks:power_projectile_2")
			if obj then
				obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent=obj:get_luaentity()
				if ent then
					ent.player=ent.player or user
				end
				user:get_meta():set_string("personal_ocular_power", userPower-500)
				minetest.sound_play("OCN_shot_1", {gain = 1, pos = pos, max_hear_distance = 10})
			end
		end
		return itemstack
	end,
})

local proj2={
	physical=false,
	timer=0,
	visual="sprite",
	visual_size={x=0.3, y=0.3},
	textures={"poly_power_spark_c.png"},
	lastpos= {},
	collisionbox={0, 0, 0, 0, 0, 0},
}

proj2.on_step=function(self, dtime)
	self.timer=self.timer + dtime
	local pos=self.object:getpos()
	local node=minetest.get_node(pos)

	if self.timer > 0.065 then
		local objs=minetest.get_objects_inside_radius({x=pos.x, y=pos.y, z=pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "ocular_networks:power_projectile_2" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage=45
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups= {fleshy=damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage=45
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups= {fleshy=damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x=pos.x, y=pos.y, z=pos.z}
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=0, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=1,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark_c.png",
	})
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=0.5, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=2,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark_c.png",
	})
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=-0.5, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=2,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark_c.png",
	})
end

minetest.register_entity("ocular_networks:power_projectile_2", proj2 )

minetest.register_tool("ocular_networks:erena_blaster", {
	description="Erena Blaster\n"..minetest.colorize("#00affa", "uses 500 power from your personal network\n(displayed in the top left)\n")..minetest.colorize("#ff0000", "200 Ranged Damage"),
	wield_scale={x=0.75,y=0.75,z=0.85},
	inventory_image="poly_blazerifle_d.png",
	wield_scale={x=3.0, y=3.0, z=1.0},
	on_secondary_use=function(itemstack, user, pointed_thing)
		local userPower=0
		if user:get_meta():get_string("personal_ocular_power") then
			userPower=tonumber(user:get_meta():get_string("personal_ocular_power"))
		end
		local pos=user:getpos()
		local dir=user:get_look_dir()
		local yaw=user:get_look_yaw()
		if pos and dir and yaw and userPower > 499 then
			pos.y=pos.y + 1.6
			local obj=minetest.add_entity(pos, "ocular_networks:power_projectile_3")
			if obj then
				obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent=obj:get_luaentity()
				if ent then
					ent.player=ent.player or user
				end
				user:get_meta():set_string("personal_ocular_power", userPower-500)
				minetest.sound_play("OCN_shot_2", {gain = 1, pos = pos, max_hear_distance = 10})
			end
		end
		return itemstack
	end,
})

local proj3={
	physical=false,
	timer=0,
	visual="sprite",
	visual_size={x=0.3, y=0.3},
	textures={"poly_power_spark_d.png"},
	lastpos= {},
	collisionbox={0, 0, 0, 0, 0, 0},
}

proj3.on_step=function(self, dtime)
	self.timer=self.timer + dtime
	local pos=self.object:getpos()
	local node=minetest.get_node(pos)

	if self.timer > 0.065 then
		local objs=minetest.get_objects_inside_radius({x=pos.x, y=pos.y, z=pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "ocular_networks:power_projectile_3" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage=200
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups= {fleshy=damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage=200
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups= {fleshy=damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x=pos.x, y=pos.y, z=pos.z}
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=0, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=1,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark_d.png",
	})
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=0.5, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=2,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark_d.png",
	})
	minetest.add_particle({
		pos=pos,
		velocity={x=0, y=-0.5, z=0},
		acceleration={x=0, y=0, z=0},
		expirationtime=2,
		size=0.3,
		glow=14,
		collisiondetection=false,
		vertical=false,
		texture="poly_power_spark_d.png",
	})
end

minetest.register_entity("ocular_networks:power_projectile_3", proj3 )