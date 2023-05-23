# Turt 

Turt is a small language used to control a turtle. This mod with the same name uses a player 
transformed by the Tortou mod. Scripts are executed using the turt command followed by the script 
name without the extension turt. Only scripts in the subdirectory scripts of this mod are executed. 
The turtle doesn't affect protected nodes. If it encounters an unloaded area, then it waits for the 
area to load. The duration can be set using the settings menu.

F is used to move the turtle into the pointed direction without placing a block.  
P is used to place the wielded block on the current position and afterwards move into the pointed 
direction. No items are taken from the inventory.  
< is used to select the previous item as wielded item.  
> is used to select the next item as wielded item.  
The letters L, R, U and D are used to turn the turtle. L turns it to the left, R turns it to the 
right. U turns it upwards and D turns it downwards.  

It uses various forms of goto commands for control flow.  
The if-goto is composed of an I, followed by an integer and a semicolon. It jumps to the position 
calculated by the index of the I and the integer offset. It is only executed, if the wielded item 
is equal to the node at the current position.  
The not-if-goto is composed of an N, followed by an integer and a semicolon. The calculation is the 
same as for the if-goto. It is only executed, if the wielded item is not equal to the node at the 
current position.  
X marks a count-goto. It is composed of an X, followed by an integer, a comma, a natural number and 
a semicolon. The second argument sets the amount of executions. The counter is saved for the whole 
execution of the script. If the goto was executed the given amount of times, it is ignored once. 
Afterwards, the counter starts again. Counter gotos can go through a loop like that multiple 
times.  
It is possible to replace the wielded item with the node type at the current position using C.  
It is possible to declare a head with sequences at the beginning of a script. The execution of the 
script starts after the head. Sequences don't have a preceding character, but end with a Z. Two 
sequences are, therefore, separated by Z. Z is a goto that jumps to the position after the last 
executed absolute goto (A). Sequences enable you to reuse code. Z should only be used in the head. 
The head is separated by the body using |. It is necessary to use the bar even if the head is 
empty.  
Another goto used in combination with sequences is the absolute goto. It is composed of an A, a 
natural number and a semicolon. This goto jumps to the index relative to the beginning of the 
script. The index of the first letter is 1. It is always executed, but you can jump over it with a 
conditional goto.  
T is used to teleport the turtle to a position relative to the position of the turtle at the 
beginning of the script. The command takes three arguments separated by commas for the x, y and z 
values. A semicolon also signifies the end of the command. The coordinate values are relative to 
the local coordinate system determined by the look direction of the turtle at the beginning of the 
script. When the turtle is facing north (0° yaw), the axes of the local and the global coordinate 
system are pointing into the same directions. Positive x values are on the right side, negative on 
the left.  Positive z values are on the front, negative are on the back.  
It is possible to place schematics using S followed by the file name without the file extension mts 
and a semicolon. The schematic files used have to be in the subfolder schematics of this mod.  
The arguments of commands such as gotos and the teleportation are also associated with indices. It 
does not make sense to jump into a goto, but the consistency makes it more simple to write code. If 
the cursor jumped into a goto, the subsequent numbers, a comma and the semicolon are ignored. If a 
goto jumps to the first letter of a goto, then the goto is executed.  
When jumping into the arguments of a schematic placement you might experience unwanted behaviour 
because some uppercase letters have a special meaning in this language. If you only use lowercase 
letters for the file names, this won't happen. Snake Case is mostly used for file names in Minetest 
(e. g. script_123).  
A script is executed until the last letter was interpreted or a goto jumps to an invalid index.  
It is possible to make the code more readable using spaces or other characters not used in this 
description. They also have an index, but otherwise have no effect. There is no guarantee that I am 
not going to expand this language in the future and use currently ignored characters, except 
whitespace characters.  

## Vim
For Vim users like me I got a syntax file.

```vim
" Vim syntax file
" Language:             Turt
" Maintainer:           Libra Subtilis
" Repository:           
" Last Change:          2022.03.12

syntax match turtControl "[INXASZT]"
syntax match turtSep "[|,;]"
syntax match turtNumbers "-\?\d\+"

highlight turtControl	ctermfg=14
highlight turtSep	ctermfg=7
highlight turtNumbers	ctermfg=13
```

