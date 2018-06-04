Citizen.CreateThread(function()
	while true do
		local h, m, s = NetworkGetServerTime()
		NetworkOverrideClockTime(h, m, s)
		Wait(60000)
	end
end)