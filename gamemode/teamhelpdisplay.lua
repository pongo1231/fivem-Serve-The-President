local displayEntry
local time
local displayTeam

for _, teamHelpText in pairs(TeamHelpTexts) do
	if teamHelpText.entry and teamHelpText.text then
		AddTextEntry(teamHelpText.entry, teamHelpText.text)
	end
end

TeamHelpDisplay = {}
function TeamHelpDisplay.Display()
	displayTeam = CurrentTeam.Get()
	displayEntry = TeamHelpTexts[displayTeam].entry
	if displayTeam == TeamId.None then
		time = -1
	else
		time = 30
	end
end

function TeamHelpDisplay.AlreadyDisplayedForTeam()
	return displayTeam == CurrentTeam.Get()
end

function TeamHelpDisplay.Stop()
	time = 0
end

Citizen.CreateThread(function()
	while true do
		Wait(1)

		if time and time ~= 0 and displayEntry then
			DisplayHelpTextThisFrame(displayEntry, 0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		if time and time > 0 then
			time = time - 1
		end
	end
end)