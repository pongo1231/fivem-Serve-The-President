local radioScreenEffectShown

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if FancyEffects.IsTargetHudComponentActive() and not radioScreenEffectShown then
			StartScreenEffect("SwitchOpenMichaelIn", 100, true)
			radioScreenEffectShown = true
		elseif not FancyEffects.IsTargetHudComponentActive() and radioScreenEffectShown then
			StopScreenEffect("SwitchOpenMichaelIn")
			StartScreenEffect("SwitchOpenMichaelOut", 100)
			radioScreenEffectShown = false
		end
	end
end)

FancyEffects = {}
function FancyEffects.IsTargetHudComponentActive()
	return IsHudComponentActive(16) or IsHudComponentActive(19) or IsPauseMenuActive()
end