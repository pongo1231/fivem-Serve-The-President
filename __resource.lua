resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	"env/timesync.lua",
	"env/env.lua",
	"env/weathersync.lua",

	"menu/teammenu.lua",
	"menu/pausemenutitle.lua",
	"util/entityiterator.lua",

	"team/teamids.lua",
	"team/teamspawns.lua",
	"team/teammodels.lua",
	"team/teamrelationships.lua",
	"team/teamweapons.lua",
	"team/teamblipcolors.lua",
	"team/teamhelptexts.lua",

	"gamemode/countdown.lua",
	"gamemode/teamhelpdisplay.lua",
	"gamemode/teamhandler.lua",
	"gamemode/invincibletime.lua",

	"player/spawner.lua",
	"player/death.lua",
	"player/fancyeffects.lua",

	"spawns/vehiclespawns.lua",
	"spawns/pickupspawns.lua"
}

server_scripts {
	"server/players.lua",
	"server/teams.lua",
	"server/countdown.lua",
	"server/round.lua",
	"server/invincibletime.lua",
	"server/weathersync.lua"
}