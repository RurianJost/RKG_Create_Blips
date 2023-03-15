globalConfig = {
    Command = 'blips',
   
    Language = {
        InitBlips = 'Você iniciou a criação de blips.',
        ExitBlips = 'Você cancelou a criação de blips.',
        AlredyBlips = 'Você já está em uma criação de blips.',
        TextLeave = '~w~Aperte ~b~F7~w~ para ~r~cancelar~w~ a criação de blips.~w~ ',
        TextCreate = '~w~Aperte ~b~E~w~ para adicionar um ~r~blip~w~ no chão.~w~'
    }
}

local function mathLegth(n)
	return math.ceil(n * 100) / 100
end

function globalConfig.getTextTypeToFormat(coords, heading)
    local types = {
        [1] = '{ ["x"] = '..mathLegth(coords.x)..', ["y"] = '..mathLegth(coords.y)..', ["z"] = '..mathLegth(coords.z)..', ["h"] = '..mathLegth(heading)..' },',
        
        [2] = '{ '..mathLegth(coords.x)..', '..mathLegth(coords.y)..', '..mathLegth(coords.z)..', '..mathLegth(heading)..' },',
        
        [3] = 'vector3('..mathLegth(coords.x)..','..mathLegth(coords.y)..','..mathLegth(coords.z)..'), heading = '..mathLegth(heading)..',',
        
        [4] = 'vector3('..mathLegth(coords.x)..','..mathLegth(coords.y)..','..mathLegth(coords.z)..'),',
        
        [5] = '{ Coord = vector3('..mathLegth(coords.x)..','..mathLegth(coords.y)..','..mathLegth(coords.z)..'), Heading = '..mathLegth(heading)..' },'
    }

    return types[5] -- Numero do type acima, basta colocar o numero desejado entre [] para estar mudando o type.
end

function globalConfig.notify(...)
    local args = { ... }

    local notifyTypes = {
        [1] = 'sucesso',
        [2] = 'negado'
    }

    if IsDuplicityVersion() then 
        local source = args[1]

        TriggerClientEvent('Notify', source, notifyTypes[args[2]], args[3], args[4])
    else 
        TriggerEvent('Notify', notifyTypes[args[1]], args[2], args[3])
    end 
end