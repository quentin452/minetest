--[[
    X Tumbleweed. Adds tumbleweeds.
    Copyright (C) 2023 SaKeL <juraj.vajda@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]

local path = minetest.get_modpath('x_tumbleweed')
local mod_start_time = minetest.get_us_time()

dofile(path .. '/api.lua')
dofile(path .. '/entity.lua')

minetest.register_globalstep(function(...)
    XTumbleweed:globalstep(...)
end)

local mod_end_time = (minetest.get_us_time() - mod_start_time) / 1000000

print('[Mod] x_tumbleweed loaded.. [' .. mod_end_time .. 's]')
