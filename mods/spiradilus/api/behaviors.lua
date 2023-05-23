---------------
-- Behaviors --
---------------

-- Local Math --

local random = math.random

local vec_dir = vector.direction
local vec_dist = vector.distance
local vec_add = vector.add
local vec_multi = vector.multiply

local dir2yaw = minetest.dir_to_yaw

local function debugpart(pos, time, tex)
    minetest.add_particle({
        pos = pos,
        texture = tex or "creatura_particle_pos.png",
        time = time or 3,
        glow = 6,
        size = 12
    })
end

----------------------
-- Register Actions --
----------------------

function spiradilus.action_eat(self)
    local anim = self.animations["eat"]
    local anim_time = (anim.range.y - anim.range.x) / anim.speed
    local timer = anim_time
    local eat_init = false
    local function func(self)
        local pos = self.object:get_pos()
        local eat_pos = vec_add(pos, vec_multi(minetest.yaw_to_dir(self.object:get_yaw()), 2.5))
        eat_pos.y = pos.y - 0.9
        self:set_gravity(-9.8)
        self:halt()
        self:animate("eat")
        timer = timer - self.dtime
        if timer < anim_time * 0.5 then
            if not eat_init then
                if not creatura.get_node_def(eat_pos).walkable then return true end
                minetest.remove_node(eat_pos)
                local new_hp = self.hp + 100
                if new_hp > self.max_health then
                    new_hp = self.max_health
                end
                self.hp = new_hp
                eat_init = true
                for i = 1, 359, 30 do
                    local dir = vec_multi(minetest.yaw_to_dir(math.rad(i)), 3)
                    minetest.add_particlespawner({
                        amount = 1,
                        time = 0.1,
                        minpos = eat_pos,
                        maxpos = eat_pos,
                        minvel = {x = dir.x, y = 1, z = dir.z},
                        maxvel = {x = dir.x * 0.7, y = 2, z = dir.z * 0.7},
                        minacc = {x = 0, y = -9.81, z = 0},
                        maxacc = {x = 0, y = -9.81, z = 0},
                        minsize = 2,
                        maxsize = 4,
                        collisiondetection = true,
                        texture = "spiradilus_particle_dirt.png"
                    })
                end
                spiradilus.set_tail(self)
            end
        end
        if timer <= 0 then
            self:animate("stand")
            return true
        end
    end
    self:set_action(func)
end

function spiradilus.action_basic_attack(self, target)
    local anim = self.animations["basic_attack"]
    local anim_time = (anim.range.y - anim.range.x) / anim.speed
    local timer = anim_time
    local damage_init = false
    local function func(self)
        self.head_tracking = target
        local pos = self:get_center_pos()
        local tgt_pos = target:get_pos()
        local damage_pos = vec_add(pos, vec_multi(minetest.yaw_to_dir(self.object:get_yaw()), 2.5))
        damage_pos.y = pos.y + 0.5
        self:set_gravity(-9.8)
        self:halt()
        self:animate("basic_attack")
        timer = timer - self.dtime
        if timer < anim_time * 0.5 then
            if not damage_init then
                local objects = minetest.get_objects_inside_radius(damage_pos, 2)
                for i = 1, #objects do
                    local object = objects[i]
                    if object ~= self.object then
                        if object:get_luaentity() then
                            local ent = object:get_luaentity()
                            local is_mobkit = (ent.logic ~= nil or ent.brainfuc ~= nil)
                            local is_creatura = ent._creatura_mob
                            if is_mobkit
                            or is_creatura then
                                target = object
                                tgt_pos = object:get_pos()
                            end
                        elseif object:is_player() then
                            target = object
                            tgt_pos = object:get_pos()
                        end
                    end
                    if tgt_pos then
                        local vel = vector.multiply(vector.direction(pos, tgt_pos), 8)
                        vel.y = 6
                        target:add_velocity(vel)
                        self:punch_target(target)
                    end
                end
                damage_init = true
            end
        else
            self:turn_to(minetest.dir_to_yaw(vec_dir(pos, tgt_pos)))
        end
        if timer <= 0 then
            self:animate("stand")
            return true
        end
    end
    self:set_action(func)
end

