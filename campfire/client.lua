local campfire
local campfireModel 
local hasCampfireSpawned

-- RegisterCommand("campfire", function(source, args)
--     TriggerEvent("CAMPFIRE:Client:SpawnCampfire", args[1])
-- end)


RegisterNetEvent("CAMPFIRE:Client:SpawnCampfire")
AddEventHandler("CAMPFIRE:Client:SpawnCampfire", function(campfireHash)

    campfireModel = campfireHash

    if campfire then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = nil
    end

    local playerPed = PlayerPedId()

    
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, - 0.95))

    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
    exports.progressbar:DisplayProgressBar(15000, "Fazendo fogueira")

    Citizen.Wait(1000)

    ClearPedTasksImmediately(PlayerPedId())

    local prop = CreateObject(GetHashKey(campfireHash), x, y, z, true, false, true)

    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)

    campfire = prop

    TriggerEvent("CAMPFIRE:Client:StartCampfire")

    hasCampfireSpawned = true

    Citizen.CreateThread(function() 
        while hasCampfireSpawned do 
            Wait(1500)
            
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local campfireCoords = GetEntityCoords(campfire)

            if #(playerCoords - campfireCoords) >= 200 then
                SetEntityAsMissionEntity(campfire)
                DeleteObject(campfire)
                campfire = nil
                hasCampfireSpawned = false
            end

        end
    end)
end)

local campfireNoFire = {
    `p_campfire01x_nofire`,
    `p_campfire03x_nofire`
}

local campfireProp = {
    `p_campfire01x`,
    `p_campfire02_amb`,
    `p_campfire02x`,
    `p_campfire02xb`,
    `p_campfire02x_combo`,
    `p_campfire02x_dynamic`,
    `p_campfire02x_script`,
    `p_campfire03x`,
    `p_campfire04x`,
    `p_campfire05x`,
    `p_campfire05x_script`,
    `p_campfire_06x`,
    `p_campfirebasin01x`,
    `p_campfireburnedout05x`,
    `p_campfireburntout02x`,
    `p_campfirechar01x`,
    `p_campfirecharsml01x`,
    `p_campfire_coloursmoke01x`,
    `p_campfirecombined01x`,
    `p_campfirecombined01x_off`,
    `p_campfirecombined02x`,
    `p_campfirecombined03x`,
    `p_campfirecombined04x`,
    `p_campfirecook01x`,
    `p_campfirecook02x`,
    `p_campfiredebris01x`,
    `p_campfiredirt01x`,
    `p_campfiredirt01x002`,
    `p_campfiredirtsml01x`,
    `p_campfireembers01x`,
    `p_campfirefresh01x`,
    `p_campfirenosmoke01x`,
    `p_campfireprop02x`,
    `p_campfirerock01x`,
    `p_campfirerock02x`,
    `p_campfirerocksml01x`,
    `p_campfirerocksml02x`,
    `p_campfiresmlsmolder01x`,
    `p_campfiresmolder01x`,
    `p_campfiretemplate01x`,
    `p_campfire_under01x`,
    `p_campfirewhitefish03x`,
    `p_campfire_win2_01x`,
    `p_campfire_win2_smolder01x`
}


