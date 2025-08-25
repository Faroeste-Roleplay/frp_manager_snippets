clientT.getLabelTextByHash = function(hash)
    return GetLabelTextByHash(GetHashKey(hash))
end

AddEventHandler("FRP:interactWithCard", function(model)
    local playerPed = PlayerPedId()
    Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 2, true) -- HidePedWeapons

    local propEntity = CreateObject(GetHashKey(model), GetEntityCoords(playerPed), false, false, false, false, false)

    Citizen.InvokeNative(0xCB9401F918CB0F75, playerPed, 'GENERIC_DOCUMENT_FLIP_AVAILABLE', true, -1) -- SetPedBlackboardBool
    TaskItemInteraction_2(playerPed, GetHashKey(model), propEntity, GetHashKey('PrimaryItem'),
        GetHashKey('CIGARETTE_CARD_W6-5_H10-7_SINGLE_INTRO'), 1, 0, -1.0)
end)

AddEventHandler('texas:interaction:seatChairBenches', function(data)
    playSeatAnim(PlayerPedId(), data.entity, false)
end)

AddEventHandler('texas:interaction:seatChair', function(data)
    playSeatAnim(PlayerPedId(), data.entity, false)
end)


function fillCanteen()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords( playerPed )
    HidePedWeapons(playerPed, 2, true)

    local taskRun = false
    local DataStruct = DataView.ArrayBuffer(256 * 4)
    local pointsExist = GetScenarioPointsInArea(playerCoords, 2.0, DataStruct:Buffer(), 10)

    if not pointsExist then goto NEXT end

    for i = 1, 1 do
        local scenario = DataStruct:GetInt32(8 * i)
        local hash = GetScenarioPointType(scenario)
        if hash == joaat('PROP_HUMAN_PUMP_WATER') then
            taskRun = true
            ClearPedTasksImmediately(playerPed)
            TaskUseScenarioPoint(playerPed, scenario, '', 10000, true, false, 0, false, -1.0, true)
            Wait(10000)
            break
        end
    end

    ::NEXT::
    if not taskRun then
        local boneIndex = GetEntityBoneIndexByName(playerPed, 'SKEL_R_HAND')
        local modelHash = joaat('p_cs_canteen_hercule')
        LoadModel(modelHash)
        local Canteen = CreateObject(modelHash, playerCoords, true, true, false, false, true)
        SetEntityVisible(Canteen, true)
        SetEntityAlpha(Canteen, 255, false)
        SetModelAsNoLongerNeeded(modelHash)
        AttachEntityToEntity(Canteen, playerPed, boneIndex, 0.12, 0.09, -0.05, 306.0, 18.0, 0.0, true, true, false, true, 2,
            true)
    
        local dict = 'amb_work@world_human_crouch_inspect@male_c@idle_a'
        LoadAnim(dict)
        TaskSetCrouchMovement(playerPed, true, 0, false)
        Wait(1500)
        TaskPlayAnim(playerPed, dict, 'idle_a', 1.0, 1.0, -1, 3, 1.0, false, false, false)
        Wait(8000)
        TaskSetCrouchMovement(playerPed, false, 0, false)
        Wait(1500)
        DeleteObject(Canteen)
    end

    ClearPedTasks(playerPed)
end

