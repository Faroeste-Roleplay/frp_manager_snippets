
RegisterNetEvent("teleport_to_guarma:checkPlayerHaveMoney")
AddEventHandler("teleport_to_guarma:checkPlayerHaveMoney", function()
    local playerId = source

    if playerId then
        local money = exports.ox_inventory:GetItem(playerId, "money", nil, true)
        if money >= 0.4 then
            exports.ox_inventory:RemoveItem(playerId, "money", 0.2)
            TriggerClientEvent('teleport_to_guarma:teleportPlayerToGuarma', playerId)
        else
            cAPI.Notify(playerId, "error", "Você precisa de 0,2 centavos para viajar!", 5000)
        end
    end
end)