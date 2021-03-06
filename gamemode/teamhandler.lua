local currentTeam = TeamId.None

DecorRegister("_PLAYER_TEAM", 3)

CurrentTeam = {}
function CurrentTeam.Update(team, instant)
	currentTeam = team
	TeamHelpDisplay.Stop()
	TriggerServerEvent("stp:server:teamEntered", team)
	Spawner.Respawn(instant)
end
RegisterNetEvent("stp:toTeam")
AddEventHandler("stp:toTeam", CurrentTeam.Update)

function CurrentTeam.Get()
	return currentTeam
end

Citizen.CreateThread(function()
	NetworkSetFriendlyFireOption(false)

	while true do
		Wait(100)

		if PlayerPedId() then
			TeamHandler.HandleBlipsAndFriendly()

			local currentTeam = CurrentTeam.Get()
			if currentTeam == TeamId.President or currentTeam == TeamId.Vice then
				local tryingVehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
				if GetVehicleClass(tryingVehicle) == 15 or GetVehicleClass(tryingVehicle) == 16 then
					TaskPause(PlayerPedId(), 0)
					BeginTextCommandPrint("STRING")
					AddTextComponentSubstringPlayerName("~r~You can't enter helis/planes as (Vice) President!")
					EndTextCommandPrint(5000, true)
				end
			end
		end
	end
end)

TeamHandler = {}
function TeamHandler.HandleBlipsAndFriendly()
	for i = 0, 32 do
		if NetworkIsPlayerConnected(i) then
			local playerPed = GetPlayerPed(i)
			if i ~= PlayerId() and DoesEntityExist(playerPed) then
				local team = DecorGetInt(playerPed, "_PLAYER_TEAM")
				local relationship = TeamRelationships[CurrentTeam.Get()][team]

				SetPedAsEnemy(playerPed, relationship == TeamRelationshipType.Hostile)

				local blip = GetBlipFromEntity(playerPed)
				if relationship == TeamRelationshipType.Hostile and team ~= TeamId.President then
					if DoesBlipExist(blip) then
						RemoveBlip(blip)
					end
				else
					if not DoesBlipExist(blip) then
						blip = AddBlipForEntity(playerPed)
						ShowHeadingIndicatorOnBlip(blip, true)
					end
					SetBlipColour(blip, TeamBlipColors[team])
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(500)

		if CurrentTeam.Get() == TeamId.None and not GetScreenEffectIsActive("FocusIn") then
			StartScreenEffect("FocusIn")
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