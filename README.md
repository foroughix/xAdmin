# xAdmin
FiveM admin system based by Commands (Admin Tag and Rank, Report and Report Replay, ...)
- You can use this resource for all platforms (ESX, VRP, QBCore, ...)
- You can use this resource in All versions FiveM and All OneSyncs
# Install
1. Download xAdmin and copy/paste in your resources folder
2. Edit server.cfg and add below text/code and save it
```
ensure xAdmin
add_ace group.admin xtag.founder allow
add_ace group.admin xadmin.all allow
add_principal identifier.fivem:1 group.admin
```
3. Restart server and enjoy
# Log
1. Edit server.cfg and add below text/code and save it
```
set xwebhook "your discord webhook"
set xswebhook "your screenshot discord webhook"
```
2. Restart server and enjoy
# Ranks
```
/tag : show tag
/untag : hide tag
```
```
add_ace group.founder xtag.founder allow
add_ace group.owner xtag.owner allow
add_ace group.headadmin xtag.headadmin allow
add_ace group.admin xtag.admin allow
add_ace group.supporter xtag.supporter allow
add_ace group.helper xtag.helper allow
add_principal identifier.fivem:1 group.?????
```
# Commands
player = PlayerId
```
/coords : get coords location
/tpw : teleport to waypoint
/players : see players id and name above head
/dv : delete vehicle
/dvall : delete all vehicles
/bringall : bring all players
/reviveall : revive all players
/godmode : admin godmode
/noclip : admin noclip
/clearchat : clear chat for all players
/clearmap : delete all vehicles, objects and ...
/a text : admin chat
/ban player reason : ban player by id
/unban identifier : unban player by identifier
/addban identifier : ban player by identifier
/mute player : mute player from chat and voice
/unmute player : unmute player from chat and voice
/check player : check player
/spectate player : spectate player
/report report : send report for admins
/reportr player replay : report replay for player
/warn player text : send warn player
/giveweapon player weapon : give weapon to player
/givehealth player : give health to player
/givearmour player : give armour to player
/giveveh player name : give vehicle to player
/fixveh player : fix vehicle player
/setped player name : change ped player
/freeze player : freeze player
/unfreeze player : unfreeze player
/screenshot player : screenshot player
/revive player : revive player
/slay player : slay player
/announce player : send announce for all players
/bring player : teleport player to me
/goto player : teleport me to player
/kick player reason : kick player
/kickall reason : kick all players
```
# Permissions
```
add_ace group.admin xadmin.a allow
add_ace group.admin xadmin.dv allow
add_ace group.admin xadmin.mute allow
add_ace group.admin xadmin.unmute allow
add_ace group.admin xadmin.check allow
add_ace group.admin xadmin.tpw allow
add_ace group.admin xadmin.spectate allow
add_ace group.admin xadmin.players allow
add_ace group.admin xadmin.report allow
add_ace group.admin xadmin.reportr allow
add_ace group.admin xadmin.giveweapon allow
add_ace group.admin xadmin.givehealth allow
add_ace group.admin xadmin.givearmour allow
add_ace group.admin xadmin.giveveh allow
add_ace group.admin xadmin.warn allow
add_ace group.admin xadmin.fixveh allow
add_ace group.admin xadmin.setped allow
add_ace group.admin xadmin.dvall allow
add_ace group.admin xadmin.freeze allow
add_ace group.admin xadmin.unfreeze allow
add_ace group.admin xadmin.screenshot allow
add_ace group.admin xadmin.revive allow
add_ace group.admin xadmin.slay allow
add_ace group.admin xadmin.godmode allow
add_ace group.admin xadmin.announce allow
add_ace group.admin xadmin.noclip allow
add_ace group.admin xadmin.coords allow
add_ace group.admin xadmin.bring allow
add_ace group.admin xadmin.goto allow
add_ace group.admin xadmin.addban allow
add_ace group.admin xadmin.ban allow
add_ace group.admin xadmin.unban allow
add_ace group.admin xadmin.noban allow
add_ace group.admin xadmin.kick allow
add_ace group.admin xadmin.nokick allow
add_ace group.admin xadmin.clearchat allow
add_ace group.admin xadmin.clearmap allow
add_ace group.admin xadmin.bringall allow
add_ace group.admin xadmin.kickall allow
add_ace group.admin xadmin.reviveall allow
```
# Same Commands
>**To solve the problem of the same commands** : 
>```
>local xcustomcmd = '!'
>```
>You can edit server.lua and client.lua (line 2) for build custom commands And commands converted to /!command
