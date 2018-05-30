using CitizenFX.Core;
using CitizenFX.Core.Native;
using ServeThePresident.Util;
using System.Threading.Tasks;

namespace ServeThePresident.Env
{
    class AIVehicleMgr : BaseScript
    {
        public AIVehicleMgr()
        {
            Tick += OnTick;
        }

        private async Task OnTick()
        {
            await Delay(500);

            if (UPlayer.SpawnedIn)
                foreach (Vehicle vehicle in EntityEnum.GetAllVehicles())
                {
                    Ped driver = vehicle.Driver;
                    if (driver != null && !driver.IsPlayer)
                    {
                        // TODO: Actually do something lol
                    }
                }
        }
    }
}
