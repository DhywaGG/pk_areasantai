fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Naufal - Qbox Conversion'
description 'Relax Zone / Stress Relief for Qbox + ox_lib'
version '2.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
}

client_scripts {
    'client/main.lua',
}

dependencies {
    'ox_lib',
    'qbx_core',
}
