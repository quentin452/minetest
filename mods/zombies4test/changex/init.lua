
--Default
minetest.override_item ("default:leaves",{
walkable = false,
})

-- Jungle :
minetest.override_item ("default:jungleleaves",{
walkable = false,
})

--Acacia
minetest.override_item ("default:acacia_leaves",{
walkable = false,
})

-- Aspen
minetest.override_item ("default:aspen_leaves",{
walkable = false,
})



-- DOORS SOUND : ===============================================================
-- sounds door : https://freesound.org/people/utsuru/sounds/183450/ ( by:utsuru)
minetest.override_item ("doors:door_wood_a",{
 on_destruct = function(pos)
        minetest.sound_play("crack_door", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
})


minetest.override_item ("doors:door_wood_b",{
 on_destruct = function(pos)
        minetest.sound_play("crack_door", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
})



minetest.override_item ("doors:door_wood_c",{
 on_destruct = function(pos)
        minetest.sound_play("crack_door", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
})



minetest.override_item ("doors:door_wood_d",{
 on_destruct = function(pos)
        minetest.sound_play("crack_door", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
})


-- GLASS
minetest.override_item ("default:glass",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_glass", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })
   


--- DOOR GLASS

minetest.override_item ("doors:door_glass_a",{
	on_destruct = function(pos)
        minetest.sound_play("crack_glass", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
   })


   minetest.override_item ("doors:door_glass_b",{
	on_destruct = function(pos)
        minetest.sound_play("crack_glass", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
   })

   minetest.override_item ("doors:door_glass_c",{
	on_destruct = function(pos)
        minetest.sound_play("crack_glass", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
   })

   minetest.override_item ("doors:door_glass_d",{
	on_destruct = function(pos)
        minetest.sound_play("crack_glass", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
   })



   --- SUPORTE A OUTRAS DOORS : ==========================================================

   if minetest.get_modpath("moretrapdoors") then

   minetest.override_item ("doors:pine_door_a",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })
   

   minetest.override_item ("doors:pine_door_b",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:pine_door_c",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })


   minetest.override_item ("doors:pine_door_d",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })


-- aspen
minetest.override_item ("doors:aspen_doors_a",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })


   minetest.override_item ("doors:aspen_doors_b",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:aspen_doors_c",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:aspen_doors_d",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   -- acacia
   minetest.override_item ("doors:acacia_door_a",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:acacia_door_b",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:acacia_door_c",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:acacia_door_d",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   -- Jungle
   minetest.override_item ("doors:jungle_door_a",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:jungle_door_b",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:jungle_door_c",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })

   minetest.override_item ("doors:jungle_door_d",{
	on_destruct = function(pos)
		   minetest.sound_play("crack_door", {
			   pos = pos,
			   gain = 1.0,
			   max_hear_distance = 5,
		   })
	   end,
   })


end