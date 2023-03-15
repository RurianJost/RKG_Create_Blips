clientConfig = {}

Citizen.CreateThread(function()
    RegisterKeyMapping('registerBlipLocation', 'Colocar blip no chão', 'keyboard', 'E')
    RegisterKeyMapping('exitBlipCreation', 'Sair da criação de blips', 'keyboard', 'F7')
end)

function drawText(text, height)
	SetTextFont(4)
	SetTextScale(0.50, 0.50)
	SetTextColour(255, 255, 255, 180)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(.015, height)
end