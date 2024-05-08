local Tunnel = module('lib/Tunnel')

apiServer = Tunnel.getInterface('RKG_Create_Blips')

LANGUAGE = module('config/language')
GENERAL_CONFIG = module('config/general')

_G.Creation = {
    cache = {}
}

function Creation:InsertPlayer(serverBlips)
    self.cache.active = true
    self.cache.type = 1
	self.cache.blips = {}
	self.cache.typeText = GENERAL_CONFIG.TYPES[1]:format(0, 0, 0, 0)

	for _, entries in ipairs(serverBlips) do
		self:InsertBlip(entries)
	end

    Citizen.CreateThread(function()
		while self.cache.active do
			drawText(LANGUAGE.TEXT_TO_CHANGE_TYPE, 4, 0.015, 0.80, 0.38)
			drawText(LANGUAGE.TEXT_TO_LEAVE, 4, 0.015, 0.83, 0.38)
			drawText(LANGUAGE.TEXT_TO_CREATE, 4, 0.015, 0.86, 0.38)
			drawText(LANGUAGE.CURRENT_TYPE:format(self.cache.typeText), 4, 0.015, 0.89, 0.38)

			if IsControlJustPressed(0, 175) then
				Creation:IncreaseType()
			elseif IsControlJustPressed(0, 174) then
				Creation:DecreaseType()
			end

			local playerPed = PlayerPedId()
			local pedCoordinates = GetEntityCoords(playerPed)

			for _, object in ipairs(self.cache.blips) do
				local distance = #(pedCoordinates - object.coordinates)
				
				if distance <= 100 then
					DrawMarker(21, object.coordinates.x, object.coordinates.y, object.coordinates.z - 0.60, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
				end
			end
			
			Citizen.Wait(0)
		end
	end)
end

function Creation:RemovePlayer()
    self.cache = {}
end

function Creation:IsActive()
    return self.cache.active
end

function Creation:InsertBlip(entries)
    local coordinates, heading = table.unpack(entries)

    table.insert(self.cache.blips, {
        heading = heading,
        coordinates = coordinates,
    })
end

function Creation:IncreaseType()
	local newType = self.cache.type >= #GENERAL_CONFIG.TYPES and 1 or self.cache.type + 1

	self:UpdateType(newType)
end

function Creation:DecreaseType()
	local newType = self.cache.type <= 1 and #GENERAL_CONFIG.TYPES or self.cache.type - 1

	self:UpdateType(newType)
end

function Creation:UpdateType(newType)
	self.cache.type = newType
	self.cache.typeText = GENERAL_CONFIG.TYPES[newType]:format(0, 0, 0, 0)

	TriggerServerEvent('RKG_Create_Blips:UpdatePlayerType', newType)
end

function Creation:CreateBlip()
    local playerPed = PlayerPedId()
    local heading = GetEntityHeading(playerPed)
    local coordinates = GetEntityCoords(playerPed)

    self:InsertBlip({ coordinates, heading })

    TriggerServerEvent('RKG_Create_Blips:Register', coordinates, heading)
end

function drawText(text, font, x, y, scale)
	SetTextFont(font)
	SetTextScale(scale, scale)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

RegisterNetEvent('RKG_Create_Blips:InsertBlip', function(entries)
    Creation:InsertBlip(entries)
end)