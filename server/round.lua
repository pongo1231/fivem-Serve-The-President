local firstRound = true

RegisterNetEvent("stp:server:playerDied")
AddEventHandler("stp:server:playerDied", function(killer)
	CreateThread(function()
		if Players.GetPlayerTeam(source) == TeamId.President then
			Round.Restart()
			if killer ~= nil then
				TriggerClientEvent("stp:client:RoundEnd", -1, GetPlayerName(killer))
			else
				TriggerClientEvent("stp:client:RoundEnd", -1, nil)
			end
		end
	end)
	
end)

AddEventHandler("playerConnecting", function()
	if #Players.GetAll() == 1 then
		Round.Restart()
	end
end)

Round = {}
function Round.Restart()
	if not firstRound then
		TriggerClientEvent("stp:toTeam", -1, TeamId.None)
	end
	
	Countdown.Set(1800)
	firstRound = false
end

Round.Restart()