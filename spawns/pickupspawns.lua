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
	{ptype = "ARMOUR_STANDARD", x = 2528.0, y = -416.4, z = 94.1},
	{ptype = "WEAPON_GUSENBERG", x = 1691.3, y = -1672.8, z = 111.5},
	{ptype = "WEAPON_COMBATMG", x = 1703.1, y = -1714.8, z = 120.0},
	{ptype = "ARMOUR_STANDARD", x = 338.9, y = -1276.1, z = 33.3},
	{ptype = "WEAPON_PISTOL", x = 464.8, y = -983.5, z = 35.9},
	{ptype = "WEAPON_NIGHTSTICK", x = 458.2, y = -990.4, z = 30.7},
	{ptype = "WEAPON_MINISMG", x = 480.9, y = -568.4, z = 28.9},
	{ptype = "WEAPON_SAWNOFFSHOTGUN", x = -176.0, y = -633.9, z = 49.0},
	{ptype = "WEAPON_BAT", x = -1631.7, y = 238.0, z = 60.1},
	{ptype = "WEAPON_GOLFCLUB", x = -1284.1, y = -127.0, z = 45.8},
	{ptype = "WEAPON_MACHINEPISTOL", x = -1295.5, y = -123.7, z = 47.4},
	{ptype = "WEAPON_MOLOTOV", x = -1305.5, y = 240.4, z = 59.0},
	{ptype = "WEAPON_BULLPUPRIFLE", x = -1256.6, y = 4.8, z = 45.0},
	{ptype = "WEAPON_SMG", x = -852.3, y = -158.9, z = 20.0},
	{ptype = "WEAPON_FLAREGUN", x = -1096.2, y = -529.8, z = 41.7},
	{ptype = "HEALTH_STANDARD", x = -449.5, y = -341.4, z = 34.5},
	{ptype = "WEAPON_ASSAULTSMG", x = -238.4, y = -325.9, z = 30.0},
	{ptype = "WEAPON_ASSAULTSHOTGUN", x = -1048.9, y = -2741.6, z = 14.6},
	{ptype = "WEAPON_GRENADELAUNCHER", x = -937.2, y = -2931.7, z = 13.9},
	{ptype = "WEAPON_SPECIALCARBINE", x = -1286.6, y = -2652.1, z = 14.0},
	{ptype = "WEAPON_STICKYBOMB", x = 99.6, y = -2019.2, z = 18.4},
	{ptype = "WEAPON_BULLPUPSHOTGUN", x = -466.0, y = -1656.3, z = 19.3},
	{ptype = "WEAPON_MG", x = -435.0, y = -1717.6, z = 19.2},
	{ptype = "WEAPON_MARKSMANRIFLE", x = 115.1, y = -2182.7, z = 6.0},
	{ptype = "ARMOUR_STANDARD", x = -217.0, y = -2369.7, z = 29.7},
	{ptype = "WEAPON_SNIPERRIFLE", x = -232.7, y = -2372.7, z = 17.3},
	{ptype = "WEAPON_RPG", x = -224.6, y = -2381.4, z = 17.2},
	{ptype = "WEAPON_REVOLVER", x = -478.6, y = -2776.6, z = 6.0},
	{ptype = "WEAPON_MARKSMANPISTOL", x = -549.4, y = -2892.0, z = 3.0},
	{ptype = "WEAPON_COMBATPDW", x = -1809.9, y = -366.3, z = 49.2},
	{ptype = "WEAPON_MUSKET", x = -1858.6, y = -348.2, z = 49.8}
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
		pickupSpawn.z, 0.0, 0.0, 0.0, 8, 100)
	SetPickupRegenerationTime(pickup, 60)
end