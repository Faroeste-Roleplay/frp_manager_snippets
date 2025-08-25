

local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
local WaterTypes = {
    [1] =  {    ["name"] = "Sea of Coronado",       ["waterhash"] = -247856387,	    ["watertype"] = "lake",    isClear = false    },
    [2] =  {    ["name"] = "San Luis River",        ["waterhash"] = -1504425495,    ["watertype"] = "river",   isClear = true    },
    [3] =  {    ["name"] = "Lake Don Julio",        ["waterhash"] = -1369817450,    ["watertype"] = "lake",    isClear = false    },
    [4] =  {    ["name"] = "Flat Iron Lake",        ["waterhash"] = -1356490953,    ["watertype"] = "lake",    isClear = false    },
    [5] =  {    ["name"] = "Upper Montana River",   ["waterhash"] = -1781130443,    ["watertype"] = "river",   isClear = true    },
    [6] =  {    ["name"] = "Owanjila",              ["waterhash"] = -1300497193,    ["watertype"] = "river",   isClear = true    },
    [7] =  {    ["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360,    ["watertype"] = "river",   isClear = true    },
    [8] =  {    ["name"] = "Little Creek River",    ["waterhash"] = -1410384421,    ["watertype"] = "river",   isClear = true    },
    [9] =  {    ["name"] = "Dakota River",          ["waterhash"] = 370072007, 	    ["watertype"] = "river",   isClear = true    },
    [10] =  {   ["name"] = "Beartooth Beck",        ["waterhash"] = 650214731, 	    ["watertype"] = "river",   isClear = true    },
    [11] =  {   ["name"] = "Lake Isabella",         ["waterhash"] = 592454541, 	    ["watertype"] = "lake",    isClear = false    },
    [12] =  {   ["name"] = "Cattail Pond",          ["waterhash"] = -804804953,     ["watertype"] = "lake",    isClear = false    },
    [13] =  {   ["name"] = "Deadboot Creek",        ["waterhash"] = 1245451421,     ["watertype"] = "river",   isClear = true    },
    [14] =  {   ["name"] = "Spider Gorge",          ["waterhash"] = -218679770,     ["watertype"] = "river",   isClear = true    },
    [15] =  {   ["name"] = "O'Creagh's Run",        ["waterhash"] = -1817904483,    ["watertype"] = "lake",    isClear = false    },
    [16] =  {   ["name"] = "Moonstone Pond",        ["waterhash"] = -811730579,     ["watertype"] = "lake",    isClear = false    },
    [17] =  {   ["name"] = "Roanoke Valley",        ["waterhash"] = -1229593481,    ["watertype"] = "river",   isClear = false    },
    [18] =  {   ["name"] = "Elysian Pool",          ["waterhash"] = -105598602,     ["watertype"] = "lake",    isClear = false    },
    [19] =  {   ["name"] = "Heartland Overflow",    ["waterhash"] = 1755369577,     ["watertype"] = "swamp",   isClear = false    },
    [20] =  {   ["name"] = "Lannahechee River",     ["waterhash"] = -2040708515,    ["watertype"] = "river",   isClear = false    },
    [21] =  {   ["name"] = "Dakota River",          ["waterhash"] = 370072007,      ["watertype"] = "river",   isClear = true    },
    [22] =  {   ["name"] = "Random1",               ["waterhash"] = 231313522,      ["watertype"] = "river",   isClear = true    },
    [23] =  {   ["name"] = "Random2",               ["waterhash"] = 2005774838,     ["watertype"] = "river",   isClear = true    },
    [24] =  {   ["name"] = "Random3",               ["waterhash"] = -1287619521,    ["watertype"] = "river",   isClear = true    },
    [25] =  {   ["name"] = "Random4",               ["waterhash"] = -1308233316,    ["watertype"] = "river",   isClear = true    },
    [26] =  {   ["name"] = "Random5",               ["waterhash"] = -196675805,     ["watertype"] = "river",   isClear = true    },
    [27] =  {   ["name"] = "Lagras",                ["waterhash"] = -557290573,     ["watertype"] = "swamp",   isClear = false   },
}

local playerBusy = false
local playerInWater = false
local gWaterIsClear = false

exports("playerBusy", function()
    return playerBusy
end)

exports("playerInWater", function()
    return playerInWater
end)

exports("gWaterIsClear", function()
    return gWaterIsClear
end)

Citizen.CreateThread(function()
	while true do

		local sleep = 1000

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x+3, coords.y+3, coords.z)
        
        local isInMount = IsPedOnMount(playerPed, true)

        if playerBusy then
            -- PromptSetEnabled(prompt_drink, false)
            -- PromptSetEnabled(prompt_washer, false)
        else
            -- PromptSetEnabled(prompt_drink, true)
            -- PromptSetEnabled(prompt_washer, true)
        end

        local isAim = false

        if IsEntityInWater(playerPed) then
        
            for k,v in pairs(WaterTypes) do

                if water == WaterTypes[k]["waterhash"] then

                    if not isInMount and not playerBusy then
                        sleep = 1

                        
                        if not playerInWater then
                            playerInWater = true

                            createPrompts()

                            local isClear = WaterTypes[k].isClear

                            -- PromptSetVisible(prompt_drink, true)
                            -- PromptSetEnabled(prompt_drink, true)

                            -- local hasCanteen = playerHasItem( "canteen_full", 1)

                            -- PromptSetVisible(prompt_canteen, hasCanteen)
                            -- PromptSetEnabled(prompt_canteen, hasCanteen)
                            
                            -- if isClear then
                            --     PromptSetVisible(prompt_washer, true)
                            --     PromptSetEnabled(prompt_washer, true)
                            -- else
                            --     PromptSetVisible(prompt_washer, false)
                            --     PromptSetEnabled(prompt_washer, false)
                            -- end
                            gWaterIsClear = isClear
                        end

                        -- if PromptHasStandardModeCompleted(prompt_washer) then
                        --     TriggerEvent("banhorio:ok", isClear)
                            
                        -- elseif PromptHasStandardModeCompleted(prompt_drink) then
                        --     TriggerEvent("drp:rio", isClear)
                        -- end

                        -- if PromptHasStandardModeCompleted(prompt_canteen) then
                        --     TriggerEvent("river_actions:item", "canteen_full")
                        -- end

                    end
                end
            end
        else
            if playerInWater then
                playerInWater = false

                -- PromptSetVisible(prompt_washer, false)
                -- PromptSetVisible(prompt_drink, false)
                -- PromptSetVisible(prompt_canteen, false)

                DeleteAllPrompts()
            end
            
		end
		Citizen.Wait(sleep)
	end
end)



AddEventHandler('drp:rio', function( )
	local playerPed = PlayerPedId()

	playerBusy = true

    local scenario = 'WORLD_HUMAN_BUCKET_DRINK_GROUND'

	if not IsPedMale(playerPed) then
        scenario = 'WORLD_HUMAN_GRAVE_MOURNING_KNEEL'
    end

    ClearPedTasks(PlayerPedId())

    TaskStartScenarioInPlace(playerPed, GetHashKey(scenario), -1, true, false, false, false)

    exports.progressbar:DisplayProgressBar(15000, "Bebendo...") 

    -- TriggerEvent("HUD:increaseStress", 1.50)	
    -- TriggerServerEvent("metabolism.vary", 'thirst', -25)

    if not gWaterIsClear then
        local health = GetAttributeCoreValue( playerPed, 0 )
        SetAttributeCoreValue( playerPed, 0, health - 40)
    end

    HudStatus.Aumentar('thirst', 15)

    ClearPedTasks(PlayerPedId())

	playerBusy = false
end)



RegisterNetEvent('banhorio:ok')
AddEventHandler('banhorio:ok', function( )

    playerBusy = true
    
    StartWash("amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l")

    if gWaterIsClear then

        ClearPedEnvDirt(PlayerPedId())
        ClearPedBloodDamage(PlayerPedId())

        N_0xe3144b932dfdff65(PlayerPedId(), 0.0, -1, 1, 1)
        ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
        Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)
    end

end)

