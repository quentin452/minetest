local mod_storage = minetest.get_mod_storage()

local data = {
    death_pos = minetest.deserialize(mod_storage:get_string("death_pos")) or nil,
    death_time = tonumber(mod_storage:get_string("death_time")) or nil,
}

local function save()
    mod_storage:set_string("death_pos", minetest.serialize(data.death_pos))
    mod_storage:set_string("death_time", data.death_time)
end

minetest.register_on_shutdown(save)
minetest.register_on_leaveplayer(save)

local function periodic_save()
    save()
    minetest.after(120, periodic_save)
end
minetest.after(120, periodic_save)

return data