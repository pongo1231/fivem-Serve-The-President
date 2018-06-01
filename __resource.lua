resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	"env/timesync.lua",
	"menu/teammenu.lua",
	"util/entityiterator.lua",

	"team/teamids.lua",
	"team/teamspawns.lua",
	"team/teammodels.lua",
	"team/teamrelationships.lua",
	"team/teamweapons.lua",
	"team/teamblipcolors.lua",

	"gamemode/countdown.lua",
	"gamemode/teamshandler.lua",

	"player/spawner.lua",
	"player/death.lua",

	"spawns/vehiclespawns.lua",
	"spawns/weaponspawns.lua"
}

server_script "server/teambalance.lua"