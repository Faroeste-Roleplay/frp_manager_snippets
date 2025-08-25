RegisterNetEvent("manager_small_resources:cleanDirt")
AddEventHandler("manager_small_resources:cleanDirt",function()
    local ped   = PlayerPedId()

    Citizen.InvokeNative(0x6585D955A68452A5, ped)
    Citizen.InvokeNative(0x9C720776DAA43E7E, ped)
    Citizen.InvokeNative(0x8FE22675A5A45817, ped)
    Citizen.InvokeNative(0xA7A806677F8DE138, ped)
end)