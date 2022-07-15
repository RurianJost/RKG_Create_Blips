Config_Blips = {
    Command = "blips", -- Comando para iniciar a criação de blips.
    Permission = "Owner", -- Permissão para iniciar a criação de blips.
    Language = {
        InitBlips = "Você iniciou a criação de blips.", -- Notify de inicio da criação de blips.
        ExitBlips = "Você cancelou a criação de blips.", -- Notify de finalização da criação de blips.
        AlredyBlips = "Você já está em uma criação de blips.", -- Notify para caso a pessoa já esteje em uma criação de blips.
        TextLeave = "~w~Aperte ~b~F7~w~ para ~r~cancelar~w~ a criação de blips.~w~ ", -- Texto que aparecerá na tela para cancelar a criação de blips.
        TextCreate = "~w~Aperte ~b~E~w~ para adicionar um ~r~blip~w~ no chão.~w~", -- Texto que aparecerá na tela para pegar a coordenada.
    },
}

function UpdateTextBlips(coords,heading)
    local types = {
        [1] = "{ ['x'] = "..tD(coords.x)..", ['y'] = "..tD(coords.y)..", ['z'] = "..tD(coords.z)..", ['h'] = "..tD(heading).." },",
        [2] = "{ "..tD(coords.x)..", "..tD(coords.y)..", "..tD(coords.z)..", "..tD(heading).." },",
        [3] = "vector3("..tD(coords.x)..","..tD(coords.y)..","..tD(coords.z).."), heading = "..tD(heading)..",",
    }
    return types[3] -- Numero do type acima, basta colocar o numero desejado entre [] para estar mudando o type.
end