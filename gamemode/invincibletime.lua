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
				SetEntityInvincible(PlayerPedId())

				SetNotificationTextEntry("STRING")
				AddTextComponentSubstringPlayerName("~r~You are not invincible anymore!")
				DrawNotification(true)
				StopScreenEffect("FocusIn")
				StartScreenEffect("FocusOut", 1000)
			elseif timeLeft == 29 and not GetScreenEffectIsActive("FocusIn") then
				SetNotificationTextEntry("STRING")
				AddTextComponentSubstringPlayerName("~g~You are invincible for 30 seconds!")
				DrawNotification(true)
				StartScreenEffect("FocusIn")
			else
				SetEntityInvincible(PlayerPedId(), true)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if not Spawner.IsSwitching() then
			if timeLeft and timeLeft > 0 then
				DrawRect(0.675, 0.05, 0.08, 0.1, 0, 0, 0, 155, 0)

			    BeginTextCommandDisplayText("STRING")
				SetTextFont(4)
				SetTextScale(1.5, 1.5)
				SetTextColour(255, 214, 0, 255)

				AddTextComponentSubstringPlayerName(string.format("%02i", timeLeft % 60))
				EndTextCommandDisplayText(0.658, 0.005)
			end
		end
	end
end)