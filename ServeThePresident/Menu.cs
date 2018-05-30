using CitizenFX.Core;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ServeThePresident
{
    class TeamMenu : BaseScript
    {
        private List<string> menuSpawnTeamIDs;

        public TeamMenu()
        {
            menuSpawnTeamIDs = new List<string>();

            EventHandlers["menu:setup"] += new Action(InitMenu);
            EventHandlers["ServeThePresident:ReceiveTeamsInfos"] += new Action<bool, bool, bool, bool, bool>(ReceiveTeamsInfos);

        }

        private void InitMenu()
        {
            Action<string> addIDAction = new Action<string>(id => { menuSpawnTeamIDs.Add(id); });

            TriggerEvent("menu:registerModuleMenu", "Team Menu", new Action<string>(id =>
            {
                addIDAction.Invoke(id);

                // TODO: Items actually do shit
                TriggerEvent("menu:addModuleItem", id, "President", null, addIDAction, null);
                TriggerEvent("menu:addModuleItem", id, "Vice President", null, addIDAction, null);
                TriggerEvent("menu:addModuleItem", id, "Bodyguard", null, addIDAction, null);
                TriggerEvent("menu:addModuleItem", id, "Terrorist", null, addIDAction, null);
                TriggerEvent("menu:addModuleItem", id, "Civilian", null, addIDAction, null);
            }), null);
        }
        private async Task UpdateTeams()
        {
            TriggerServerEvent("ServeThePresident:RequestTeamsInfos");
            await Delay(100);
        }
        private void ReceiveTeamsInfos(bool PresidentState, bool VicePresidentState, bool BodyGuardState, bool CivilianState, bool TerroristState)
        {
           //grey out locked teams 
        }
    }
}
