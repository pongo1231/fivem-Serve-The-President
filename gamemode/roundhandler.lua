RegisterNetEvent("stp:client:RoundEnd")
AddEventHandler("stp:client:RoundEnd", function(name)
    Citizen.CreateThread(function()
        local start = GetGameTimer()

        while GetGameTimer() - start < 10000 do 
            Wait(0)
            DrawWinnerThisFrame(name)
        end
    end)
end)

function DrawWinnerThisFrame(name)
    local scaleform = RequestScaleformMovie("mp_big_message_freemode")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString("~y The President Died!")
    if name then
    PushScaleformMovieMethodParameterString("Killed by:" .. name)
    else
        PushScaleformMovieMethodParameterString("")
    end
    PushScaleformMovieMethodParameterInt(5)
    EndScaleformMovieMethod()
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end