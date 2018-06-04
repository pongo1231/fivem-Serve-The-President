local weatherTypes = {
	"CLEAR",
	"EXTRASUNNY",
	"CLOUDS",
	"OVERCAST",
	"RAIN",
	"CLEARING",
	"THUNDER",
	"SMOG",
	"FOGGY"
}
local currentWeather = "CLEAR"
local weatherTransitionCooldown = 300
local cloudOpacity = 0.0

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		TriggerClientEvent("stp:weatherSync", -1, currentWeather, cloudOpacity)

		weatherTransitionCooldown = weatherTransitionCooldown - 1
		if weatherTransitionCooldown == 0 then
			weatherTransitionCooldown = 300
			currentWeather = weatherTypes[math.random(1, #weatherTypes)]
			if math.random() > 0.5 and cloudOpacity < 1.0 then
				cloudOpacity = cloudOpacity + 0.1
			else
				cloudOpacity = cloudOpacity - 0.1
			end
		end
	end
end)