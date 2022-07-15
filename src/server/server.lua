local oRP = {}
Tunnel.bindInterface("RKG_Store:Create_Blips", oRP)
local vCLIENT = Tunnel.getInterface("RKG_Store:Create_Blips")

local blip_coords = {}
local in_create_race = {}

local path = GetResourcePath(GetCurrentResourceName())

RegisterCommand(Config_Blips.Command,function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,Config_Blips.Permission) then
            if not in_create_race[source] then
                in_create_race[source] = true

                vCLIENT.controlBlipsThread(source)
                vCLIENT.returnBlips(source)

                TriggerClientEvent("Notify",source,"sucess",Config_Blips.Language.InitBlips)
            else
                TriggerClientEvent("Notify",source,"denied",Config_Blips.Language.AlredyBlips)
            end
        end
    end
end)

RegisterServerEvent("RKG_Blips:StoreBlips")
AddEventHandler("RKG_Blips:StoreBlips",function(coords,heading)
    local user_id = vRP.getUserId(source)
    if in_create_race[source] then
        table.insert(blip_coords,{ tD(coords.x),tD(coords.y),tD(coords.z) })

        writeText("id_"..user_id.."_blips.lua",UpdateTextBlips(coords,heading))

        for k,v in pairs(in_create_race) do
            vCLIENT.returnBlips(k)
        end
    end
end)

function oRP.stopCreation()
    if in_create_race[source] then
        in_create_race[source] = nil

        vCLIENT.controlBlipsThread(source)

        TriggerClientEvent("Notify",source,"denied",Config_Blips.Language.ExitBlips)
    end
end

function oRP.returnTableBlips()
    return blip_coords
end

function writeText(archive,text)
	archive = io.open(path.."/blips/"..archive,"a")
	if archive then
		archive:write(text.."\n")
        archive:close()
	end
end

AddEventHandler("playerDropped",function(reason)
    if in_create_race[source] then
        in_create_race[source] = nil
    end
end)