local brushs = {
    `RDR_BUSH_AGAVE_AA_SIM`,
    `RDR_BUSH_AGAVE_AB_SIM`,
    `RDR_BUSH_ALOE_AA_SIM`,
    `RDR_BUSH_AREC_AA_SIM`,
    `RDR_BUSH_AREC_AB_SIM`,
    `RDR_BUSH_BRAM_AA_SIM`,
    `RDR_BUSH_BRAM_DEAD_AA_SIM`,
    `RDR_BUSH_BROAD_AA_CRT_SIM`,
    `RDR_BUSH_BROAD_AA_SIM`,
    `RDR_BUSH_BROAD_AB_CRT_SIM`,
    `RDR_BUSH_BROAD_AB_SIM`,
    `RDR_BUSH_BRUSH_BURNT_AA_SIM`,
    `RDR_BUSH_BRUSH_DEAD_AA_SIM`,
    `RDR_BUSH_BRUSH_DEAD_BA_SIM`,
    `RDR_BUSH_BRUSH_DEAD_CA_SIM`,
    `RDR_BUSH_BRUSH_GRN_AA_SIM`,
    `RDR_BUSH_BRUSH_SNW_AA_SIM`,
    `RDR_BUSH_CAT_TAIL_AA_SIM`,
    `RDR_BUSH_CAT_TAIL_AB_SIM`,
    `RDR_BUSH_DECOR_AA`,
    `RDR_BUSH_DECOR_AB`,
    `RDR_BUSH_DRY_THIN_AA_SIM`,
    `RDR_BUSH_DRY_THIN_BA_SIM`,
    `RDR_BUSH_EAR_AA_SIM`,
    `RDR_BUSH_EAR_AB_SIM`,
    `RDR_BUSH_FERN_AA_SIM`,
    `RDR_BUSH_FERN_AA`,
    `RDR_BUSH_FERN_AB_SIM`,
    `RDR_BUSH_FERN_BA_SIM`,
    `RDR_BUSH_FERN_DEAD_BA_SIM`,
    `RDR_BUSH_FERN_MIX_DA_SIM`,
    `RDR_BUSH_FERN_TALL_CA_SIM`,
    `RDR_BUSH_FERN_TALL_CB_SIM`,
    `RDR_BUSH_FERN_TALL_CC_SIM`,
    `RDR_BUSH_FICUS_AA_SIM`,
    `RDR_BUSH_HEDGECORE_AA`,
    `RDR_BUSH_HEDGECORE_AB`,
    `RDR_BUSH_HEDGECORE_AC`,
    `RDR_BUSH_HEDGECORE_AD`,
    `RDR_BUSH_JUNIP_AA_SIM`,
    `RDR_BUSH_JUNIP_AB_SIM`,
    `RDR_BUSH_JUNIP_AC_SIM`,
    `RDR_BUSH_KUDZU_AA`,
    `RDR_BUSH_KUDZU_AB`,
    `RDR_BUSH_KUDZU_AC`,
    `RDR_BUSH_KUDZU_AD`,
    `RDR_BUSH_KUDZU_AE`,
    `RDR_BUSH_KUDZU_AF`,
    `RDR_BUSH_KUDZU_AG`,
    `RDR_BUSH_KUDZU_BR_AA_SIM`,
    `RDR_BUSH_KUDZU_BR_AB_SIM`,
    `RDR_BUSH_KUDZU_BR_AC_SIM`,
    `RDR_BUSH_KUDZU_GC_01`,
    `RDR_BUSH_KUDZU_GC_02`,
    `RDR_BUSH_KUDZU_GF_01`,
    `RDR_BUSH_KUDZU_GF_02`,
    `RDR_BUSH_KUDZU_GF_03`,
    `RDR_BUSH_KUDZU_GF_04`,
    `RDR_BUSH_KUDZU_MOSS_AA_SIM`,
    `RDR_BUSH_KUDZU_ROOTS_AA_SIM`,
    `RDR_BUSH_KUDZU_ROOTS_AB_SIM`,
    `RDR_BUSH_KUDZU_ROOTS_AC_SIM`,
    `RDR_BUSH_KUDZU_TOP_01`,
    `RDR_BUSH_KUDZU_TOP_02`,
    `RDR_BUSH_KUDZU_TOP_03`,
    `RDR_BUSH_KUDZU_TOP_04`,
    `RDR_BUSH_KUDZU_WALL_01`,
    `RDR_BUSH_LEAFY_AA_SIM`,
    `RDR_BUSH_LOW_AA`,
    `RDR_BUSH_LOW_AB`,
    `RDR_BUSH_LOW_BA`,
    `RDR_BUSH_LOW_BB`,
    `RDR_BUSH_LRG_AA_SIM`,
    `RDR_BUSH_LRG_DEAD_AA_SIM`,
    `RDR_BUSH_MANG_AA_SIM`,
    `RDR_BUSH_MANG_AB_SIM`,
    `RDR_BUSH_MANG_AC_SIM`,
    `RDR_BUSH_MANG_AD_SIM`,
    `RDR_BUSH_MANG_LG_AA_SIM`,
    `RDR_BUSH_MANG_LOW_AA`,
    `RDR_BUSH_MANG_LOW_AB`,
    `RDR_BUSH_NEAT_AA_SIM`,
    `RDR_BUSH_NEAT_AB_SIM`,
    `RDR_BUSH_NEAT_AC_SIM`,
    `RDR_BUSH_NEAT_AD_SIM`,
    `RDR_BUSH_NEAT_AE_SIM`,
    `RDR_BUSH_NEAT_BA_SIM`,
    `RDR_BUSH_NEAT_BB_SIM`,
    `RDR_BUSH_NEAT_BC_SIM`,
    `RDR_BUSH_PALM_AA_SIM`,
    `RDR_BUSH_PALM_AB_SIM`,
    `RDR_BUSH_PARADISE_AA_SIM`,
    `RDR_BUSH_ROOTS_AA`,
    `RDR_BUSH_ROOTS_AB`,
    `RDR_BUSH_SAGE_AA`,
    `RDR_BUSH_SAGE_AB`,
    `RDR_BUSH_SCRUB_AA_SIM`,
    `RDR_BUSH_SOGA_AA_SIM`,
    `RDR_BUSH_SOGA_AB_SIM`,
    `RDR_BUSH_SUMAC_AA_SIM`,
    `RDR_BUSH_TALL_REEDS_AA_SIM`,
    `RDR_BUSH_THICK_AA_SIM`,
    `RDR_BUSH_THINGREEN_AA_SIM`,
    `RDR_BUSH_THORN_AA_SIM`,
    -- `RDR_BUSH_WANDERING_AA_SIM`,
    `RDR_BUSH_YUCCA_AA_SIM`,
    `RDR_BUSH_YUCCA_DEAD_AA_SIM`,
    `RDR2_BUSH_AMERICANBOXWOOD`,
    `RDR2_BUSH_BEAVERTAILCACTUS_02`,
    `RDR2_BUSH_BEAVERTAILCACTUS`,
    `RDR2_BUSH_BIGBERRYMANZANITA`,
    `RDR2_BUSH_CATCLAW`,
    `RDR2_BUSH_CHOLLOCACTUS`,
    `RDR2_BUSH_CREOSOTEBUSH_2`,
    `RDR2_BUSH_CREOSOTEBUSH`,
    `RDR2_BUSH_DESERTBROOM_2`,
    `RDR2_BUSH_DESERTBROOM`,
    `RDR2_BUSH_DESERTIRONWOOD`,
    `RDR2_BUSH_PRICKLYPEARCACTUS`,
    `RDR2_BUSH_SAGEBRUSH`,
    `RDR2_BUSH_SCRUBOAK`,
    `RDR2_BUSH_SNAKEWEED`,
    `RDR2_BUSH_SNAKEWEEDFLOWER_2`,
    `RDR2_BUSH_SNAKEWEEDFLOWER`,
    `RDR2_TREE_BEECH`,
    `RDR2_TREE_BROKENTREE`,
    `RDR2_TREE_GIMLET`,
    `RDR2_TREE_RATA01`,
    `RDR2_TREE_RATA02`,
    `RDR2_TREE_RIVERBIRCH`,
    `RDR2_TREE_SYCAMORE`,
    `RDR2_TREE_UTAHJUNIPER`
}

