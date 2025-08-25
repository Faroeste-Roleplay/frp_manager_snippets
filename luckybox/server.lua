---- Kit Streamer
--- Repeater Henry = 1
--- Tonico Super = 3

--- Kit Booster 
--- dkkd
--- 

local weaponsList = {
    initial_weapon_box = {
        {name = "weapon_revolver_cattleman", chance = 10},
        {name = "weapon_revolver_doubleaction", chance = 11},
        {name = "weapon_pistol_semiauto", chance = 12},
        {name = "weapon_repeater_carbine", chance = 20},
        {name = "weapon_repeater_henry", chance = 20},
        {name = "weapon_melee_knife", chance = 9},
    },
    medium_weapon_box = {
        {name = "weapon_revolver_lemat", chance = 10},
        {name = "weapon_pistol_mauser", chance = 11},
        {name = "weapon_pistol_m1899", chance = 12},
        {name = "weapon_repeater_evans", chance = 11},
        {name = "WEAPON_REPEATER_WINCHESTER", chance = 30},
        {name = "WEAPON_SHOTGUN_DOUBLEBARREL", chance = 2},
        {name = "WEAPON_MELEE_KNIFE_VAMPIRE", chance = 1},
    },
    elite_weapon_box = {
        {name = "WEAPON_REVOLVER_NAVY", chance = 30},
        {name = "WEAPON_REVOLVER_NAVY_CROSSOVER", chance = 29},
        {name = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK", chance = 10},
        {name = "WEAPON_SHOTGUN_SAWEDOFF", chance = 9},
        {name = "WEAPON_MELEE_KNIFE_JAWBONE", chance = 11},
    }
}

LuckyItems = {
    { amount = 3, item = 'tonic_potent_miracle' },
    { amount = 3, item = 'tonic_potent_cure' },

    { amount = 5, item = 'bread' },
    { amount = 5, item = 'water' },

    { amount = 2, item = 'colacola' },
    { amount = 2, item = 'consumable_chocolate' },
    { amount = 2, item = 'consumable_candycanes' },
}

local CONST_INITIAL_MONEY = 20.00

local StandardItems = {
    { amount = 1, item = 'compass' },
    { amount = 1, item = 'WEAPON_LASSO' },
    { amount = 1, item = 'WEAPON_MELEE_KNIFE' },
}

RegisterServerEvent('inventory:item:OpenLuckyBox', function()
    local playerId = source
	local lucky = exports.ox_inventory:GetItem(playerId, 'luckybox', nil, true)

	if lucky >= 1 then
		for i = 1, math.random(3, 7) do
			local item = LuckyItems[math.random(1, #LuckyItems)]
            exports.ox_inventory:AddItem(playerId, item.item, item.amount)
		end

        for _, item in pairs( StandardItems ) do 
            exports.ox_inventory:AddItem(playerId, item.item, item.amount)
        end

		exports.ox_inventory:RemoveItem(playerId, 'luckybox', 1)
	end

	exports.ox_inventory:AddItem(playerId, 'money', CONST_INITIAL_MONEY)
end)

RegisterServerEvent('inventory:item:openWeaponBox', function( weaponBoxItem )
    local playerId = source
	local hasBox = exports.ox_inventory:GetItem(playerId, weaponBoxItem, nil, true)

    local wepList = weaponsList[weaponBoxItem]

	if hasBox >= 1 and wepList then
        local randomItem = drawItem(wepList)

        exports.ox_inventory:AddItem(playerId, randomItem, 1)
        exports.ox_inventory:RemoveItem(playerId, weaponBoxItem, 1)

        lib.logger(playerId, 'luckyBox', ('Ganhou na caixa(%s) - %sx %s - executor %s %s'):format(weaponBoxItem, 1, randomItem, GetPlayerName(playerId), playerId))
	end
end)