function fillBucket()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords( playerPed )
    HidePedWeapons(playerPed, 2, true)

    local taskRun = false
    -- Dataview snippet credit to Xakra and Ricx
    local DataStruct = DataView.ArrayBuffer(256 * 4)
    local pointsExist = GetScenarioPointsInArea(playerCoords, 2.0, DataStruct:Buffer(), 10)

    if not pointsExist then goto NEXT end

    for i = 1, 1 do
        local scenario = DataStruct:GetInt32(8 * i)
        local hash = GetScenarioPointType(scenario)
        if hash == GetHashKey('PROP_HUMAN_PUMP_WATER') or hash == GetHashKey('PROP_HUMAN_PUMP_WATER_BUCKET') then
            taskRun = true
            ClearPedTasksImmediately(playerPed)
            TaskUseScenarioPoint(playerPed, scenario, '', 15000, true, false, 0, false, -1.0, true)
            Wait(15000)
            ClearPedTasks(playerPed, true, true)
            Wait(3000)
            HidePedWeapons(playerPed, 2, true) -- Hide Bucket
            break
        end
    end

    ::NEXT::
    if not taskRun then
        TaskStartScenarioInPlaceHash(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_FILL'), 8000, true, 0, -1, false)
        Wait(8500)
        HidePedWeapons(playerPed, 2, true) -- Hide Bucket
    end
end

function washHands(animType)
    local playerPed = PlayerPedId()
    if animType == "ground" then
        PlayAnim('amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d', 'idle_l')
    elseif animType == "stand" then
        PlayAnim('amb_misc@world_human_wash_face_bucket@table@male_a@idle_d', 'idle_l')
    end
    ClearPedEnvDirt(playerPed)
    ClearPedDamageDecalByZone(playerPed, 10, 'ALL')
    ClearPedBloodDamage(playerPed)
    SetPedDirtCleaned(playerPed, 0.0, -1, true, true)
end

AddEventHandler("frp:interaction:fillCanteen", function()
    fillCanteen()
    TriggerServerEvent("frp:interaction:fillCanteen")
end)

AddEventHandler("frp:interaction:fillBucket", function()
    fillBucket()
    TriggerServerEvent("frp:interaction:fillBucket")
end)

AddEventHandler("frp:interaction:washHands", function()
    washHands('stand')
    TriggerServerEvent("frp:interaction:washHands")
end)

-- AddEventHandler('texas:interaction:pumpWater', function()
--     local pumpWater = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.8, `P_WATERPUMP01X`, 0, 0, 0);

--     if not pumpWater then
--         return
--     end

    -- local pumpHeading = GetEntityHeading(pumpWater)
    -- local pumpCoords = GetEntityCoords(pumpWater)

--     SetEntityHeading(PlayerPedId(), pumpHeading - 180)
--     SetEntityCoords(PlayerPedId(), pumpCoords)

--     -- TaskStartScenarioInPlace(cache.ped, joaat('WORLD_HUMAN_BUCKET_DRINK_GROUND'), -1, true, false, false, false)
--     -- TaskGoToCoordAnyMeans(PlayerPedId(), vec3(pumpCoords.x + 1.0, pumpCoords.y + 1.0, pumpCoords.z), 1.0, 0, 0, 786603, 0xbf800000);

--     Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey('PROP_HUMAN_PUMP_WATER'), -1, true, 0, -1.0, 0);
-- end)

-- RegisterCommand("runCreateScenario", function(_, args)


--     TaskUseScenarioPoint(PlayerPedId(), 'PROP_HUMAN_PUMP_WATER_BUCKET', "" , -1.0, true, false, 0, false, -1.0, true)

--     -- createScenario( 'PROP_HUMAN_PUMP_WATER_BUCKET' )
-- end)



function createScenario( anim )
    local pumpWater = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.8, `P_WATERPUMP01X`, 0, 0, 0);

    local pumpHeading = GetEntityHeading(pumpWater)
    local pumpCoords = GetEntityCoords(pumpWater)

    local ped = PlayerPedId()

    local scenarioHash = GetHashKey( anim )

    while HasScenarioTypeLoaded( scenarioHash ) == 0 do
        RequestScenarioType( scenarioHash, 15 ,0, 0 )

        Wait(100)
    end

    local scenario = CreateScenarioPointHash( scenarioHash, pumpCoords.x, pumpCoords.y, pumpCoords.z + 0.98, pumpHeading - 180,  1, 1, true);
    TaskUseScenarioPoint( ped, scenario, 0, 0, true, false, 0, false, -1082130432, false)
end

-- RegisterCommand("interaction", function()

--     local struct = DataView.ArrayBuffer(48)
--     -- local pumpWater = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.8, `P_WATERPUMP01X`, 0, 0, 0);
--     -- local pumpCoords = GetEntityCoords(pumpWater)

--     Citizen.InvokeNative(0x345EC3B7EBDE1CB5, GetEntityCoords(PlayerPedId()), 2.0, struct:Buffer(), 1, Citizen.ReturnResultAnyway())
--     print(struct:GetInt32(8))
--     Citizen.InvokeNative(0xCCDAE6324B6A821C, PlayerPedId(), struct:GetInt32(8), 0, 0, true, true, 0, false, -1.0, false);


