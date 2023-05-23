
if minetest.get_modpath("3d_armor") then


	armor:register_armor("skullkingsitems:helmet_skullking", {
		description = ("Skull King crown "),
		inventory_image = "skullkingsitems_inv_helmet_skullking.png",
		groups = {
		armor_head=1, 
		armor_heal=14, 
		armor_use=200,
		physics_speed=1, 
		--armor_fire=1,
		
		},
		
		armor_groups = {fleshy=17},
		damage_groups = {cracky=2, snappy=1, level=4},
    })


	

end


-- HUMMER


minetest.register_node("skullkingsitems:hammer", {
	description = "Skull Kings Hammer",
	drawtype = "mesh",
	mesh = "skull_king_deep_hummer.obj",
	tiles = {"skull_king_deep.png"} ,
	wield_scale = {x=2, y=2, z=2},
	--inventory_image = "skull_king_deep.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.50, [2]=0.60, [3]=0.30}, uses=100, maxlevel=3},
			cracky = {times={[1]=1.90, [2]=0.90, [3]=0.40}, uses=100, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1,pickaxe = 1,dig_immediate=3},
	paramtype = "light",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.32, -0.5, -0.3, 0.95, 1.05, 0.3},
				
			},
		},
		
		
	
})




 -- TROFEU : ----------------------------------------------------------------------------
 
 -- == MESE LORD ==
 
 minetest.register_node("skullkingsitems:meselord_trophy", {
	description = "Mese Lord Trophy",
	drawtype = "mesh",
	mesh = "mese_lord_tro.obj",
	tiles = {"mese_lord_tro.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})
 





-- === GOLEM ===

minetest.register_node("skullkingsitems:golem_trophy", {
	description = "Golem Trophy",
	drawtype = "mesh",
	mesh = "golem_tro.obj",
	tiles = {"golem_tro.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})


-- === SKULL KING ===

minetest.register_node("skullkingsitems:skullking_trophy", {
	description = "Skull King Trophy",
	drawtype = "mesh",
	mesh = "skull_king_deep_tro.obj",
	tiles = {"skull_king_deep_tro.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})




---- ITENS ------------------------------------------------------------------------------

minetest.register_craftitem("skullkingsitems:bone", {
    description = "Skull Bone",
    inventory_image = "bonex.png",
 
	
})


minetest.register_craft({
    type = "shapeless",
    output = "dye:white 3",
    recipe = {
        "skullkingsitems:bone",
        
    },
})



-- COMPATIBILIDADE COM BONEMEAL

if minetest.get_modpath("bonemeal") then

minetest.register_craft({
    type = "shapeless",
    output = "bonemeal:bonemeal",
    recipe = {
        "skulls:bone",
        
    },
})

end




-- == CURA  ==
-- Sound : https://freesound.org/people/craigglenday/sounds/517173/
minetest.register_craftitem("skullkingsitems:healing", {
    description = "Healing ",
    inventory_image = "elixi.png",
    stack_max = 1,
    groups = {vessel = 1},
    
    
    on_use = function(itemstack, user, pointed_thing,pos) -- função para recuperar vida simples
		local hp = user:get_hp() -- usuario consegue o valor atual de sua vida
		if hp ~= 20 then -- comparando vida
			user:set_hp(hp + 5)  -- atribuindo mais 5 de vida
			--itemstack:take_item( )
		end
		
		minetest.sound_play("bebendo", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
		
		local pos = user:getpos()
		
		for i=1,30 do
		
	        minetest.add_particle({
		pos = pos,
		acceleration = 0,
          	velocity = {x =math.random(-3,3),y=math.random(-3,3),z=math.random(-3,3)},
          	-- x ou y ,ou z  = random (-3 right , 3 left )
		size = 2, 
		expirationtime = 2.0,
		collisiondetection = false,
		vertical = false,
		texture = "cura.png",
		glow = 8,
	        })
	        
	        end
	        
	        
		
		return  "vessels:glass_bottle"  
	end
	

})

minetest.register_craft({
  output = "skullkingsitems:healing",
  recipe = {
    {"", "default:mese_crystal_fragment", ""},
    {"hungry:hungry_sheet", "default:apple", "hungry:hungry_sheet"},
    {"", "vessels:glass_bottle", ""}
  }
})





-- == BLOCO  ===

-- BLOCO DE OSSO ( INUTIL XD )

minetest.register_node("skullkingsitems:bone_block", {
	description = "Bone Block",
	tiles = {"osso_bloco.png"}, 
	groups = {cracky = 2}, 
        drop = "skullkingsitems:bone_block",
        sounds = default.node_sound_stone_defaults(),	
})

minetest.register_craft({
	output = "skullkingsitems:bone_block",
	recipe = {
		{"skullkingsitems:bone", "skullkingsitems:bone", "skullkingsitems:bone"},
		{"skullkingsitems:bone", "skullkingsitems:bone", "skullkingsitems:bone"},
		{"skullkingsitems:bone", "skullkingsitems:bone", "skullkingsitems:bone"},
	}
})




-- CONQUISTAS :

		if minetest.get_modpath("awards") then  
		
		   awards.register_award("boss_1", {
			title = "First Boss , Mese Lord ",
			description = "Kill the first boss, get the trophy and unlock the next achievement...", 
			icon = "mese_lord_award.png", 
			background = "awards_bg_mining.png",
			-- requires = {""},
			prizes = {"skullkingsitems:meselord_trophy"} ,
			
		})
		
		
		
	
		  
		   awards.register_award("boss_2", {
			title = "Golem Boss",
			description = "One more challenge ahead of you, defeat the Golem boss...", 
			icon = "golem_award.png", 
			background = "awards_bg_mining.png",
			requires = {"boss_1"},
			prizes = {"skullkingsitems:golem_trophy"} ,
			
		})
		
		
	
		  
		   awards.register_award("boss_3", {
			title = "Skull King Boss",
			description = "You've proven yourself strong enough, now defeat King Cave...", 
			icon = "skullking_award.png", 
			background = "awards_bg_mining.png",
			requires = {"boss_2"},
			prizes = {"skullkingsitems:skullking_trophy"} ,
			
		})
		
		end
