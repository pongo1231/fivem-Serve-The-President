local timeLeft

RegisterNetEvent("stp:setCountdown")
AddEventHandler("stp:setCountdown", function(time)
	timeLeft = time
	
	if time == 30 then
		TriggerMusicEvent("FM_COUNTDOWN_30S")
	end
end)

Countdown = {}
function Countdown.Get()
	return timeLeft
end

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if timeLeft and timeLeft > 0 and CurrentTeam.Get() ~= TeamId.None then
			DrawRect(0.5, 0.05, 0.2, 0.1, 0, 0, 0, 155, 0)

		    BeginTextCommandDisplayText("STRING")
			SetTextFont(4)
			SetTextScale(1.5, 1.5)

			if timeLeft < 60 then
				SetTextColour(213, 0, 0, 255)
			end

			local seconds = timeLeft % 60
			local minutes = math.floor(timeLeft / 60)
			AddTextComponentSubstringPlayerName(string.format("%02i:%02i", minutes, seconds))
			EndTextCommandDisplayText(0.465, 0.005)
		end
	end
end)