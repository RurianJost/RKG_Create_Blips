local Tunnel = module('lib/Tunnel')
local Proxy = module('lib/Proxy')

local vRP = Proxy.getInterface('vRP')

local function mathLegth(number)
	return math.ceil(number * 100) / 100
end

return {
    COMMAND_NAME = 'blips',

    TYPES = {
        [1] = '{ ["x"] = %s, ["y"] = %s, ["z"] = %s, ["h"] = %s }, ',

        [2] = '{ %s, %s, %s, %s }, ', 

        [3] = '{ coords = vector3(%s, %s, %s), heading = %s }, ', 

        [4] = '{ coordinates = vector3(%s, %s, %s), heading = %s }, ', 

        [5] = 'vector3(%s, %s, %s), ',

        [6] = 'vector2(%s, %s), ',
    },

    FORMAT_TEXT = function(stringToFormat, coordinates, heading)
        return string.format(
            stringToFormat, 
            mathLegth(coordinates.x), 
            mathLegth(coordinates.y), 
            mathLegth(coordinates.z), 
            mathLegth(heading)
        )
    end,

    PLAYER_CAN_ENTER = function(playerSource)
        local playerId = vRP.getUserId(playerSource)

        return vRP.hasPermission(playerId, 'Admin')
    end, 

    GENERATE_ARCHIVE_NAME = function(playerSource)
        local playerName = GetPlayerName(playerSource)
        
        return string.format('%s.lua', playerName)
    end,

    NOTIFY = function(...)
        local args = { ... }

        if IsDuplicityVersion() then 
            local source = args[1]
    
            TriggerClientEvent('Notify', source, 'warn', args[2], 10000)
        else 
            TriggerEvent('Notify', 'warn', args[1], 10000)
        end 
    end
}