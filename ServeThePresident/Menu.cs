using CitizenFX.Core;
using CitizenFX.Core.Native;
using ServeThePresident.Player.Team;
using System;
using System.Collections.Generic;

namespace ServeThePresident
{
    public class TeamMenu : BaseScript
    {
        private static List<string> menuSpawnTeamIDs;

        public TeamMenu()
        {
            EventHandlers["menu:setup"] += new Action(InitMenu);
        }

        private void InitMenu()
        {
            menuSpawnTeamIDs = new List<string>();
            Action<string> addIDAction = new Action<string>(id => { menuSpawnTeamIDs.Add(id); });

            TriggerEvent("menu:registerModuleMenu", "Team Menu", new Action<string>(id =>
            {
                addIDAction.Invoke(id);

                TriggerEvent("menu:addModuleItem", id, "TEST: NONE", null, addIDAction, new Action(delegate
                {
                    PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_NONE);
                }));
                TriggerEvent("menu:addModuleItem", id, "President", null, addIDAction, new Action(delegate
                {
                    PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_PRESIDENT);
                }));
                TriggerEvent("menu:addModuleItem", id, "Vice President", null, addIDAction, new Action(delegate
                {
                    PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_VICE);
                }));
                TriggerEvent("menu:addModuleItem", id, "Bodyguard", null, addIDAction, new Action(delegate
                {
                    PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_BODYGUARD);
                }));
                TriggerEvent("menu:addModuleItem", id, "Terrorist", null, addIDAction, new Action(delegate
                {
                    PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_TERRORIST);
                }));
                TriggerEvent("menu:addModuleItem", id, "Civilian", null, addIDAction, new Action(delegate
                {
                    PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_CIVIL);
                }));
            }), null);
        }

        public static void SetSpawnMenuItemsGreyedOut(bool state)
        {
            if (menuSpawnTeamIDs != null)
                foreach (string id in menuSpawnTeamIDs)
                {
                    TriggerEvent("menu:setGreyedOut", state, id);
                }
        }
    }
}
