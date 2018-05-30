using CitizenFX.Core;
using System.Linq;

namespace ServeThePresident.Player.Team
{
    public static class TeamSpawns
    {
        private struct TeamSpawn
        {
            public PlayerTeamType TeamType { get; private set; }
            public Vector3 SpawnPos { get; private set; }

            public TeamSpawn(PlayerTeamType teamType, Vector3 pos)
            {
                TeamType = teamType;
                SpawnPos = pos;
            }
        }

        private static TeamSpawn[] PlayerTeamSpawns { get; } = {
            new TeamSpawn(PlayerTeamType.TEAM_NONE, new Vector3(-1236f, -445f, 1000f)),
            new TeamSpawn(PlayerTeamType.TEAM_PRESIDENT, new Vector3(2550f, -415f, 93f)),
            new TeamSpawn(PlayerTeamType.TEAM_VICE, new Vector3(2560f, -425f, 93f)),
            new TeamSpawn(PlayerTeamType.TEAM_BODYGUARD, new Vector3(2540f, -405f, 93f)),
            new TeamSpawn(PlayerTeamType.TEAM_TERRORIST, new Vector3(-1833f, -1223f, 13f)),
            new TeamSpawn(PlayerTeamType.TEAM_CIVIL, new Vector3(-2308f, 263f, 169f)),
        };

        public static Vector3[] GetTeamSpawns(PlayerTeamType teamType)
        {
            return PlayerTeamSpawns
                .Where(teamSpawn => teamSpawn.TeamType == teamType)
                .Select(teamSpawn => teamSpawn.SpawnPos)
                .ToArray();
        }
    }

    public static class TeamSkins
    {
        private struct TeamSkin
        {
            public PlayerTeamType TeamType { get; private set; }
            public PedHash PlayerSkin { get; private set; }

            public TeamSkin(PlayerTeamType teamType, PedHash playerSkin)
            {
                TeamType = teamType;
                PlayerSkin = playerSkin;
            }
        }

        private static TeamSkin[] PlayerTeamSkins { get; } =
        {
            new TeamSkin(PlayerTeamType.TEAM_PRESIDENT, PedHash.Business03AMY),
            new TeamSkin(PlayerTeamType.TEAM_VICE, PedHash.Business02AMY),
            new TeamSkin(PlayerTeamType.TEAM_BODYGUARD, PedHash.FibOffice01SMM),
            new TeamSkin(PlayerTeamType.TEAM_BODYGUARD, PedHash.FibOffice02SMM),
            new TeamSkin(PlayerTeamType.TEAM_BODYGUARD, PedHash.FibSec01),
            new TeamSkin(PlayerTeamType.TEAM_BODYGUARD, PedHash.FibOffice01SMM),
            new TeamSkin(PlayerTeamType.TEAM_TERRORIST, PedHash.BikeHire01),
            new TeamSkin(PlayerTeamType.TEAM_TERRORIST, PedHash.StrPunk01GMY),
            new TeamSkin(PlayerTeamType.TEAM_TERRORIST, PedHash.StrPunk02GMY),
            new TeamSkin(PlayerTeamType.TEAM_TERRORIST, PedHash.MexGang01GMY),
            new TeamSkin(PlayerTeamType.TEAM_CIVIL, PedHash.Hipster01AMY),
            new TeamSkin(PlayerTeamType.TEAM_CIVIL, PedHash.Skater01AMM),
            new TeamSkin(PlayerTeamType.TEAM_CIVIL, PedHash.Fatlatin01AMM),
            new TeamSkin(PlayerTeamType.TEAM_CIVIL, PedHash.Latino01AMY),
            new TeamSkin(PlayerTeamType.TEAM_CIVIL, PedHash.Hipster03AFY)
        };

        public static PedHash[] GetTeamSkins(PlayerTeamType teamType)
        {
            return PlayerTeamSkins
                .Where(teamSpawn => teamSpawn.TeamType == teamType)
                .Select(teamSpawn => teamSpawn.PlayerSkin)
                .ToArray();
        }
    }
}
