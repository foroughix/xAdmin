-- base
local xcustomcmd = ''
local xwebhook = GetConvar('xwebhook', 'none')
local xbantype = 'license'
local xbanreason = 'You Are Banned. Name: '
-- ban
local bans = json.decode(LoadResourceFile(GetCurrentResourceName(), 'bans.json'))
local function OnPlayerConnecting(name, setKickReason, deferrals)
	local reason = ''
	local banned = false
	local identifiers = GetPlayerIdentifiers(source)
	for _, v in pairs(identifiers) do
		if string.find(v, xbantype..':') then
			if bans[v] then
				reason = bans[v]
				banned = true
				break
			end
		end
	end
	if banned then
		reason = xbanreason..reason
		CancelEvent()
		setKickReason(reason)
	end
end
AddEventHandler('playerConnecting', OnPlayerConnecting)
RegisterCommand(xcustomcmd..'ban',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.ban') and args[1] and args[2] then
		if GetPlayerName(args[1]) and not IsPlayerAceAllowed(args[1],'xadmin.all') and not IsPlayerAceAllowed(args[1],'xadmin.noban') then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local ide = nil
			for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
				if string.match(v, xbantype..':') then
					ide = v
					break
				end
			end
			local reason = string.gsub(rawCommand, xcustomcmd..'ban '..args[1]..' ', '')
			if not bans[ide] then
				local admin = GetPlayerName(source)
				if xwebhook ~= 'none' then
					PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Ban**```Admin:'..admin..'\nPlayer:'..playerName..'\nReason:'..reason..'\n'..ide..'```'}), { ['Content-Type'] = 'application/json' })
				end
				bans[ide] = playerName
				SaveResourceFile(GetCurrentResourceName(), 'bans.json', json.encode(bans, {indent = true}), -1)
			end
			DropPlayer(playerId, reason)
		end
	end
end)
RegisterCommand(xcustomcmd..'unban',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.unban') and args[1] then
		local ide = args[1]
		if bans[ide] then
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Unban**```Admin:'..admin..'\n'..ide..'```'}), { ['Content-Type'] = 'application/json' })
			end
			bans[ide] = nil
			SaveResourceFile(GetCurrentResourceName(), 'bans.json', json.encode(bans, {indent = true}), -1)
		end
	end
end)
RegisterCommand(xcustomcmd..'addban',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.addban') and args[1] then
		local ide = args[1]
		if not bans[ide] then
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Addban**```Admin:'..admin..'\n'..ide..'```'}), { ['Content-Type'] = 'application/json' })
			end
			bans[ide] = 'Unnamed'
			SaveResourceFile(GetCurrentResourceName(), 'bans.json', json.encode(bans, {indent = true}), -1)
		end
		for _, playerId in ipairs(GetPlayers()) do
			for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
				if string.match(v, xbantype..':') then
					if v == ide then
						DropPlayer(playerId, xbanreason..'Unnamed')
						break
					end
				end
			end
		end
	end
end)
-- tag
RegisterCommand(xcustomcmd..'tag', function(source, args)
	local tag = nil
	if IsPlayerAceAllowed(source, 'xtag.founder') then
		tag = '~u~[Founder] '..GetPlayerName(source)
		TriggerClientEvent('xtag:tag', -1, tag, source)
	elseif IsPlayerAceAllowed(source, 'xtag.owner') then
		tag = '~o~[Owner] '..GetPlayerName(source)
		TriggerClientEvent('xtag:tag', -1, tag, source)
	elseif IsPlayerAceAllowed(source, 'xtag.headadmin') then
		tag = '~p~[Head Admin] '..GetPlayerName(source)
		TriggerClientEvent('xtag:tag', -1, tag, source)
	elseif IsPlayerAceAllowed(source, 'xtag.admin') then
		tag = '~r~[Admin] '..GetPlayerName(source)
		TriggerClientEvent('xtag:tag', -1, tag, source)
	elseif IsPlayerAceAllowed(source, 'xtag.supporter') then
		tag = '~b~[Supporter] '..GetPlayerName(source)
		TriggerClientEvent('xtag:tag', -1, tag, source)
	elseif IsPlayerAceAllowed(source, 'xtag.helper') then
		tag = '~g~[Helper] '..GetPlayerName(source)
		TriggerClientEvent('xtag:tag', -1, tag, source)
	end
	if tag then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Tag**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
RegisterCommand(xcustomcmd..'untag', function(source, args)
	local untag = nil
	if IsPlayerAceAllowed(source, 'xtag.founder') then
		TriggerClientEvent('xtag:untag', -1, source)
		untag = true
	elseif IsPlayerAceAllowed(source, 'xtag.owner') then
		TriggerClientEvent('xtag:untag', -1, source)
		untag = true
	elseif IsPlayerAceAllowed(source, 'xtag.headadmin') then
		TriggerClientEvent('xtag:untag', -1, source)
		untag = true
	elseif IsPlayerAceAllowed(source, 'xtag.admin') then
		TriggerClientEvent('xtag:untag', -1, source)
		untag = true
	elseif IsPlayerAceAllowed(source, 'xtag.supporter') then
		TriggerClientEvent('xtag:untag', -1, source)
		untag = true
	elseif IsPlayerAceAllowed(source, 'xtag.helper') then
		TriggerClientEvent('xtag:untag', -1, source)
		untag = true
	end
	if untag then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Untag**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- mute
RegisterCommand(xcustomcmd..'mute',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.mute') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Mute**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:mute', playerId)
			TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Mute', 'Done !' } })
		end
	end
end)
RegisterCommand(xcustomcmd..'unmute',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.unmute') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Unmute**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:unmute', playerId)
			TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Unmute', 'Done !' } })
		end
	end
end)
-- check
RegisterCommand(xcustomcmd..'check',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.check') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local ide = nil
			for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
				if string.match(v, xbantype..':') then
					ide = v
					break
				end
			end
			local check = 'Health:'..GetEntityHealth(GetPlayerPed(playerId))..'/'..GetEntityMaxHealth(GetPlayerPed(playerId))..'\nArmour:'..GetPedArmour(GetPlayerPed(playerId))..'/'..GetPlayerMaxArmour(playerId)..'\n'..ide
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Check**```Admin:'..admin..'\nPlayer:'..playerName..'\n'..check..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:check', source, check)
		end
	end
end)
-- tpw
RegisterCommand(xcustomcmd..'tpw',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.tpw') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Tpw**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:tpw', source)
	end
end)
-- spectate
RegisterCommand(xcustomcmd..'spectate',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.spectate') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Spectate**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			local coords = GetEntityCoords(GetPlayerPed(playerId))
			if coords.x ~= 0 and coords.y ~= 0 and coords.z ~= 0 then
				TriggerClientEvent('xadmin:spectate', source, coords, playerId)
			end
		end
	end
end)
-- players
RegisterCommand(xcustomcmd..'players',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.players') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Players**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:players', source)
	end
end)
-- report
RegisterCommand(xcustomcmd..'report',function(source, args, rawCommand)
	local reason = string.gsub(rawCommand, xcustomcmd..'report ', '')
	local playerName = GetPlayerName(source)
	if xwebhook ~= 'none' then
		PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Report**```Player:'..playerName..'\nReason:'..reason..'```'}), { ['Content-Type'] = 'application/json' })
	end
	for _, playerId in ipairs(GetPlayers()) do
		if IsPlayerAceAllowed(playerId,'xadmin.all') or IsPlayerAceAllowed(playerId,'xadmin.report') then
			TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Report (ID: '..source..' | User: '..playerName..')', reason } })
		end
	end
	TriggerClientEvent('chat:addMessage', source, { args = { '^1Report', 'Sent !' } })
end)
-- reportr
RegisterCommand(xcustomcmd..'reportr',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.reportr') and args[1] and args[2] then
		if GetPlayerName(args[1]) then
			local replay = string.gsub(rawCommand, xcustomcmd..'reportr '..args[1]..' ', '')
			local playerId2 = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Reportr**```Admin:'..admin..'\nPlayer:'..playerName..'\nReplay:'..replay..'```'}), { ['Content-Type'] = 'application/json' })
			end
			for _, playerId in ipairs(GetPlayers()) do
				if IsPlayerAceAllowed(playerId,'xadmin.all') or IsPlayerAceAllowed(playerId,'xadmin.reportr') or playerId == playerId2 then
					TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Report Replay (Admin: '..admin..')', replay } })
				end
			end
			TriggerClientEvent('chat:addMessage', source, { args = { '^1Report Replay', 'Sent !' } })
		end
	end
end)
-- giveweapon
RegisterCommand(xcustomcmd..'giveweapon',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.giveweapon') and args[1] and args[2] then
		if GetPlayerName(args[1]) then
			local weapon = args[2]
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Giveweapon**```Admin:'..admin..'\nPlayer:'..playerName..'\nWeapon:'..weapon..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:giveweapon', playerId, weapon)
		end
	end
