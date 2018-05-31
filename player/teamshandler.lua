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
						if relationship == TeamRelationshipType.Hostile and blip then
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