function spiradilus.action_tail_attack(self, target)
    local anim = self.animations["tail_attack"]
    local anim_time = (anim.range.y - anim.range.x) / anim.speed
    local timer = anim_time
    local damage_init = false
    local function func(self)
        self.head_tracking = target
        local pos = self:get_center_pos()
        local tgt_pos = target:get_pos()
        local damage_pos = vec_add(pos, vec_multi(minetest.yaw_to_dir(self.object:get_yaw()), 2.5))
        damage_pos.y = pos.y + 0.5
        self:set_gravity(-9.8)
        self:halt()
        self:animate("tail_attack")
        timer = timer - self.dtime
        if timer < anim_time * 0.5 then
            if not damage_init then
                local objects = minetest.get_objects_inside_radius(damage_pos, 5)
                for i = 1, #objects do
                    local object = objects[i]
                    if object ~= self.object then
                        if object:get_luaentity() then
                            local ent = object:get_luaentity()
                            local is_mobkit = (ent.logic ~= nil or ent.brainfuc ~= nil)
                            local is_creatura = ent._creatura_mob
                            if is_mobkit
                            or is_creatura then
                                target = object
                                tgt_pos = object:get_pos()
                            end
                        elseif object:is_player() then
                            target = object
                            tgt_pos = object:get_pos()
                        end
                    end
                    if tgt_pos then
                        local vel = vector.multiply(vector.direction(pos, tgt_pos), 12)
                        vel.y = 6
                        target:add_velocity(vel)
                        self:punch_target(target)
                    end
                end
                damage_init = true
            end
        else
            self:turn_to(minetest.dir_to_yaw(vec_dir(pos, tgt_pos)))
        end
        if timer <= 0 then
            self:animate("stand")
            return true
        end
    end
    self:set_action(func)
end

function spiradilus.action_dodge_attack(self, target)
    local anim = self.animations["dodge_attack"]
    local anim_time = (anim.range.y - anim.range.x) / anim.speed
    local timer = anim_time
    local damage_init = false
    local function func(self)
        self.head_tracking = target
        local pos = self:get_center_pos()
        local tgt_pos = target:get_pos()
        local damage_pos = vec_add(pos, vec_multi(minetest.yaw_to_dir(self.object:get_yaw()), 2.5))
        damage_pos.y = pos.y + 0.5
        self:set_gravity(-9.8)
        self:halt()
        self:animate("dodge_attack")
        timer = timer - self.dtime
        if timer < anim_time * 0.3 then
            if not damage_init then
                local objects = minetest.get_objects_inside_radius(pos, 12)
                for i = 1, #objects do
                    local object = objects[i]
                    if object ~= self.object then
                        if object:get_luaentity() then
                            local ent = object:get_luaentity()
                            local is_mobkit = (ent.logic ~= nil or ent.brainfuc ~= nil)
                            local is_creatura = ent._creatura_mob
                            if is_mobkit
                            or is_creatura then
                                target = object
                                tgt_pos = object:get_pos()
                            end
                        elseif object:is_player() then
                            target = object
                            tgt_pos = object:get_pos()
                        end
                    end
                    if tgt_pos then
                        local vel = vector.multiply(vector.direction(pos, tgt_pos), 14)
                        vel.y = 3
                        target:add_velocity(vel)
                        self:punch_target(target)
                    end
                    for i = 1, 359, 15 do
                        local dir = vec_multi(minetest.yaw_to_dir(math.rad(i)), 10)
                        minetest.add_particlespawner({
                            amount = 2,
                            time = 0.25,
                            minpos = pos,
                            maxpos = pos,
                            minvel = {x = dir.x, y = 1, z = dir.z},
                            maxvel = {x = dir.x * 0.7, y = 2, z = dir.z * 0.7},
                            minacc = {x = 0, y = -9.81, z = 0},
                            maxacc = {x = 0, y = -9.81, z = 0},
                            minsize = 2,
                            maxsize = 4,
                            collisiondetection = true,
                            texture = "spiradilus_particle_dirt.png"
                        })
                    end
                    self:play_sound("slam")
                end
                damage_init = true
            end
        else
            self:turn_to(minetest.dir_to_yaw(vec_dir(pos, tgt_pos)))
        end
        if timer <= 0 then
            self:animate("stand")
            return true
        end
    end
    self:set_action(func)
end

function spiradilus.action_roar_attack(self, target)
    local anim = self.animations["roar"]
    local anim_time = (anim.range.y - anim.range.x) / anim.speed
    local timer = anim_time
    local damage_init = false
    local function func(self)
        self.head_tracking = target
        local pos = self:get_center_pos()
        local tgt_pos = target:get_pos()
        self:set_gravity(-9.8)
        self:halt()
        self:animate("roar")
        timer = timer - self.dtime
        if timer < anim_time * 0.6 then
            if not damage_init then
                local objects = minetest.get_objects_inside_radius(pos, 12)
                for i = 1, #objects do
                    local object = objects[i]
                    if object ~= self.object then
                        if object:get_luaentity() then
                            local ent = object:get_luaentity()
                            local is_mobkit = (ent.logic ~= nil or ent.brainfuc ~= nil)
                            local is_creatura = ent._creatura_mob
                            if is_mobkit
                            or is_creatura then
                                target = object
                                tgt_pos = object:get_pos()
                            end
                        elseif object:is_player() then
                            target = object
                            tgt_pos = object:get_pos()
                        end
                    end
                    if tgt_pos then
                        local vel = vector.multiply(vector.direction(pos, tgt_pos), -8)
                        vel.y = 3
                        target:add_velocity(vel)
                        self:punch_target(target)
                    end
                    self:play_sound("roar")
                end
                damage_init = true
            end
        else
            self:turn_to(minetest.dir_to_yaw(vec_dir(pos, tgt_pos)))
        end
        if timer <= 0 then
            self:animate("stand")
            return true
        end
    end
    self:set_action(func)
