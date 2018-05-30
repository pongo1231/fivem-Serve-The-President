using CitizenFX.Core;
using System.Threading.Tasks;

namespace ServeThePresident.Util
{
    class ScaleformDrawer : BaseScript
    {
        public static Scaleform Scaleform { private get; set; }
        public static bool Draw = false;

        public ScaleformDrawer()
        {
            Tick += OnTick;
        }

        private async Task OnTick()
        {
            await Task.FromResult(0);

            if (Scaleform != null && Draw)
                Scaleform.Render2D();
        }
    }
}
