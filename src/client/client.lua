local oRP = {}
Tunnel.bindInterface("RKG_Store:Create_Blips", oRP)
local vSERVER = Tunnel.getInterface("RKG_Store:Create_Blips")

local in_thread = false
local blip_coords = {}

function oRP.controlBlipsThread()
	in_thread = not in_thread
end

Citizen.CreateThread(function()
	while true do
		local RKG = 1000
		if in_thread then
			RKG = 0
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			if IsControlJustPressed(0,38) then
				TriggerServerEvent("RKG_Blips:StoreBlips",coords,heading)
			end

			if IsControlJustPressed(0,168) then
				vSERVER.stopCreation()
			end

			dwTextBlips(Config_Blips.Language.TextLeave,0.71)
			dwTextBlips(Config_Blips.Language.TextCreate,0.68)

			for k,v in pairs(blip_coords) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 100 then
					DrawMarker(21,v[1],v[2],v[3] - 0.60,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				end
			end

		end
		Citizen.Wait(RKG)
	end
end)

function oRP.returnBlips()
	local races = vSERVER.returnTableBlips()
	blip_coords = races
end

function dwTextBlips(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(.015,height)
end