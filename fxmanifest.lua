fx_version 'cerulean'
games {'gta5' }

author 'Miguel Reyes'
description 'Clock for jobs system'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}