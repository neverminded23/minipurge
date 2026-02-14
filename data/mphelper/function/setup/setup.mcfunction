#Copyright JayPyro2000 2025. All Rights Reserved.

# Sets up treasure chest.
schedule function mphelper:mechanics/treasure_chest 2t

# Set world spawn.
setworldspawn ~ ~1 ~

# If there is peace teleport and set spawnpoint for all players to mid.
execute if score #peace variables matches 1.. run tp @a ~ ~1 ~
execute if score #peace variables matches 1.. run spawnpoint @a ~ ~1 ~

# If there is no peace scatter spwn players.
execute as @a if score #peace variables matches 0 run function mphelper:setup/scatter_spawn with storage minipurge:variables

# Set everyones health etc. attributes.
gamemode survival @a
xp add @a -50000
clear @a
effect clear @a
effect give @a minecraft:instant_health 2 225 false
effect give @a minecraft:saturation 2 225 false
advancement revoke @a everything
gamerule minecraft:locator_bar false
execute as @a run function mphelper:setup/clear_enderchests

# Set and keep time.
execute if score #peace_daylight variables matches 0 run time set noon
execute if score #peace_daylight variables matches 0 run gamerule minecraft:advance_time false
execute if score #peace_daylight variables matches 1 run time set day
execute if score #peace_daylight variables matches 1 run gamerule minecraft:advance_time true
weather clear

# Disable pvp.
gamerule minecraft:pvp false
gamerule spawn_phantoms false

# Set worldborder.
worldborder center ~ ~
$worldborder set $(border)
worldborder damage buffer 4
worldborder damage amount 0.5

# Count minecraft deaths.
scoreboard objectives add deaths minecraft.custom:minecraft.deaths
scoreboard players set @a deaths 0
schedule function mphelper:mechanics/death_dispatcher 1t

#Create bossbar and timer
bossbar add minipurge:timerbar Timerbar
bossbar set minipurge:timerbar name Peace
bossbar set minipurge:timerbar color green
bossbar set minipurge:timerbar style notched_20
$bossbar set minipurge:timerbar max $(peace)
bossbar set minipurge:timerbar visible true
$bossbar set minipurge:timerbar value $(peace)
bossbar set minipurge:timerbar players @a
$scoreboard players set #countdown variables $(peace)
schedule function mphelper:mechanics/countdown 5s

#Clean up floating items
kill @e[type=item] 

#Display title
title @a times 20 40 20
title @a title {"text":"GOOD LUCK!", "bold":true, "italic":true, "color":"green"}

# Dispaly more info.
tellraw @a [{"text":"UHCFUNNY SPEED BR","bold":true,"color":"yellow"}]

# Display peace info.
execute if score #peace variables matches 0 run tellraw @a [{"text":"NO PEACE","bold":true,"color":"white"}]
$execute if score #peace variables matches 1.. run tellraw @a [{"text":"You have ","bold":true,"color":"white"}, {"text":"$(peace_mins)","bold":true,"color":"green"}, {"text":" minutes of peace!!!","color":"white"}]

# Display war info.
$execute if score #war variables matches 1.. run tellraw @a [{"text":"The pvp phase will last ","color":"white","bold":true}, {"text":"$(war_mins)","bold":true,"color":"yellow"}, {"text":" minutes.","color":"white","bold":true}]

# Display border shrink info.
$execute if score #shrink variables matches 1.. run tellraw @a [{"text":"The border shrinks to ","color":"white","bold":true}, {"text":"$(center_x_pos), $(center_y_pos), $(center_z_pos)","bold":true,"color":"blue"},{"text":" over ","color":"white","bold":true},{"text":"$(shrink_mins)","bold":true,"color":"red"}, {"text":" minutes.","color":"white","bold":true}]
execute if score #shrink variables matches 0 run tellraw @a [{"text":"The border will not shrink.","bold":true,"color":"white"}]

# Display lives info.
$execute if score #lives variables matches 2.. run tellraw @a [{"text":"Use your ","color":"white","bold":true}, {"text":"$(lives)","bold":true,"color":"green"},{"text":" lives wisely.","color":"white","bold":true}]
execute if score #lives variables matches 1 run tellraw @a [{"text":"HARDCORE MODE IS ON","color":"red","bold":true}]

tellraw @a [{"text":"Good luck!","bold":true,"color":"green"}]

# Run the add-ons.
function mphelper:add_ons/run_add_ons {stage:mpsetup}

$schedule function mphelper:mechanics/master_dispatcher $(peace)s
