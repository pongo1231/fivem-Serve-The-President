local running
local counter

Countdown = {}
function Countdown.Set(time)
	counter = time
	running = true
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if running then
			counter = counter - 1
			if counter == 0 then
				running = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if running and CurrentTeam.Get() ~= TeamId.None then
			DrawRect(0.5, 0.05, 0.2, 0.1, 0, 0, 0, 155, 0)

		    BeginTextCommandDisplayText("STRING")
			SetTextFont(4)
			SetTextScale(1.5, 1.5)
			SetTextColour(255, 255, 255, 255)

			local seconds = counter % 60
			local minutes = math.floor(counter / 60)
			AddTextComponentSubstringPlayerName(string.format("%02i:%02i", minutes, seconds))
			EndTextCommandDisplayText(0.465, 0.005)
		end
	end
end)

Countdown.Set(1800)