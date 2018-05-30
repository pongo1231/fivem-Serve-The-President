using CitizenFX.Core;
using CitizenFX.Core.Native;
using ServeThePresident.Util;
using System.Threading.Tasks;

namespace ServeThePresident.Env
{
    class VehicleMgr : BaseScript
    {
        public VehicleMgr()
        {
            Tick += OnTick;
        }

        private async Task OnTick()
        {
            await Delay(500);

            if (Util.Player.SpawnedIn)
                foreach (Vehicle vehicle in EntityEnum.GetAllVehicles())
                    API.SetVehicleExplodesOnHighExplosionDamage(vehicle.Handle, false);
        }
    }
}
