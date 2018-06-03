local firstRound = true

RegisterNetEvent("stp:server:presidentDied")
AddEventHandler("stp:server:presidentDied", function()
	Round.Restart()
end)

Round = {}
function Round.Restart()
	if not firstRound then
		TriggerClientEvent("stp:teamToNone", -1)
	end

	Countdown.Set(1800)
	firstRound = false
end