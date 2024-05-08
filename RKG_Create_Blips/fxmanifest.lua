fx_version 'bodacious'
game 'gta5'

name 'RKG_Create_Blips'
author '@rurian'
version '2.0'
discord 'https://dsc.gg/rkgstore'

files {
	'config/*.lua',
}

shared_script {
	'lib/utils.lua',
	'lib/Tools.lua',
	'lib/Proxy.lua',
	'lib/Tunnel.lua'
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}