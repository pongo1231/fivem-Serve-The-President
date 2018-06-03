local ids = {}

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		ids["teammenu"] = id

		--TriggerEvent("menu:addModuleItem", id, "TEST: None", nil, function(id) ids["TEST: None"] = id end, function() CurrentTeam.Update(TeamId.None) end)
		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) ids["president"] = id end, function() CurrentTeam.Update(TeamId.President) end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) ids["vice"] = id end, function() CurrentTeam.Update(TeamId.Vice) end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) ids["bodyguard"] = id end, function() CurrentTeam.Update(TeamId.Bodyguard) end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) ids["terrorist"] = id end, function() CurrentTeam.Update(TeamId.Terrorist) end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) ids["civil"] = id end, function() CurrentTeam.Update(TeamId.Civil) end)
	end, false)
end)

TeamMenu = {}
function TeamMenu.GreyOut(state)
	for _, id in pairs(ids) do
		TriggerEvent("menu:setGreyedOut", state, id)
	end
end