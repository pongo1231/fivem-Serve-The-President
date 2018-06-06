local currentWeather
local transitioningWeather

RegisterNetEvent("stp:weatherSync")
AddEventHandler("stp:weatherSync", function(weather)
	if not transitioningWeather then
		if currentWeather ~= weather then
			SetWeatherTypeOverTime(weather, 30.0)
			currentWeather = weather
			transitioningWeather = true
			Wait(30000)
			transitioningWeather = false
		else
			SetWeatherTypeNowPersist(weather)
		end
	end
end)