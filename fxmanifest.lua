fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    '@callbacks/import.lua',
    '@frp_lib/library/linker.lua',
    "@ox_lib/init.lua"
    
    -- 'coach_shop/config.lua',
}

ui_page "nuiblocker/client/index.html"

files {
    'nuiblocker/client/index.html',
}

client_scripts {
    '@frp_lib/lib/dataview.lua',
    'client.lua',
    'warmenu.lua',

    'density_wagons.lua',
    'compass/client.lua',

    'bandana_animation/client.js',
    'pause_map/client.lua',

    'loadscreen/client.lua',
    'destress/client.lua',
    
    'baloon/client.lua',
    'campfire/client.lua',
    'nuiblocker/client/main.lua',

    -- 'clothes_menu/client.lua',
    -- 'coach_shop/client.lua',

    'gathering/client.lua',
    'discord/main.lua',
    
    'interaction_with_objects/client.lua',
    'interaction_with_objects/client.js',

    --'old_animations/client.lua',
    'mugging_player/client.lua',
    'remove_stress/client.lua',

    'river_actions/client.lua',

    'teleport_to_guarma/client.lua',

    'teleports/client.lua',
    'soap/client.lua',

    -- 'stuck_wagons/client.lua',
    -- 'temperature/client.lua',

    'trash/client.lua',

    'weather/client.lua',
    'tonic_usable/client.lua',

    'utils/client.lua',
}

server_scripts {
    'server.lua',
    'baloon/server.lua',
    'campfire/server.lua',

    'nuiblocker/server/main.lua',
    -- 'coach_shop/server.lua',
    'gathering/server.lua',
    'tonic_usable/server.lua',
    'interaction_with_objects/server.lua',

    'river_actions/server.lua',
    'teleport_to_guarma/server.lua',
    -- 'temperature/server.lua',
    'trash/server.lua',
    'luckybox/server.lua',

    'salary/server.lua'
}

lua54 'yes'