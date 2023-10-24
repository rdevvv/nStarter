fx_version 'adamant'
game 'gta5'

client_scripts {
  "client.lua"
}

server_scripts {
  "server.lua",
  '@mysql-async/lib/MySQL.lua',
  '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
  "config.lua"
}

dependencies {
	'es_extended',
	'async'
}

client_scripts {
  "src/RMenu.lua",
  "src/menu/RageUI.lua",
  "src/menu/Menu.lua",
  "src/menu/MenuController.lua",
  "src/components/*.lua",
  "src/menu/elements/*.lua",
  "src/menu/items/*.lua",
  "src/menu/panels/*.lua",
  "src/menu/windows/*.lua",
}