
local gIsCompassScriptEnabled = true
local gIsCompassEnabled = nil

-- local gCompassEntityId = nil

function UpdateMinimap()
    local minimapType = 1 --[[ Regular ]]

    if gIsCompassScriptEnabled then
        minimapType = 0 --[[ Off ]]
    end

    if gIsCompassEnabled then
        minimapType = 1 --[[ Simple ]]

        -- local playerPedId = PlayerPedId()

        -- -- GetTransportPedIsSeatedOn
        -- local isInAnyTransport = N_0x849bd6c6314793d0(playerPedId) ~= 0

        -- if isInAnyTransport then
        --     minimapType = 1 --[[ Regular ]]
        -- end
    end

    SetMinimapType(minimapType)
end

function CreateMainLoop()
    CreateThread(function()

        -- local playerPedId = PlayerPedId()

        --[[
        local compassModelHash = `s_inv_pocketWatch01x`
        RequestModel(compassModelHash)
        --]]

        while true do
            Wait(100)
        
            UpdateMinimap()

            --[=[
            if not gCompassEntityId and HasModelLoaded(compassModelHash) then
                local playerPos = GetEntityCoords(playerPedId)
                gCompassEntityId = CreateObject(compassModelHash, playerPos.x, playerPos.y, playerPos.z, true, false, false, false, true)
                -- TaskItemInteraction_2(playerPedId, `POCKETWATCH@D6-5_H1-5_InspectZ`, gCompassEntityId, `PrimaryItem`, GetHashKey("POCKET_WATCH_INSPECT_UNHOLSTER"), 1, 0, -1)
                -- <Flags>LEFT_HANDED USE_BODY_BLEND_TAGS ALLOW_SPEECH SUPPRESS_SECONDARY_GRIP_IK</Flags>
                -- <Flags>USE_BODY_BLEND_TAGS ALLOW_LOOKAT_FACING ALLOW_ILO_PROMPTS ALLOW_SPEECH DISABLE_ARM_IK_BLOCKING ALLOW_FIRST_PERSON_RIGHT_HAND</Flags>
                -- <Flags>LOOPING USE_BODY_BLEND_TAGS ALLOW_ILO_PROMPTS ALLOW_LOOKAT_FACING ALLOW_SPEECH GROUP_PROMPTS</Flags>
                TaskItemInteraction_2(
                    playerPedId,
                    `CONSUMABLE_COFFEE`,
                    gCompassEntityId,
                    `PrimaryItem`,
                    `POCKET_WATCH_INSPECT_UNHOLSTER`,
                    1,
                    0, -- 0 | 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 | 8192 | 16384 | 32768 | 65536--[[ flags ]],
                    -1
                )
            end
            --]=]

            -- SetCompassEnabled(false)
        end

        --[[
        SetModelAsNoLongerNeeded(compassModelHash)
        if gCompassEntityId then
            DeleteEntity(gCompassEntityId)
            gCompassEntityId = nil
        end
        ClearPedTasks(playerPedId, false, false)
        --]]

        --[[ Cleanup? ]]
    end)
end

function SetCompassEnabled(enabled)
    if gIsCompassEnabled == enabled then
        return
    end

    gIsCompassEnabled = enabled

    UpdateMinimap()

    TriggerEvent("frp_hud:compassStatus", enabled)
    PlaySoundFrontend(gIsCompassEnabled and 'INFO' or 'INFO_HIDE', 'HUD_SHOP_SOUNDSET', true, 0)
end

function EnableCompass()
    SetCompassEnabled(true)
end

function DisableCompass()
    SetCompassEnabled(false)
end

CreateThread(function()
    DisableCompass()

    CreateMainLoop()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then

        --[[ Forçar a deixar o minimapa padrão pela função de update. ]]
        gIsCompassScriptEnabled = false

        DisableCompass()
    end
end)

--[[ O compasso foi usado no inventário ]]
exports('inventoryUsedCompass', function(data, slot)
	exports.ox_inventory:useItem(data, function(data)
        SetCompassEnabled(not gIsCompassEnabled)
	end)
end)

--[[ O inventário disse para a gente que todos os items de compasso foram removidas do inventario do player ]]
AddEventHandler('playerInventoryRemovedAllCompassItem', function()
    DisableCompass()
end)