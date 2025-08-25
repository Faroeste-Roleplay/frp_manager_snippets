Citizen.CreateThread(
    function()
        local coldThreshold = 0

        local categoryTempVariation = {
            [`hats`] = 0.05, -- Hat
            -- [0x864B03AE] = 0.75, -- Hair

            [`shirts_full`] = 1.7, -- Shirts
            [`vests`] = 1.0, -- Vests
            [`pants`] = 1.0, -- Pants
            [`beards_chin`] = 0.05, -- Goatees
            [`beards_chops`] = 0.05, -- Goatees

            -- [0x18729F39] = 0.75, -- Spurs

            [`chaps`] = 1.10, -- Chaps
            [`cloaks`] = 1.40, --Cloaks
            [`skirts`] = 0.5, -- Skirts (MP)

            [`MASKS_LARGE`] = 0.15, -- Masks
            [`masks`] = 0.15, -- Masks (MP)

            [`spats`] = 0.40, -- Spats
            [`neckwear`] = 0.5, -- Neckwear

            -- [0x76F0E272] = 0.1, -- Aprons

            [`boots`] = 0.5, -- Boots
            [`gauntlets`] = 0.4, -- Gauntlets (MP)

            -- [0x7A96FACA] = 0.3, -- Neckties
            -- [0x9B2C8B89] = 0.7, -- Gunbelts
            -- [0xA6D134C6] = 0.5, -- Belts
            -- [0xFAE9107F] = 0.5, -- Belt Buckle

            [`coats`] = 7.0, -- Coats
            [`coats_closed`] = 7.0, -- Coats closes
            [`ponchos`] = 3.0, -- Ponchos (MP)
            [`armor`] = 1.0, -- Armor (MP)
            [`gloves`] = 1.5, -- Gloves

            -- [0xECC8B25A] = 0.25, -- Mustache
            -- [0xF8016BCA] = 0.25 -- Mustache (MP)
        }

        while true do
            Citizen.Wait(10000)

            local ped = PlayerPedId()
            local tempAtPed = GetTemperatureAtCoords(GetEntityCoords(ped))

            local oldTempt = tempAtPed
            
            for i = 0, NativeGetNumOfCategoriesUsesByPed(ped) do
                local componentCategory = NativeGetPedCategoryAtIndex(ped, i)

                if categoryTempVariation[componentCategory] then
                    tempAtPed = tempAtPed + categoryTempVariation[componentCategory]
                end
            end
            
            if tempAtPed >= 41 and tempAtPed <= 44 then
                SetPedWetnessHeight(ped, 1.0)

                TriggerEvent('client.temperatureNotification', "Você está com calor, tente abrigar-se ou vestir-se melhor")

                TriggerServerEvent('server.temperatureThirst', 1)
            elseif tempAtPed >= 44 then
            
                SetPedWetnessHeight(ped, 1.0)

                if GetEntityHealth(ped) >= 5 then
                    NativeApplyDamageToPed(ped, 1)
                end

                TriggerEvent('client.temperatureNotification', "Você está com muito calor, tente abrigar-se ou vestir-se melhor")

                TriggerServerEvent('server.temperatureThirst', 1)

            elseif tempAtPed <= 4 and tempAtPed > 0 then
                Citizen.InvokeNative(0xCB9401F918CB0F75, ped, "Cold_Stamina", 1, 1500)

                TriggerEvent('client.temperatureNotification', "Você está com frio, tente abrigar-se ou vestir-se melhor")

            elseif tempAtPed <= 0 then
                Citizen.InvokeNative(0xCB9401F918CB0F75, ped, "Cold_Stamina", 1, 1500)

                TriggerEvent('client.temperatureNotification', "Você está com muito frio, tente abrigar-se ou vestir-se melhor")

                if GetEntityHealth(ped) >= 5 then
                    NativeApplyDamageToPed(ped, 1)
                end
            else                
                Citizen.InvokeNative(0xCB9401F918CB0F75, ped, "Cold_Stamina", 0, 0)
            end
        end
    end
)

local showNotify = false

AddEventHandler("client.temperatureNotification", function(msg)

    if showNotify then
        return
    end

    showNotify = true

    TriggerEvent("texas:notify:native", msg, 6000)

    Wait(25000)

    showNotify = false   
end)


function NativeApplyDamageToPed(ped, damage)
    Citizen.InvokeNative(0x697157CED63F18D4, ped, damage, false, true, true)
end

function NativeGetNumOfCategoriesUsesByPed(ped)
    return Citizen.InvokeNative(0x90403E8107B60E81, ped, Citizen.ResultAsInteger())
end

function NativeGetPedCategoryAtIndex(ped, index)
    return Citizen.InvokeNative(0x9B90842304C938A7, ped, index, 0)
end

function removeStaminaFromPed(playerPed, amount)    
    -- local sCore = GetAttributeCoreValue(playerPed, 1)
    local sNormal = Citizen.InvokeNative(0x22F2A386D43048A9, playerPed, Citizen.ResultAsFloat())

    -- Citizen.InvokeNative(0xC6258F41D86676E0, playerPed, 1, sCore - amount) -- _SET_ATTRIBUTE_CORE_VALUE

    Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerPed, sNormal - amount - 4) -- _CHANGE_PED_STAMINA
end