local Tunnel = module('vrp', 'lib/Tunnel')

apiClient = Tunnel.getInterface('RKG_Store:Create_Blips')

api = {}
Tunnel.bindInterface('RKG_Store:Create_Blips', api)

local usersInCreateBlips = {}
local resourcePath = GetResourcePath(GetCurrentResourceName())

GlobalState.RegisteredBlips = {}

RegisterCommand(globalConfig.Command, function(source)
    local source = source

    if serverConfig.userCanEnterBlipCreation(source) then
        if not isUserInCreation(source) then
            insertUserInCreation(source)

            apiClient.insertPlayerInCreateBlips(source)

            globalConfig.notify(source, 1, globalConfig.Language.InitBlips, 8000)
        else
            globalConfig.notify(source, 2, globalConfig.Language.AlredyBlips, 8000)
        end
    end
end)

RegisterServerEvent('RKG_Store:StoreBlips')
AddEventHandler('RKG_Store:StoreBlips', function(coords, heading)
    local source = source

    if isUserInCreation(source) then
        local userName = GetPlayerName(source)

        local registeredBlips = GlobalState.RegisteredBlips
        
        table.insert(registeredBlips, coords)
		
        GlobalState.RegisteredBlips = registeredBlips

        writeText(tostring(userName)..'_blips.lua', globalConfig.getTextTypeToFormat(coords, heading))
    end
end)

function api.exitBlipCreation()
    if isUserInCreation(source) then
        removeUserInCreation(source)

        globalConfig.notify(source, 2, globalConfig.Language.ExitBlips, 8000)
    end
end

function writeText(archive, text)
	archive = io.open(resourcePath..'/blips/'..archive, 'a')
	
    if archive then
		archive:write(text..'\n')
        archive:close()
	end
end

function isUserInCreation(userSource)
    return usersInCreateBlips[userSource]
end

function insertUserInCreation(userSource)
    if not usersInCreateBlips[userSource] then
        usersInCreateBlips[userSource] = true
    end
end

function removeUserInCreation(userSource)
    if usersInCreateBlips[userSource] then
        usersInCreateBlips[userSource] = nil
    end
end

AddEventHandler('playerDropped', function(reason)
    local source = source

    removeUserInCreation(source)
end)