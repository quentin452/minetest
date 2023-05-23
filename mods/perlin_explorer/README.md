# Perlin Explorer [`perlin_explorer`]

Version: 1.0.3

Perlin Explorer is a mod for Minetest to allow to test and experiment around with Perlin noises.

This is especially useful for game and mod developers who want to fine-tune the noises in an
efficient manner. It’s also useful to discover useful noise parameters for the various
mapgen settings in Minetest.

This mod uses Minetest’s builtin Perlin noise, so the same rules apply here.
Refer to Minetest’s documentation to learn about noise parameters.

## /!\ WARNING WARNING WARNING /!\

This mod can aggressively **grief** your world due to its
mapgen feature! Don’t use it in worlds with buildings
you care about.

**NEVER** use this mod on a public server, it has not been
security-tested.

## Features

* Powerful noise parameter editor to quickly adjust parameters
* Look up Perlin noise value at a given position
* Special nodes to represent noise values
	* Color denotes value, cutoff points can be customized
	* Choose between solid nodes, transparent grid nodes, and tiny climbable cube nodes
* Generate a small portion of the noise as map at a given area
* Enable “mapgen mode” to automatically generate nodes as you move around
* Load predefined Perlin noises from the Minetest configuration
* Save noise parameters into profiles for later use
* Mathematical and statistical analysis of noises

## Usage
### Before you begin
This document assumes you already have a rough understanding of what
Perlin noises are used for.

To use this mod, create a brand new world to avoid accidents.

Everything in this mod requires the `server` privilege, so obtain
this privilege as well.

### Overview
The main feature and tool in this mod is the Perlin Noise Creator. Using
this item opens a window in which you can view, modify, analyze and
manage noise parameters, generate nodes and perform some basic
analysis.

### What are noise parameters?
These are used by Minetest for the Perlin noises.
Perlin noises are used for various things such as generating the world,
decorations (trees, plants, etc.), ores, biomes and much more.

And noise parameters are, well, the parameters that are used
to tweak the Perlin noises. They change the output numbers,
they stretch or squeeze the noise, they make more or less
detailed, and more.

The Perlin Explorer mod’s main use case is to allow you to
try out various parameters and to modify them in a quick
manner so you can quickly get results. This is much more
efficient than tweaking the noise in the Minetest settings
or Lua code.

This document is *not* an introduction to Perlin noises
and noise parameters themselves! Please refer to the Minetest
Lua API documentation to learn more.

### Active noise
This mod heavily relies on something called the “active noise”
(or “active noise parameters”). These are the noise parameters
and options that the mod will use for various operations, like
getting values, generating nodes, using mapgen mode, etc. The “Apply” button
in the Perlin Noise Creator tool sets the active noise.
There can only be one active noise parameters. Also, the active
noise is always valid; if you enter invalid noise parameters,
the mod refuses them for the active noise.

Initially, there are no active noise parameters, so you have
to push the “Apply” button mentioned before first.

### The tools
This section explains the various tools you have at your disposal.
These tools are items, so check out your Creative Inventory
(or something similar) to get them.

#### Perlin Noise Creator
This is the main tool of this mod. Hold this item in hand and punch
to open a window.

The window has multiple sections:

* Noise parameters: You specify noise parameters here
* Noise options: This is how the noise parameters are being interpreted
* Node generation: Stuff you need to specify when you want to generate
  a chunk (or chunks) of nodes

##### Noise parameters

This section has 2 parts: The top part is a list of profiles.
An explanation for that is below.

The bottom part contains the actual noise parameters:

* Offset
* Scale
* Seed
* X/Y/Z Spread
* Octaves
* Persistence
* Lacunarity
* Flags (defaults, eased, absvalue)

Please refer to Minetest Lua API documentation for a definition.
This mod enforces a few sanity checks on some for the values,
i.e. octaves can’t be lower than 1.

**Hint**: If you hit “Enter” while the focus is on any of the noise
parameters, this is the same as if you clicked “Accept” or “Accept
and create” (see below). Use this to your advantage to quickly
tweak a particular value.

The little dice button randomizes the seed, it’s a simple
convenience.

