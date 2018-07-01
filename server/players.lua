local players = {}

Players = {}
function Players.SetTeam(source, team)
	players[source] = team
end

function Players.GetAll()
	return players
end

function Players.GetPlayerTeam(source)
	return players[source]
end

AddEventHandler("playerConnecting", function()
	Players.SetTeam(source, TeamId.None)
end)

RegisterServerEvent("stp:server:teamEntered")
AddEventHandler("stp:server:teamEntered", function(team)
	Players.SetTeam(source, team)
end)

AddEventHandler("playerDropped", function()
	players[source] = nil
end)