visionLib.Material.require({"luminium", "lumigold", "hekatonium", "angmallen", "silicotin", "zweinium", "shimmering", "copper", "iron", "gold", "tin", "bronze"})

ocular_networks.register_item("ocular_networks:lens", {
	description="Silver Lens\n"..minetest.colorize("#00affa", "Rightclick a frame with this to make it\npower batteries under it"),
	inventory_image="poly_silver_lens.png",
})

ocular_networks.register_item("ocular_networks:cross", {
	description="Plated Quad Gear\n"..minetest.colorize("#00affa", "Rightclick a frame with this to make it\na machine stucture block"),
	inventory_image="poly_cross.png",
})

ocular_networks.register_item("ocular_networks:luminium_lump", {
	description="Luminium Lump\n"..minetest.colorize("#00affa", "Smelt it to obtain a luminium ingot,\na very useful material"),
	inventory_image="poly_luminium_l.png",
})

ocular_networks.register_item("ocular_networks:luminium_chip", {
	description="Luminium Chip\n"..minetest.colorize("#00affa", "Nine of these makes a luminium lump."),
	inventory_image="poly_luminium_c.png",
})

ocular_networks.register_item("ocular_networks:luminium_bar", {
	description="Luminium Ingot\n"..minetest.colorize("#00affa", "Used to make many things"),
	inventory_image="poly_luminium_i.png",
})

ocular_networks.register_item("ocular_networks:hekatonium_chunk", {
	description=minetest.colorize("#00affa", "Hekatonium Chunk"),
	inventory_image="poly_hekatonium_chunk.png",
})

ocular_networks.register_item("ocular_networks:hekatonium_bar", {
	description=minetest.colorize("#00affa", "Hekatonic Ingot"),
	inventory_image="poly_hekatonium_ingot.png",
})

ocular_networks.register_item("ocular_networks:piston", {
	description="Piston\n"..minetest.colorize("#00affa", "Hydraulic motion!"),
	inventory_image="poly_piston.png",
})

ocular_networks.register_item("ocular_networks:silver_dust", {
	description="Silver Dust\n"..minetest.colorize("#00affa", "Sifted silver sand... \nNow mix it with broken glass."),
	inventory_image="poly_silver_dust.png",
})

ocular_networks.register_item("ocular_networks:luminium_bar_2", {
	description="Luminium Ingot stacked on gold\n"..minetest.colorize("#00affa", "Smelt to make lumigold"),
	inventory_image="poly_luminium_ig.png",
})

ocular_networks.register_item("ocular_networks:luminium_bar_3", {
	description="Lumigold Ingot\n"..minetest.colorize("#00affa", "A rather unimpressive ingot,\nbut used in many recipies"),
	inventory_image="poly_lumigold_i.png",
})

ocular_networks.register_item("ocular_networks:angmallen_bar", {
	description="Angmallen Ingot\n"..minetest.colorize("#00affa", "Usually this wouldn't work, but apparently the alloyer has wierd qualities."),
	inventory_image="poly_angmallen.png",
})

ocular_networks.register_item("ocular_networks:toxic_slate_chip", {
	description="Toxic Slate Chips\n"..minetest.colorize("#00affa", "Poisonous stone that becomes safe near\nclose-to-pure carbon compounds"),
	inventory_image="poly_slate.png",
})

ocular_networks.register_item("ocular_networks:toxic_slate_rod", {
	description="Toxic Slate Rod\n"..minetest.colorize("#00affa", "A rod of poisonous stone that becomes safe near\nclose-to-pure carbon compounds"),
	inventory_image="poly_slate_rod.png",
})

ocular_networks.register_item("ocular_networks:lumigold_rod", {
	description="Lumigold Rod\n"..minetest.colorize("#00affa", "A hardy rod of luminium-gold alloy"),
	inventory_image="poly_lumigold_rod.png",
})

ocular_networks.register_item("ocular_networks:crud", {
	description="Crud\n"..minetest.colorize("#00affa", "'Trash, rubbish, waste.'\nProduced by the fuser"),
	inventory_image="poly_crud.png",
})

ocular_networks.register_item("ocular_networks:fuel", {
	description="Fuel Nugget\n"..minetest.colorize("#00affa", "Who would have thought\nyou could make fuel out of THAT."),
	inventory_image="poly_fuel.png",
})

