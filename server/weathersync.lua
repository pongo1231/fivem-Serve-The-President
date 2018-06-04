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

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		TriggerClientEvent("stp:weatherSync", -1, currentWeather)

		weatherTransitionCooldown = weatherTransitionCooldown - 1
		if weatherTransitionCooldown == 0 then
			weatherTransitionCooldown = 300
			currentWeather = weatherTypes[math.random(1, #weatherTypes)]
		end
	end
end)