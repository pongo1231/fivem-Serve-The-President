resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	"env/timesync.lua",
	"menu/teammenu.lua",

	"team/teams.lua",
	"team/teamspawns.lua",
	"team/teammodels.lua",
	"team/teamrelationships.lua",
	"team/teamweapons.lua",
	"team/teamblipcolors.lua",

	"player/spawner.lua",
	"player/death.lua",
	"player/teamshandler.lua"
}

server_script "server/teambalance.lua"