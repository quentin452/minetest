
ocular_networks.pumpable_liquids={}

ocular_networks.register_node("ocular_networks:luminium_source", {
	description="Luminium Source",
	drawtype="liquid",
	tiles={
		{name="poly_lumi_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:luminium_flowing",
	liquid_alternative_source="ocular_networks:luminium_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=0, g=64, b=200},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:luminium_flowing", {
	description="Flowing Luminium",
	drawtype="flowingliquid",
	tiles={"poly_lumi_liq.png"},
	special_tiles={
		{
			name="poly_lumi_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_lumi_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:luminium_flowing",
	liquid_alternative_source="ocular_networks:luminium_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=0, g=64, b=200},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:luminium_source",
	"ocular_networks:luminium_flowing",
	"ocular_networks:bucket_luminium",
	"bucket.png^poly_luminium_liq.png",
	"Bucket of Molten Luminium"
)

ocular_networks.pumpable_liquids["ocular_networks:luminium_source"]="ocular_networks:bucket_luminium"

ocular_networks.register_node("ocular_networks:lumigold_source", {
	description="Lumigold Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_lumig_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:lumigold_flowing",
	liquid_alternative_source="ocular_networks:lumigold_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=50, g=64, b=0},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:lumigold_flowing", {
	description="Flowing Lumigold",
	drawtype="flowingliquid",
	tiles={"poly_lumig_liq.png"},
	special_tiles={
		{
			name="poly_lumig_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_lumig_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:lumigold_flowing",
	liquid_alternative_source="ocular_networks:lumigold_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=50, g=64, b=0},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:lumigold_source",
	"ocular_networks:lumigold_flowing",
	"ocular_networks:bucket_lumigold",
	"bucket.png^poly_lumigold_liq.png",
	"Bucket of Molten Lumigold"
)

ocular_networks.pumpable_liquids["ocular_networks:lumigold_source"]="ocular_networks:bucket_lumigold"

ocular_networks.register_node("ocular_networks:gold_source", {
	description="Gold Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_gold_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:gold_flowing",
	liquid_alternative_source="ocular_networks:gold_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=40, g=64, b=0},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:gold_flowing", {
	description="Flowing Gold",
	drawtype="flowingliquid",
	tiles={"poly_gold_liq.png"},
	special_tiles={
		{
			name="poly_gold_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_gold_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:gold_flowing",
	liquid_alternative_source="ocular_networks:gold_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=40, g=64, b=0},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:gold_source",
	"ocular_networks:gold_flowing",
	"ocular_networks:bucket_gold",
	"bucket.png^poly_gold_bliq.png",
	"Bucket of Molten Gold"
)

ocular_networks.pumpable_liquids["ocular_networks:gold_source"]="ocular_networks:bucket_gold"

ocular_networks.register_node("ocular_networks:steel_source", {
	description="Steel Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_steel_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:steel_flowing",
	liquid_alternative_source="ocular_networks:steel_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=200, g=200, b=200},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:steel_flowing", {
	description="Flowing Steel",
	drawtype="flowingliquid",
	tiles={"poly_steel_liq.png"},
	special_tiles={
		{
			name="poly_steel_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_steel_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:steel_flowing",
	liquid_alternative_source="ocular_networks:steel_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=200, g=200, b=200},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:steel_source",
	"ocular_networks:steel_flowing",
	"ocular_networks:bucket_steel",
	"bucket.png^poly_steel_bliq.png",
	"Bucket of Molten Steel"
)

ocular_networks.pumpable_liquids["ocular_networks:steel_source"]="ocular_networks:bucket_steel"

ocular_networks.register_node("ocular_networks:copper_source", {
	description="Copper Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_copper_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:copper_flowing",
	liquid_alternative_source="ocular_networks:copper_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=250, g=200, b=0},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:copper_flowing", {
	description="Flowing Copper",
	drawtype="flowingliquid",
	tiles={"poly_copper_liq.png"},
	special_tiles={
		{
			name="poly_copper_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_copper_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:copper_flowing",
	liquid_alternative_source="ocular_networks:copper_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=250, g=200, b=0},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

ocular_networks.pumpable_liquids["ocular_networks:copper_source"]="ocular_networks:bucket_copper"

bucket.register_liquid(
	"ocular_networks:copper_source",
	"ocular_networks:copper_flowing",
	"ocular_networks:bucket_copper",
	"bucket.png^poly_copper_bliq.png",
	"Bucket of Molten Copper"
)

ocular_networks.register_node("ocular_networks:bronze_source", {
	description="Bronze Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_bronze_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:bronze_flowing",
	liquid_alternative_source="ocular_networks:bronze_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=150, g=100, b=0},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:bronze_flowing", {
	description="Flowing Bronze",
	drawtype="flowingliquid",
	tiles={"poly_bronze_liq.png"},
	special_tiles={
		{
			name="poly_bronze_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_bronze_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:bronze_flowing",
	liquid_alternative_source="ocular_networks:bronze_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=150, g=100, b=0},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:bronze_source",
	"ocular_networks:bronze_flowing",
	"ocular_networks:bucket_bronze",
	"bucket.png^poly_bronze_bliq.png",
	"Bucket of Molten Bronze"
)

ocular_networks.pumpable_liquids["ocular_networks:bronze_source"]="ocular_networks:bucket_bronze"

ocular_networks.register_node("ocular_networks:tin_source", {
	description="Tin Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_tin_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:tin_flowing",
	liquid_alternative_source="ocular_networks:tin_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=100, g=100, b=200},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:tin_flowing", {
	description="Flowing Tin",
	drawtype="flowingliquid",
	tiles={"poly_tin_liq.png"},
	special_tiles={
		{
			name="poly_tin_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_tin_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:tin_flowing",
	liquid_alternative_source="ocular_networks:tin_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=100, g=100, b=200},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:tin_source",
	"ocular_networks:tin_flowing",
	"ocular_networks:bucket_tin",
	"bucket.png^poly_tin_bliq.png",
	"Bucket of Molten Tin"
)

ocular_networks.pumpable_liquids["ocular_networks:tin_source"]="ocular_networks:bucket_tin"

ocular_networks.register_node("ocular_networks:angmallen_source", {
	description="Angmallen Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_angmallen_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:angmallen_flowing",
	liquid_alternative_source="ocular_networks:angmallen_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=100, g=100, b=200},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:angmallen_flowing", {
	description="Flowing Angmallen",
	drawtype="flowingliquid",
	tiles={"poly_angmallen_liq.png"},
	special_tiles={
		{
			name="poly_angmallen_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_angmallen_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:angmallen_flowing",
	liquid_alternative_source="ocular_networks:angmallen_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=100, g=100, b=200},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:angmallen_source",
	"ocular_networks:angmallen_flowing",
	"ocular_networks:bucket_angmallen",
	"bucket.png^poly_angmallen_bliq.png",
	"Bucket of Molten Angmallen"
)

ocular_networks.pumpable_liquids["ocular_networks:angmallen_source"]="ocular_networks:bucket_angmallen"

ocular_networks.register_node("ocular_networks:hekatonium_source", {
	description="Hekatonium Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_hekatonium_liq_source.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:hekatonium_flowing",
	liquid_alternative_source="ocular_networks:hekatonium_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=0, g=64, b=200},
	groups={liquid=2, igniter=1},
})

ocular_networks.register_node("ocular_networks:hekatonium_flowing", {
	description="Flowing Hekatonium",
	drawtype="flowingliquid",
	tiles={"poly_hekatonium_liq.png"},
	special_tiles={
		{
			name="poly_hekatonium_liq_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_hekatonium_liq_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:hekatonium_flowing",
	liquid_alternative_source="ocular_networks:hekatonium_source",
	liquid_viscosity=7,
	liquid_renewable=false,
	damage_per_second=8,
	post_effect_color={a=100, r=0, g=64, b=200},
	groups={liquid=2, igniter=1,
		not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:hekatonium_source",
	"ocular_networks:hekatonium_flowing",
	"ocular_networks:bucket_hekatonium",
	"bucket.png^poly_hekatonium_bliq.png",
	"Bucket of Molten Hekatonium"
)

ocular_networks.pumpable_liquids["ocular_networks:hekatonium_source"]="ocular_networks:bucket_hekatonium"

ocular_networks.register_node("ocular_networks:zweinium_source", {
	description="Unstable Zweinium Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_zweinium_flux.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:zweinium_flowing",
	liquid_alternative_source="ocular_networks:zweinium_source",
	liquid_viscosity=0,
	liquid_renewable=false,
	post_effect_color={a=100, r=68, g=246, b=92},
	groups={liquid=2},
})

ocular_networks.register_node("ocular_networks:zweinium_flowing", {
	description="Flowing Unstable Zweinium",
	drawtype="flowingliquid",
	tiles={"poly_zweinium_flux_b.png"},
	special_tiles={
		{
			name="poly_zweinium_flux_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_zweinium_flux_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:zweinium_flowing",
	liquid_alternative_source="ocular_networks:zweinium_source",
	liquid_viscosity=0,
	liquid_renewable=false,
	post_effect_color={a=100, r=68, g=246, b=92},
	groups={liquid=2,	not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:zweinium_source",
	"ocular_networks:zweinium_flowing",
	"ocular_networks:bucket_zweinium",
	"bucket.png^poly_zwei_bliq.png",
	"Bucket of Unstable Zweinium"
)

ocular_networks.pumpable_liquids["ocular_networks:zweinium_source"]="ocular_networks:bucket_zweinium"

ocular_networks.register_node("ocular_networks:coolant_source", {
	description="Nitrogen Coolant Source",
	drawtype="liquid",
	tiles={
		{
			name="poly_coolant.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
			},
		},
	},
	paramtype="light",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="source",
	liquid_alternative_flowing="ocular_networks:coolant_flowing",
	liquid_alternative_source="ocular_networks:coolant_source",
	liquid_viscosity=0,
	liquid_renewable=false,
	post_effect_color={a=100, r=68, g=246, b=92},
	groups={liquid=2},
})

ocular_networks.register_node("ocular_networks:coolant_flowing", {
	description="Flowing Nitrogen Coolant",
	drawtype="flowingliquid",
	tiles={"poly_coolant_b.png"},
	special_tiles={
		{
			name="poly_coolant_flowing.png",
			backface_culling=false,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
		{
			name="poly_coolant_flowing.png",
			backface_culling=true,
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.3,
			},
		},
	},
	paramtype="light",
	paramtype2="flowingliquid",
	light_source=default.LIGHT_MAX - 1,
	walkable=false,
	pointable=false,
	diggable=false,
	buildable_to=true,
	is_ground_content=false,
	drop="",
	drowning=1,
	liquidtype="flowing",
	liquid_alternative_flowing="ocular_networks:coolant_flowing",
	liquid_alternative_source="ocular_networks:coolant_source",
	liquid_viscosity=0,
	liquid_renewable=false,
	post_effect_color={a=100, r=68, g=246, b=92},
	groups={liquid=2,	not_in_creative_inventory=1},
})

bucket.register_liquid(
	"ocular_networks:coolant_source",
	"ocular_networks:coolant_flowing",
	"ocular_networks:bucket_coolant",
	"bucket.png^poly_coolant_bliq.png",
	"Bucket of Nitrogen Coolant"
)

ocular_networks.pumpable_liquids["ocular_networks:coolant_source"]="ocular_networks:bucket_coolant"
ocular_networks.pumpable_liquids["default:water_source"]="bucket:bucket_water"
ocular_networks.pumpable_liquids["default:river_water_source"]="bucket:bucket_river_water"
ocular_networks.pumpable_liquids["default:lava_source"]="bucket:bucket_lava"