The “Analyze” button shows you some basic info about the
noise parameters as displayed in the form. First, the
theoretical minimum and maximum possible value
of the entire noise.
Then, the “wavelengths” for each axis. This means across
how many nodes (roughly) the noise is stretched out, specified
for each octave, beginning with the first.
If any wavelength reaches a number lower than 1, it will be
shown in red because this means your noise parameters are invalid.
If this happens, either increase the spread or decrease the octaves
or lacunarity.

**Note**: The Analyze feature uses the noise parameters as they
are displayed in the form, *not* the *active* noise parameters.
This is because the active noise must always be valid.

###### Profiles
A profile is just noise parameters that you can load for later use.
It’s a convenience feature.
The drop-down list to the left is the list of all profiles.
This list contains three types of profiles:

* Active noise parameters: Special profile that represents
  the currently active noise. Can not be deleted.
* Builtin profiles are the noise parameters
  of the official Minetest mapgens, loaded from settings.
  Their name always begins with `mg_`
  Can not be deleted.
* User profiles: These are your profiles, you can
  add and remove them at will. These are named like
  “Profile 1”

User profiles will also automatically saved on disk so they
get restored when restarting the world.

The buttons do the following:

* Add: Save the current noise parameters into a new user profile
* Load: Load the currently selected profile and replace the
        input fields
* Delete: Delete the currently selected user profile (not possible
          for non-user profiles)

##### Noise options
This section roughly says how the noise parameters are “interpreted”.
These fields are available:

* Number of dimensions (2D or 3D)
    * 2D: Noise is 2-dimensional. In the world, only the X and Z
      coordinates are used. The Y coordinate is ignored.
    * 3D: Noise uses the same 3 dimensions as the Minetest world,
      with X, Y and Z coordinates.
* Pixelization: If this number is higher than 1, the noise values
  will be repeated for this number of nodes, along every axis.
  This gives a “pixelized”/“voxelized” look. You normally don’t need
  this but it’s useful to emulate the `sidelen` parameter of
  mapgen decorations (relevant for game development)
* Statistics: Will calculate tons of values (without generating
  nodes) in a predefined area/volume to make some statistics. This
  will take a while to do so.
  The main feature is a histogram which shows which values were the most
  common. The first row shows the percentage, the 2nd and 3rd row show
  the maximum and minimum value of that column. For example,
  if the column says “31.4%”, “0.0” for “Max.” and “-4.2” for “Min.” that means
  that 31.4% of all values that were calculated were greater than or equal
  to -4.2, but smaller than 0.
  The statistics always distributes the values into “buckets” of
  equal sizes, beginning with the lowest theoretical value and
  ending with the highest one.
  The histogram is useful if you want to see how common or rare
  each value is.
  **Note**: This button will calculate statistics of the noise settings
  as they were displayed in the form. It does *not* use the active noise.

##### Node generation

Playing around with parameters isn’t very useful if you don’t
get a visual result. That’s where the node generation comes
into play. Here you specify parameters for generating nodes
from the noise.
All noise values are either high or low; they are divided
by the **midpoint**: Values equal to or higher than the
midpoint are high, otherwise low.

In 2D mode, the mapgen will be a flat XZ plane with nodes.

In 3D mode, the mapgen will place nodes at every position
in the 3D world.

###### Build modes

The drop-down list to the bottom right stands for the
“build modes”. This sets for which noise values nodes
will be generated:

* Auto: In 2D mode, generate nodes for every value,
        in 3D mode, only generate nodes for high values
* All: Generate nodes for every value
* High only: Only generate nodes for high values
* Low only: Only generate nodes for low values

###### Node visualization

Generated nodes will be color-coded, which stands for the value:

* White to yellow to orange: High values
* Light blue to blue (with a small dot): Low values

There are two parameters:

* Low color at: The lowest noise value at which the
  color gradient for low noise values begins.
* High color at: The highest noise value at which the
  color gradient for high noise values ends.

The low color gradient begins at the “Low color at”
setting and ends right before the the midpoint.
The high color gradient begins at the midpoint
and ends at the ”High color at” setting.

For example, if 0 is the midpoint, and the “low/high color”
settings are -1 and 1, respectively, all values below 0 (the
midpoint) will use the ‘low values’ color gradient and all
values above 0 will use the ‘high values’ color gradient.
All values at -1 and below will have the “extreme low”
color (dark blue) and all values at 1 or above will have the
“extreme high” (orange) color.
Note that the colors only serve as a visual aid and
given the limited palette, is only an estimation
of the noise values. You can always use the Perlin Value
Getter for the exact values.
If you have problems seeing color differences, activate
the grayscale color palette in the mod settings.

