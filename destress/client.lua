
Interiors = {
    {id = 21250, name = "Saloon Valentine"},
    {id = 29698, name = "Saloon Valentine 2"},    
    {id = 56834, name = "Saloon Armadillo"},
    {id = 5634, name = "Saloon Tumbleweed"},
    {id = 54274, name = "Saloon Rhodes"},    
    {id = 53762, name = "Saloon Saint Dennis"},
    {id = 37378, name = "Saloon Saint Dennis 2"},    
    {id = 39426, name = "Saloon Van Horn"},
    {id = 41218, name = "Saloon BlackWater"}
}


PlaceCoords = {    
    {coord = vec3(451.820, 2239.701, 248.307), name = "Aldeia Indigena"},
    {coord = vec3(-1051.02, 79.885, 92.002), name = "Montanha"},
    {coord = vec3(-1007.198, 386.941, 90.129), name = "Montanha"},
    {coord = vec3(472.3645, 62.143, 138.93), name = "Montanha"},
    {coord = vec3(646.244, -105.1076, 149.86), name = "Acampamento"},
}

local isLoaded = false

RegisterNetEvent("FRP:onCharacterLoaded", function()
    isLoaded = true
end)

Citizen.CreateThread(function()
    Wait(30000)
    while true do

        if cAPI.IsPlayerInitialized() and isLoaded then
            local plyPed = PlayerPedId()        
            local interiorId = GetInteriorFromEntity(plyPed)
            
            if interiorId ~= 0 then
                for i = 1, #Interiors do
                    if interiorId == Interiors[i].id then
                        currentShop = Interiors[i].name                    
                    end
                end
            end 
            
            if currentShop ~= "none" and not insideSaloon then
                insideSaloon = true
                TriggerEvent("texas:destressPlayer")

            elseif interiorId == 0 and insideSaloon then
                currentShop = "none"
                insideSaloon = false
            end
        end

        Citizen.Wait(2000)
    end
end)

local currentPlace = false
local inPlace = false

Citizen.CreateThread(function()
    Wait(60000)

    while true do

        if cAPI.IsPlayerInitialized() and isLoaded then
            local plyPed = PlayerPedId()        
            local playerCoords = GetEntityCoords(plyPed)

            for i = 1, #PlaceCoords do
                
                if #(playerCoords - PlaceCoords[i].coord) <= 50 and not inPlace then                
                    
                    HudStatus.Aumentar("fatigue", 1)
                    inPlace = true
                elseif #(playerCoords - PlaceCoords[i].coord) >= 50 and inPlace then                
                    inPlace = false
                end
            end
        end

        Citizen.Wait(3500)
    end
end)


RegisterNetEvent("texas:destressPlayer")
AddEventHandler("texas:destressPlayer",function()

    if not isLoaded then return end

    while insideSaloon or inPlace do
        Citizen.Wait(2000)        
        
        HudStatus.Aumentar("fatigue", 1)
    end
end)





