function GetPlayerHairShopitem()
    return exports.frp_manager_snippets:js_get_ped_component_at_index({ `HAIR` })
end

function GetPlayerBeardShopitem()
return exports.frp_manager_snippets:js_get_ped_component_at_index({ `BEARD` })
end

function IsPlayerWearingPomade( isBeard )
    --[[ Find the hair component, check wearablestate]]
    local shopitemHash = GetPlayerHairShopitem()

    local size = N_0xffcc2db2d9953401(shopitemHash, 0, 1)

    local wearablestate = N_0x6243635af2f1b826(shopitemHash, 0, 0, 1)

    -- print('size', size)

    -- print('wearablestate', wearablestate, `BASE`, `POMADE`)

    -- print('shopitemHash', shopitemHash)

    -- exports['research']:FindItemByHashAndFilloutWearableData(shopitemHash)

    -- INVENTORY::_0x025A1B1FB03FBF61(func_2350(bParam2), &Var5, &Var9, 15, 1)
    return false
end

function UseItemPomade( data, slot )
    local playerPedId = PlayerPedId()
    local itemSlot = slot.slot

    if not IsPlayerWearingPomade() then

        -- IsMetapedUsingComponent
        if N_0xfb4891bd7578cdc1(playerPedId, `HATS`) ~= 0 then
            TaskItemInteraction(playerPedId, 0, `APPLY_POMADE_WITH_HAT`, 1, 0, -1.0)
        else
            TaskItemInteraction(playerPedId, 0, `APPLY_POMADE_WITH_NO_HAT`, 1, 0, -1.0)
        end

        if slot.name == 'hair_pomade' then
            ApplyPlayerHairPomade()
        -- elseif slot.name == 'beard_pomade' then
            -- ApplyPlayerBeardPomade()
        end

        -- TriggerServerEvent('inventory:server:RemoveDurability', itemSlot, 25)
        --[ thread ]
    else
        --[[ Already using pomade]]
    end
end

exports("UseItemPomade", UseItemPomade)

function ApplyPlayerBeardPomade()
    local playerPedId = PlayerPedId()

    local shopitemHash = GetPlayerBeardShopitem()

    -- UpdateShopItemWearableState
    N_0x66b957aac2eaaeab(playerPedId, shopitemHash, `POMADE`, true --[[ bUpdate ]], true, 1)
end


function ApplyPlayerHairPomade()
    local playerPedId = PlayerPedId()

    local shopitemHash = GetPlayerHairShopitem()

    -- UpdateShopItemWearableState
    N_0x66b957aac2eaaeab(playerPedId, shopitemHash, `POMADE`, true --[[ bUpdate ]], true, 1)
end
