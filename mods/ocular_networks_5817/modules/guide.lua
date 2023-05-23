
local function format(t)
	return minetest.formspec_escape(minetest.colorize("#000000", t))
end

guideBooks.Common.register_guideBook("ocular_networks:guide", {
	inventory_image="poly_guide.png",
	description_short=minetest.colorize("#00affa", "Compendium Of Eyes"),
	description_long=minetest.colorize("#888888", "The Ocular Networks guidebook"),
	style={
		cover={
			bg="poly_abc_guide_cover.png",
			next="poly_abc_guide_arrownext.png",
			w=7
		},
		defaultTextColor="956D37",
		page={
			bg="poly_abc_guide_page.png",
			next="poly_abc_guide_arrownext.png",
			prev="poly_abc_guide_arrowprev.png",
			start="poly_abc_guide_arrowup.png",
			w=14
		},
		buttonGeneric="poly_abc_guide_btn.png"
	}
})

guideBooks.Common.register_section("ocular_networks:guide","tutorial", {
	description="Getting Started"
})
guideBooks.Common.register_page("ocular_networks:guide", "tutorial", 1, {
	text1=format([[
	To make proper use of Ocular Networks, there are a few things you must first know. 
	The main concept of Ocular Networks is, of course, networks. Each player has three networks which only they can access, unless they give access to someone else.
	These networks are:
	The power network, which transmits ocular power through invisible light beams and optical cables,
	The item network, which moves items through physical pipes or teleportation, 
	and the data network, which sends and recieves wireless signals to allow complex computations and decision making.
	
	When working in unison these networks can create powerful machines, factories and even computers. 
	This first chapter will cover how to begin working with each of these concepts and pave the way for you	to start making more complex systems.
	
	There are, however, many things you must find out for yourself.
	]]), 
	text2=format([[
	You should start by amassing a sizeable amount of gold, copper, iron, and luminium. Luminium can be found below y level -1000 and glows slightly.
	Make some lumigold (you need about as much lumigold as luminium) by crafting a gold ingot with a luminium ingot and smelting the resulting item.
	Next find some slate by digging below the desert stone in a desert biome. 
	Once you have these you can make a solar battery and some golden frames.
	You'll also need to make a silver lens using silver sand. 
	Place the battery somewhere with no artificial light (torches, lamps, fire, lava) and place a golden frame on top of it. 
	Right-click the frame with the silver lens, and the battery will start making power.
	
	In order to move the power around and use it in machines you'll need to make some power collectors, power reservoirs, and network nodes.
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","materials", {
	description="Materials",
	master=1
})
guideBooks.Common.register_section("ocular_networks:guide","luminium", {
	description="Luminium",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "luminium", 1, {
	text1=format([[
	Luminium is a glowing, light blue metal. It has the useful ability to turn eletrical current into invisible light beams and vice versa. Its main use is wireless power transfer, but it can do many other things.
	]]), 
	text2=format([[
		Found: In stone, below y -1000
		Color: blue, low saturation / violet, energized
		Notes: ore glows faintly
	]]),
	extra=[[]]
})
guideBooks.Common.register_section("ocular_networks:guide","lumigold", {
	description="Lumigold",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "lumigold", 1, {
	text1=format([[
	Lumigold is a very conductive alloy of luminium and gold. It rivals steel in strength and hardness, but is about 15% heavier.
	]]), 
	text2=format([[
		Found: Must be crafted
		Color: gold, low purity / pastel yellow, very pure
		Notes: antimicrobial
	]]),
	extra=[[]]
})
guideBooks.Common.register_section("ocular_networks:guide","silic", {
	description="Silicotin",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "silic", 1, {
	text1=format([[
	Silicotin is a curious version of the alloy SiSn, with some extra stuff thrown in. It's about 20% tin, 76% silicon, and 4% mixed metals.
	]]), 
	text2=format([[
		Found: Must be crafted
		Color: dull blue, silver when draw-forged
		Notes: acts almost like rubber under most conditions, will not dent
	]]),
	extra=[[]]
})
guideBooks.Common.register_section("ocular_networks:guide","angmallen", {
	description="Angmallen",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "angmallen", 1, {
	text1=format([[
	Angmallen is an alloy of iron and gold, held together by powerful magnetic forces.
	When exposed to enough electrical current the bonds become so strong that most conventional tools won't affect it.
	]]), 
	text2=format([[
		Found: Must be crafted
		Color: orange-yellow / blue-purple when energized
		Notes: is somehow lighter than the sum of its parts, don't ask too many
		questions.
	]]),
	extra=[[]]
})
guideBooks.Common.register_section("ocular_networks:guide","zweinium", {
	description="Zweinium",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "zweinium", 1, {
	text1=format([[
	Zweinium is a green crystallized version of toxic slate, with almost no flaws in the average crystal. Perfect for focusing light.
	]]), 
	text2=format([[
		Found: In toxic slate deposits
		Color: soft green
		Notes: it's clarity makes it perfect for carrying information
	]]),
	extra=[[]]
})
guideBooks.Common.register_section("ocular_networks:guide","shimmering", {
	description="Shimmering Alloy",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "shimmering", 1, {
	text1=format([[
	An alloy of iron and whatever makes silver sand shiny. 
	Good at preventing interference in sensitive systems.
	]]), 
	text2=format([[
		Found: must be crafted
		Color: white
	]]),
	extra=[[]]
})
guideBooks.Common.register_section("ocular_networks:guide","heka", {
	description="Hekatonium",
	slave="materials",
})
guideBooks.Common.register_page("ocular_networks:guide", "heka", 1, {
	text1=format([[
	An insanely hard, strong metal. Its structure allows it to dissipate incurred energy damage to nearby ferrous objects.
	]]), 
	text2=format([[
		Found: deep in the earth
		Color: dark violet / neon purple when energized
		Notes: in plasma form it is attracted very strongly to its solid 
		counterpart
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","reactor", {
	description="The Hekaton Reactor"
})
guideBooks.Common.register_page("ocular_networks:guide", "reactor", 1, {
	text1=format([[
	The hekaton reactor will generate huge amounts of power, but it needs a constant supply of fuel and coolant, as well as a multiblock structure.
	
	Firstly, place the hekaton core where you want it.
	secondly, place firebricks on all faces but the top, you should need 5.
	Next, place a pipe storage crate on top - this will be your interface point.
	
	To operate the reactor, place superfuel and nitrogen coolant in the crate. 
	You need 1 coolant for every 50 superfuel, otherwise the core will overheat and explode.
	]]), 
	text2=format([[
		The explosion from the reactor melting down is small, but destructive. 
		Automation of the coolant and fuel injection can help to alleviate the danger of an explosion.
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","data", {
	description="The Data Network"
})
guideBooks.Common.register_page("ocular_networks:guide", "data", 1, {
	text1=format([[
	The Data Network is a very versatile utility for automating machines.
	The main tools are: 
	- network uplinks and downlinks, used to read fields from nodes or
	activate/deactivate systems
	- network processors and terminals, used to repeatedly run a series of commands or enter commands directly. These also have storage.
	
	All of these tools act on Channels, which are public and unprotected global settings that can have a string, number, or table value.	There are no private channels.
	
	]]), 
	text2=format([[
	A list of commands can be obtained by running 'help' in a terminal. 
	It should be noted that: 
	1. comments can't contain spaces, so use underscores or	dots.
	2. When you set a channel's value, a '$' is atomatically added in front of the channel name. (so 'let a=>hello' sets $a to 'hello', not a.)
	3. The 'if' command only works with strict equality; no other operators will work. (This will change in the future)
	4. The multi-purpose tablet is the same as a terminal, but wireless	and without a storage utility.
	]]),
	extra=[[]]
})


guideBooks.Common.register_page("ocular_networks:guide", "data", 2, {
	text1=format([[
	Finally, you can comment a line using '#'.
	A quick example of a valid program (in a terminal or processor):
	
	# my.program_1.1_foobar
	let my_channel=foo
	append channel_2=$my_channel+bar
	get $channel_2
	
	This should output:
	foobar
	]]), 
	text2=format([[
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","armor", {
	description="Armor & Upgrades"
})

guideBooks.Common.register_page("ocular_networks:guide", "armor", 1, {
	text1=format([[
	Angmallen and hekatonium armor can be upgraded with angmallen upgrade tokens using an upgrade pendant, performance controller, or multi-purpose tablet.
	]]), 
	text2=format([[
	Cybernetic parts can be used to give yourself extra functionality. They can be added using a performance controller or multi-purpose tablet.
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","machines", {
	description="Basic Mechanisms"
})
guideBooks.Common.register_page("ocular_networks:guide", "machines", 1, {
	text1=format([[
	Ocular Networks provides many machines and devices for processing, transporting, and producing items, liquids, and power. This chapter will detail the purpose and operation of these machines, as well as some lore/flavor text.
	]]), 
	text2=format([[
	The Metal Melter is a basic mechanism which will take a block of any default or Ocular Networks metal, and melt it into a liquid source. This liquid will appear below the melter.
	The melter will take power from any block above itself that contains power. Metal can be inserted using a pipe.
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines", 2, {
	text1=format([[
	The Mixer Centrifuge mixes liquid metals together by spinning them in alternating directions. It accepts power from any power block above itself, and outputs into an internal inventory.
	Pipes can be used to extract items from the output, but an omni-insertor will be required to insert items into the inputs.
	]]), 
	text2=format([[
	The Fusion compressor functions similarly to the metal melter, but instead of mixing molten metals together it fuses solid items together. It accepts power from above, and outputs into an internal inventory. It also produces a waste product, which falls out the bottom.
	Pipes can be used to extract the created item, but like the mixer, an omni insertor is required to add items. 
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines", 3, {
	text1=format([[
	The Pneumatic Pulverizer allows the grinding of items using power. It takes power from below, and outputs into its on inventory. Pipes may be used for insertion and extraction of items.
	]]), 
	text2=format([[
	The Panel Forge works similarly to the pulverizer, but rather than grinding the resulting item it flattens it into a plate. It takes power from above, and is fully pipe-enabled.
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines", 4, {
	text1=format([[
	The Passive Cooler cools buckets of molten metal into full blocks. It requires no power, and is fully pipe-enabled.
	]]), 
	text2=format([[
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","machines2", {
	description="Basic Generators"
})

guideBooks.Common.register_page("ocular_networks:guide", "machines2", 1, {
	text1=format([[
	The steam battery generates substantial amounts of power when a lava source block is above, a river water source block is below, and the four side faces are covered with machine structure blocks.
	Power can be collected using a Power Collector.
	]]), 
	text2=format([[
	The Photosynthesis Battery generates power when placed above a gearbox, and a grass plant is above it. The power generated is based on the height of the grass.
	]]),
	extra=[[]]
})

guideBooks.Common.register_section("ocular_networks:guide","machines3", {
	description="Advanced Machinery"
})

guideBooks.Common.register_page("ocular_networks:guide", "machines3", 1, {
	text1=format([[
	On top of the standard set of machines, Ocular Networks provides a set of more complex and specialized mechanisms for all manner of tasks.
	]]), 
	text2=format([[
	The Fluid Collector and Fluid Depositor allow liquids to be pumped through normal pipes and pipe crates without the need for buckets. They require no power, and can pump any liquid. 
	Additionally, tanks can be made that interface wih pipes, so mass liquid storage is very simple.
	Finally, the fluid transposer will, when supplied with buckets, take any liquids pumped into it and fill a bucket with it. This can then be piped out.
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines3", 2, {
	text1=format([[
	The Phytogenic Cultivator accelerates the growth of plants when supplied with fertilizer. It is fully pipe-enabled and takes power from below.
	]]), 
	text2=format([[
	The Charging Station infuses items with OCP power. It takes power from above, and is fully pipe-enabled.
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines3", 3, {
	text1=format([[
	The Chemical Oven breaks down items into their constituent chemicals using OCP. It can optionally be fueled with peat to halve the cost of power. It is fully pipe-enabled and accepts power from above.
	]]), 
	text2=format([[
	The Power Cell Packager and Electrofraction Generator respectively allow conversion of OCP into basic machines power cells and technic MV EU. They take power from below.
	The power cell packager outputs into its own inventory, while the electrofraction generator connects to an MV cable.
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines3", 4, {
	text1=format([[
	The Universe Tether will keep the mapblock it is placed in loaded forever. It needs no power.
	]]), 
	text2=format([[
	The Laser Drill is a multipart machine that digs a long, straight 1x1 hole. It consists of a laser drill head with a laser drill controller above, and a frame with a lens below. The drill requires power to be inserted into the controller via a network downlink.
	It outputs into the controller's inventory, which can be emptied via a pipe.
	]]),
	extra=[[]]
})

guideBooks.Common.register_page("ocular_networks:guide", "machines3", 5, {
	text1=format([[
	The Fresnel Furnace functions like a normal furnace, but it is much faster and uses OCP instead of coal. It takes power from below and is fully pipe enabled.
	]]), 
	text2=format([[
	The Optical Power controller will distribute any and all power inserted into it via a network node evenly between any connected optical reservoirs. Reservoirs need to be connected via a fiber optic cable.
	]]),
	extra=[[]]
})