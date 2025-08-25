



API = Proxy.getInterface("API")

libClient = Tunnel.getInterface("lib")
cAPI = Tunnel.getInterface("API")
cHud = Tunnel.getInterface("frp_hud")


function calculateWeightTable(items)
    local totalWeight = 0
    for _, item in ipairs(items) do
        totalWeight = totalWeight + item.chance
        item.accumulatedWeight = totalWeight
    end
    return totalWeight
end

function drawItem(items)
    local totalWeight = calculateWeightTable(items)
    local randomNumber = math.random(1, totalWeight)

    for _, item in ipairs(items) do
        if randomNumber <= item.accumulatedWeight then
            return item.name
        end
    end
end


local MapaDeBaloes = {} --formato: { [netIdDoBalao] = { capitao = idJogador, ... } }

-- nomes padrão dos assentos, para evitar repetição
local NOMES_DOS_ASSENTOS = {"capitao", "passageiro1", "passageiro2", "passageiro3", "passageiro4"}

-- sistema de Log para depuração no lado do servidor
local LoggerServidor = {
    ativo = false,
    nivel = 3, -- INFO
    prefixo = "[BalaoServidor]",
    Registrar = function(self, nivel, mensagem)
        if not self.ativo or nivel > self.nivel then return end
        local niveisStr = {"[OFF]", "[ERRO]", "[AVISO]", "[INFO]", "[DEBUG]"}
        print(self.prefixo .. " " .. niveisStr[nivel + 1] .. " " .. tostring(mensagem))
    end
}


-- garantir que um balão esteja registrado na nossa tabela de controle
local function GarantirRegistroDoBalao(netId)
    if not MapaDeBaloes[netId] then
        MapaDeBaloes[netId] = {}
        for _, nomeAssento in ipairs(NOMES_DOS_ASSENTOS) do
            MapaDeBaloes[netId][nomeAssento] = nil
        end
        LoggerServidor:Registrar(4, "Novo balão registrado para rastreamento: " .. netId)
    end
end

-- se um jogador já esta em um assento, remove ele antes de colocar em um novo
local function LimparAssentoAntigoDoJogador(netId, idJogador)
    for _, nomeAssento in ipairs(NOMES_DOS_ASSENTOS) do
        if MapaDeBaloes[netId][nomeAssento] == idJogador then
            LoggerServidor:Registrar(2, "Jogador " .. idJogador .. " já estava no assento " .. nomeAssento .. ". Removendo.")
            MapaDeBaloes[netId][nomeAssento] = nil
            TriggerClientEvent("balloon:seatUpdate", -1, netId, nomeAssento, idJogador, false)
            return 
        end
    end
end

local function TransmitirAtualizacaoDeAssento(netId, nomeAssento, idJogador, ocupado)
    TriggerClientEvent("balloon:seatUpdate", -1, netId, nomeAssento, idJogador, ocupado)
end

RegisterNetEvent("balloon:requestEnterSeat", function(netId, tipoDeAssento, idJogador)
    local idFonte = source
    if idJogador ~= idFonte then
        LoggerServidor:Registrar(1, "Incompatibilidade de IDs! Evento de " .. idFonte .. " para " .. idJogador .. ". Negado.")
        return
    end

    LoggerServidor:Registrar(3, "Jogador " .. idFonte .. " pediu para sentar em " .. tipoDeAssento .. " no balão " .. netId)
    GarantirRegistroDoBalao(netId)

    if not MapaDeBaloes[netId][tipoDeAssento] then
        LimparAssentoAntigoDoJogador(netId, idFonte)
        
        MapaDeBaloes[netId][tipoDeAssento] = idFonte
        LoggerServidor:Registrar(3, "Assento " .. tipoDeAssento .. " alocado para o jogador " .. idFonte)
        
        TriggerClientEvent("balloon:seatConfirmed", idFonte, netId, tipoDeAssento, idFonte)
        TransmitirAtualizacaoDeAssento(netId, tipoDeAssento, idFonte, true)
    else
        LoggerServidor:Registrar(2, "Pedido negado. Assento " .. tipoDeAssento .. " já ocupado por " .. MapaDeBaloes[netId][tipoDeAssento])
        TriggerClientEvent("balloon:seatDenied", idFonte, "Este assento já está ocupado.")
    end
end)

