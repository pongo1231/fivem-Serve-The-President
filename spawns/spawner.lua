--[[local weaponSpawns = {
	{model = "WEAPON_PISTOL", x = 1412.9, y = -725.5, z = 67.2},
	{model = "WEAPON_CARBINE", x = 21.3, y = -1105.7, z = 30.8},
	{model = "WEAPON_ROCKETLAUNCHER", x = 386.8, y = -341.5, z = 49.7}
}]]--

DecorRegister("_STP_VEHICLE", 2)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if PlayerPedId() then
			local playerCoords = GetEntityCoords(PlayerPedId(), true)
			for _, vehicleSpawn in ipairs(VehicleSpawns) do
				if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y,
					playerCoords.z, vehicleSpawn.x, vehicleSpawn.y, vehicleSpawn.z,
					true) < 100.0 then
						local canSpawn = true
						for nearbyVehicle in EnumerateVehicles() do
							if GetDistanceBetweenCoords(playerCoords.x,
								playerCoords.y, playerCoords.z,
								vehicleSpawn.x, vehicleSpawn.y, vehicleSpawn.z,
								true) < 100.0
								and GetEntityModel(nearbyVehicle) == GetHashKey(vehicleSpawn.model)
								and DecorExistOn(nearbyVehicle, "_STP_VEHICLE") then
								canSpawn = false
							end
						end

						if canSpawn then
							local model = GetHashKey(vehicleSpawn.model)
							RequestModel(model)
							while not HasModelLoaded(model) do
								Wait(1)
							end
							local vehicle = CreateVehicle(model, vehicleSpawn.x,
								vehicleSpawn.y, vehicleSpawn.z, vehicleSpawn.h,
								true, false)
							DecorSetBool(vehicle, "_STP_VEHICLE", true)
							SetVehicleAsNoLongerNeeded(vehicle)
						end
				end
			end
		end
	end
end)