fx_version 'bodacious'
game 'gta5'

name 'RKG_Create_Blips'
author '@Rurian#4410'
version '1.0'
discord 'https://dsc.gg/rkgstore'

shared_script {
	'@vrp/lib/utils.lua',
	
	'config/config.lua'
}

server_scripts {
	'config/server/functions.lua',

	'server/server.lua'
}

client_scripts {
	'config/client/functions.lua',
	
	'client/client.lua'
}