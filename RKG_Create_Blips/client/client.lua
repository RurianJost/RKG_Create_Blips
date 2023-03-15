local Tunnel = module('vrp', 'lib/Tunnel')

apiServer = Tunnel.getInterface('RKG_Store:Create_Blips')

api = {}
Tunnel.bindInterface('RKG_Store:Create_Blips', api)

local inCreateBlips = false

function api.insertPlayerInCreateBlips()
	inCreateBlips = true

	Citizen.CreateThread(function()
		while inCreateBlips do
			drawText(globalConfig.Language.TextLeave, 0.71)
			drawText(globalConfig.Language.TextCreate, 0.68)

			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			for _, blipCoords in pairs(GlobalState.RegisteredBlips) do
				local distance = #(coords - blipCoords)
				
				if distance <= 100 then
					DrawMarker(21, blipCoords.x, blipCoords.y, blipCoords.z - 0.60, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
				end
			end
			
			Citizen.Wait(0)
		end
	end)
end

RegisterCommand('registerBlipLocation', function()
	if inCreateBlips then
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local pedHeading = GetEntityHeading(ped)
	
		TriggerServerEvent('RKG_Store:StoreBlips', pedCoords, pedHeading)
	end
end)

RegisterCommand('exitBlipCreation', function()
	if inCreateBlips then
		inCreateBlips = false

		apiServer.exitBlipCreation()
	end
end)