-- end)

AddEventHandler('texas:interaction:pile', function()
    -- local pumpWater = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.8, `P_WATERPUMP01X`, 0, 0, 0)

    -- if not pumpWater then
    --     return
    -- end

    -- local pumpCoords = GetEntityCoords(pumpWater)
    -- local pumpHeading = GetEntityHeading(pumpWater)

    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey('WORLD_PLAYER_CHORES_BUCKET_FILL'), 15000, true,
        true, true, false)
end)

-- RegisterCommand("afeno2", function(source, args, rawCommand)
--     -- local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 3.0, `P_FEEDBAGS01X`, 0, 0, 0)
--     -- print(object)

--     local model = "P_HAYBALE03X"
--     if IsModelValid(model) then
--         if not HasModelLoaded(model) then
--             RequestModel(model)
--             while not HasModelLoaded(model) do
--                 Citizen.Wait(10)
--             end
--         end
--     end

--     local coords = GetEntityCoords(PlayerPedId()) + (GetEntityForwardVector(PlayerPedId()) * 0.7)
--     local object = CreateObject(model, coords, true, true, false, false, true)
--     PlaceObjectOnGroundProperly(object)

--     Citizen.InvokeNative(0x3BBDD6143FF16F98, PlayerPedId(), object, "p_hayBale03x_PH_R_HAND", "WORLD_HUMAN_COTTONBALE_PICKUP_2", 0, 0)
-- end)

