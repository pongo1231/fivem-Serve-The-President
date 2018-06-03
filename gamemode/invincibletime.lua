local running
local counter
local invincibleEndWarned = false

InvincibleTime = {}
function InvincibleTime.Start()
	counter = 20
	running = true
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if running then
			counter = counter - 1
			if counter == 9 then
				PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 1)
			elseif counter == 0 then
				running = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(100)

		if not running then
			invincibleEndWarned = false
		else
			if counter == 1 then
				SetEntityInvincible(PlayerPedId(), false)

				if not invincibleEndWarned then
					SetNotificationTextEntry("STRING")
					AddTextComponentSubstringPlayerName("~r~You are not invincible anymore!")
					DrawNotification(true, false)
					StartScreenEffect("FocusOut", 1000, false)
					invincibleEndWarned = true
				end
			else
				SetEntityInvincible(PlayerPedId(), true)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if running then
		    BeginTextCommandDisplayText("STRING")
			SetTextFont(4)
			SetTextScale(1.0, 1.0)
			SetTextColour(255, 255, 0, 255)

			AddTextComponentSubstringPlayerName(string.format("%02i", counter % 60))
			EndTextCommandDisplayText(0.4925, 0.1)
		end
	end
end)