###### Node types

Right to the color settings, there is a list of node types.
This is for different node styles for different
noise visualizations:

* Solid Nodes: Simple, solid, opaque cubes
* Grid Nodes: Solid see-through nodes (like glass)
* Minibox Nodes: See-thorough nodes, but smaller. You can also
  walk and climb up on down in these
* Stone: Places stone for high values, air otherwise.
  This uses the stone node from the game (if it supports it).

Solid Nodes are recommend to use normally.

Grid or Minibox nodes can be useful in 3D mode if you want to
expose the inner structure of complex 3D noises. This can be quite
trippy and reduce your FPS sharply, so consider reducing the
render distance.

###### Position settings

The following settings are only used when you want
to place nodes in a certain area:

* X, Y, Z: Coordinates of the bottom left front corner if you
 want to generate an area manually with “Apply and create”
* Size: Side length of the square or cube of the area/volume
  to generate, if you generate it with “Apply and create”.
  **ATTENTION:** Don’t make this value too large
  (especially in 3D), otherwise map generation
  will take forever and the game freezes.

#### Footer (Apply / Apply and close / Enable mapgen / Disable mapgen)

The footer is the final part of the form. It has these buttons:

* Apply: Set the current noise params as the “active noise”. If the
  mapgen is active, it will automatically update the world around
  players
* Apply and create: Generate some nodes at the specified XYZ coordinates
  with the specified size (see Position settings above)
* Enable mapgen: Enable the mapgen mode. In mapgen mode, nodes will
  automatically be generated according to the settings around players.
  This allows you to actually *explore* a world.
  When a new part of the world is created, a little star icon will
  appear in its center to show you this part is new.
  Note: When mapgen mode is enabled, the XYZ, size and “Apply and create”
  buttons disappear because those are for single generations.
  Note: If you modify the noise parameters and hit “Accept”, the mapgen
  will automatically update.
* Disable mapgen: Disables the mapgen again. The “XYZ”, “Size”
  and “Apply and create” will appear again.

### Perlin Value Getter
This item tells you the (nearly) exact value of the current active
noise parameters at a given position. You can use it on nodes
and in mid-air.

Use the “Place” key on a node to get the value of the node position.
Use the “Punch” key anywhere to get the value of *your* position (rounded).
If you hold down “Sneak” while punching, your *exact* position (not rounded)
will be used instead.

**Note**: This tool always calculates the values of the *active noise*
It completely ignores whatever nodes were generated and what those nodes
represents, so tool also works if you haven’t generated any nodes.
It actually only looks at the coordinates of the node or yourself.
If you’re unsure about what the current active noise is, just hit “Accept” again
in the Perlin Noise Creator.

### Random Perlin seed setter

This is just a convenience item. Using it is the same as opening the Perlin Noise
Creator, changing the seed and accepting.

In mapgen mode, punching or placing will set a new seed only, but the mapgen
will then instantly update the map.

If mapgen mode is disabled, the meaning of this tool is this:

* Punch: Set a new seed of the active noise, but do not regenerate map
* Place: Set a new seed  of the active noise, then regenerate nodes
  (using the XYZ and Size parameters in the Perlin Noise Creator)

This can be useful to look at many different variations of the noise.

### Troubleshooting

#### The mod hangs up / is extremely slow
Sorry! :-(

This can happen if the mod tries to calculate enormous numbers of values
or generates a huge number of nodes.

Which is the case if you selected a huge number when starting to
generate nodes.

Be careful with large numbers in 3D mode as it is exponentially more
expensive to calculate than 2D.

The only thing you can do is to just not generate huge areas at once.
The mod doesn’t have any warnings in place for now, so you’re on
your own for now. Sorry! :-(

#### The Perlin noise gives the exact same value everywhere.
The most likely reason is that `scale` is exactly 0.
Because if `scale` is 0, the noise will return the same value
everywhere. Remember the result of all noise computations is multiplied
with `scale` at the end, so a multiplication with 0 will
literally nullify all that.
This is correct behavior but obviously useless.
Just pick a non-zero scale to fix this.

## Credits
This mod was written by Wuzzy.

## License

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
