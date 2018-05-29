using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;
using ServeThePresident.Util;
using System.Threading.Tasks;

namespace ServeThePresident.Player.Team
{
    class PlayerNoTeamMgr : BaseScript
    {
        public PlayerNoTeamMgr()
        {
            Tick += OnTick;
        }

        public async Task OnTick()
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
    }
}
