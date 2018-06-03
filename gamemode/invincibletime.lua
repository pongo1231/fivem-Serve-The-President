local timeLeft

InvincibleTime = {}
function InvincibleTime.Request()
	TriggerServerEvent("stp:server:requestInvincibleTime")
end

RegisterNetEvent("stp:setInvincibleTime")
AddEventHandler("stp:setInvincibleTime", function(time)
	timeLeft = time

	if time == 9 then
		PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 1)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(100)

		if timeLeft and timeLeft > 0 then
			if timeLeft == 1 then
				Wait(1000)
				SetEntityInvincible(PlayerPedId(), false)

				SetNotificationTextEntry("STRING")
				AddTextComponentSubstringPlayerName("~r~You are not invincible anymore!")
				DrawNotification(true, false)
				StartScreenEffect("FocusOut", 1000, false)
			else
				SetEntityInvincible(PlayerPedId(), true)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if timeLeft and timeLeft > 0 then
		    BeginTextCommandDisplayText("STRING")
			SetTextFont(4)
			SetTextScale(1.0, 1.0)
			SetTextColour(255, 255, 0, 255)

			AddTextComponentSubstringPlayerName(string.format("%02i", timeLeft % 60))
			EndTextCommandDisplayText(0.4925, 0.1)
		end
	end
end)