ItemsList = nil



RegisterServerEvent("FRP:TRASH:receive")
AddEventHandler("FRP:TRASH:receive", function()	
	local playerId = source

	if not ItemsList then
		ItemsList = exports.ox_inventory:Items()
	end

	math.randomseed(os.time())
    local sort = math.random(0, 102)
    local qtd = math.random(1, 3)

	local item

    if sort >= 0 and sort <= 5 then 
		item = 'ammo_revolver'
		
    elseif sort >=6 and sort <=13 then
		item = 'ferro'

    elseif sort >=14 and sort <=29 then
		item = 'corn'

    elseif sort >=30 and sort <=50 then
		item = 'hay'

    elseif sort >=51 and sort <=62 then
		item = 'madeira'

    elseif sort >=63 and sort <=74 then
		item = 'pedra'

    elseif sort >=75 and sort <=84 then				
		item = 'stick'

    elseif sort >=85 and sort <=92 then			
		item = 'opio'

    elseif sort >=93 and sort <=102 then	
		item = 'cerveja'
    end

	exports.ox_inventory:AddItem(playerId, item, qtd)

	cAPI.Notify(playerId, "success", "Você encontrou ".. qtd .."x de ".. ItemsList[item].label , 10000)
end)