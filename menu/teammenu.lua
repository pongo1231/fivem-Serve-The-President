local ids = {}

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		ids["Team Menu"] = id

		TriggerEvent("menu:addModuleItem", id, "TEST: None", nil, function(id) ids["TEST: None"] = id end, function() CurrentTeam.Update(TeamId.None) end)
		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) ids["President"] = id end, function() CurrentTeam.Update(TeamId.President) end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) ids["Vice President"] = id end, function() CurrentTeam.Update(TeamId.Vice) end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) ids["Bodyguard"] = id end, function() CurrentTeam.Update(TeamId.Bodyguard) end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) ids["Terrorist"] = id end, function() CurrentTeam.Update(TeamId.Terrorist) end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) ids["Civilian"] = id end, function() CurrentTeam.Update(TeamId.Civil) end)
	end, false)
end)

TeamMenu = {}
function TeamMenu.GreyOut(state)
	for _, id in pairs(ids) do
		TriggerEvent("menu:setGreyedOut", state, id)
	end
end