end)
-- dv
RegisterCommand(xcustomcmd..'dv',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.dv') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Dv**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:dv', source)
	end
end)
-- warn
RegisterCommand(xcustomcmd..'warn',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.warn') and args[1] and args[2] then
		if GetPlayerName(args[1]) then
			local reason = string.gsub(rawCommand, xcustomcmd..'warn '..args[1]..' ', '')
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Warn**```Admin:'..admin..'\nPlayer:'..playerName..'\nReason:'..reason..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:warn', playerId, reason)
		end
	end
end)
-- givehealth
RegisterCommand(xcustomcmd..'givehealth',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.givehealth') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Givehealth**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:givehealth', playerId)
		end
	end
end)
-- givearmour
RegisterCommand(xcustomcmd..'givearmour',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.givearmour') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Givearmour**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:givearmour', playerId)
		end
	end
end)
-- fixveh
RegisterCommand(xcustomcmd..'fixveh',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.fixveh') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Fixveh**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:fixveh', playerId)
		end
	end
end)
-- setped
RegisterCommand(xcustomcmd..'setped',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.setped') and args[1] and args[2] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			local ped = args[2]
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Setped**```Admin:'..admin..'\nPlayer:'..playerName..'\nPed:'..ped..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:setped', playerId, ped)
		end
	end
