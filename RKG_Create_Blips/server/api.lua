local Tunnel = module('lib/Tunnel')

api = {}
Tunnel.bindInterface('RKG_Create_Blips', api)

function api.attemptToEnterInBlipCreation()
    local playerSource = source
    local playerCanEnter = GENERAL_CONFIG.PLAYER_CAN_ENTER(playerSource)

    if playerCanEnter then
        local playerActive = Creation:GetPlayer(playerSource)

        if playerActive then
            return false, {}, 'ALREADY_IN_CREATING_BLIPS'
        else
            Creation:InsertPlayer(playerSource)

            local availableBlips = Creation:GetBlips()

            return true, availableBlips, 'ENTERED_IN_CREATION_BLIPS'
        end
    end
end

function api.leaveFromBlipCreation()
    local playerSource = source
    local playerActive = Creation:GetPlayer(playerSource)

    if playerActive then
        Creation:RemovePlayer(playerSource)
    end
end