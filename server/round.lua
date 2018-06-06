local firstRound = true

RegisterNetEvent("stp:server:playerDied")
AddEventHandler("stp:server:playerDied", function()
	if Players.GetPlayerTeam(source) == TeamId.President then
		Round.Restart()
	end
end)

AddEventHandler("playerConnecting", function(playerName, setKickReason)
	if #Players.Get() == 1 then
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