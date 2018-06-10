TeamModels = {
	[TeamId.None] = {
		-257153498
	},
	[TeamId.President] = {
		2120901815
	},
	[TeamId.Vice] = {
		-912318012
	},
	[TeamId.Bodyguard] = {
		-306416314,
		653289389,
		-681004504
	},
	[TeamId.Terrorist] = {
		1984382277,
		-48477765,
		228715206,
		-1109568186
	},
	[TeamId.Civil] = {
		587703123,
		-640198516,
		-1044093321,
		-1342520604,
		1641152947,
		321657486,
		-2109222095
	}
}

function TeamModels.Random(team)
	return TeamModels[team][math.random(1, #TeamModels[team])]
end