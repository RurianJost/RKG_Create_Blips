local Tunnel = module('lib/Tunnel')
local Proxy = module('lib/Proxy')

local vRP = Proxy.getInterface('vRP')
local vRPclient = Tunnel.getInterface('vRP')

serverConfig = {
    userCanEnterBlipCreation = function(userSource)
        local userId = vRP.getUserId(userSource)
        
        if vRP.hasPermission(userId, 'Admin') then
            return true
        end

        return false
    end
}