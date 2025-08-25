local coordsToPosition = {
    { label = "Olhar", coords = vector3(2089.11, -1814.85, 42.86), toPosition = vector3(3477.61, -2407.24, 58.24) },
    { label = "Acessar", coords = vector3(829.87, 1923.41, 259.35), toPosition = vector3(-1859.68, 2657.76, 582.53) },
    { label = "Acessar", coords = vector3(-873.4102, -1647.2310, 66.0843), toPosition = vector3(-1860.69, -1729.64, 89.23) },
}

local teleports = {}

CreateThread(function()
    for _, teleport in pairs(coordsToPosition) do

        local targetId = exports.ox_target:addSphereZone(
            {
                coords = teleport.coords,
                name = "Acessar",
                radius = 1,
                drawSprite = true,
                options = {
                    {
                        name = 'peek_1',
                        label = teleport.label,
                        distance = 2,
                        onSelect = function()
                            cAPI.TeleportPlayerWithGroundZ(teleport.toPosition)
                        end
                    },
                }
            }
        )
        table.insert(teleports, targetId)
        
        local targetId2 = exports.ox_target:addSphereZone(
            {
                coords = teleport.toPosition,
                name = "Acessar",
                radius = 1,
                drawSprite = true,
                options = {
                    {
                        name = 'peek_2',
                        label = "Interagir",
                        distance = 2,
                        onSelect = function()
                            cAPI.TeleportPlayerWithGroundZ(teleport.coords)
                        end
                    },
                }
            }
        )

        table.insert(teleports, targetId2)
    end
end)


AddEventHandler("onResourceStop", function( resName )
    if resName == GetCurrentResourceName() then
        for _, targetId in pairs( teleports ) do
            exports.ox_target:removeZone( targetId )
        end
    end
end)