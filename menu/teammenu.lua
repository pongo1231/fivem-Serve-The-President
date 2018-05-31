local ids = {}

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		table.insert(ids, id)

		TriggerEvent("menu:addModuleItem", id, "TEST: None", nil, function(id) table.insert(ids, id) end, function() CurrentTeam.Update(TeamId.None) end)
		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) table.insert(ids, id) end, function() CurrentTeam.Update(TeamId.President) end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) table.insert(ids, id) end, function() CurrentTeam.Update(TeamId.Vice) end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) table.insert(ids, id) end, function() CurrentTeam.Update(TeamId.Bodyguard) end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) table.insert(ids, id) end, function() CurrentTeam.Update(TeamId.Terrorist) end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) table.insert(ids, id) end, function() CurrentTeam.Update(TeamId.Civil) end)
	end, false)
end)

TeamMenu = {}
function TeamMenu.GreyOut(state)
	for _, id in ipairs(ids) do
		TriggerEvent("menu:setGreyedOut", state, id)
	end
end