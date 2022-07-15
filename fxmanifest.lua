fx_version "bodacious"
game "gta5"

name "RKG_Create_Blips"
author "@Rurian#4410"
version "1.0"
discord "https://dsc.gg/rkgstore"

shared_script {
	"@vrp/lib/utils.lua",
	"config/config.lua",
	"shared/shared.lua",
}

server_scripts {
	"src/server/*.lua",
}

client_scripts {
	"src/client/*.lua",
}