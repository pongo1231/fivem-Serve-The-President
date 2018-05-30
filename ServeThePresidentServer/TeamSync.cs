using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;

namespace ServeThePresidentServer
{
    class TeamSync : BaseScript
    {
        public List<int> Civilians = new List<int>();
        public List<int> BodyGuards = new List<int>();
        public int President = 666;
        public List<int> Terrorists = new List<int>();
        public int VicePresident = 666;
        public TeamSync()
        {
            EventHandlers.Add("ServeThePresident:TryingToJoin",new Action<Player,string>(HandleJoin));
        }
        public void HandleJoin([FromSource]Player Player, string ChosenTeam)
        {
            switch (ChosenTeam)
            {
                case "President":
                    if (President != 666)
                    {
                        Player.TriggerEvent("ServeThePresident:TeamFull");
                    } else
                    {
                        Player.TriggerEvent("ServeThePresident:TeamSelected");
                    }
                    break;
                case "VicePresident":
                    if (President != 666 && VicePresident != 666 )
                    {
                        Player.TriggerEvent("ServeThePresident:TeamFull");
                    } else if (President != 666 && VicePresident == 666)
                    {
                        Player.TriggerEvent("ServeThePresident:TeamSelected");
                    } else if (President == 666 && VicePresident == 666)
                    {
                        Player.TriggerEvent("ServeThePresident:TeamSelected");
                    } else
                    {
                        Player.TriggerEvent("ServeThePresident:TeamFull");
                    }
                    break;
                default:
                    break;
            }
        }
    }
}
