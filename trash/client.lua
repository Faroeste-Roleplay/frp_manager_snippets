local trash2 = {}
local closestTrash  = nil

local trash = {
    `prop_bin_01a`,
    50927092,
    -1177561480,
}

RegisterNetEvent("FRP:OpenTrashCan")
AddEventHandler(
	"FRP:OpenTrashCan",
	function()
        if not trash2[closestTrash] then
            trash2[closestTrash] = true

            Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_PLAYER_LOOT_WALL_STASH"), -1, true, false, false, false)
            math.randomseed(GetGameTimer())
            TriggerServerEvent("FRP:TRASH:receive")
            
            ClearPedTasks(PlayerPedId())
        else                            
            TriggerEvent('texas:notify:native', "Você já vasculhou este lixo!", 10000)
        end
	end
)

Citizen.CreateThread(function()

    -- Wait(20000)
    
    -- exports['target']:AddTargetModel(trash, {
    --     options = {
    --         {
    --             event = "FRP:OpenTrashCan",
    --             icon = "fas fa-dumpster",
    --             label = "Vasculhar",
    --         },
    --     },
    --     job = {"all"},
    --     distance = 2.5
    -- })
end)

Citizen.CreateThread(function()
    while true do
        local sleepThread = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local x
        for i = 1, #trash do

            if type(trash[i]) == "string" then
                x = Citizen.InvokeNative(0xE143FA2249364369, playerCoords, 2.0, GetHashKey(trash[i]), false, false, false)
            else
                x = Citizen.InvokeNative(0xE143FA2249364369, playerCoords, 2.0, trash[i], false, false, false)
            end

            local entity = nil

            if DoesEntityExist(x) then

                entity = x
                lixo    = GetEntityCoords(entity)

                if DoesEntityExist(entity) <= 2 then
                    closestTrash = entity
                end
                
            end

        end
        Citizen.Wait(sleepThread)
    end
end)

function notify(_message)
	local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
	SetTextScale(0.15, 0.15)
	SetTextCentre(1)
	Citizen.InvokeNative(0xFA233F8FE190514C, str)
	Citizen.InvokeNative(0xE9990552DEC71600)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.25, 0.25)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        DisplayText(str, _x, _y)
        local factor = (string.len(text)) / 225
        --DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
        DrawSprite("feeds", "toast_bg", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 1, 1, 1, 190, 0)
    end
end