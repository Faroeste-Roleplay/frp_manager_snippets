local handsup = false

local mugging = nil

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if handsup then
            DisableControlAction(0, `INPUT_QUICK_USE_ITEM`)

            if mugging then

                local muggingCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(mugging)))
                local playerCoords = GetEntityCoords(PlayerPedId())

                if #(muggingCoords - playerCoords) >= 1.5 then
                    TriggerServerEvent("inventory:server:closeMugging", mugging)
                    mugging = nil
                end
            end
        else            
    
        end
    end
end)


local isPointing = false
local lastPointAngle = -90;


Citizen.CreateThread(function()
    while true do 
        local playerPed = PlayerPedId()

        if IsControlPressed(0, 0x4CC0E2FE) then
            
            if not isPointing then
                isPointing = true
            end

        elseif isPointing then
            isPointing = false
            lastPointAngle = -90
            ClearPedTasks(playerPed)
        end

        if isPointing then
            local camHeading = GetGameplayCamRelativeHeading()
            if camHeading < -180 then
                camHeading = -180
            elseif camHeading > 180 then
                camHeading = 180
            end

            camHeading = camHeading + 360;

            camHeading = 360 - (camHeading % 360);

            local newPointAngle = math.floor( camHeading / 45) * 45

            if lastPointAngle ~= newPointAngle then

                lastPointAngle = newPointAngle

                local dict = "ai_react@point@witness"

                RequestAnimDict(dict)    

                while not HasAnimDictLoaded(dict)  do 
                    Citizen.Wait(100)
                end

                local anim = newPointAngle .. "_loop"                
                
                TaskPlayAnim(playerPed, dict, anim, 2.0, -2.0, -1, 31, 0, true, 0, false, 0, false)
            end
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent("receiveMugging")
AddEventHandler("receiveMugging",  function(pid)   
    mugging = pid   
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if handsup and not IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
            SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
            DisablePlayerFiring(ped, true)
            TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 2.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
            -- exports['nxt-flags']:SetPedFlag(PlayerPedId(), 'isHandsUp', true)
            handsup = true
        end

        if (IsControlJustPressed(0,0x8CC9CD42))  then
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then  
                RequestAnimDict( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" )    
                while ( not HasAnimDictLoaded( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" ) ) do 
                    Citizen.Wait( 100 )
                end

                if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
                    DisablePlayerFiring(ped, true)
                    ClearPedSecondaryTask(ped)

                    if mugging then
                        TriggerServerEvent("inventory:server:closeMugging", mugging)
                        mugging = nil
                    end
                    
                    -- exports['nxt-flags']:SetPedFlag(PlayerPedId(), 'isHandsUp', false)

                    handsup = false
                else;
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
                    DisablePlayerFiring(ped, true)
                    TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 2.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
                    -- exports['nxt-flags']:SetPedFlag(PlayerPedId(), 'isHandsUp', true)
                    handsup = true
                end
            end
        end
    end
end)


local muggablePlayer

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            local nearestPlayer, distancePlayer = GetClosestPlayer()
            if nearestPlayer ~= nil then
                -- print('tem um jogador aqui ', nearestPlayer)
                if IsEntityPlayingAnim(nearestPlayer, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) and distancePlayer <= 1.5 then
                    -- print('mãos levantadas')
                    muggablePlayer = nearestPlayer
                else
                    muggablePlayer = nil
                end
            else
                muggablePlayer = nil
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local prompt = PromptRegisterBegin()
        local promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0xCEFD9220)
        local str = CreateVarString(10, 'LITERAL_STRING', 'Assaltar')
        PromptSetText(prompt, str)
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetHoldMode(prompt, 1)

        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)
        while true do
            Citizen.Wait(0)

            if muggablePlayer ~= nil then
                if not IsEntityDead(muggablePlayer) then

                    local promptGroupName = CreateVarString(10, 'LITERAL_STRING', GetPlayerName(muggablePlayer))
                    PromptSetActiveGroupThisFrame(promptGroup, promptGroupName)
                    if PromptHasHoldModeCompleted(prompt) then
                        Citizen.Wait(1000)
                        -- ExecuteCommand('revistar')
                        -- local playerId = GetPlayerServerId(muggablePlayer)                        
                        -- TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                        -- TriggerServerEvent("mugging:server:SearchPlayer", playerId)
                    end
                end
            end
        end
    end
)


function GetPlayers()
	local players = {}

	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end
	return players
end

function GetClosestPlayer()
	local players, closestDistance, closestPlayer = GetPlayers(), -1, -1

	local coords, usePlayerPed = coords, false
	local playerPed, playerId = PlayerPedId(), PlayerId()

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end
	for i = 1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance = #(coords - targetCoords)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end
