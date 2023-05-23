# MT_QOL - Improve quality of life

## Commands

### `/QOL_ping`
Test if connection is working and mod is loaded.

### `/QOL_description`
Gives name, count, wear, and description of wielded item.

### `/QOL_rename name`
Changes description of wielded item to rename it.

### `/QOL_refill [wear]`
Refills wielded itemstack to maximum stack size, sets wear to `wear` (if provided) if item is a tool.
May not work for power tools which store extra metadata.
*Requires `creative` privilege.*

### `/QOL_nothungry`
Sets your satiation to its maximum value.
Requires hunger_ng.
*Requires `creative` privilege.*

### `/QOL_boost [axis [distance]]`
Teleports you `distance` nodes in the `axis` direction.
`axis` and `distance` are optional; `distance` may only be provided if `axis` is given.
*Requires `fast` privilege.*

### `/QOL_whosthere`
Prints a list of currently online players.
