local currentTeam

TeamId = {
	["None"] = 0,
	["President"] = 1,
	["Vice"] = 2,
	["Bodyguard"] = 3,
	["Terrorist"] = 4,
	["Civil"] = 5
}

DecorRegister("_PLAYER_TEAM", 3)

CurrentTeam = {}
function CurrentTeam.Update(team, instant)
	currentTeam = team
	Spawner.Respawn(instant)
end

function CurrentTeam.Get()
	return currentTeam
end