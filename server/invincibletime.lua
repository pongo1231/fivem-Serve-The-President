local invincibleClients = {}

RegisterServerEvent("stp:server:requestInvincibleTime")
AddEventHandler("stp:server:requestInvincibleTime", function()
	invincibleClients[source] = {}
	invincibleClients[source].time = 30
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		for client, invincibleClient in pairs(invincibleClients) do
			if invincibleClient.time and invincibleClient.time > -1 then
				invincibleClient.time = invincibleClient.time - 1
				TriggerClientEvent("stp:setInvincibleTime", client, invincibleClient.time)
			end
		end
	end
end)