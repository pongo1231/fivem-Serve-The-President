local running
local counter

RegisterNetEvent("stp:server_fetchCounter")
AddEventHandler("stp:server_fetchCounter", function(cb)
	cb(counter)
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if running then
			counter = counter - 1
			if not counter then
				running = false
				-- TODO: Stop Round
			end
		end
	end
end)