StartWash = function(dic, anim)

    LoadAnim(dic)
    TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 10000, 0, 0.0, false, false, false)
    Wait(8000)
    ClearPedTasks(PlayerPedId())

    Citizen.InvokeNative(0x6585D955A68452A5, PlayerPedId())
    Citizen.InvokeNative(0x9C720776DAA43E7E, PlayerPedId())
    Citizen.InvokeNative(0x8FE22675A5A45817, PlayerPedId())

	playerBusy = false

end

LoadAnim = function(dic)
    RequestAnimDict(dic)

    while not (HasAnimDictLoaded(dic)) do
        Citizen.Wait(0)
    end
end

RegisterNetEvent('river_actions:item', function(itemName)
	local coords = GetEntityCoords(PlayerPedId())
    local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)

	for k,v in pairs(WaterTypes) do 
        if Water == WaterTypes[k]["waterhash"]  then
            if IsEntityInWater(PlayerPedId()) and not IsPedOnMount(PlayerPedId(), true) and not bebendo then
				animacao(itemName)
                Wait(4000)
			end
		end
	end
end)

function animacao(itemName)	
	bebendo = true
	local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    if itemName == "canteen_full" then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
        local modelHash = GetHashKey("p_cs_canteen_hercule")
        LoadModel(modelHash)
        entity = CreateObject(modelHash, coords.x, coords.y,coords.z, true, false, false)
        SetEntityVisible(entity, true)
        SetEntityAlpha(entity, 255, false)
        Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
        SetModelAsNoLongerNeeded(modelHash)
        AttachEntityToEntity(entity,ped, boneIndex, 0.12, 0.09, -0.05, 306.0, 18.0, 0.0, false, false, false, true, 2, true)
    end
    local scenarioName = itemName == "canteen_full" and 'WORLD_HUMAN_CROUCH_INSPECT' or 'WORLD_HUMAN_BUCKET_FILL'
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(scenarioName), 10000, true, false, false, false)
	exports.progressbar:DisplayProgressBar(10000,  "Enchendo")
	ClearPedTasksImmediately(PlayerPedId())
    if entity then
        DeleteObject(entity)
        entity = nil
    end
    TriggerServerEvent("river_actions:FillContainersInTheRiver", itemName)
    bebendo = false
