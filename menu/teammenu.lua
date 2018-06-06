local ids = {}
local overriden

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		ids["menu"] = id

		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) ids[TeamId.President] = id end, function()
			TeamMenu.OnClick(TeamId.President)
		end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) ids[TeamId.Vice] = id end, function()
			TeamMenu.OnClick(TeamId.Vice)
		end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) ids[TeamId.Bodyguard] = id end, function()
			TeamMenu.OnClick(TeamId.Bodyguard)
		end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) ids[TeamId.Terrorist] = id end, function()
			TeamMenu.OnClick(TeamId.Terrorist)
		end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) ids[TeamId.Civil] = id end, function()
			TeamMenu.OnClick(TeamId.Civil)
		end)
	end)
end)

TeamMenu = {}
function TeamMenu.OnClick(team)
	CurrentTeam.Update(team)
	TriggerEvent("menu:hideMenu")
end

function TeamMenu.OverrideGreyedOut(state)
	overriden = state
	for _, id in pairs(ids) do
		TriggerEvent("menu:setGreyedOut", state, id)
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if not overriden then
			local teamAmounts = {}
			for _, teamId in pairs(TeamId) do
				teamAmounts[teamId] = 0
			end

			for i = 0, 32 do
				if NetworkIsPlayerConnected(i) and DoesEntityExist(GetPlayerPed(i)) and DecorExistOn(GetPlayerPed(i), "_PLAYER_TEAM") then
					local teamId = DecorGetInt(GetPlayerPed(i), "_PLAYER_TEAM")
					teamAmounts[teamId] = teamAmounts[teamId] + 1
				end
			end

			TriggerEvent("menu:setGreyedOut", true, ids[CurrentTeam.Get()])
			TriggerEvent("menu:setGreyedOut", teamAmounts[TeamId.President] > 0, ids[TeamId.President])
			TriggerEvent("menu:setGreyedOut", teamAmounts[TeamId.Vice] > 0, ids[TeamId.Vice])

			local lowest = 99999
			for team, amount in pairs(teamAmounts) do
				if team ~= TeamId.None and team ~= TeamId.President and team ~= TeamId.Vice and amount < lowest then
					lowest = amount
				end
			end
			for team, amount in pairs(teamAmounts) do
				if team ~= TeamId.None and team ~= TeamId.President and team ~= TeamId.Vice then
					local greyOut = teamAmounts[team] > lowest + 1
					if team == TeamId.Bodyguard then
						greyOut = teamAmounts[TeamId.President] == 0
					end
					TriggerEvent("menu:setGreyedOut", greyOut, ids[team])
				end
			end
		end
	end
end)