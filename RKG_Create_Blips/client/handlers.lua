RegisterCommand(GENERAL_CONFIG.COMMAND_NAME, function()
    local playerActive = Creation:IsActive()

    if not playerActive then
        local status, blips, messageId = apiServer.attemptToEnterInBlipCreation()

        GENERAL_CONFIG.NOTIFY(LANGUAGE[messageId])

        if status then
            Creation:InsertPlayer(blips)
        end
    end
end)

RegisterCommand('RKG_Create_Blips:Leave', function()
    local playerActive = Creation:IsActive()

    if playerActive then
        apiServer.leaveFromBlipCreation()

        Creation:RemovePlayer()
    end
end)

RegisterCommand('RKG_Create_Blips:Register', function()
    local playerActive = Creation:IsActive()

    if playerActive then
        Creation:CreateBlip()
    end
end)

Citizen.CreateThread(function()
    RegisterKeyMapping('RKG_Create_Blips:Register', 'Colocar blip no chão', 'keyboard', 'E')
    RegisterKeyMapping('RKG_Create_Blips:Leave', 'Sair da criação de blips', 'keyboard', 'F7')
end)