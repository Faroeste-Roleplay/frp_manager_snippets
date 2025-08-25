


RegisterNetEvent('server.temperatureThirst', function(amount)
    local playerId = source
    cHud.Diminuir(playerId, "thirst", amount)
end)