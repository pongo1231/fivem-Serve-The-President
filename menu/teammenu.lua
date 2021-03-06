local ids = {}
local overriden
local cooldown

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		ids["menu"] = id

		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) ids[TeamId.President] = id end, function()
			TeamMenu.OnClick(TeamId.President)
			--DebugPrint("STP::UpdateTeam::President")
		end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) ids[TeamId.Vice] = id end, function()
			TeamMenu.OnClick(TeamId.Vice)
			--DebugPrint("STP::UpdateTeam::Vice")
		end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) ids[TeamId.Bodyguard] = id end, function()
			TeamMenu.OnClick(TeamId.Bodyguard)
			--DebugPrint("STP::UpdateTeam::BodyGuard")
		end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) ids[TeamId.Terrorist] = id end, function()
			TeamMenu.OnClick(TeamId.Terrorist)
			--DebugPrint("STP::UpdateTeam::Terrorist")
		end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) ids[TeamId.Civil] = id end, function()
			TeamMenu.OnClick(TeamId.Civil)
			--DebugPrint("STP::UpdateTeam::Civil")
		end)
	end)
end)

TeamMenu = {}
function TeamMenu.OnClick(team)
	CurrentTeam.Update(team)
	TriggerEvent("menu:hideMenu")
	cooldown = 60
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if not overriden and cooldown then
			if cooldown > 0 then
				if CurrentTeam.Get() == TeamId.None then
					cooldown = 0
				else
					cooldown = cooldown - 1
				end
				TriggerEvent("menu:setGreyedOut", true, ids["menu"])
				TriggerEvent("menu:setDesc", ids["menu"], string.format("Please wait %02i seconds", cooldown))
			else
				TeamMenu.OverrideGreyedOut(false)
				cooldown = nil
			end
		end
	end
end)

function TeamMenu.OverrideGreyedOut(state, desc)
	overriden = state
	for _, id in pairs(ids) do
		TriggerEvent("menu:setGreyedOut", state, id)
		TriggerEvent("menu:setDesc", id, desc)
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if not overriden then
			if CurrentTeam.Get() == TeamId.President or CurrentTeam.Get() == TeamId.Vice then
				TeamMenu.OverrideGreyedOut(true, "No giving up as a president!")
			else
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
				TriggerEvent("menu:setGreyedOut", teamAmounts[TeamId.President] < 1, ids[TeamId.Vice])

				local lowest = 99999
				for team, amount in pairs(teamAmounts) do
					if team ~= TeamId.None and team ~= TeamId.President and team ~= TeamId.Vice and amount < lowest then
						lowest = amount
					end
				end
				for team, amount in pairs(teamAmounts) do
					if team ~= TeamId.None and team ~= TeamId.President and team ~= TeamId.Vice and team ~= CurrentTeam.Get() then
						local greyOut = teamAmounts[team] > lowest + 1
						if team == TeamId.Bodyguard then
							greyOut = teamAmounts[TeamId.President] == 0
						end
						TriggerEvent("menu:setGreyedOut", greyOut, ids[team])
					end
				end
			end
		end
	end
end)