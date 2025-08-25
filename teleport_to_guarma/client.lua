local guarmaActived = false

DoScreenFadeIn(5000)

AddEventHandler('teleport_to_guarma:TalkWithIslandNPC', function()
    TriggerEvent("teleport_to_guarma:teleportPlayerToCity")
end)


AddEventHandler('teleport_to_guarma:TalkWithNPC', function()
    TriggerServerEvent("teleport_to_guarma:checkPlayerHaveMoney")
end)    


RegisterNetEvent('teleport_to_guarma:teleportPlayerToGuarma')
AddEventHandler('teleport_to_guarma:teleportPlayerToGuarma', function()	
    local coordsToTeleport = vec3(1269.55, -6854.188, 43.318)

	DoScreenFadeOut(2000)

    Wait(2000)

	local ped = PlayerPedId()    
	SetEntityCoords(ped, coordsToTeleport)
	checkIsCollisionReady(coordsToTeleport)

	DoScreenFadeIn(5000)

    ToogleGuarmaMap(true)
end)

RegisterNetEvent('teleport_to_newaustin:TalkWithIslandNPC')
AddEventHandler('teleport_to_newaustin:TalkWithIslandNPC', function()	
    local coordsToTeleport = vec3(-2019.9047, -3039.7463, -11.3393)

	DoScreenFadeOut(2000)

    Wait(2000)

	local ped = PlayerPedId()    
	SetEntityCoords(ped, coordsToTeleport)
	checkIsCollisionReady(coordsToTeleport)

	DoScreenFadeIn(5000)

    ToogleGuarmaMap(true)
end)


RegisterNetEvent('teleport_to_guarma:teleportPlayerToCity')
AddEventHandler('teleport_to_guarma:teleportPlayerToCity', function()
    local coordsToTeleport = vec3(2797.23, -1498.93, 42.53)

	DoScreenFadeOut(2000)

    Wait(2000)

	local ped = PlayerPedId()    
	SetEntityCoords(ped, coordsToTeleport)
	checkIsCollisionReady(coordsToTeleport)

	DoScreenFadeIn(5000)

    ToogleGuarmaMap(false)
end)


function ToogleGuarmaMap(isActived)
    guarmaActived = isActived or not guarmaActived
    local zoneHashMinimap
    
    if guarmaActived then
        zoneHashMinimap = 1935063277
    else
        zoneHashMinimap = -1868977180
    end

	Citizen.InvokeNative(0xA657EC9DBC6CC900, zoneHashMinimap) --natiivi guarmaworld
    Citizen.InvokeNative(0xE8770EE02AEE45C2, guarmaActived) --natiivi guarmawatertype
	Citizen.InvokeNative(0x74E2261D2A66849A, guarmaActived) --natiivi SetGuarmaWorldhorizonActive
end


function checkIsCollisionReady(coords)
    while not Citizen.InvokeNative(0xDA8B2EAF29E872E2, coords) do
        Wait(100)
    end
end


CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords( playerPed )

        local stateHash = Citizen.InvokeNative(0x43AD8FC02B429D33, playerCoords, 10)
        local isInGuarma = stateHash == -512529193

        if isInGuarma then -- 
            if not guarmaActived then
                ToogleGuarmaMap( true )
            end 
        end

        if not isInGuarma then
            if guarmaActived then
                ToogleGuarmaMap( false )
            end
        end

        Wait(5000)
    end
end)