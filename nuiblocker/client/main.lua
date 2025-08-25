local isOk = false

-- RegisterNUICallback("devtools_detected", function()
--     TriggerServerEvent("devtools:abriu")
-- end)


RegisterNUICallback(GetCurrentResourceName(), function()
    TriggerServerEvent("devtools:abriu")
end)

RegisterNUICallback('response', function()
    isOk = true
end)

CreateThread(function()

    Wait(60000)

    SendNUIMessage(json.encode({
        type = "isDone"
    }))

    Wait(60000)

    if not isOk then
        TriggerServerEvent("devtools:abriu")
    end 
end)