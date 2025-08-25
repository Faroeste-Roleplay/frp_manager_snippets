RegisterNetEvent("consumable:cigarette_box:getOne", function()
    local playerId = source
    exports.ox_inventory:AddItem(playerId, "cigarette", 1)
end)