# X Tumbleweed [x_tumbleweed]

Adds tumbleweed.

![screenshot](screenshot.png)

## Features

* spawns in desert, sandstone desert and cold desert by default
* have a ~33% change to split down to smaller tumbleweeds when broken
* drops decoration items from the biome where it was broken
* has various sizes and textures
* punching the tumbleweed will make it change direction

## API

Class

`XTumbleweed`

Methods

`add_allowed_biomes(biomes: string[]): void`

Add biome names to XTumbleweed allowed biomes list so the tumbleweed can spawn in them.

example
```lua
XTumbleweed:add_allowed_biomes({
    'everness_forsaken_desert',
    'everness_forsaken_desert_ocean',
    'everness_forsaken_desert_under',
    'everness_baobab_savanna'
})
```

## Dependencies

- mobkit

## Optional Dependencies

- none

## License:

### Code

GNU Lesser General Public License v2.1 or later (see included LICENSE file)

### Textures

**CC-BY-SA-4.0, Pixel Perfection by XSSheep**, https://minecraft.curseforge.com/projects/pixel-perfection-freshly-updated

- x_tumbleweed_death_particle_animated.png

**CC-BY-SA-4.0, by SaKeL**

- x_tumbleweed_tumbleweed_1.png
- x_tumbleweed_tumbleweed_2.png
- x_tumbleweed_tumbleweed_3.png
- x_tumbleweed_tumbleweed_mask_1.png
- x_tumbleweed_tumbleweed_mask_2.png
- x_tumbleweed_tumbleweed_mask_3.png

### Models

**CC-BY-SA-4.0, by SaKeL**

- x_tumbleweed_tumbleweed.b3d

### Sounds

**CC-BY-4.0, by duckduckpony**, https://freesound.org

- x_tumbleweed_tumbleweed.1.ogg
- x_tumbleweed_tumbleweed.2.ogg
- x_tumbleweed_tumbleweed.3.ogg

## Installation

see: https://wiki.minetest.net/Installing_Mods
