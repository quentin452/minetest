armor:register_armor("zarmor:hat_head", {
    description = "Hat",
    inventory_image = "inv_hat.png",
    groups = {armor_head=1, armor_heal=6, armor_use=300,
        physics_speed=-0.02, physics_gravity=0.02},
    armor_groups = {fleshy=10},
    damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
})

armor:register_armor("zarmor:Jacket_torso", {
    description = "Jacket",
    inventory_image = "inv_Jacket.png",
    groups = {armor_torso=1, armor_heal=6, armor_use=300,
        physics_speed=-0.05, physics_gravity=0.05},
    armor_groups = {fleshy=15},
    damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
})


armor:register_armor("zarmor:jeanspants_legs", {
    description = "jeans pants",
    inventory_image = "inv_jeanspants.png",
    groups = {armor_legs=1, armor_heal=6, armor_use=300,
        physics_speed=-0.04, physics_gravity=0.04},
    armor_groups = {fleshy=15},
    damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
})


armor:register_armor("zarmor:tennis_feet", {
    description = "Tennis",
    inventory_image = "inv_tennis.png",
    groups = {armor_feet=1, armor_heal=6, armor_use=300,
        physics_speed=-0.02, physics_gravity=0.02},
    armor_groups = {fleshy=10},
    damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
})