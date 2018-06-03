Citizen.CreateThread(function()
	while true do
		Wait(500)

		SetMaxWantedLevel(0)
		SetAudioFlag("DisableFlightMusic", true)
		SetAudioFlag("WantedMusicDisabled", true)
	end
end)