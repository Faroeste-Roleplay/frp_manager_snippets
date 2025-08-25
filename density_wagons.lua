local densityVeh = 0.2
local dentityPed = 0.5


CreateThread(function()
    while true do
        SetRandomVehicleDensityMultiplierThisFrame( densityVeh )
        SetVehicleDensityMultiplierThisFrame( densityVeh )
        SetScenarioPedDensityMultiplierThisFrame( dentityPed )
        SetAmbientPedDensityMultiplierThisFrame( dentityPed )
        
        SetParkedVehicleDensityMultiplierThisFrame( 0.0 )
        Wait(0)
    end
end)