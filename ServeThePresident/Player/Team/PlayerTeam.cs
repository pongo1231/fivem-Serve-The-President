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
        public static PlayerTeamType CurrentTeam { get; private set; } = PlayerTeamType.TEAM_NONE;

        public static void UpdateTeam(PlayerTeamType newTeamType)
        {
            CurrentTeam = newTeamType;
            // TODO: Respawn and shit
        }
    }
}
