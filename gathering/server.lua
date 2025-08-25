

local AnimalModelToItem = {
	-- PASSAROS
	[`A_C_Bat_01`] =				{ "provision_bat_wing", "stringy_meat" },

	[`A_C_Oriole_01`] =				{ "gamey_meat" },
	[`A_C_Parrot_01`] =				{ "provision_parrot_feather", "exotic_meat" },

	[`A_C_Turkey_01`] =				{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_Turkey_02`] =				{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_TurkeyWild_01`] =			{ "generic_animal_feather_large", "gamey_meat" },

    [`A_C_SongBird_01`] =			{ "generic_animal_feather_small", "gamey_meat" },
    [`A_C_Woodpecker_01`] =			{ "gamey_meat" },
    [`A_C_Woodpecker_02`] =			{ "gamey_meat" },
	[`A_C_BlueJay_01`] =			{ "provision_bird_feather_flight", "gamey_meat" },
	[`A_C_Cardinal_01`] =			{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_Egret_01`] =				{ "generic_animal_feather_small",  "gamey_meat" },
	[`A_C_CarolinaParakeet_01`] =	{ "exotic_meat", "provision_bird_feather_flight" },
	[`A_C_Crow_01`] =				{ "provision_crow_feather", "gamey_meat" },
	[`A_C_Raven_01`] =				{ "provision_raven_claw","provision_raven_feather",  "gamey_meat" },
	[`A_C_Loon_01`] =				{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_Owl_01`] =				{ "provision_owl_feather", "gamey_meat" },
	[`A_C_CraneWhooping_01`] =		{ "generic_animal_feather_small",  "gamey_meat" },
	[`A_C_Vulture_01`] =			{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_Eagle_01`] =				{ "generic_animal_feather_large", "gamey_meat" },
	[`A_C_Quail_01`] =				{ "generic_animal_feather_small", "game_meat" },
	[`A_C_Pheasant_01`] =			{ "generic_animal_feather_large", "game_meat" },
	[`A_C_Duck_01`] =				{ "generic_animal_feather_small", "game_meat" },
	[`A_C_GooseCanada_01`] =		{ "generic_animal_feather_small", "plump_meat"  },
	[`A_C_Heron_01`] =				{ "feathers_plume", "gamey_meat" },
	[`A_C_CaliforniaCondor_01`] =	{ "generic_animal_feather_large", "gamey_meat" },
	[`A_C_Hawk_01`] =				{ "provision_hawk_feather", "gamey_meat"  },
	[`A_C_Chicken_01`] =			{ "generic_animal_feather_small", "plump_meat" },	
	[`A_C_PrairieChicken_01`] =		{ "generic_animal_feather_small", "plump_meat" },
	[`A_C_Cormorant_01`] =			{ "generic_animal_feather_small",  "gamey_meat" },
	[`A_C_Pelican_01`] =			{ "provision_pelican_feather", "exotic_meat" },
	[`A_C_Seagull_01`] =			{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_RoseateSpoonbill_01`] =	{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_Rooster_01`] =			{ "generic_animal_feather_small", "plump_meat" },
	[`A_C_RedFootedBooby_01`] =		{ "provision_booby_feather", "gamey_meat" },
	[`A_C_Pigeon`] = 				{ "gamey_meat", "provision_bird_feather_flight" },

	-- COBRAS
	[`A_C_Snake_01`] = 						{ "provision_snake_skin", "stringy_meat" },
	[`A_C_Snake_Pelt_01`] = 				{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeBlackTailRattle_01`] = 		{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeBlackTailRattle_Pelt_01`] = 	{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeFerDeLance_01`] = 			{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeFerDeLance_Pelt_01`] = 		{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeRedBoa_01`] = 				{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeRedBoa_Pelt_01`] = 			{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeRedBoa10ft_01`] = 			{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeWater_01`] = 				{ "provision_snake_skin", "stringy_meat" },
	[`A_C_SnakeWater_Pelt_01`] = 			{ "provision_snake_skin", "stringy_meat" },

	-- ANIMAIS PEQUENOS -- Couro
	[`A_C_CedarWaxwing_01`] =				{ "gamey_meat" },
	[`A_C_Chipmunk_01`] =					{ "small_leather", "stringy_meat" },
	[`A_C_Crab_01`] =					 	{ "small_leather", "crustacean_meat" },
	[`A_C_Rat_01`] =					 	{ "stringy_meat_poor" },
	[`A_C_Rabbit_01`] =					 	{ "provision_rabbit_pelt", " " },
	[`A_C_Squirrel_01`] =					{ "provision_squirrel_tooth", "provision_squirrel_tail", "provision_squirrel_pelt" },
	[`A_C_Skunk_01`] =					 	{ "provision_skunk_fur", "stringy_meat" },

	-- ANIMAIS GRANDES -- Couro
	[`A_C_Armadillo_01`] = 					{ "provision_armadillo_skin",  "stringy_meat"},
	[`A_C_Badger_01`] =					 	{ "provision_badger_pelt", "animal_claw" },

	[`A_C_GilaMonster_01`] = 				{ "herptile_meat" },
	[`A_C_Muskrat_01`] = 					{ "provision_muskrat_fur", "provision_muskrat_scentgland", "stringy_meat" },
	[`A_C_Iguana_01`] = 					{ "provision_iguana_skin", "herptile_meat" },
	[`A_C_IguanaDesert_01`] = 				{ "provision_iguana_skin", "herptile_meat" },

	-- ANIMAIS GRANDES -- Chifre
	-- ANIMAIS GRANDES -- Gordura

	[`A_C_FrogBull_01`] =    				{ "herptile_meat", "provision_frog_skin" },
	[`A_C_Toad_01`] =    					{ "herptile_meat" },
	[`A_C_Possum_01`] =    					{ "provision_opossum_fur", "stringy_meat" },
	[`A_C_Raccoon_01`] =    				{ "provision_raccoon_fur", "stringy_meat" },
	[`A_C_Robin_01`] =    					{ "generic_animal_feather_small", "gamey_meat" },
	[`A_C_Sparrow_01`] =    				{ "generic_animal_feather_small", "gamey_meat" },


	[`A_C_Cow`] = 							{ "prime_meat" },
	[`A_C_Bull_01`] = 						{ "animal_fat", "prime_meat", "provision_bull_horns" },
	[`A_C_Ox_01`] = 						{ "prime_meat", "animal_horn" },
	[`A_C_Buffalo_01`] =    				{ "provision_buffalo_horn", "prime_meat" },

	[`A_C_BearBlack_01`] = 					{ "animal_fat", "animal_claw", "big_meat" },
	[`A_C_Bear_01`] = 						{ "animal_fat", "animal_claw", "big_meat" },
	[`A_C_Beaver_01`] = 					{ "animal_fat", "provision_beaver_scentgland"},
	
	
	[`A_C_Javelina_01`] =    				{ "animal_fat", "provision_javelina_tusk", "tender_meat" },
	[`A_C_BoarLegendary_01`] =    			{ "animal_fat", "provision_boar_tusk", "tender_meat"  },
	[`A_C_Boar_01`] = 						{ "animal_fat", "provision_boar_tusk", "tender_meat" },	
	[`A_C_Pig_01`] = 						{ "animal_fat", "tender_meat" },

	[`A_C_TurtleSnapping_01`] =				{ "herptile_meat" },

	[`A_C_Coyote_01`] = 					{ "stringy_meat", "provision_coyote_fang" },
	[`A_C_Fox_01`] = 						{ "stringy_meat" },
	
	[`MP_A_C_BUFFALO_01`] = 				{ "provision_buffalo_horn", "big_meat" },
	[`A_C_Buffalo_Tatanka_01`] = 			{ "provision_buffalo_horn", "big_meat" },

	[`A_C_Wolf`] = 							{ "provision_wolf_heart", "big_meat" },
	[`A_C_Wolf_Medium`] = 					{ "provision_wolf_heart", "big_meat" },
	[`A_C_Wolf_Small`] = 					{ "provision_wolf_heart", "big_meat" },

	-- ANIMAIS GRANDES -- Dente
	[`A_C_Alligator_01`] = 					{ "alligator_tooth", "big_meat", "provision_alligator_skin" },
	[`A_C_Alligator_02`] = 					{ "alligator_tooth", "big_meat", "provision_alligator_skin" },
	[`A_C_Alligator_03`] = 					{ "alligator_tooth", "big_meat", "provision_alligator_skin" },

	-- ANIMAIS GRANDES -- Pata
	[`A_C_Cougar_03`] = 					{ "provision_cougar_fang", "provision_cougar_claw", "big_meat" },
	[`A_C_Panther_01`] =					{ "provision_panther_eye", "provision_panther_heart", "big_meat" },
	-- ANIMAIS GRANDE - galhada
	[`A_C_Moose_01`] = 						{ "mature_meat" },
	[`A_C_Buck_01`] = 						{ "provision_buck_antlers",	"mature_meat" },
	[`A_C_Elk_01`] = 						{ "provision_elk_antlers", "mature_meat" },
	[`MP_A_C_ELK_01`] = 					{ "mature_meat" },	
	
	[`A_C_Deer_01`] = 						{ "mature_meat", "provision_deer_pelt" },	
	[`A_C_Pronghorn_01`] = 					{ "animal_fat", "mature_meat" },
	[`MP_A_C_PRONGHORN_01`] = 				{ "animal_fat", "mature_meat" },
	[`MP_A_C_RAM_01`] = 					{ "provision_ram_horn", "mature_meat" },

	[`A_C_Goat_01`] = 						{ "gristly_meat" },
	-- ANIMAIS GRANDES -- Chifre Bode
	[`A_C_BigHornRam_01`] = 				{ "provision_ram_horn", "gristly_meat" },	
	-- [`A_C_BigHornRam_01`] = 				{ "provision_ram_horn", "gristly_meat" },
	[`MP_A_C_BIGHORNRAM_01`] = 				{ "provision_ram_horn", "gristly_meat" },
	-- ANIMAIS GRANDES -- LÃ OVELHA
	[`A_C_Sheep_01`] = 						{ "sheep_wool", "gristly_meat" },
	[`MP_A_C_SHEEP_01`] = 					{ "sheep_wool", "gristly_meat" },	
}

RegisterNetEvent("GATHERING:Gathered")
AddEventHandler("GATHERING:Gathered",function(entityModelHash, isHuman, entityQuality)
    local playerId = source

    if playerId then
		if not isHuman then

			if AnimalModelToItem[entityModelHash] then
				local items = AnimalModelToItem[entityModelHash]

				for i = 1, #items do

					local item = items[i]
					local amount = math.random(1, 3)

					if string.find(item, "feather") then
						amount = math.random(2, 4)
					end

					if string.find(item, "meat") then
						if entityQuality == 0 then
							item = item .. "_poor"
							amount = 1
						elseif entityQuality == 1 then
							item = item .. "_good"
							amount = 2
						elseif entityQuality == 2 then
							item = item .. "_perfect"
							amount = 3
						end
					end

					-- local ItemsList = exports.ox_inventory:Items()

					exports.ox_inventory:AddItem(playerId, item, amount)
				end
			else
				local count2 = math.random(1, 3)
				exports.ox_inventory:AddItem(playerId, 'animal_fat', count2)
			end
		end
	end
end)

