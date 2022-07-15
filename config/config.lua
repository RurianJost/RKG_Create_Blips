Config_Blips = {
    Command = "blips", -- Comando para iniciar a criação de blips.
    Permission = "Owner", -- Permissão para iniciar a criação de blips.
    Language = {
        InitBlips = "Você iniciou a criação de blips.",
        ExitBlips = "Você cancelou a criação de blips.",
        AlredyBlips = "Você já está em uma criação de blips.",
        TextLeave = "~w~Aperte ~b~F7~w~ para ~r~cancelar~w~ a criação de blips.~w~ ",
        TextCreate = "~w~Aperte ~b~E~w~ para adicionar um ~r~blip~w~ no chão.~w~",
    },
}

function UpdateTextBlips(coords,heading)
    local types = {
        [1] = "{ ['x'] = "..tD(coords.x)..", ['y'] = "..tD(coords.y)..", ['z'] = "..tD(coords.z)..", ['h'] = "..tD(heading).." },",
        [2] = "{ "..tD(coords.x)..", "..tD(coords.y)..", "..tD(coords.z)..", "..tD(heading).." },",
        [3] = "vector3("..tD(coords.x)..","..tD(coords.y)..","..tD(coords.z).."), heading = "..tD(heading)..",",
    }
    return types[3] -- Numero do type acima
end