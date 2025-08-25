AddEventHandler('gameEventLootComplete', function(looterEntityId, lootedEntityId, isLootSuccess)
    if looterEntityId ~= PlayerPedId() then
        return
    end

    if isLootSuccess == 1 then
        local isLootedEntityHuman = IsPedHuman(lootedEntityId)

        local lootedEntityModelHash = GetEntityModel(lootedEntityId)

        local lootedAnimalCarcassQuality = GetAnimalCarcassQuality(lootedEntityId)

        TriggerServerEvent("GATHERING:Gathered", lootedEntityModelHash, isLootedEntityHuman, lootedAnimalCarcassQuality)
    end
end)

function GetAnimalCarcassQuality(entity)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, entity)

    return ret ~= false and ret or 0
end
