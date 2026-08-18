Config = {}

Config.Framework = 'QBOX'

-- Stress akan berkurang secara bertahap.
-- Sesuaikan JumlahStress dan WaitTick pada masing-masing zone.
Config.Stress = {
    enabled = true,
    mode = 'server_event',
    event = 'hud:server:RelieveStress',
}

Config.Notify = {
    enter = {
        title = 'Relax Zone',
        description = 'Stress akan berkurang perlahan selama kamu berada di zona.',
        type = 'success',
        duration = 2500,
    },
    exit = {
        title = 'Relax Zone',
        description = 'Kamu keluar dari Relax Zone.',
        type = 'error',
        duration = 2500,
    },
}

Config.Healing = {
    {
        useblip = true,

        blip = {
            name = 'Zona Healing Karnaval',
            coords = vector3(-1828.57, -1215.61, 12.02),
            sprite = 197,
            scale = 0.7,
            color = 4,
        },

        points = {
            vec3(-1826.0, -1270.0, 9.0),
            vec3(-1866.0, -1237.0, 9.0),
            vec3(-1881.0, -1213.0, 13.0),
            vec3(-1832.0, -1157.0, 13.0),
            vec3(-1782.0, -1199.0, 13.0),
            vec3(-1813.0, -1237.0, 13.0),
            vec3(-1806.0, -1243.0, 13.0),
        },

        thickness = 10.0,
        debug = false,

        -- Setiap 2 detik stress berkurang 5.
        -- Contoh stress 100 -> 0 membutuhkan sekitar 40 detik.
        WaitTick = 60000,
        JumlahStress = 25,
    },
}
