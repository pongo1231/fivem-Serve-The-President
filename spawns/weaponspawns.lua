local weaponSpawns = {
	{pickup = "PICKUP_WEAPON_PISTOL", wep = "WEAPON_PISTOL", x = 1412.9, y = -725.5, z = 67.2},
	{pickup = "PICKUP_WEAPON_CARBINERIFLE", wep = "WEAPON_CARBINERIFLE", x = 21.3, y = -1105.7, z = 30.8},
	{pickup = "PICKUP_WEAPON_RPG", wep = "WEAPON_RPG", x = 386.8, y = -341.5, z = 49.7},
}

local weaponGroupBlips = {
	[-728555052] = { -- Melee
		sprite = 151, entry = "_MELEE", text = "Melee Weapon"
	},
	[416676503] = { -- Pistols
		sprite = 156, entry = "_PISTOL", text = "Pistol"
	}, 
	[-957766203] = { -- SMGs
		sprite = 159, entry = "_SMG", text = "SMG"
	},
	[970310034] = { -- Rifles
		sprite = 150, entry = "_RIFLE", text = "Rifle"
	},
	[860033945] = { -- Shotguns
		sprite = 158, entry = "_SHOTGUN", text = "Shotgun"
	},
	[1159398588] = { -- MGs (only?)
		sprite = 150, entry = "_MG", text = "MG"
	},
	[-1212426201] = { -- Sniper Rifles
		sprite = 160, entry = "_SNIPER", text = "Sniper Rifle"
	},
	[-1569042529] = { -- Heavy
		sprite = 157, entry = "_HEAVY", text = "Heavy Weapon"
	},
	[1548507267] = { -- Grenade Thingies
		sprite = 152, entry = "_GRENADE", text = "Throwable Weapon"
	}
}

--[[for _, weaponSpawn in ipairs(weaponSpawns) do
	local blip = AddBlipForCoord(weaponSpawn.x, weaponSpawn.y, weaponSpawn.z)
	SetBlipAsShortRange(blip, true)

	local blipinfo = weaponGroupBlips[GetWeapontypeGroup(GetHashKey(weaponSpawn.wep))]
	SetBlipSprite(blip, blipinfo.sprite)
	AddTextEntry(blipinfo.entry, blipinfo.text)
	SetBlipNameFromTextFile(blip, blipinfo.entry)
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if DoesEntityExist(PlayerPedId()) then
			local playerCoords = GetEntityCoords(PlayerPedId(), true)
			for _, weaponSpawn in ipairs(weaponSpawns) do
				if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, weaponSpawn.x, weaponSpawn.y,
					weaponSpawn.z, true) < 100.0 then
						if not IsWeaponValid(GetHashKey(weaponSpawn.wep)) then
							print("Weapon " .. weaponSpawn.wep .. " in invalid. Fix this RIGHT NOW!")
						else
							local canSpawn = true
							for nearbyPickup in EnumeratePickups() do
								print("a")
								local nearbyPickupCoords = GetEntityCoords(nearbyPickup)
								if GetDistanceBetweenCoords(nearbyPickupCoords.x, nearbyPickupCoords.y, nearbyPickupCoords.z,
									weaponSpawn.x, weaponSpawn.y, weaponSpawn.z, true) < 5.0 then
										canSpawn = false
								end
							end

							if canSpawn then
								local pickup = CreatePortablePickup(GetHashKey(weaponSpawn.pickup), weaponSpawn.x, weaponSpawn.y,
									weaponSpawn.z, true, GetHashKey(weaponSpawn.pickup))
								SetObjectAsNoLongerNeeded(pickup)
							end
						end
				end
			end
		end
	end
end)]]--