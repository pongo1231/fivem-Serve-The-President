using CitizenFX.Core;

namespace ServeThePresident.Player.Team
{
    public static class TeamSpawns
    {
        public static Vector3 SPAWN_NONE { get; } = new Vector3(-1236f, -445f, 1000f);
        public static Vector3 SPAWN_PRESIDENT { get; } = new Vector3(2550f, -415f, 93f);
        public static Vector3 SPAWN_VICE { get; } = new Vector3(2560f, -425f, 93f);
        public static Vector3 SPAWN_BODYGUARDS { get; } = new Vector3(2540f, -405f, 93f);
        public static Vector3 SPAWN_TERRORIST { get; } = new Vector3(-1833f, -1223f, 13f);
        public static Vector3 SPAWN_CIVIL { get; } = new Vector3(-2308f, 263f, 169f);
    }
}
