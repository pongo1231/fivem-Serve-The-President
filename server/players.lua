local players = {}
local teamAmount = {}

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

TeamAmount = {}
function TeamAmount.Get(team)
	return teamAmount[team]
end

function TeamAmount.Add(team)
	if not TeamAmount.Get(team) then
		teamAmount[team] = 1
	else
		teamAmount[team] = teamAmount[team] + 1
	end
end

function TeamAmount.Remove(team)
	if not TeamAmount.Get(team) then
		teamAmount[team] = 0
	elseif #TeamAmount.Get(team) > 0 then
		teamAmount[team] = teamAmount[team] - 1
	end
end

AddEventHandler("playerConnecting", function()
	Players.SetTeam(source, PlayerId.None)
	TeamAmount.Add(PlayerId.None)
end)

RegisterServerEvent("stp:server:teamEntered")
AddEventHandler("stp:server:teamEntered", function(team)
	Players.SetTeam(source, team)
	TeamAmount.Add(team)
end)

AddEventHandler("playerDropped", function()
	if Players.GetPlayerTeam(source) then
		TeamAmount.Remove(Players.GetPlayerTeam(source))
	end

	table.remove(players, source)
end)