ocular_networks.register_item("ocular_networks:peat", {
	description="Peat Block\n"..minetest.colorize("#00affa", "Used by the chemical oven. When the oven has no peat,\n the cost of power will double.\n(Not placeable)"),
	inventory_image=minetest.inventorycube("poly_peat.png"),
})

ocular_networks.register_item("ocular_networks:gun_stock", {
	description="Wooden Stock\n"..minetest.colorize("#00affa", "A stock for a rifle."),
	inventory_image="poly_stock.png",
})

ocular_networks.register_item("ocular_networks:uncharged_gem", {
	description="Uncharged Gem\n"..minetest.colorize("#00affa", "This gem radiates energy, or it would, if it had any.\nPut it in the charger to charge it."),
	inventory_image="poly_gem_2.png",
	groups={ocp_gem=1}
})

ocular_networks.register_item("ocular_networks:charged_gem", {
	description="Charged Gem\n"..minetest.colorize("#00affa", "This gem radiates energy."),
	inventory_image="poly_gem.png",
	groups={ocp_gem=1}
})

ocular_networks.register_item("ocular_networks:pipe_socket", {
	description="Pipe Socket\n"..minetest.colorize("#00affa", "A locking plate for pipes."),
	inventory_image="poly_pipe_socket_inv.png",
})

ocular_networks.register_item("ocular_networks:pipe_socket_filter", {
	description="Filtered Pipe Socket\n"..minetest.colorize("#00affa", "A locking plate for pipes, with a built-in filter."),
	inventory_image="poly_pipe_socket_inv2.png",
})

ocular_networks.register_item("ocular_networks:silicotin_bar", {
	description="Silicotin Ingot\n"..minetest.colorize("#00affa", "A special version of the alloy SiSn\nresulting from the heat fluctuations in the fuser."),
	inventory_image="poly_silicotin_ingot.png",
})

ocular_networks.register_item("ocular_networks:erena_sphere", {
	description="Stable Erena Core\n"..minetest.colorize("#00affa", "A black hole full of antimatter that keeps it open."),
	inventory_image="poly_power_core.png",
})

ocular_networks.register_item("ocular_networks:barrel", {
	description="Focus Barrel\n"..minetest.colorize("#00affa", "Enhances the power of laser shots."),
	inventory_image="poly_barrel.png",
})

ocular_networks.register_item("ocular_networks:gun_stock2", {
	description="Grip Stock\n"..minetest.colorize("#00affa", "A synthetic stock"),
	inventory_image="poly_stock_2.png",
})

ocular_networks.register_item("ocular_networks:scope", {
	description="Marksman Scope\n"..minetest.colorize("#00affa", "A high-accuracy scope"),
	inventory_image="poly_scope.png",
})

ocular_networks.register_item("ocular_networks:shimmering_bar", {
	description="Shimmering Alloy Ingot\n"..minetest.colorize("#00affa", "A shiny silvery ingot."),
	inventory_image="poly_shimmering_ingot.png",
})

ocular_networks.register_item("ocular_networks:zweinium_crystal_chunk", {
	description="Zweinium Crystal Chunk",
	inventory_image="poly_zweinium_crystal.png",
})

ocular_networks.register_item("ocular_networks:zweinium_crystal", {
	description="Pure Zweinium Crystal",
	inventory_image="poly_zweinium_crystal_pure.png",
})

ocular_networks.register_item("ocular_networks:zweinium_lens", {
	description="Zweinium Crystal Lens",
	inventory_image="poly_zweinium_crystal_lens.png",
})

ocular_networks.register_item("ocular_networks:freeElem_nitrogen", {
	description="Stabilized Nitrogen",
	inventory_image="poly_element.png^[colorize:#0090FF80",
})

ocular_networks.register_item("ocular_networks:freeElem_carbon", {
	description="Stabilized Carbon",
	inventory_image="poly_element.png^[colorize:#55555580",
})

ocular_networks.register_item("ocular_networks:freeElem_hydrogen", {
	description="Stabilized Hydrogen",
	inventory_image="poly_element.png^[colorize:#0000FF80",
})

