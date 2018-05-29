using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;
using ServeThePresident.Util;
using System;
using System.Threading.Tasks;

namespace ServeThePresident.Player.Team
{
    class PlayerSpawnMgr : BaseScript
    {
        private const int RESPAWN_DEAD_TIME = 10000;
        private const int RESPAWN_LOADING_TIME = 4000;

        private Scaleform deathScaleform;
        private bool alreadySpawned = false;

        public PlayerSpawnMgr()
        {
            if (Util.Player.SpawnedIn)
                Init();

            EventHandlers["playerSpawned"] += new Action(delegate
            {
                if (!alreadySpawned)
                {
                    Init();
                }
            });

            Tick += OnTick;
        }

        private void Init()
        {
            deathScaleform = new Scaleform("MP_BIG_MESSAGE_FREEMODE");
            Exports["spawnmanager"].setAutoSpawn(false);
            HandleSpawning();

            alreadySpawned = true;
        }

        private async Task OnTick()
        {
            await Delay(100);

            if (!Util.Player.SpawnedIn)
                return;

            if (Game.PlayerPed.IsDead)
            {
                if (!alreadySpawned)
                    return;

                deathScaleform.CallFunction("SHOW_SHARD_WASTED_MP_MESSAGE", "~r~wasted");
                ScaleformDrawer.Scaleform = deathScaleform;
                ScaleformDrawer.Draw = true;
                Screen.Effects.Start(ScreenEffect.DeathFailMpIn);

                API.PlaySoundFrontend(-1, "Bed", "WastedSounds", true);
                API.TriggerMusicEvent("KILL_LIST_START_MUSIC");
                Screen.Hud.IsRadarVisible = false;

                await Delay(RESPAWN_DEAD_TIME / 2);
                Screen.Effects.Start(ScreenEffect.DeathFailMpIn);
                deathScaleform.CallFunction("SHOW_SHARD_WASTED_MP_MESSAGE", "~r~wasted", "Respawning...");

                await Delay(RESPAWN_DEAD_TIME / 2);
                ScaleformDrawer.Draw = false;
                Screen.Effects.Stop();

                API.TriggerMusicEvent("KILL_LIST_STOP_MUSIC");
                Screen.Fading.FadeOut(500);
                await Delay(RESPAWN_LOADING_TIME);
                HandleSpawning();
                Screen.Fading.FadeIn(500);
                Screen.Effects.Start(ScreenEffect.DeathFailOut, 1000);

                Screen.Hud.IsRadarVisible = true;
            }
        }

        private void HandleSpawning()
        {
            Ped playerPed = Game.PlayerPed;
            Vector3 spawnPos;

            switch (PlayerTeam.CurrentTeam)
            {
                case PlayerTeamType.TEAM_NONE:
                    spawnPos = TeamSpawns.SPAWN_NONE;
                    break;
                case PlayerTeamType.TEAM_PRESIDENT:
                    spawnPos = TeamSpawns.SPAWN_PRESIDENT;
                    break;
                case PlayerTeamType.TEAM_VICE:
                    spawnPos = TeamSpawns.SPAWN_VICE;
                    break;
                case PlayerTeamType.TEAM_BODYGUARD:
                    spawnPos = TeamSpawns.SPAWN_BODYGUARDS;
                    break;
                case PlayerTeamType.TEAM_TERRORIST:
                    spawnPos = TeamSpawns.SPAWN_TERRORIST;
                    break;
                case PlayerTeamType.TEAM_CIVIL:
                    spawnPos = TeamSpawns.SPAWN_CIVIL;
                    break;
                default:
                    // Wtf?
                    spawnPos = new Vector3();
                    break;
            }

            API.NetworkResurrectLocalPlayer(spawnPos.X, spawnPos.Y, spawnPos.Z,
                API.GetRandomFloatInRange(0f, 360f), true, false);

            playerPed.SetDecor(PlayerTeam.DECOR_PLAYER_TEAM, (int) PlayerTeam.CurrentTeam);
        }
    }
}
