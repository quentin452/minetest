# Turtloop

A simple node based hyperloop travelling system. It adds a node used as tube and a ticket.
In order to travel with the hyperloop, players need to wield a ticket and use the "place"-trigger
(right click for mouse users) on any node of a tube. The travelling system determines the direction
based on the pointed direction (param2/face dir values) of the tube nodes and teleports you to the 
end of the tube.  
If parts of the tube are not loaded, the player is moved to the edge of the loaded area and waits 
for it to load. The duration can be set using the settings menu. 
In case there is a solid or damaging node in the target destination, the player is returned to the 
entry position.

I didn't create the sounds used in this mod. The attributions are in the sounds subfolder.
