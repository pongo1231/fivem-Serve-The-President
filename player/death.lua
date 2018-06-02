local drawDeathScaleform
local deathScaleform

Citizen.CreateThread(function()
	while true do
		Wait(100)

		if DoesEntityExist(PlayerPedId()) and IsEntityDead(PlayerPedId()) then
			TeamMenu.GreyOut(true)
			drawDeathScaleform = true

			PlaySoundFrontend(-1, "Bed", "WastedSounds", true)
			TriggerMusicEvent("KILL_LIST_START_MUSIC")
			DisplayRadar(false)

			StartScreenEffect("DeathFailMPIn", 0, false)
			Wait(10000)
			TriggerMusicEvent("KILL_LIST_STOP_MUSIC")

			DoScreenFadeOut(500)
			drawDeathScaleform = false
			Wait(4000)
			Spawner.Respawn(true)
			StopScreenEffect("DeathFailMPIn")
			DoScreenFadeIn(500)

			TeamMenu.GreyOut(false)
		end
	end
end)

Citizen.CreateThread(function()
	deathScaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
	while not HasScaleformMovieLoaded(deathScaleform) do
		Wait(1)
	end

	while true do
		Wait(1)

		if drawDeathScaleform then
			PushScaleformMovieFunction(deathScaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			PushScaleformMovieFunctionParameterString("~r~wasted")
			PopScaleformMovieFunction()

			DrawScaleformMovieFullscreen(deathScaleform, 255, 255, 255, 255, 0)
		end
	end
end)