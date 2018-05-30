using CitizenFX.Core;
using CitizenFX.Core.Native;
using System;

namespace ServeThePresident.Env
{
    public class TimeSync : BaseScript
    {
        public TimeSync()
        {
            EventHandlers["playerSpawned"] += new Action<dynamic>(delegate
            {
                int h = 0, m = 0, s = 0;
                API.NetworkGetServerTime(ref h, ref m, ref s);
                API.NetworkOverrideClockTime(h, m, s);
            });
        }
    }
}
