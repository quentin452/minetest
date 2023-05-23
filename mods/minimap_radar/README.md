# Minimap Radar [minimap_radar]

[![luacheck](https://github.com/OgelGames/minimap_radar/workflows/luacheck/badge.svg)](https://github.com/OgelGames/minimap_radar/actions)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%204.0-green.svg)](LICENSE.md)
[![Minetest](https://img.shields.io/badge/Minetest-5.3+-blue.svg)](https://www.minetest.net)
[![ContentDB](https://content.minetest.net/packages/OgelGames/minimap_radar/shields/downloads/)](https://content.minetest.net/packages/OgelGames/minimap_radar/)

## Table of Contents

- [Overview](#overview)
- [Usage](#usage)
- [Crafting](#crafting)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [License](#license)

## Overview

A simple extension to Minetest Game's `map` mod, this mod adds a single craftable item, that when placed in a player's inventory, enables the use of the radar mode of the minimap.

![Overview Image](images/overview.png?raw=true "Overview Image")

## Usage

1. Craft (or give yourself) the Radar item (see crafting below).
2. Place the Radar item anywhere in your inventory.
3. Use the **Minimap** key to toggle the minimap on, and switch between modes.

Note that the Radar item also enables the surface mode of the minimap, which means you don't need to carry a Mapping Kit in your inventory if you have a Radar item.

## Crafting

The crafting recipe for the Radar item changes depending on which mods are installed:

- Minetest Game only:

![Default Recipe](images/default_recipe.png?raw=true "Default Recipe")

- With Moreores installed:

![Moreores Recipe](images/moreores_recipe.png?raw=true "Moreores Recipe")

- With Technic installed:

![Technic Recipe](images/technic_recipe.png?raw=true "Technic Recipe")

## Dependencies

**Required**

- `default` (included in [Minetest Game](https://github.com/minetest/minetest_game))
- `dye` (included in [Minetest Game](https://github.com/minetest/minetest_game))
- `map` (included in [Minetest Game](https://github.com/minetest/minetest_game))

## Installation

Download the [master branch](https://github.com/OgelGames/minimap_radar/archive/master.zip) or the [latest release](https://github.com/OgelGames/minimap_radar/releases), and follow [the usual installation steps](https://dev.minetest.net/Installing_Mods).

Alternatively, you can download and install the mod from [ContentDB](https://content.minetest.net/packages/OgelGames/minimap_radar) or the online content tab in Minetest.

## License

Except for any exceptions stated in [LICENSE.md](LICENSE.md#exceptions), all code is licensed under the [MIT License](LICENSE.md#mit-license), with all textures, models, sounds, and other media licensed under the [CC BY-SA 4.0 License](LICENSE.md#cc-by-sa-40-license). 
