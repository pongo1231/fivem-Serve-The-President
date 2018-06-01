RegisterNetEvent("ServeThePresident:CheckTimer")
AddEventHandler("ServeThePresident:CheckTimer", function(checkcounter)
  if counter ~= checkcounter then
    TriggerClientEvent("ServeThePresident:CorrectTimer", source, counter)
  end  
end)