using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;
using System;

namespace ServeThePresident.Player.Team
{
    public enum PlayerTeamType
    {
        TEAM_PRESIDENT,
        TEAM_VICE,
        TEAM_BODYGUARD,
        TEAM_TERRORIST,
        TEAM_CIVIL,
        TEAM_NONE
    }

    public static class PlayerTeam
    {
        public const string DECOR_PLAYER_TEAM = "_PLAYER_TEAM";
        public static PlayerTeamType CurrentTeam { get; private set; }

        public async static void UpdateTeam(PlayerTeamType newTeamType, bool instant = false)
        {
            CurrentTeam = newTeamType;
            await PlayerSpawner.Respawn(instant);

            BaseScript.TriggerEvent("stp:reinitteam", (int) newTeamType);
        }

        public static void ReinitTeam()
        {
            BaseScript.TriggerEvent("stp:reinitteam", -1);
        }

        private class PlayerTeamMgr : BaseScript
        {
            public PlayerTeamMgr()
            {
                EventHandlers["stp:reinitteam"] += new Action<int>(OnTeamUpdate);
            }

            private void OnTeamUpdate(int newTeamType)
            {
                Ped playerPed = Game.PlayerPed;
                PlayerTeamType teamType;
                if (newTeamType == -1)
                    teamType = CurrentTeam;
                else
                    teamType = (PlayerTeamType)newTeamType;

                switch (teamType)
                {
                    case PlayerTeamType.TEAM_NONE:
                        SetPlayerNoTeamAttr();
                        break;
                    default:
                        SetPlayerRealTeamAttr();
                        break;
                }
            }

            private void SetPlayerNoTeamAttr()
            {
                Ped playerPed = Game.PlayerPed;
                playerPed.IsVisible = false;
                playerPed.IsPositionFrozen = true;
                playerPed.IsInvincible = true;

                Screen.Hud.IsVisible = false;
                Screen.Hud.IsRadarVisible = false;

                API.TriggerMusicEvent("BST_START");
            }

            private async void SetPlayerRealTeamAttr()
            {
                PedHash[] teamSkins = TeamSkins.GetTeamSkins(CurrentTeam);
                await Game.Player.ChangeModel(teamSkins[API.GetRandomIntInRange(0, teamSkins.Length - 1)]);

                Ped playerPed = Game.PlayerPed;
                playerPed.IsVisible = true;
                playerPed.IsPositionFrozen = false;
                playerPed.IsInvincible = false;

                Screen.Hud.IsVisible = true;
                Screen.Hud.IsRadarVisible = true;

                API.TriggerMusicEvent("BST_STOP");
            }

            /*private async Task OnHelpTextTick()
            {
                await Delay(1);

                if (PlayerTeam.CurrentTeam == PlayerTeamType.TEAM_NONE)
                    Screen.DisplayHelpTextThisFrame("Press ~INPUT_SELECT_CHARACTER_FRANKLIN~" +
                        " to open Team Menu");
            }*/
        }
    }
}