ocular_networks.register_item("ocular_networks:freeElem_sulfur", {
	description="Stabilized Sulfur",
	inventory_image="poly_element.png^[colorize:#fffb0080",
})

ocular_networks.register_item("ocular_networks:freeElem_silicon", {
	description="Stabilized Silicon",
	inventory_image="poly_element.png^[colorize:#ffffff80",
})

ocular_networks.register_item("ocular_networks:freeElem_iron", {
	description="Stabilized Iron",
	inventory_image="poly_element.png^[colorize:#ff000080",
})

ocular_networks.register_item("ocular_networks:freeElem_gold", {
	description="Stabilized Gold",
	inventory_image="poly_element.png^[colorize:#ffdd0080",
})

ocular_networks.register_item("ocular_networks:freeElem_copper", {
	description="Stabilized Copper",
	inventory_image="poly_element.png^[colorize:#ffa60080",
})

ocular_networks.register_item("ocular_networks:freeElem_tin", {
	description="Stabilized Tin",
	inventory_image="poly_element.png^[colorize:#c2c2c280",
})


ocular_networks.register_item("ocular_networks:superfuel", {
	description="Superfuel",
	inventory_image="poly_fuel_2.png",
})

ocular_networks.register_item("ocular_networks:hammer", {
	description="Compound Hammer",
	inventory_image="poly_hammer.png",
})

ocular_networks.register_item("ocular_networks:dust_luminium", {
	description="Luminium Dust",
	inventory_image="poly_luminium_dust.png",
})

ocular_networks.register_item("ocular_networks:dust_lumigold", {
	description="Lumigold Dust",
	inventory_image="poly_lumigold_dust.png",
})

ocular_networks.register_item("ocular_networks:dust_angmallen", {
	description="Angmallen Dust",
	inventory_image="poly_angmallen_dust.png",
})

ocular_networks.register_item("ocular_networks:dust_silicotin", {
	description="Silicotin Dust",
	inventory_image="poly_silicotin_dust.png",
})

ocular_networks.register_item("ocular_networks:dust_shimmering", {
	description="Shimmering Dust",
	inventory_image="poly_shimmering_dust.png",
})

ocular_networks.register_item("ocular_networks:dust_zweinium", {
	description="Zweinium Dust",
	inventory_image="poly_zweinium_dust.png",
})

ocular_networks.register_item("ocular_networks:dust_slate", {
	description="Toxic Slate Dust",
	inventory_image="poly_slate_dust.png",
})

ocular_networks.register_item("ocular_networks:emitter", {
	description="OCP Emitter",
	inventory_image="poly_emitter.png",
})

ocular_networks.register_item("ocular_networks:plate_luminium", {
	description="Luminium Plate",
	inventory_image="poly_luminium_plate.png",
})

ocular_networks.register_item("ocular_networks:plate_lumigold", {
	description="Lumigold Plate",
	inventory_image="poly_lumigold_plate.png",
})

ocular_networks.register_item("ocular_networks:plate_silicotin", {
	description="Silicotin Plate",
	inventory_image="poly_silicotin_plate.png",
})

ocular_networks.register_item("ocular_networks:plate_shimmering", {
	description="Shimmering Plate",
	inventory_image="poly_shimmering_plate.png",
})

ocular_networks.register_item("ocular_networks:rubber", {
	description="Insulating Rubber",
	inventory_image="poly_rubber.png",
})

ocular_networks.register_item("ocular_networks:ruined_gun", {
	description="Crushed Erena Blaster"..minetest.colorize("#00affa", "\nWhy would you do this?!"),
	inventory_image="poly_blazerifle_e.png",
})

ocular_networks.register_item("ocular_networks:gum", {
	description="Sugary Pulp",
	inventory_image="poly_sugar.png",
})

ocular_networks.register_item("ocular_networks:fertiliser", {
	description="Fertiliser",
	inventory_image="poly_sugar2.png",
})

ocular_networks.register_item("ocular_networks:fibre", {
	description="Natural Fibre",
	inventory_image="poly_fibre.png",
})

ocular_networks.register_item("ocular_networks:dagnabbitite", {
	description=minetest.colorize("#00affa", "Dagnabbitite"),
	inventory_image="poly_dagnabbitite.png",
})
