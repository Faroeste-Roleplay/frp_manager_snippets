RegisterNetEvent('devtools:abriu')
AddEventHandler('devtools:abriu', function()
    local _source = source

    lib.logger(_source, "devtools", ("Abriu o dev tools %s %s"):format(GetPlayerName(_source), _source))

    if API.IsPlayerAceAllowedGroup(_source,  "admin") then
        return
    end

    DropPlayer(_source, "Você foi expulso do servidor. Motivo: Tentar Abrir Dev Tools")
end)