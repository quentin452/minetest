if minetest.get_modpath("awards") then 


--- LADRÃO DE TUMULO
awards.register_award("graverobber", {
			title = "grave robber",
			description = "dig 20 tombstones",
			icon = "ladraodetumulo.png",
			background = "awards_bg_mining.png",
			-- prizes = {"default:stone_with_diamond"} ,
			trigger = {
				type = "dig",
				node = "group:tree",
				target = 20
			}
		})



-- MUITO DOCE...
 awards.register_award("verysweet", {
			title = "Very sweet",
			description = "Eat 50 chocolate bars",
			icon = "muitodoce.png",
			background = "awards_bg_mining.png",
			--requires = {"},
			--prizes = {""} , 
			trigger = {
				type = "eat",
				item = "foods:chocolate_bar",
				target = 50
			}
		})



-- CURA TOTAL...
 awards.register_award("totalcure", {
			title = "Total Cure",
			description = "Use 20 medical kits",
			icon = "curatotal.png",
			background = "awards_bg_mining.png",
			--requires = {"},
			--prizes = {""} , 
			trigger = {
				type = "eat",
				item = "items:medicalkit",
				target = 20
			}
		})


-- MAIS TANK QUE UM TANK ...
awards.register_award("tank", {
			title = "More tank than a tank",
			description = "Kill a zombie tank..",
			icon = "tank.png",
			--secret =  true


		})


end
