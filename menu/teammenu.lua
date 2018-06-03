local ids = {}

AddEventHandler("menu:setup", function()
	ids = {}

	TriggerEvent("menu:registerModuleMenu", "Team Menu", function(id)
		ids["menu"] = id

		TriggerEvent("menu:addModuleItem", id, "President", nil, function(id) ids[TeamId.President] = id end, function()
			CurrentTeam.Update(TeamId.President)
			TriggerEvent("menu:hideMenu")
		end)
		TriggerEvent("menu:addModuleItem", id, "Vice President", nil, function(id) ids[TeamId.Vice] = id end, function()
			CurrentTeam.Update(TeamId.Vice)
			TriggerEvent("menu:hideMenu")
		end)
		TriggerEvent("menu:addModuleItem", id, "Bodyguard", nil, function(id) ids[TeamId.Bodyguard] = id end, function()
			CurrentTeam.Update(TeamId.Bodyguard)
			TriggerEvent("menu:hideMenu")
		end)
		TriggerEvent("menu:addModuleItem", id, "Terrorist", nil, function(id) ids[TeamId.Terrorist] = id end, function()
			CurrentTeam.Update(TeamId.Terrorist)
			TriggerEvent("menu:hideMenu")
		end)
		TriggerEvent("menu:addModuleItem", id, "Civilian", nil, function(id) ids[TeamId.Civil] = id end, function()
			CurrentTeam.Update(TeamId.Civil)
			TriggerEvent("menu:hideMenu")
		end)
	end)
end)

TeamMenu = {}
function TeamMenu.GreyOut(state)
	for _, id in pairs(ids) do
		TriggerEvent("menu:setGreyedOut", state, id)
	end
end