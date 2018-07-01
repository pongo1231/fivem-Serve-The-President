RegisterNetEvent("stp:client:RoundEnd")
AddEventHandler("stp:client:RoundEnd", function(name)
    print("round has ended")
    local name = name
    Citizen.CreateThread(function()
        local start = GetGameTimer()
        FreezeEntityPosition(PlayerPedId(), true)
        while GetGameTimer() - start < 5000 do 
            Wait(0)
            DrawWinnerThisFrame(name)
            print("drawing...")
        end
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end)

RegisterNetEvent("stp:client:TimeIsOut")
AddEventHandler("stp:client:TimeIsOut", function()
    Citizen.CreateThread(function()
        local start = GetGameTimer()
        FreezeEntityPosition(PlayerPedId(), true)
        while GetGameTimer() - start < 5000 do 
            Wait(0)
            DrawEndScreenThisFrame()
        end
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end)

function DrawWinnerThisFrame(name)
    local scaleform = RequestScaleformMovie("mp_big_message_freemode")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~y~The President Died!")
    if name ~= nil then
    PushScaleformMovieMethodParameterString("Killed by:" .. name)
    else
        PushScaleformMovieMethodParameterString("")
    end
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end

function DrawEndScreenThisFrame()
    local scaleform = RequestScaleformMovie("mp_big_message_freemode")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~y Time's Up!")
    PushScaleformMovieMethodParameterString("The President Lives!")
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end