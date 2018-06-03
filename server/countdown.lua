local counter

Countdown = {}
function Countdown.Set(time)
	counter = time
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if counter and counter > 0 then
			counter = counter - 1
			TriggerClientEvent("stp:setCountdown", -1, counter)
			if counter == 0 then
				TriggerClientEvent("stp:teamToNone", -1)
				Countdown.Set(1800)
			end
		end
	end
end)

Countdown.Set(1800)