using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;
using ServeThePresident.Util;
using System;
using System.Threading.Tasks;

namespace ServeThePresident.Player.Team
{
    public static class PlayerSpawner
    {
        public async static Task Respawn(bool instant = false)
        {
            TeamMenu.SetSpawnMenuItemsGreyedOut(true);

            if (!instant) {
                bool wasHudVisible = Screen.Hud.IsVisible, wasRadarVisible = Screen.Hud.IsVisible;
                Screen.Hud.IsVisible = false;
                Screen.Hud.IsRadarVisible = false;

                Ped playerPed = Game.PlayerPed;
                Vector3 playerPos = playerPed.Position;
                // TODO: Randomized spawn
                Vector3 targetPos = TeamSpawns.GetTeamSpawns(PlayerTeam.CurrentTeam)[0];

                Ped decoyPed = await CreateDecoyPed(targetPos);
                API.StartPlayerSwitch(playerPed.Handle, decoyPed.Handle, 8,
                    API.GetIdealPlayerSwitchType(playerPos.X, playerPos.Y, playerPos.Z,
                    targetPos.X, targetPos.Y, targetPos.Z));
                decoyPed.Delete();

                while (API.GetPlayerSwitchState() != 8 && API.GetPlayerSwitchState() != 10)
                    await BaseScript.Delay(1);
            }

            BaseScript.TriggerEvent("stp:respawn");

            if (!instant)
            {
                API.StopPlayerSwitch();
                API.RenderScriptCams(false, false, 3000, true, false);
                API.PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", false);
            }

            TeamMenu.SetSpawnMenuItemsGreyedOut(false);
        }

        private async static Task<Ped> CreateDecoyPed(Vector3 pos)
        {
            Model model = new Model(PedHash.Abigail);
            while (!model.IsLoaded)
            {
                await BaseScript.Delay(1);
                model.Request();
            }

            return new Ped(API.CreatePed(4, (uint) model.Hash, pos.X, pos.Y, pos.Z, 0f,
                false, false));
        }

        private class PlayerSpawnMgr : BaseScript
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

                EventHandlers["stp:respawn"] += new Action(HandleSpawning);

                Tick += OnTick;
            }

            private void Init()
            {
                deathScaleform = new Scaleform("MP_BIG_MESSAGE_FREEMODE");
                Exports["spawnmanager"].setAutoSpawn(false);
                PlayerTeam.UpdateTeam(PlayerTeamType.TEAM_NONE, true);

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

                    TeamMenu.SetSpawnMenuItemsGreyedOut(true);

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

                    API.TriggerMusicEvent("KILL_LIST_STOP_MUSIC");
                    Screen.Fading.FadeOut(500);
                    await Delay(RESPAWN_LOADING_TIME);
                    HandleSpawning();
                    Screen.Effects.Stop();
                    Screen.Fading.FadeIn(500);

                    Screen.Hud.IsRadarVisible = true;
                    TeamMenu.SetSpawnMenuItemsGreyedOut(false);
                }
            }

            private void HandleSpawning()
            {
                Ped playerPed = Game.PlayerPed;
                // TODO: Randomized spawns
                Vector3 spawnPos = TeamSpawns.GetTeamSpawns(PlayerTeam.CurrentTeam)[0];

                if (playerPed.IsDead)
                    API.NetworkResurrectLocalPlayer(spawnPos.X, spawnPos.Y, spawnPos.Z,
                        API.GetRandomFloatInRange(0f, 360f), true, false);
                else
                    playerPed.Position = spawnPos;

                PlayerTeam.ReinitTeam();
                playerPed.SetDecor(PlayerTeam.DECOR_PLAYER_TEAM, (int) PlayerTeam.CurrentTeam);
            }
        }
    }
}