local chairs = {
    [`p_bench03x`] = { "isChairBenches" },
    [`p_bench06x`] = { "isChairBenches" },
    [`p_bench08bx`] = { "isChairBenches" },
    [`p_bench09x`] = { "isChairBenches" },
    [`p_bench15_mjr`] = { "isChairBenches" },
    [`p_bench15x`] = { "isChairBenches" },
    [`p_bench18x`] = { "isChairBenches" },
    [`p_benchch01x`] = { "isChairBenches" },
    [`p_benchironnbx01x`] = { "isChairBenches" },
    [`p_bench_log01x`] = { "isChairBenches" },
    [`p_bench_log02x`] = { "isChairBenches" },
    [`p_bench_log03x`] = { "isChairBenches" },
    [`p_bench_log04x`] = { "isChairBenches" },
    [`p_bench_log05x`] = { "isChairBenches" },
    [`p_bench_log06x`] = { "isChairBenches" },
    [`p_bench_log07x`] = { "isChairBenches" },
    [`p_bench_logsnow07x`] = { "isChairBenches" },
    [`p_benchnbx02x`] = { "isChairBenches" },
    [`p_benchnbx03x`] = { "isChairBenches" },
    [`p_couch01x`] = { "isChairBenches" },
    [`p_couch02x`] = { "isChairBenches" },
    [`p_couch05x`] = { "isChairBenches" },
    [`p_couch06x`] = { "isChairBenches" },
    [`p_couch08x`] = { "isChairBenches" },
    [`p_couch09x`] = { "isChairBenches" },
    [`p_couch10x`] = { "isChairBenches" },
    [`p_couch11x`] = { "isChairBenches" },
    [`p_couchwicker01x`] = { "isChairBenches" },
    [`p_hallbench01x`] = { "isChairBenches" },
    [`p_loveseat01x`] = { "isChairBenches" },
    [1753274330] = { "isChairBenches" },
    [`p_settee_05x`] = { "isChairBenches" },
    [`p_sit_chairwicker01a`] = { "isChairBenches" },
    [`p_sofa02x`] = { "isChairBenches" },
    [`p_windsorbench01x`] = { "isChairBenches" },
    [`mp005_s_posse_col_chair01x`] = { "isChair" },
    [`mp005_s_posse_foldingchair_01x`] = { "isChair" },
    [`mp005_s_posse_trad_chair01x`] = { "isChair" },
    [`p_ambchair01x`] = { "isChair" },
    [`p_ambchair02x`] = { "isChair" },
    [`p_armchair01x`] = { "isChair" },
    [`p_bistrochair01x`] = { "isChair" },
    [-1079917818] = { "isChair" },
    [`p_bench20x`] = { "isChair" },
    [`p_benchpiano02x`] = { "isChair" },
    [`p_chair02x`] = { "isChair" },
    [`p_chair04x`] = { "isChair" },
    [`p_chair05x`] = { "isChair" },
    [`p_chair06x`] = { "isChair" },
    [`p_chair07x`] = { "isChair" },
    [`p_chair09x`] = { "isChair" },
    [`p_chair_10x`] = { "isChair" },
    [`p_chair11x`] = { "isChair" },
    [`p_chair12bx`] = { "isChair" },
    [`p_chair12x`] = { "isChair" },
    [`p_chair13x`] = { "isChair" },
    [`p_chair14x`] = { "isChair" },
    [`p_chair15x`] = { "isChair" },
    [`p_chair16x`] = { "isChair" },
    [`p_chair17x`] = { "isChair" },
    [`p_chair18x`] = { "isChair" },
    [`p_chair19x`] = { "isChair" },
    [`p_chair20x`] = { "isChair" },
    [`p_chair21x`] = { "isChair" },
    [`p_chair21x_fussar`] = { "isChair" },
    [`p_chair22x`] = { "isChair" },
    [`p_chair23x`] = { "isChair" },
    [`p_chair24x`] = { "isChair" },
    [`p_chair25x`] = { "isChair" },
    [`p_chair26x`] = { "isChair" },
    [`p_chair27x`] = { "isChair" },
    [`p_chair30x`] = { "isChair" },
    [`p_chair31x`] = { "isChair" },
    [`p_chair37x`] = { "isChair" },
    [`p_chair38x`] = { "isChair" },
    [`p_chair_barrel04b`] = { "isChair" },
    [`p_chaircomfy01x`] = { "isChair" },
    [`p_chaircomfy02`] = { "isChair" },
    [`p_chaircomfy03x`] = { "isChair" },
    [`p_chaircomfy04x`] = { "isChair" },
    [`p_chaircomfy05x`] = { "isChair" },
    [`p_chaircomfy06x`] = { "isChair" },
    [`p_chaircomfy07x`] = { "isChair" },
    [`p_chaircomfy08x`] = { "isChair" },
    [`p_chaircomfy09x`] = { "isChair" },
    [`p_chaircomfy10x`] = { "isChair" },
    [`p_chaircomfy11x`] = { "isChair" },
    [`p_chaircomfy12x`] = { "isChair" },
    [`p_chaircomfy14x`] = { "isChair" },
    [`p_chaircomfy17x`] = { "isChair" },
    [`p_chaircomfy18x`] = { "isChair" },
    [`p_chaircomfy22x`] = { "isChair" },
    [`p_chaircomfy23x`] = { "isChair" },
    [`p_chairdoctor01x`] = { "isChair" },
    [`p_chair_crate02x`] = { "isChair" },
    [`p_chair_crate15x`] = { "isChair" },
    [`p_chair_cs05x`] = { "isChair" },
    [`p_chairdesk01x`] = { "isChair" },
    [`p_chairdesk02x`] = { "isChair" },
    [`p_chairdining01x`] = { "isChair" },
    [`p_chairdining02x`] = { "isChair" },
    [`p_chairdining03x`] = { "isChair" },
    [`p_chaireagle01x`] = { "isChair" },
    [`p_chairfolding02x`] = { "isChair" },
    [`p_chairhob01x`] = { "isChair" },
    [`p_chairhob02x`] = { "isChair" },
    [`p_chairmed01x`] = { "isChair" },
    [`p_chairmed02x`] = { "isChair" },
    [`p_chairoffice02x`] = { "isChair" },
    [`p_chairpokerfancy01x`] = { "isChair" },
    [`p_chairporch01x`] = { "isChair" },
    [`p_chair_privatedining01x`] = { "isChair" },
    [`p_chairrocking02x`] = { "isChair" },
    [`p_chairrocking03x`] = { "isChair" },
    [`p_chairrocking04x`] = { "isChair" },
    [`p_chairrocking05x`] = { "isChair" },
    [`p_chairrocking06x`] = { "isChair" },
    [`p_chairrustic01x`] = { "isChair" },
    [`p_chairrustic02x`] = { "isChair" },
    [`p_chairrustic03x`] = { "isChair" },
    [`p_chairrustic04x`] = { "isChair" },
    [`p_chairrustic05x`] = { "isChair" },
    [`p_chairsalon01x`] = { "isChair" },
    [`p_chairvictorian01x`] = { "isChair" },
    [`p_chairwhite01x`] = { "isChair" },
    [`p_chairwicker01x`] = { "isChair" },
    [`p_chairwicker02x`] = { "isChair" },
    [`p_cs_electricchair01x`] = { "isChair" },
    [`p_diningchairs01x`] = { "isChair" },
    [`p_gen_chair07x`] = { "isChair" },
    [`p_oldarmchair01x`] = { "isChair" },
    [`p_pianochair01x`] = { "isChair" },
    [`p_privatelounge_chair01x`] = { "isChair" },
    [`p_rockingchair01x`] = { "isChair" },
    [`p_rockingchair02x`] = { "isChair" },
    [`p_rockingchair03x`] = { "isChair" },
    [`p_seatbench01x`] = { "isChair" },
    [`p_settee01x`] = { "isChair" },
    [`p_settee02bx`] = { "isChair" },
    [`p_settee03x`] = { "isChair" },
    [`p_settee03bx`] = { "isChair" },
    [`p_settee04x`] = { "isChair" },
    [`p_sit_chairwicker01b`] = { "isChair" },
    [`p_stool01x`] = { "isChair" },
    [`p_stool02x`] = { "isChair" },
    [`p_stool03x`] = { "isChair" },
    [`p_stool04x`] = { "isChair" },
    [`p_stool05x`] = { "isChair" },
    [`p_stool06x`] = { "isChair" },
    [`p_stool07x`] = { "isChair" },
    [`p_stool08x`] = { "isChair" },
    [`p_stool09x`] = { "isChair" },
    [`p_stool10x`] = { "isChair" },
    [`p_stool12x`] = { "isChair" },
    [`p_stool13x`] = { "isChair" },
    [`p_stool14x`] = { "isChair" },
    [`p_stoolcomfy01x`] = { "isChair" },
    [`p_stoolcomfy02x`] = { "isChair" },
    [`p_stoolfolding01bx`] = { "isChair" },
    [`p_stoolfolding01x`] = { "isChair" },
    [`p_stoolwinter01x`] = { "isChair" },
    [`o_stoolfoldingstatic01x`] = { "isChair" },
    [`p_theaterchair01b01x`] = { "isChair" },
    [`p_windsorchair01x`] = { "isChair" },
    [`p_windsorchair02x`] = { "isChair" },
    [`p_windsorchair03x`] = { "isChair" },
    [`p_woodbench02x`] = { "isChair" },
    [`p_woodendeskchair01x`] = { "isChair" },
    [`s_bench01x`] = { "isChair" },
}

