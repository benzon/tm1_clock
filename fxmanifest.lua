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

pmc_updates 'yes'
pmc_github 'https://github.com/benzon/tm1_clock'
pmc_version '2'
