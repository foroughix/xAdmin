-- base
local xcustomcmd = ''
-- suggestions
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'coords', 'get coords location')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'tag', 'show your rank tag in near player')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'untag', 'hide your rank tag in near player')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'tpw', 'teleport to waypoint')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'players', 'see players id and name above head')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'dv', 'delete vehicle')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'dvall', 'delete all vehicles')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'bringall', 'bring all players')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'reviveall', 'revive all players')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'godmode', 'admin godmode')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'noclip', 'admin noclip')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'clearchat', 'clear chat for all players')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'clearmap', 'delete all vehicles, objects and ...')
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'a', 'admin chat', {{ name='text', help='text admin chat' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'ban', 'ban player by id', {{ name='player', help='player id' }, { name='reason', help='ban reason' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'unban', 'unban player by identifier', {{ name='identifier', help='player identifier' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'addban', 'ban player by identifier', {{ name='identifier', help='player identifier' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'mute', 'mute player from chat and voice', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'unmute', 'unmute player from chat and voice', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'check', 'check player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'spectate', 'spectate player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'report', 'send report for admins', {{ name='report', help='report text' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'reportr', 'report replay for player', {{ name='player', help='player id' }, { name='replay', help='replay text' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'warn', 'send warn player', {{ name='player', help='player id' }, { name='warn', help='warn text' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'giveweapon', 'give weapon to player', {{ name='player', help='player id' }, { name='weapon', help='weapon name' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'givehealth', 'give health to player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'givearmour', 'give armour to player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'giveveh', 'give vehicle to player', {{ name='player', help='player id' }, { name='name', help='vehicle name' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'fixveh', 'fix vehicle player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'setped', 'change ped player', {{ name='player', help='player id' }, { name='name', help='ped name' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'freeze', 'freeze player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'unfreeze', 'unfreeze player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'screenshot', 'screenshot player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'revive', 'revive player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'slay', 'slay player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'announce', 'send announce for all players', {{ name='announce', help='announce text' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'bring', 'teleport player to me', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'goto', 'teleport me to player', {{ name='player', help='player id' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'kick', 'kick player', {{ name='player', help='player id' }, { name='reason', help='kick reason' }})
TriggerEvent('chat:addSuggestion', '/'..xcustomcmd..'kickall', 'kick all players', {{ name='reason', help='kick all reason' }})
-- functions
function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end
-- tag & untag
local peds = {}
local function DrawText3D(coords, tag)
	local camCoords = GetGameplayCamCoord()
	local dist = #(coords - camCoords)   
	local scale = 200 / (GetGameplayCamFov() * dist)
	SetTextColour(0, 0, 0, 255)
	SetTextScale(0.0, 0.7 * scale)
	SetTextFont(0)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(tag)
	SetDrawOrigin(coords, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end
local function Display(ped, tag, ntag)	
	local playerPed = PlayerPedId()
	while peds[ntag] do
		local x, y, z = table.unpack(GetEntityCoords(ped))
		DrawText3D(vector3(x, y, z + 1.0), tag)
		Wait(0)
	end
end
RegisterNetEvent('xtag:tag')
AddEventHandler('xtag:tag', function(tag, serverId)
	local ntag = tonumber(serverId)
	local player = GetPlayerFromServerId(serverId)
	if player ~= -1 or serverId == GetPlayerServerId(PlayerId()) then
		local ped = GetPlayerPed(player)
		if not peds[ntag] then
			peds[ntag] = true
			Display(ped, tag, ntag)
		end
	end
end)
RegisterNetEvent('xtag:untag')
AddEventHandler('xtag:untag', function(serverId)
	local ntag = tonumber(serverId)
	peds[ntag] = nil
end)
Citizen.CreateThread(function()
	while true do
		peds = {}
		Citizen.Wait(600000)
	end
end)
-- mute & unmute
local mute = false
Citizen.CreateThread(function()
	while true do
		if mute then
			DisableControlAction(0, 245, true)
			DisableControlAction(0, 249, true)
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	end
end)
RegisterNetEvent('xadmin:mute')
AddEventHandler('xadmin:mute', function()
	mute = true
end)
RegisterNetEvent('xadmin:unmute')
AddEventHandler('xadmin:unmute', function()
	mute = false
end)
-- check
RegisterNetEvent('xadmin:check')
AddEventHandler('xadmin:check', function(check)
	ShowNotification('Check !!!\n'..check)
end)
-- tpw
RegisterNetEvent('xadmin:tpw')
AddEventHandler('xadmin:tpw', function()
	local WaypointHandle = GetFirstBlipInfoId(8)
	if DoesBlipExist(WaypointHandle) then
		local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords['x'], waypointCoords['y'], height + 0.0)
			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords['x'], waypointCoords['y'], height + 0.0)
			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords['x'], waypointCoords['y'], height + 0.0)
				break
			end
			Wait(1)
		end
	end
end)
-- spectate
local cdspectate = false
local spectate = false
local lastcoords = nil
local positionped = nil
local spectateped = nil
RegisterNetEvent('xadmin:spectate')
AddEventHandler('xadmin:spectate', function(coords, playerId)
	if not cdspectate then
		cdspectate = true
		if spectate then
			spectate = false
			Wait(300)
			RequestCollisionAtCoord(positionped)
			NetworkSetInSpectatorMode(false, spectateped)
			FreezeEntityPosition(PlayerPedId(), false)
			SetEntityCoords(PlayerPedId(), lastcoords)
			SetEntityVisible(PlayerPedId(), true)
			lastcoords = nil
			positionped = nil
			spectateped = nil
			cdspectate = false
		else
			spectate = true
			foundplayer = false
			lastcoords = GetEntityCoords(PlayerPedId())
			SetEntityVisible(PlayerPedId(), false)
			SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z + 10.0)
			FreezeEntityPosition(PlayerPedId(), true)
			Wait(1500)
			SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z - 10.0)
			for _, i in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(i) and tonumber(GetPlayerServerId(i)) == tonumber(playerId) then
					foundplayer = true
					ped = GetPlayerPed(i)
					positionped = GetEntityCoords(ped)
					spectateped = ped
					RequestCollisionAtCoord(positionped)
					NetworkSetInSpectatorMode(true, spectateped)
					cdspectate = false
					while spectate do
						Wait(100)
						local cped = GetEntityCoords(spectateped)
						if cped.x == 0 and cped.y == 0 and cped.z == 0 then
							spectate = false
							Wait(300)
							RequestCollisionAtCoord(positionped)
							NetworkSetInSpectatorMode(false, spectateped)
							FreezeEntityPosition(PlayerPedId(), false)
							SetEntityCoords(PlayerPedId(), lastcoords)
							SetEntityVisible(PlayerPedId(), true)
							lastcoords = nil
							positionped = nil
							spectateped = nil
							cdspectate = false
						else
							SetEntityCoords(PlayerPedId(), cped.x, cped.y, cped.z - 10.0)
						end
					end
					break
				end
			end
			if not foundplayer then
				FreezeEntityPosition(PlayerPedId(), false)
				SetEntityCoords(PlayerPedId(), lastcoords)
				SetEntityVisible(PlayerPedId(), true)
				lastcoords = nil
				spectate = false
				cdspectate = false
			end
		end
	end
end)
-- players
local players = false
RegisterNetEvent('xadmin:players')
AddEventHandler('xadmin:players', function()
	players = not players
end)
Citizen.CreateThread(function()
	while true do
		if players then
			for _, i in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= PlayerPedId() then
					PPed = GetPlayerPed(i)
					PPlayer = CreateFakeMpGamerTag(PPed, '[' .. GetPlayerServerId(i) .. '] ' .. GetPlayerName(i), false, false, '', false)
					SetMpGamerTagVisibility(PPlayer, 0, true)
					if NetworkIsPlayerTalking(i) then
						SetMpGamerTagVisibility(PPlayer, 9, true)
					else
						SetMpGamerTagVisibility(PPlayer, 9, false)
					end
				end
			end
			Citizen.Wait(100)
		else
			for _, i in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= PlayerPedId() then
					PPed = GetPlayerPed(i)
					PPlayer = CreateFakeMpGamerTag(PPed, '[' .. GetPlayerServerId(i) .. '] ' .. GetPlayerName(i), false, false, '', false)
					SetMpGamerTagVisibility(PPlayer, 0, false)
					SetMpGamerTagVisibility(PPlayer, 9, false)
				end
			end
			Citizen.Wait(1000)
		end
	end
end)
-- giveweapon
RegisterNetEvent('xadmin:giveweapon')
AddEventHandler('xadmin:giveweapon', function(weapon)
	GiveWeaponToPed(PlayerPedId(),GetHashKey(weapon),299,false,false)
end)
-- dv
RegisterNetEvent('xadmin:dv')
AddEventHandler('xadmin:dv', function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local xveh = GetVehiclePedIsIn(PlayerPedId(), false)
		SetEntityAsMissionEntity(xveh, false, false)
		DeleteEntity(xveh)
	end
end)
-- warn
RegisterNetEvent('xadmin:warn')
AddEventHandler('xadmin:warn', function(reason)
	ShowNotification('Warn !!!\n'..reason)
	AnimpostfxPlay('ExplosionJosh3', 3000, false)
end)
-- givehealth
RegisterNetEvent('xadmin:givehealth')
AddEventHandler('xadmin:givehealth', function()
	SetEntityHealth(PlayerPedId(), 200)
end)
-- givearmour
RegisterNetEvent('xadmin:givearmour')
AddEventHandler('xadmin:givearmour', function()
	AddArmourToPed(PlayerPedId(), 100)
end)
-- fixveh
RegisterNetEvent('xadmin:fixveh')
AddEventHandler('xadmin:fixveh', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		SetVehicleOnGroundProperly(vehicle)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0)
	end
end)
-- setped
RegisterNetEvent('xadmin:setped')
AddEventHandler('xadmin:setped', function(name)
	local pedloadstatus = true
	local pedhash = GetHashKey(name)
	RequestModel(pedhash)
	local waiting = 0
	while not HasModelLoaded(pedhash) do
		if waiting > 10000 then					
			pedloadstatus = false
			break
		else
			Wait(100)
			waiting = waiting + 100
		end
	end
	if pedloadstatus then
		SetPlayerModel(PlayerId(), pedhash)
		SetModelAsNoLongerNeeded(pedhash)
	end
end)
-- giveveh
RegisterNetEvent('xadmin:giveveh')
AddEventHandler('xadmin:giveveh', function(name)
	local sveh = true
	local vehiclehash = GetHashKey(name)
	RequestModel(vehiclehash)
	local waiting = 0
	while not HasModelLoaded(vehiclehash) do
		if waiting > 10000 then					
			sveh = false
			break
		else
			Wait(100)
			waiting = waiting+100
		end
	end
	if sveh then
		local coords = GetEntityCoords(PlayerPedId(), true)
		local veh = CreateVehicle(vehiclehash, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, false)
		SetVehicleDirtLevel(veh, 0)
		SetVehicleEngineOn(veh, true, true, true)
		SetPedIntoVehicle(PlayerPedId(), veh, -1)
		SetModelAsNoLongerNeeded(vehiclehash)
	end
end)
-- freeze & unfreeze
RegisterNetEvent('xadmin:freeze')
AddEventHandler('xadmin:freeze', function()
	FreezeEntityPosition(PlayerPedId(), true)
end)
RegisterNetEvent('xadmin:unfreeze')
AddEventHandler('xadmin:unfreeze', function()
	FreezeEntityPosition(PlayerPedId(), false)
end)
-- screenshot
RegisterNetEvent('xadmin:screenshot')
AddEventHandler('xadmin:screenshot', function()
	local xswebhook = GetConvar('xswebhook', 'none')
	if xswebhook ~= 'none' then
		exports['screenshot-basic']:requestScreenshotUpload(GetConvar('xswebhook', 'none'), 'files[]')
	end
end)
-- revive & reviveall
RegisterNetEvent('xadmin:revive')
AddEventHandler('xadmin:revive', function()
	local coords = GetEntityCoords(PlayerPedId(), true)
	NetworkResurrectLocalPlayer(coords, true, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end)
-- slay
RegisterNetEvent('xadmin:slay')
AddEventHandler('xadmin:slay', function()
	ApplyDamageToPed(PlayerPedId(), 5000, false, true, true)
end)
-- godmode
local godmode = false
RegisterNetEvent('xadmin:godmode')
AddEventHandler('xadmin:godmode', function()
	NetworkSetFriendlyFireOption(godmode)
	SetEntityInvincible(PlayerPedId(), not godmode)
	godmode = not godmode
end)
-- announce
RegisterNetEvent('xadmin:announce')
AddEventHandler('xadmin:announce', function(announce)
	ShowNotification('Announce !!!\n'..announce)
end)
-- noclip
local noclip = false
RegisterNetEvent('xadmin:noclip')
AddEventHandler('xadmin:noclip', function()
	noclip = not noclip
	FreezeEntityPosition(PlayerPedId(), noclip)
	SetEntityVisible(PlayerPedId(), not noclip)
	SetPlayerCanUseCover(PlayerId(), not noclip)
end)
Citizen.CreateThread(function()
	while true do
		if noclip then
			local yoff = 0.0
			local zoff = 0.0
			if IsDisabledControlPressed(0, 32) then
				yoff = 0.5
			end
			if IsDisabledControlPressed(0, 33) then
				yoff = -0.5
			end
			if IsDisabledControlPressed(0, 34) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+3)
			end
			if IsDisabledControlPressed(0, 35) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-3)
			end
			if IsDisabledControlPressed(0, 85) then
				zoff = 0.2
			end
			if IsDisabledControlPressed(0, 48) then
				zoff = -0.2
			end
			local newPos = nil
			if IsDisabledControlPressed(0, 21) then
				newPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, yoff * (10 + 0.3), zoff * (10 + 0.3))
			else
				newPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, yoff * (5 + 0.3), zoff * (5 + 0.3))
			end
			SetEntityVelocity(PlayerPedId(), 0.0, 0.0, 0.0)
			SetEntityRotation(PlayerPedId(), 0.0, 0.0, 0.0, 0, false)
			SetEntityHeading(PlayerPedId(), GetGameplayCamRelativeHeading())
			SetEntityCoordsNoOffset(PlayerPedId(), newPos.x, newPos.y, newPos.z, noclip, noclip, noclip)
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	end
end)
-- clearchat
RegisterNetEvent('xadmin:clearchat')
AddEventHandler('xadmin:clearchat', function()
	TriggerEvent('chat:clear')
end)
-- dvall & clearmap
RegisterNetEvent('xadmin:dvall')
AddEventHandler('xadmin:dvall', function()
	for xveh in EnumerateVehicles() do
		if not IsPedAPlayer(GetPedInVehicleSeat(xveh, -1)) then 
			SetEntityAsMissionEntity(xveh, false, false)
			DeleteEntity(xveh)
		end
	end
end)
RegisterNetEvent('xadmin:clearmap')
AddEventHandler('xadmin:clearmap', function()
	for xveh in EnumerateVehicles() do
		SetEntityAsMissionEntity(xveh, false, false)
		DeleteEntity(xveh)
	end
	for xobj in EnumeratePickups() do
		RemovePickup(xobj)
		SetEntityAsMissionEntity(xobj, false, false)
		DeleteEntity(xobj)
	end
	for xped in EnumeratePeds() do
		if not IsPedAPlayer(xped) then	
			SetEntityAsMissionEntity(xped, false, false)
			DeleteEntity(xped)
		end
	end
	for xobj in EnumerateObjects() do
		if NetworkGetEntityOwner(xobj) ~= -1 then
			DetachEntity(xobj, true, true)
			SetEntityAsMissionEntity(xobj, false, false)
			DeleteEntity(xobj)
		end
	end
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	ClearAreaOfObjects(x, y, z, 300.0, 1)
	ClearAreaOfCops(x, y, z, 300.0, 1)
	ClearAreaOfPeds(x, y, z, 300.0, 1)
	ClearAreaOfProjectiles(x, y, z, 300.0, 1)
	ClearAreaOfVehicles(x, y, z, 300.0, false, false, false, false, false)
end)
local entityEnumerator = {
	__gc = function(enum)
	    if enum.destructor and enum.handle then
		    enum.destructor(enum.handle)
	    end
	    enum.destructor = nil
	    enum.handle = nil
	end
}
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	    local iter, id = initFunc()
	    if not id or id == 0 then
	        disposeFunc(iter)
		    return
	    end  
	    local enum = {handle = iter, destructor = disposeFunc}
	    setmetatable(enum, entityEnumerator) 
	    local next = true
	    repeat
		    coroutine.yield(id)
		    next, id = moveFunc(iter)
	    until not next  
	    enum.destructor, enum.handle = nil, nil
	    disposeFunc(iter)
	end)
end
function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
