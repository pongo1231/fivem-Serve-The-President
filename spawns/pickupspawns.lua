local pickupSpawns = {
	{ptype = "WEAPON_PISTOL", x = 1412.9, y = -725.5, z = 67.2},
	{ptype = "WEAPON_CARBINERIFLE", x = 21.3, y = -1105.7, z = 30.8},
	{ptype = "WEAPON_RPG", x = 386.8, y = -341.5, z = 49.7},
	{ptype = "WEAPON_SNIPERRIFLE", x = 91.8, y = -334.8, z = 75.6},
	{ptype = "WEAPON_MICROSMG", x = 104.9, y = -377.3, z = 70.1},
	{ptype = "ARMOUR_STANDARD", x = -128.7, y = -1585.9, z = 32.3},
	{ptype = "WEAPON_PISTOL", x = -44.6, y = -1749.1, z = 30.3},
	{ptype = "WEAPON_HATCHET", x = 389.1, y = -1823.3, z = 28.8},
	{ptype = "WEAPON_ASSAULTRIFLE", x = 388.4, y = -1685.1, z = 37.8},
	{ptype = "HEALTH_STANDARD", x = 304.6, y = -1451.8, z = 30.0},
	{ptype = "WEAPON_GRENADE", x = 702.9, y = -1540.1, z = 9.7},
	{ptype = "WEAPON_PISTOL50", x = 690.5, y = -1564.1, z = 10.5},
	{ptype = "WEAPON_COMBATPISTOL", x = -1821.7, y = -1202.1, z = 19.2},
	{ptype = "ARMOUR_STANDARD", x = 2528.0, y = -416.4, z = 94.1},
	{ptype = "WEAPON_ADVANCEDRIFLE", x = 2513.7, y = -405.8, z = 94.1},
	{ptype = "WEAPON_GUSENBERG", x = 1691.3, y = -1672.8, z = 111.5},
	{ptype = "WEAPON_MINIGUN", x = 1703.1, y = -1714.8, z = 117.2}
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
	if IsWeaponValid(pickupSpawn.ptype) then
		blipinfo = weaponGroupBlips[GetWeapontypeGroup(GetHashKey(pickupSpawn.ptype))]
	else
		if pickupSpawn.ptype == "ARMOUR_STANDARD" then
			blipinfo = {sprite = 175, entry = "_ARMOR", text = "Armor Pickup"}
		elseif pickupSpawn.ptype == "HEALTH_STANDARD" then
			blipinfo = {sprite = 153, entry = "_HEALTH", text = "Health Pickup"}
		else
			print("Invalid pickup " .. pickupSpawn.ptype .. "! PLZ fix!!!!")
		end
	end
	SetBlipSprite(blip, blipinfo.sprite)
	AddTextEntry(blipinfo.entry, blipinfo.text)
	SetBlipNameFromTextFile(blip, blipinfo.entry)

	local pickup = CreatePickupRotate(GetHashKey("PICKUP_" .. pickupSpawn.ptype), pickupSpawn.x, pickupSpawn.y,
		pickupSpawn.z, 0.0, 0.0, 0.0, 8, GetRandomIntInRange(1, 100))
	SetPickupRegenerationTime(pickup, 60)
end