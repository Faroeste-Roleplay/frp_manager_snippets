
RegisterNetEvent("usableItems:UseTonic")
AddEventHandler("usableItems:UseTonic", function(variation)
	local playerPed = PlayerPedId()

	--[[ Caso sejam 3 goles no máximo, vai curar ~100% da vida. ]]

	local ADD_HEALTH = (GetEntityMaxHealth(playerPed) - 100.0) * variation
	N_0x835f131e7dc8f97a(playerPed, ADD_HEALTH, 0, 0) -- ChangeEntityHealth

	local ADD_CORE_HEALTH = math.floor(GetAttributeCoreValue(playerPed, 0) + (100.0 * variation))
	Citizen.InvokeNative(0xC6258F41D86676E0, playerPed, 0, ADD_CORE_HEALTH)

    local prop = CreateObject(`s_inv_tonic01x`, GetEntityCoords(playerPed), false, true, false, false, true)

    TaskItemInteraction_2(playerPed, `DRINK_BOTTLE`, prop, `PrimaryItem`, `USE_TONIC_SATCHEL_UNARMED_QUICK`, 1, 0, -1.0)
end)

RegisterNetEvent("usableItems:UseTonicPoison")
AddEventHandler("usableItems:UseTonicPoison", function(variation)
	local playerPed = PlayerPedId()

	TriggerEvent("hud:restoreMana", variation)

    local prop = CreateObject(`s_inv_tonic01x`, GetEntityCoords(playerPed), false, true, false, false, true)
    TaskItemInteraction_2(playerPed, `DRINK_BOTTLE`, prop, `PrimaryItem`, `USE_TONIC_SATCHEL_UNARMED_QUICK`, 1, 0, -1.0)
end)