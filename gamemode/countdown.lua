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
			if not counter then
				running = false
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
	local scaleform = RequestScaleformMovie("MP_CELEBRATION")
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(1)
	end

	while true do
		Wait(1)

		if running then
			PushScaleformMovieFunction(scaleform, "startCounter")
			PushScaleformMovieFunctionParameterInt(0)
			PushScaleformMovieFunctionParameterInt(255)
			PushScaleformMovieFunctionParameterInt(10)
			PushScaleformMovieFunctionParameterInt(100)
			PopScaleformMovieFunction()
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end
end)]]--