end)
-- giveveh
RegisterCommand(xcustomcmd..'giveveh',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.giveveh') and args[1] and args[2] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			local veh = args[2]
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Giveveh**```Admin:'..admin..'\nPlayer:'..playerName..'\nVeh:'..veh..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:giveveh', playerId, veh)
		end
	end
end)
-- dvall
RegisterCommand(xcustomcmd..'dvall',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.dvall') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Dvall**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:dvall', -1)
	end
end)
-- freeze
RegisterCommand(xcustomcmd..'freeze',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.freeze') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Freeze**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:freeze', playerId)
		end
	end
end)
-- unfreeze
RegisterCommand(xcustomcmd..'unfreeze',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.unfreeze') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Unfreeze**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:unfreeze', playerId)
		end
	end
end)
-- revive
RegisterCommand(xcustomcmd..'revive',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.revive') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Revive**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:revive', playerId)
		end
	end
end)
-- slay
RegisterCommand(xcustomcmd..'slay',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.slay') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Slay**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			TriggerClientEvent('xadmin:slay', playerId)
		end
	end
end)
-- godmode
RegisterCommand(xcustomcmd..'godmode',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.godmode') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Godmode**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:godmode', source)
	end
end)
-- announce
RegisterCommand(xcustomcmd..'announce',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.announce') and args[1] then
		local announce = string.gsub(rawCommand, xcustomcmd..'announce ', '')
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Announce**```Admin:'..admin..'\nAnnounce:'..announce..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:announce', -1, announce)
	end
end)
-- noclip
RegisterCommand(xcustomcmd..'noclip',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.noclip') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Noclip**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:noclip', source)
	end
end)
-- clearchat
RegisterCommand(xcustomcmd..'clearchat',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.clearchat') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Clearchat**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:clearchat', -1)
	end
end)
-- bringall
RegisterCommand(xcustomcmd..'bringall',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.bringall') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Bringall**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		local coords = GetEntityCoords(GetPlayerPed(source))
		for _, playerId in ipairs(GetPlayers()) do
			SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z + 0.5)
		end
	end
