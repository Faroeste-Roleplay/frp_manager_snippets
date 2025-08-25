local itemsNeededToGetReward = 
{
    ['canteen_empty'] = 'canteen_full',
    
    ['empty_watering_can'] = 'watering_can'
}


RegisterNetEvent("canteen:use", function()
    local playerId = source    

    local itemSlot = exports.ox_inventory:GetSlotWithItem(playerId, "canteen_full")
    if itemSlot then 
        -- TriggerEvent('inventory:server:RemoveDurability', itemSlot, 40, playerId)
    end
end)

RegisterServerEvent('river_actions:FillContainersInTheRiver')
AddEventHandler('river_actions:FillContainersInTheRiver', function(itemName)
    local playerId = source

    local Item = exports.ox_inventory:GetItem(playerId, itemName, nil, true)

    if itemName == "empty_watering_can" then
        local itemReward = itemsNeededToGetReward[itemName]

        if Item >= 1 and itemReward then
            exports.ox_inventory:RemoveItem(playerId, itemName, 1)
            exports.ox_inventory:AddItem(playerId, itemReward, 1)
        else
            cAPI.Notify(playerId, "error", "Você não possuí 1 " .. Item.label, 3000)
        end

        return
    end

    if itemName == "canteen_full" then
        local itemSlot = exports.ox_inventory:GetSlotWithItem(playerId, "canteen_full")

        if itemSlot then
            exports.ox_inventory:SetDurability(playerId, itemSlot.slot, 100)
        end

        return
    end
end)
