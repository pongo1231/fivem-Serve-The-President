using CitizenFX.Core.Native;

namespace ServeThePresident.Util
{
    public static class UPlayer
    {
        public static bool SpawnedIn
        {
            get
            {
                return API.NetworkIsSessionStarted() && !API.GetIsLoadingScreenActive();
            }
        }
    }
}
