

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")
Inventory = Tunnel.getInterface("inventory")

clientT = {}

Tunnel.bindInterface("lib", clientT)

HudStatus = Proxy.getInterface("frp_hud")

function playerHasItem( item, amount)
    local playerId = GetPlayerServerId(PlayerId())
    local itemCount = Inventory.GetItem(playerId, item, nil, true)
    
    return itemCount >= ( amount or 1 )
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        Citizen.InvokeNative(0xD66A941F401E7302, 3)
    end
end)