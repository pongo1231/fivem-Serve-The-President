local pickupSpawns = {
	{type = "WEAPON_PISTOL", x = 1412.9, y = -725.5, z = 67.2},
	{type = "WEAPON_CARBINERIFLE", x = 21.3, y = -1105.7, z = 30.8},
	{type = "WEAPON_RPG", x = 386.8, y = -341.5, z = 49.7},
	{type = "WEAPON_SNIPERRIFLE", x = 91.8, y = -334.8, z = 75.6},
	{type = "WEAPON_MICROSMG", x = 104.9, y = -377.3, z = 70.1}
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

for _, pickupSpawn in ipairs(pickupSpawns) do
	local blip = AddBlipForCoord(pickupSpawn.x, pickupSpawn.y, pickupSpawn.z)
	SetBlipAsShortRange(blip, true)

	-- TODO: No hardcoding PLEEASSEE
	local blipinfo
	if IsWeaponValid(pickupSpawn.type) then
		blipinfo = weaponGroupBlips[GetWeapontypeGroup(GetHashKey(pickupSpawn.type))]
	else
		if pickupSpawn.type == "ARMOUR_STANDARD" then
			blipinfo = {sprite = 175, entry = "_ARMOR", text = "Armor Pickup"}
		elseif pickupSpawn.type == "HEALTH_STANDARD" then
			blipinfo = {sprite = 153, entry = "_HEALTH", text = "Health Pickup"}
		else
			print("Invalid pickup " .. pickupSpawn.type .. "! PLZ fix!!!!")
		end
	end
	SetBlipSprite(blip, blipinfo.sprite)
	AddTextEntry(blipinfo.entry, blipinfo.text)
	SetBlipNameFromTextFile(blip, blipinfo.entry)

	local pickup = CreatePickupRotate(GetHashKey("PICKUP_" .. pickupSpawn.type), pickupSpawn.x, pickupSpawn.y,
		pickupSpawn.z, 0.0, 0.0, 0.0, 8, GetRandomIntInRange(1, 100))
	SetPickupRegenerationTime(pickup, 60)
end