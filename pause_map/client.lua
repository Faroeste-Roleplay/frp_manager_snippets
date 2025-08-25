-- START Kort i hånden ved ESC menu
local isMenuMode = false
local Animation = false

local function LegendaryMap()

    local flowblockHash = -980176693
    local flowblockEnteringHash = -980176693
    local flowblock = UiflowblockRequest(flowblockHash)
    local statemachineHash = 978408792

    repeat Wait(0) until UiflowblockIsLoaded(flowblock) == 1

    UiflowblockEnter(flowblock, flowblockEnteringHash)
    if (UiStateMachineExists(statemachineHash) == 0) then
        UiStateMachineCreate(statemachineHash, flowblock)
    end
    
    if DBD?.a then 
        DatabindingRemoveDataEntry(DBD.a)
    end
    DBD = {}
    DBD.a = DatabindingAddDataContainerFromPath("", "DynamicAnimalMap")
    local nr = 0
    
    -- while (nr < 28) do 
    --     local txt = "Zone"..(nr+1)
    --     local str = GetTextSubstring_2(txt, GetLengthOfLiteralString(txt))
    --     DBD.b = DatabindingAddDataContainer(DBD.a, str)
    --     DBD.c = DatabindingAddDataHash(DBD.b, "animalType", -317373141)
    --     DBD.d = DatabindingAddDataBool(DBD.b, "isVisible", true)
    --     nr += 1
    --     Wait(1)
    -- end

    isMenuMode = true
    StartTaskItemInteraction(PlayerPedId(), 17745825, 889797228, 1, 0, -1082130432)
end

CreateThread(function()
    while true do
        Wait(500)

        -- print(" IsPauseMenuActive  :: ", IsPauseMenuActive())
        -- print(" isMenuMode  :: ", isMenuMode)

        if IsPauseMenuActive() and not isMenuMode then
            LegendaryMap()
        end

        if not IsPauseMenuActive() and isMenuMode then
            ClearPedTasks(PlayerPedId())
            isMenuMode = false
        end
    end
end)

-- RegisterCommand("mapL", function()
--     LegendaryMap()
-- end)