local scenario =
{
    ["isChair"] = "PROP_PLAYER_SEAT_CHAIR_GENERIC",
    ["isChairBenches"] = "PROP_PLAYER_SEAT_CHAIR_DYNAMIC",
}

function checkHasClosestChair(coords)
    local objChair

    for model, flag in pairs(chairs) do
        objChair = GetClosestObjectOfType(coords, 1.8, model, 0, 0, 0)

        if objChair ~= 0 and objChair then
            if not Citizen.InvokeNative(0x083D497D57B7400F, objChair) then
                FreezeEntityPosition(objChair, true)
            end
            SetEntityInvincible(objChair, true)
            return objChair, flag[1]
        end
    end

    return false
end

function playSeatAnim(ped, entity, forceTeleport)
    local heading = GetEntityHeading(ped)
    local coords = GetEntityCoords(ped)

    local objChair, flag = checkHasClosestChair(coords)

    local anim = scenario[flag]

    local chairCoords = nil

    if objChair then
        chairCoords = GetEntityCoords(entity or objChair)
    end

    local chairHeading = GetEntityHeading(entity or objChair)

    Wait(1000)

    local isSeat = false
    forceTeleport = true

    TaskStartScenarioAtPosition(ped, GetHashKey('PROP_PLAYER_SEAT_CHAIR_GENERIC'), chairCoords.x, chairCoords.y,
        chairCoords.z + 0.50, chairHeading - 180, 0, isSeat, forceTeleport or false, 0, false)
end

ClearPedTasksImmediately(PlayerPedId(), -1)
