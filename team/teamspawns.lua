TeamSpawns = {
	[TeamId.None] = {
		 {x = -1236.0, y = -445.0, z = 2000.0}
	},
	[TeamId.President] = {
		{x = 2550.0, y = -415.0, z = 93.0}
	},
	[TeamId.Vice] = {
		{x = 2560.0, y = -425.0, z = 93.0}
	},
	[TeamId.Bodyguard] = {
		{x = 2540.0, y = -405.0, z = 93.0}
	},
	[TeamId.Terrorist] = {
		{x = -1833.0, y = -1223.0, z = 13.0}
	},
	[TeamId.Civil] = {
		{x = -2308.0, y = 263.0, z = 169.0}
	}
}

function TeamSpawns.Random(team)
	return TeamSpawns[team][GetRandomIntInRange(1, #TeamSpawns[team])]
end