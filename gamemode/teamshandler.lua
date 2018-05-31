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
		Wait(500)
		TriggerServerEvent("ServeThePresident:RequestTeamInfo")
	end
end)

RegisterNetEvent("ServeThePresident:ReceiveTeamInfos")
AddEventHandler("ServeThePresident:ReceiveTeamInfos", function(PresidentStatus, VicePresidentStatus, TerroristsStatus, CiviliansStatus, BodyGuardsStatus)
	if not PresidentStatus then
		TriggerEvent("menu:setGreyedOut", true, ids["President"])
	elseif PresidentStatus
		TriggerEvent("menu:setGreyedOut", false, ids["President"])
	end
	if not VicePresidentStatus then
		TriggerEvent("menu:setGreyedOut", true, ids["VicePresident"])
	elseif VicePresidentStatus
		TriggerEvent("menu:setGreyedOut", false, ids["VicePresident"])
	end
	if not BodyGuardsStatus then
		TriggerEvent("menu:setGreyedOut", true, ids["BodyGuard"])
	elseif BodyGuardsStatus
		TriggerEvent("menu:setGreyedOut", false, ids["BodyGuard"])
	end
	if not TerroristsStatus then
		TriggerEvent("menu:setGreyedOut", true, ids["Terrorist"])
	elseif TerroristsStatus
		TriggerEvent("menu:setGreyedOut", false, ids["Terrorist"])
	end
	if not CiviliansStatus then
		TriggerEvent("menu:setGreyedOut", true, ids["Civilian"])
	elseif CiviliansStatus
		TriggerEvent("menu:setGreyedOut", false, ids["Civilian"])
	end
end)