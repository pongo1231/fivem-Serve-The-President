namespace ServeThePresident
{
    public enum PlayerTeamType
    {
        TEAM_PRESIDENT,
        TEAM_VICE_PRESIDENT,
        TEAM_BODYGUARD,
        TEAM_TERRORIST,
        TEAM_CIVIL,
        TEAM_NONE
    }

    public class PlayerTeam
    {
        public const string DECOR_PLAYER_TEAM = "_PLAYER_TEAM";
        public static PlayerTeamType CurrentTeam = PlayerTeamType.TEAM_NONE;
    }
}
