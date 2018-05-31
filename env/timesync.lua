AddEventHandler("playerSpawned", function()
	local h, m, s = NetworkGetServerTime()
	NetworkOverrideClockTime(h, m, s)
end)