Citizen.CreateThread(function()

    -- exports["nxt-peek"]:AddPeekEntryByModel(campfireNoFire, 
    -- {
    --     {
    --         id = "CAMPFIRE-RemoveCampfire",
    --         event = "CAMPFIRE:Client:Refire",
    --         icon = "fas fa-dumpster",
    --         label = "Reacender",
    --         parameters = {},
    --     },
    --     {
    --         id = "CAMPFIRE-RemoveCampfire",
    --         event = "CAMPFIRE:Client:RemoveCampfire",
    --         icon = "fas fa-dumpster",
    --         label = "Desmontar",
    --         parameters = {},
    --     },
    -- }, {
    --     distance = { radius = 2.5 },
    -- })
    
end)



RegisterNetEvent("CAMPFIRE:Client:StartCampfire")
AddEventHandler("CAMPFIRE:Client:StartCampfire", function()

    local campfireCoords = GetEntityCoords(campfire)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local campfireHeading = GetEntityHeading(campfire)

    Wait((6000 * 10 ) * 10)
    
    local campfireHash

    if campfireModel == 'p_campfire01x' then
        campfireHash = 'p_campfire01x_nofire'
    elseif campfireModel == 'p_campfire03x' then
        campfireHash = 'p_campfire03x_nofire'
    end
    
    SetEntityAsMissionEntity(campfire)
    DeleteObject(campfire)

    local prop = CreateObject(GetHashKey(campfireHash), campfireCoords, true, false, true)    
    SetEntityHeading(prop, campfireHeading)
    PlaceObjectOnGroundProperly(prop)

    campfire = prop
end)


RegisterNetEvent("CAMPFIRE:Client:RemoveCampfire")
AddEventHandler("CAMPFIRE:Client:RemoveCampfire", function()

    local hasPermission = false

    if not campfire then
        TriggerEvent("texas:notify:native", "Esta fogueira não é sua.", 5000)
        return
    else
        local objCampfire
        
        for i = 1, #campfireNoFire do
            local cpModel = campfireNoFire[i]

            local playerCoords = GetEntityCoords(PlayerPedId())
            objCampfire = Citizen.InvokeNative(0xE143FA2249364369, playerCoords, 2.0, cpModel, false, false, false)

            if DoesEntityExist(objCampfire) then

                if GetEntityModel(objCampfire) == cpModel then
                    hasPermission = true
                    break
                end
            end
        end

        if hasPermission then
            local playerPed = PlayerPedId()

            TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
            exports.progressbar:DisplayProgressBar(6000, "Removendo fogueira")
        
            Citizen.Wait(1000)    
            ClearPedTasks(playerPed)
            SetEntityAsMissionEntity(objCampfire)
            DeleteObject(objCampfire)

            TriggerServerEvent("CAMPFIRE:Server:GiveCampfireToPlayer", campfireModel)

            campfire = nil
        end
    end
end)


