local currentTeam = TeamId.None

CurrentTeam = {}
function CurrentTeam.Update(team, instant)
	currentTeam = team
	Spawner.Respawn(instant)
end

function CurrentTeam.Get()
	return currentTeam
end

Citizen.CreateThread(function()
	NetworkSetFriendlyFireOption(false)

	while true do
		Wait(100)

		if PlayerPedId() then
			for i = 0, 32, 1 do
				if NetworkIsPlayerConnected(i) then
					local playerPed = GetPlayerPed(i)
					if playerPed then
						local team = DecorGetInt(playerPed, "_PLAYER_TEAM")
						local relationship = TeamRelationships[CurrentTeam.Get()][team]

						SetPedAsEnemy(playerPed, relationship == TeamRelationshipType.Hostile)

						local blip = GetBlipFromEntity(playerPed)
						if relationship == TeamRelationshipType.Hostile and not team == TeamId.President and blip then
							RemoveBlip(blip)
						else
							if not blip then
								blip = AddBlipForEntity(playerPed)
							end
							SetBlipColour(blip, TeamBlipColors[team])
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(100)

		if PlayerPedId() then
			local currentTeam = CurrentTeam.Get()
			if currentTeam == TeamId.President or currentTeam == TeamId.Vice then
				local tryingVehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
				if GetVehicleClass(tryingVehicle) == 15 or GetVehicleClass(tryingVehicle) == 16 then
					TaskPause(PlayerPedId(), 0)
					TriggerEvent("chatMessage", "", {255, 0, 0}, "You can't enter helis/planes as (Vice) President!")
				end
			end
		end
	end
end)

AddTextEntry("_TEAMNONE_GUIDE", "Press ~INPUT_SELECT_CHARACTER_FRANKLIN~ to open the gamemode menu, then select Team Menu to choose a team.")
Citizen.CreateThread(function()
	while true do
		Wait(1)

		if CurrentTeam.Get() == TeamId.None then
			BeginTextCommandPrint(_TEAMNONE_GUIDE)
			DisplayHelpTextThisFrame("_TEAMNONE_GUIDE", 0)
		end
	end
end)

-- I'll look at this later

--[[Citizen.CreateThread(function()
	while true do
		Wait(500)
		TriggerServerEvent("ServeThePresident:RequestTeamInfo")
	end
end)

RegisterNetEvent("ServeThePresident:ReceiveTeamInfos")
AddEventHandler("ServeThePresident:ReceiveTeamInfos", function(TeamStatuses)
	for Team, Status in pairs(TeamStatuses) do
		TriggerEvent("menu:setGreyedOut", not Status, ids[Team])
	end
end)]]--