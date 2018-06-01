local alreadyInited

Spawner = {}
function Spawner.Respawn(instant)
	TriggerEvent("stp:respawn", instant)
end

function Spawner.Init()
	if not alreadyInited then
		--exports.spawnmanager:setAutoSpawn(false)
		CurrentTeam.Update(TeamId.None, true)

		alreadyInited = true
	end
end

if PlayerPedId() then
	Spawner.Init()
end
AddEventHandler("playerSpawned", Spawner.Init)

AddEventHandler("stp:respawn", function(instant)
	DisplayRadar(false)
	DisplayHud(false)

	local spawnPos = TeamSpawns.Random(CurrentTeam.Get())

	if not instant then
		TeamMenu.GreyOut(true)

		local currentPos = GetEntityCoords(PlayerPedId(), true)

		local decoyPedModel = -257153498
		RequestModel(decoyPedModel)
		while not HasModelLoaded(decoyPedModel) do
			Wait(1)
		end
		local decoyPed = CreatePed(4, decoyPedModel, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, false, false)
		StartPlayerSwitch(PlayerPedId(), decoyPed, 8, GetIdealPlayerSwitchType(currentPos.x, currentPos.y, currentPos.z,
			spawnPos.x, spawnPos.y, spawnPos.z))
		DeletePed(decoyPed)

		while GetPlayerSwitchState() ~= 8 and GetPlayerSwitchState() ~= 10 do
			Wait(1)
		end
	end

	if IsEntityDead(PlayerPedId()) then
		NetworkResurrectLocalPlayer(spawnPos.x, spawnPos.y, spawnPos.z, GetRandomFloatInRange(0.0, 360.0), true, false)
	else
		SetEntityCoords(PlayerPedId(), spawnPos.x, spawnPos.y, spawnPos.z, 0.0, 0.0, 0.0, true)
	end

	Spawner.SetTeamStuff()

	if not instant then
		StopPlayerSwitch()
		RenderScriptCams(false, false, 3000, true, false)
		PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", false)
		TeamMenu.GreyOut(false)
	end
end)

function Spawner.SetTeamStuff()
	local playerModel = TeamModels.Random(CurrentTeam.Get())
	RequestModel(playerModel)
	while not HasModelLoaded(playerModel) do
		Wait(1)
	end
	SetPlayerModel(PlayerId(), playerModel)
	DecorSetInt(PlayerPedId(), "_PLAYER_TEAM", CurrentTeam.Get())

	if CurrentTeam.Get() == TeamId.None then
		SetEntityInvincible(PlayerPedId(), true)
		SetEntityVisible(PlayerPedId(), false, 0)
		FreezeEntityPosition(PlayerPedId(), true)
		TriggerMusicEvent("BST_START")
	else
		DisplayRadar(true)
		DisplayHud(true)

		SetEntityInvincible(PlayerPedId(), false)
		SetEntityVisible(PlayerPedId(), true, 0)
		FreezeEntityPosition(PlayerPedId(), false)
		TriggerMusicEvent("BST_STOP")

		for _, weapon in ipairs(TeamWeapons[CurrentTeam.Get()]) do
			GiveWeaponToPed(PlayerPedId(), GetHashKey(weapon), 100, true, false)
		end
	end
end