local ids = {}

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		ids["menu"] = id

		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) ids[TeamId.President] = id end, function()
			TeamMenu.OnClick(TeamId.President)
		end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) ids[TeamId.Vice] = id end, function()
			TeamMenu.OnClick(TeamId.Vice)
		end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) ids[TeamId.Bodyguard] = id end, function()
			TeamMenu.OnClick(TeamId.Bodyguard)
		end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) ids[TeamId.Terrorist] = id end, function()
			TeamMenu.OnClick(TeamId.Terrorist)
		end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) ids[TeamId.Civil] = id end, function()
			TeamMenu.OnClick(TeamId.Civil)
		end)
	end)
end)

TeamMenu = {}
function TeamMenu.OnClick(team)
	CurrentTeam.Update(team)
	TriggerEvent("menu:hideMenu")
end

function TeamMenu.GreyOut(state, team)
	if not team then
		for _, id in pairs(ids) do
			TriggerEvent("menu:setGreyedOut", state, id)
		end
	else
		TriggerEvent("menu:setGreyedOut", state, ids[team])
	end
end
RegisterNetEvent("stp:teamMenuGreyOut")
AddEventHandler("stp:teamMenuGreyOut", TeamMenu.GreyOut)