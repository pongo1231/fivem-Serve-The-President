using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;
using System.Threading.Tasks;

namespace ServeThePresident.Player.Team
{
    class PlayerNoTeamMgr : BaseScript
    {
        public PlayerNoTeamMgr()
        {
            Tick += OnTick;
            Tick += OnHelpTextTick;
        }

        private async Task OnTick()
        {
            await Delay(100);

            if (!Util.Player.SpawnedIn)
                return;

            Ped playerPed = Game.PlayerPed;
            bool noTeam = PlayerTeam.CurrentTeam == PlayerTeamType.TEAM_NONE;

            playerPed.IsVisible = !noTeam;
            playerPed.IsPositionFrozen = noTeam;
            playerPed.IsInvincible = noTeam;

            if (noTeam && playerPed.IsAlive)
            {
                Screen.Hud.IsVisible = false;
                Screen.Hud.IsRadarVisible = false;

                API.TriggerMusicEvent("BST_START");
            }
        }

        private async Task OnHelpTextTick()
        {
            await Delay(1);

            if (PlayerTeam.CurrentTeam == PlayerTeamType.TEAM_NONE)
                Screen.DisplayHelpTextThisFrame("Press ~INPUT_SELECT_CHARACTER_FRANKLIN~" +
                    " to open Team Menu");
        }
    }
}