RegisterNetEvent("CAMPFIRE:Client:Refire")
AddEventHandler("CAMPFIRE:Client:Refire", function()
    local playerPed = PlayerPedId()
    local campfireCoords = GetEntityCoords(campfire)
    local playerCoords = GetEntityCoords(playerPed)
    local campfireHeading = GetEntityHeading(campfire)
    
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
    exports.progressbar:DisplayProgressBar(4000, "Reacendendo fogueira")

    if not campfire then
        local objCampfire

        for i = 1, #campfireNoFire do
            local cpModel = campfireNoFire[i]
    
            local playerCoords = GetEntityCoords(PlayerPedId())
            objCampfire = Citizen.InvokeNative(0xE143FA2249364369, playerCoords, 2.0, cpModel, false, false, false)
    
            if DoesEntityExist(objCampfire) then    
                if GetEntityModel(objCampfire) == cpModel then
                    campfire = objCampfire
                    break
                end
            end
        end

    else

        ClearPedTasks(playerPed)
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)

        local prop = CreateObject(campfireModel, campfireCoords, true, false, true)
        SetEntityHeading(prop, campfireHeading)
        PlaceObjectOnGroundProperly(prop)

        campfire = prop

        TriggerEvent("CAMPFIRE:Client:StartCampfire")
    end
end)


RegisterNetEvent("CAMPFIRE:Client:CutWoodlog", function()
    local playerPed = PlayerPedId()

    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
    exports.progressbar:DisplayProgressBar(5000, "Cortando Madeira")    
    
    ClearPedTasks(playerPed)
    TriggerServerEvent("CAMPFIRE:Server:RewardWoodlog")
end)

local harvest = false

RegisterNetEvent("CAMPFIRE:Client:Harvest", function()

    if harvest then
        return
    end

    local playerPed = PlayerPedId()

    harvest = true
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
    exports.progressbar:DisplayProgressBar(1500, "Coletando Gravetos")    
    
    ClearPedTasks(playerPed)
    TriggerServerEvent("CAMPFIRE:Server:RewardWoodlog")
    harvest = false
end)

local collected = {}

RegisterNetEvent("Plant-Collect:Special", function( data )
    local entity = data.entity
    local playerPed = PlayerPedId()

    if collected[entity] then
        return
    end 

    harvest = true
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
    exports.progressbar:DisplayProgressBar(1500, "Coletando")    
    
    ClearPedTasks(playerPed)
    TriggerServerEvent("CAMPFIRE:Server:RewardSpecial")

    -- DeleteEntity(entity)
    harvest = false

    collected[entity] = true
end)



local campfireNoFire = {
    `p_tree_orange_01`,
}

Citizen.CreateThread(function()

    -- exports["nxt-peek"]:AddPeekEntryByModel(campfireNoFire, 
    -- {
    --     {
    --         id = "Orange-Robbery",
    --         event = "CAMPFIRE:Client:Refire",
    --         icon = "fas fa-dumpster",
    --         label = "Reacender",
    --         parameters = {},
    --     },
    --     {
    --         id = "Orange-Robbery",
    --         event = "Orange:Client:Robbery",
    --         icon = "fas fa-dumpster",
    --         label = "Pegar Laranja",
    --         parameters = {},
    --     },
    -- }, {
    --     distance = { radius = 2.5 },
    -- })
    
end)


RegisterNetEvent("Orange:Client:Robbery")
AddEventHandler("Orange:Client:Robbery", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)    
    exports.progressbar:DisplayProgressBar(1500, "Coletando Laranjas")    
    ClearPedTasks(playerPed)
    TriggerServerEvent("Orange:Server:RewardOrange")
end)



RegisterNetEvent("Indian:Client:Aljava")
AddEventHandler("Indian:Client:Aljava", function()
    local ObjectAljava = "p_arrowbundle01x"
    placeAljava(ObjectAljava)
end)


function placeAljava(ObjectAljava)
    local myPed = PlayerPedId()
    local playerModel = Citizen.InvokeNative(0xDA76A9F39210D365, myPed)
    local bone 

    if (playerModel == -171876066) then  -- MALE
        bone = 131 
    elseif (playerModel == -1481695040) then -- FEMALE
        bone = 215 
    end
    exports.progressbar:DisplayProgressBar(1500, "Vestindo")
    local PropHash = GetHashKey(ObjectAljava)
    tempAljava = CreateObject(PropHash, GetEntityCoords(playerPedId), true, true, false, false, true)
    AttachEntityToEntity(tempAljava, myPed, bone, 0.21, -0.20, -0.03, 273.0, -131.0, 188.0, 0.0, 0, 0, 0, 0, 1, 0, 0);
    currentAljavaName = ObjectAljava
end
