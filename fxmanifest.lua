fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Jon Doe'
description 'Example resource'
version '1.0.0'

-- What to run
client_scripts {
    'config.lua',
    'client.lua'
}
server_script {
    'config.lua',
    'server.lua'
}
-- Extra data can be used as well
my_data 'one' { two = 42 }
my_data 'three' { four = 69 }

-- due to Lua syntax, the following works too:
my_data('nine')({ninety = "nein"})