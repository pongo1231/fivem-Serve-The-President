using CitizenFX.Core;
using ServeThePresident.MPlayer.Team;
using ServeThePresident.Util;
using System.Threading.Tasks;

namespace ServeThePresident
{
    public class PlayerBlipsMgr : BaseScript
    {
        public PlayerBlipsMgr()
        {
            Tick += OnTick;
        }

        private async Task OnTick()
        {
            await Delay(500);

            if (!UPlayer.SpawnedIn)
                return;

            foreach (Player player in Players)
            {
                Ped playerPed = player.Character;
                if (playerPed != null && playerPed.HasDecor(PlayerTeam.DECOR_PLAYER_TEAM))
                {
                    PlayerTeamType playerTeam = playerPed.GetDecor<PlayerTeamType>(PlayerTeam.DECOR_PLAYER_TEAM);
                }
            }
        }
    }
}
