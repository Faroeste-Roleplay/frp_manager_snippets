RegisterServerEvent("CAMPFIRE:Server:GiveCampfireToPlayer")
AddEventHandler('CAMPFIRE:Server:GiveCampfireToPlayer', function(campfire)
    local playerId = source
    
    if campfire == "p_campfire01x_nofire" then
        exports.ox_inventory:AddItem(playerId, 'campfiremed', 1)    
    elseif campfire == "p_campfire03x" then
        exports.ox_inventory:AddItem(playerId, 'campfiresmall', 1)    
    end
end)

RegisterNetEvent('CAMPFIRE:Server:RewardSpecial', function()
    local playerId = source
    exports.ox_inventory:AddItem(playerId, "ancestral_plant", math.random(4, 5))
end)

RegisterServerEvent("CAMPFIRE:Server:RewardWoodlog")
AddEventHandler('CAMPFIRE:Server:RewardWoodlog', function()
    local playerId = source

    exports.ox_inventory:AddItem(playerId, "wood_stick", math.random(2, 5))
end)  

RegisterServerEvent("Orange:Server:RewardOrange")
AddEventHandler('Orange:Server:RewardOrange', function()
    local playerId = source

    math.randomseed(os.time())
    exports.ox_inventory:AddItem(playerId, "orange", math.random(2, 5))
end)  

-- Citizen.CreateThread(function()

--     Wait(5000)

--     Inventory.Functions.CreateUseableItem('campfiremed', function(source, item)    

--         TriggerClientEvent('CAMPFIRE:Client:SpawnCampfire', source, "p_campfire01x")
        
--         exports.ox_inventory:RemoveItem(source, 'campfiremed', 1)    
--     end)

--     Inventory.Functions.CreateUseableItem('campfiresmall', function(source, item)    
--         local Player = Inventory.Functions.GetPlayer(source)

--         TriggerClientEvent('CAMPFIRE:Client:SpawnCampfire', source, "p_campfire03x")
        
--         Player.RemoveItem('campfiresmall', 1)
--     end)

--     -- Inventory.Functions.CreateUseableItem('pinheiro', function(source, item)    
--     --     local Player = Inventory.Functions.GetPlayer(source)
        
--     --     local Item = Player.GetItemByName("weapon_melee_hatchet")

--     --     if Item then    
--     --         TriggerClientEvent("CAMPFIRE:Client:CutWoodlog", source)
--     --         Player.RemoveItem("pinheiro", 1)
--     --     else
--     --         TriggerClientEvent("texas:notify:native", source, "Você precisa ter um Machadinho para cortar a madeira", 4000)
--     --     end    
--     -- end)

--     -- Inventory.Functions.CreateUseableItem('madeira', function(source, item)    
--     --     local Player = Inventory.Functions.GetPlayer(source)
        
--     --     local Item = Player.GetItemByName("weapon_melee_hatchet")

--     --     if Item then    
--     --         TriggerClientEvent("CAMPFIRE:Client:CutWoodlog", source)
--     --         Player.RemoveItem("madeira", 1)
--     --     else
--     --         TriggerClientEvent("texas:notify:native", source, "Você precisa ter um Machadinho para cortar a madeira", 4000)
--     --     end
--     -- end)
-- end)