end)
-- bring
RegisterCommand(xcustomcmd..'bring',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.bring') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Bring**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			local coords = GetEntityCoords(GetPlayerPed(source))
			SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z + 0.5)
		end
	end
end)
-- goto
RegisterCommand(xcustomcmd..'goto',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.goto') and args[1] then
		if GetPlayerName(args[1]) then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Goto**```Admin:'..admin..'\nPlayer:'..playerName..'```'}), { ['Content-Type'] = 'application/json' })
			end
			local coords = GetEntityCoords(GetPlayerPed(playerId))
			SetEntityCoords(GetPlayerPed(source), coords.x, coords.y, coords.z + 0.5)
		end
	end
end)
-- clearmap
RegisterCommand(xcustomcmd..'clearmap',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.clearmap') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Clearmap**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('xadmin:clearmap', -1)
	end
end)
-- kick
RegisterCommand(xcustomcmd..'kick',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.kick') and args[1] and args[2] then
		if GetPlayerName(args[1]) and not IsPlayerAceAllowed(args[1],'xadmin.all') and not IsPlayerAceAllowed(args[1],'xadmin.nokick') then
			local playerId = args[1]
			local playerName = GetPlayerName(args[1])
			local reason = string.gsub(rawCommand, xcustomcmd..'kick '..args[1]..' ', '')
			local admin = GetPlayerName(source)
			if xwebhook ~= 'none' then
				PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Kick**```Admin:'..admin..'\nPlayer:'..playerName..'\nReason:'..reason..'```'}), { ['Content-Type'] = 'application/json' })
			end
			DropPlayer(playerId, reason)
		end
	end
end)
-- kickall
RegisterCommand(xcustomcmd..'kickall',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.kickall') and args[1] then
		local reason = string.gsub(rawCommand, xcustomcmd..'kickall ', '')
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Kickall**```Admin:'..admin..'\nReason:'..reason..'```'}), { ['Content-Type'] = 'application/json' })
		end
		for _, playerId in ipairs(GetPlayers()) do
			DropPlayer(playerId, reason)
		end
	end
end)
-- reviveall
RegisterCommand(xcustomcmd..'reviveall',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.reviveall') then
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Reviveall**```Admin:'..admin..'```'}), { ['Content-Type'] = 'application/json' })
		end
		for _, playerId in ipairs(GetPlayers()) do
			TriggerClientEvent('xadmin:revive', playerId)
		end
	end
end)
-- coords
RegisterCommand(xcustomcmd..'coords',function(source, args)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.coords') then
		local admin = GetPlayerName(source)
		local coords = GetEntityCoords(GetPlayerPed(source))
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**Coords**```Admin:'..admin..'\nCoords:'..coords.x..','..coords.y..','..coords.z..'```'}), { ['Content-Type'] = 'application/json' })
		end
		TriggerClientEvent('chat:addMessage', source, { args = { '^1Coords', coords.x..','..coords.y..','..coords.z } })
	end
end)
-- admin chat
RegisterCommand(xcustomcmd..'a',function(source, args, rawCommand)
	if IsPlayerAceAllowed(source,'xadmin.all') or IsPlayerAceAllowed(source,'xadmin.a') and args[1] then
		local a = string.gsub(rawCommand, xcustomcmd..'a ', '')
		local playerName = GetPlayerName(args[1])
		local admin = GetPlayerName(source)
		if xwebhook ~= 'none' then
			PerformHttpRequest(xwebhook, function(err, text, headers) end, 'POST', json.encode({content = '**A**```Admin:'..admin..'\nA:'..a..'```'}), { ['Content-Type'] = 'application/json' })
		end
		for _, playerId in ipairs(GetPlayers()) do
			if IsPlayerAceAllowed(playerId,'xadmin.all') or IsPlayerAceAllowed(playerId,'xadmin.a') then
				TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Admin Chat (Admin: '..admin..')', a } })
			end
		end
	end
end)
-- resource name
Citizen.CreateThread(function()
	while true do
		if GetCurrentResourceName() ~= 'xAdmin' then
			print('Change resource ' .. GetCurrentResourceName() .. ' name to xAdmin')
		end
		Citizen.Wait(60000)
	end
end)