end

------------------------
-- Register Utilities --
------------------------

-- Wander

creatura.register_utility("spiradilus:wander", function(self)
    local idle_time = 3
    local move_probability = 8
    local function func(self)
        local pos = self.object:get_pos()
        if not self:get_action() then
            local goal
            local move = random(move_probability) < 2
            if not goal
            and move then
                goal = self:get_wander_pos(1, 2)
            end
            if move
            and goal then
                creatura.action_walk(self, goal, 2, "creatura:neighbors")
            else
                creatura.action_idle(self, idle_time)
            end
        end
    end
    self:set_utility(func)
end)

-- Sleep

creatura.register_utility("spiradilus:sleep", function(self)
    local anim_init = false
    local anim = self.animations["roar"]
    local anim_time = (anim.range.y - anim.range.x) / anim.speed
    local timer = anim_time
    local function func(self)
        if not self:get_action() then
            if anim_init then
                self.sleeping = false
                return true
            end
            local player = creatura.get_nearby_player(self)
            if player then
                minetest.after(0.5, function()
                    if creatura.is_valid(self) then
                        self:play_sound("roar")
                    end
                end)
                creatura.action_idle(self, anim_time, "roar")
                anim_init = true
            else
                creatura.action_idle(self, 1, "sleep")
                self.sleeping = true
            end
        end
    end
    self:set_utility(func)
end)

-- Attack

creatura.register_utility("spiradilus:attack", function(self, target)
    local last_tgt_pos
    local last_action
    local function func(self)
        local pos = self.object:get_pos()
        local target_alive, line_of_sight, tpos = self:get_target(target)
        if not target_alive then return true end
        self:move_head(minetest.dir_to_yaw(vec_dir(pos, tpos)))
        if not self:get_action()
        or (last_tgt_pos
        and vec_dist(tpos, last_tgt_pos) > 6
        and line_of_sight
        and last_action == "pursue") then
            local dist = vec_dist(pos, tpos)
            local dist_2d = vec_dist(pos, {x = tpos.x, y = pos.y, z = tpos.z})
            if dist < 4.5 then
                local chance = random(5)
                if chance < 2 then
                    spiradilus.action_tail_attack(self, target)
                elseif chance < 3 then
                    spiradilus.action_dodge_attack(self, target)
                else
                    spiradilus.action_basic_attack(self, target)
                end
                last_action = "attack"
            else
                if dist > 24
                and self.hp < self.max_health * 0.9
                and random(3) < 2 then
                    spiradilus.action_eat(self)
                    last_action = "eat"
                elseif dist_2d < 5
                and dist > 4.5 then
                    spiradilus.action_roar_attack(self, target)
                else
                    creatura.action_walk(self, tpos, 2, "creatura:pathfind")
                    last_tgt_pos = tpos
                    last_action = "pursue"
                end
            end
        end
    end
    self:set_utility(func)
end)

-- Death

creatura.register_utility("spiradilus:death", function(self)
    local timer = 4
    local anim_init = false
    local physics_init = false
    local function func(self)
        if not anim_init then
            self:play_sound("roar")
            self:animate("roar")
            local drops = spiradilus.global_data.drops
            if #drops > 0 then
                local pos = self.object:get_pos()
                for i = 1, 3 do
                    local item = minetest.add_item({
                        x = pos.x + random(-1, 1),
                        y = pos.y + 1,
                        z = pos.z + random(-1, 1)
                    }, drops[random(#drops)])
                    local vel = {
                        x = random(-2, 2),
                        y = 2,
                        z = random(-2, 2)
                    }
                    item:add_velocity(vel)
                end
            end
            anim_init = true
        end
        timer = timer - self.dtime
        if timer < 2
        and not physics_init then
            self.object:set_properties({
                physical = false
            })
            physics_init = true
        end
        if timer <= 0 then
            self.object:remove()
            return true
        end
    end
    self:set_utility(func)
end)