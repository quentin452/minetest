minetest.register_craftitem("itemx:walkietalkie", {
    description = " Walkie Talkie",
    inventory_image = "walkietalkie.png",
    --droppable = false,	
   on_use = function() -- msg (player)
	--minetest.chat_send_all ("HELP ME ,PLEASE...")
	minetest.sound_play("Walkietalkiesoundeffect", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
    end,
	
})



---- MEDIC : ( Não tem craft )

minetest.register_craftitem("itemx:bandaid", {
    description = "Band aid\n".. core.colorize("#ff0000", "+ 2 of blood"),
    inventory_image = "band_aid.png",
    on_use = function(itemstack, user, pointed_thing) 
		local hp = user:get_hp()
		if hp ~= 20 then
			user:set_hp(hp + 2)
			itemstack:take_item()
		end
		return itemstack
	end
})


minetest.register_craftitem("itemx:medicalkit", {
    description = "Medical Kit\n".. core.colorize("#ff0000", "+ 20 of blood"),
    inventory_image = "medic_kit.png",
    on_use = function(itemstack, user, pointed_thing) 
		local hp = user:get_hp()
		if hp ~= 20 then
			user:set_hp(hp + 20)
			itemstack:take_item()
		end
		return itemstack
	end
})