RegisterNetEvent("balloon:vacateSeat", function(netId, tipoDeAssento)
    local idFonte = source
    if not netId then return end

    GarantirRegistroDoBalao(netId)
    LoggerServidor:Registrar(3, "Jogador " .. idFonte .. " está desocupando o assento " .. tipoDeAssento)

    if MapaDeBaloes[netId][tipoDeAssento] == idFonte then
        MapaDeBaloes[netId][tipoDeAssento] = nil
        TransmitirAtualizacaoDeAssento(netId, tipoDeAssento, idFonte, false)
    else
        LoggerServidor:Registrar(2, "Jogador " .. idFonte .. " tentou desocupar um assento que não era dele.")
    end
end)

RegisterNetEvent("balloon:captainEntered", function(netId, idCapitao)
    local idFonte = source
    if idCapitao ~= idFonte then return end

    GarantirRegistroDoBalao(netId)
    LoggerServidor:Registrar(3, "Jogador " .. idFonte .. " virou capitão do balão " .. netId)
    
    LimparAssentoAntigoDoJogador(netId, idFonte)

    MapaDeBaloes[netId].captain = idFonte
    TransmitirAtualizacaoDeAssento(netId, "captain", idFonte, true)
end)

RegisterNetEvent("balloon:captainExited", function(netId, idCapitao)
    local idFonte = source
    if idCapitao ~= idFonte then return end

    GarantirRegistroDoBalao(netId)
    LoggerServidor:Registrar(3, "Jogador " .. idFonte .. " deixou de ser capitão do balão " .. netId)

    if MapaDeBaloes[netId].captain == idFonte then
        MapaDeBaloes[netId].captain = nil
        TransmitirAtualizacaoDeAssento(netId, "captain", idFonte, false)
    end
end)

AddEventHandler("playerDropped", function(motivo)
    local idJogadorQueSaiu = source
    LoggerServidor:Registrar(3, "Jogador " .. idJogadorQueSaiu .. " ("..GetPlayerName(idJogadorQueSaiu)..") desconectou. Verificando assentos...")
    
    for netId, assentos in pairs(MapaDeBaloes) do
        for nomeAssento, idOcupante in pairs(assentos) do
            if idOcupante == idJogadorQueSaiu then
                LoggerServidor:Registrar(3, "Limpando assento " .. nomeAssento .. " no balão " .. netId)
                MapaDeBaloes[netId][nomeAssento] = nil
                TransmitirAtualizacaoDeAssento(netId, nomeAssento, idJogadorQueSaiu, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(240000) -- a cada 4 minutos

        local baloesParaRemover = {}
        for netId, assentos in pairs(MapaDeBaloes) do
            local estaVazio = true
            for _, idOcupante in pairs(assentos) do
                if idOcupante then
                    estaVazio = false
                    break
                end
            end
            if estaVazio then
                table.insert(baloesParaRemover, netId)
            end
        end

        if #baloesParaRemover > 0 then
            LoggerServidor:Registrar(4, "Limpando " .. #baloesParaRemover .. " balões vazios da memória.")
            for _, netId in ipairs(baloesParaRemover) do
                MapaDeBaloes[netId] = nil
            end
        end
    end
end)


RegisterCommand("balloon_server_status", function(idFonte, args, raw)
    if IsPlayerAceAllowed(idFonte, "group.admin") then
        LoggerServidor:Registrar(3, "--- Status dos Balões no Servidor ---")
        print("--- Status dos Balões no Servidor ---")

        if not next(MapaDeBaloes) then
            print("Nenhum balão está sendo rastreado no momento.")
            return
        end

        for netId, assentos in pairs(MapaDeBaloes) do
            print("Balão NetID: " .. netId)
            for nomeAssento, idOcupante in pairs(assentos) do
                local infoOcupante = "Vazio"
                if idOcupante then
                    infoOcupante = "Ocupado por: " .. GetPlayerName(idOcupante) .. " (ID: " .. idOcupante .. ")"
                end
                print("  -> Assento [" .. nomeAssento .. "]: " .. infoOcupante)
            end
        end
    end
end, false)