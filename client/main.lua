local SpeedLimitEnabled = false

RegisterNetEvent("speedlimit:client:ToggleSpeedLimit", function(bool)
    print(bool)
    SpeedLimitEnabled = bool
end)

CreateThread(function()
    while true do
        Wait(1000)
        if IsPauseMenuActive() then
            pauseMenu = true
        elseif not IsPauseMenuActive() then
            pauseMenu =  false
        end
        if IsPedInAnyVehicle(PlayerPedId()) and not pauseMenu then
            if SpeedLimitEnabled then
                local speed = GetSpeedLimit()
                SendNUIMessage({action = "show"})
                if speed then
                    SendNUIMessage({action = "setlimit", speed = speed})
                end
            elseif not SpeedLimitEnabled then
                SendNUIMessage({action = "hide"})
            end
        else
            if SpeedLimitEnabled then
                SendNUIMessage({action = "hide"})
            end
        end
    end
end)

function GetSpeedLimit()
    local coords = GetEntityCoords(PlayerPedId())
    return Config.SpeedLimits[GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))]
end