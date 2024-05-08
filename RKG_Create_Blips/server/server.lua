_G.Creation = {
    blips = {}, 
    players = {}
}

LANGUAGE = module('config/language')
GENERAL_CONFIG = module('config/general')

local RESOURCE_NAME = GetCurrentResourceName()
local RESOURCE_PATH = GetResourcePath(RESOURCE_NAME)

function Creation:WriteText(archive, text)
	archive = io.open(RESOURCE_PATH..'/blips/'..archive, 'a')
	
    if archive then
		archive:write(text..'\n')
	end

    archive:close()
end

function Creation:RegisterBlip(playerSource, coordinates, heading)
    local blipEntries = {
        coordinates, 
        heading
    }

    table.insert(self.blips, blipEntries)

    self:TriggerPlayers(playerSource, blipEntries)

    local playerObject = self:GetPlayer(playerSource)
    local stringToFormat = GENERAL_CONFIG.TYPES[playerObject.type]
    local archiveName = GENERAL_CONFIG.GENERATE_ARCHIVE_NAME(playerSource)
    local formattedText = GENERAL_CONFIG.FORMAT_TEXT(stringToFormat, coordinates, heading)

    self:WriteText(archiveName, formattedText)
end

function Creation:TriggerPlayers(ignoreSource, ...)
    for playerSource in pairs(self.players) do
        if ignoreSource ~= playerSource then
            TriggerClientEvent('RKG_Create_Blips:InsertBlip', playerSource, ...)
        end
    end
end

function Creation:GetBlips()
    return self.blips
end

function Creation:InsertPlayer(playerSource)
    if not self.players[playerSource] then
        self.players[playerSource] = {
            type = 1
        }
    end
end

function Creation:RemovePlayer(playerSource)
    if self.players[playerSource] then
        self.players[playerSource] = nil
    end
end

function Creation:UpdatePlayerType(playerSource, newType)
    if self.players[playerSource] then
        self.players[playerSource].type = newType
    end
end

function Creation:GetPlayer(playerSource)
    return self.players[playerSource]
end

AddEventHandler('playerDropped', function(reason)
    local playerSource = source

    Creation:RemovePlayer(playerSource)
end)

RegisterNetEvent('RKG_Create_Blips:Register', function(coordinates, heading)
    local playerSource = source

    Creation:RegisterBlip(playerSource, coordinates, heading)
end)

RegisterNetEvent('RKG_Create_Blips:UpdatePlayerType', function(newType)
    local playerSource = source

    Creation:UpdatePlayerType(playerSource, newType)
end)