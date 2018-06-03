local counter

Countdown = {}
function Countdown.Set(time)
	counter = time
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if counter and counter > -1 then
			counter = counter - 1
			TriggerClientEvent("stp:setCountdown", -1, counter)
		end
	end
end)

Countdown.Set(90)