end	

function animacao2()	
	bebendo = true
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_FILL'), -1, true, false, false, false)
	exports.progressbar:DisplayProgressBar(10000,  "Enchendo balde")
	ClearPedTasks(PlayerPedId())
    TriggerServerEvent("encherbalde")
    bebendo = false
end	


function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

-- prompts

promptsEnabledBlocked = {}

function createPrompts()    
    -- prompt_drink = newPrompt(`INPUT_PLAYER_MENU`, "Beber Agua", false)
    -- prompt_washer = newPrompt(`INPUT_AIM_IN_AIR`, "Lavar-se", false)
    -- prompt_canteen = newPrompt(`INPUT_PC_FREE_LOOK`, "Encher Cantil", false)
end

function newPrompt(control, text, hold, control_2)
    local prompt = PromptRegisterBegin()
	
    PromptSetControlAction(prompt, control)
	
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))
    PromptSetEnabled(prompt, true)

    PromptSetVisible(prompt, false)

    if not hold then
        PromptSetStandardMode(prompt, 0)
    else
        PromptSetHoldMode(prompt, true)
    end

    PromptRegisterEnd(prompt)

    return prompt
end

function updatePromptText(prompt, text)	
	PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))		
end

function DeleteAllPrompts()
    -- PromptDelete(prompt_drink)
    -- PromptDelete(prompt_canteen)
    -- PromptDelete(prompt_washer)
end


AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteAllPrompts()
    end
end)
