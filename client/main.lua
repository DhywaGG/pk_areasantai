local zones = {}

local function notify(data)
    lib.notify({
        title = data.title,
        description = data.description,
        type = data.type,
        duration = data.duration,
        position = 'top-right',
    })
end

local function relieveStress(amount)
    if not Config.Stress.enabled or Config.Stress.mode == 'none' then
        return
    end

    if Config.Stress.mode == 'server_event' then
        TriggerServerEvent(Config.Stress.event, amount)
        return
    end

    print(('[naufal-relaxzone] Unknown stress mode: %s'):format(tostring(Config.Stress.mode)))
end

local function createBlip(data)
    if not data.useblip or not data.blip then
        return nil
    end

    local blip = AddBlipForCoord(data.blip.coords.x, data.blip.coords.y, data.blip.coords.z)
    SetBlipSprite(blip, data.blip.sprite)
    SetBlipScale(blip, data.blip.scale)
    SetBlipColour(blip, data.blip.color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(data.blip.name)
    EndTextCommandSetBlipName(blip)

    return blip
end

local function createRelaxZone(data)
    createBlip(data)

    local zone = lib.zones.poly({
        points = data.points,
        thickness = data.thickness,
        debug = data.debug,

        onEnter = function()
            lib.showTextUI('Relax Zone', {
                position = 'left-center',
                icon = 'person',
            })

            notify(Config.Notify.enter)
        end,

        onExit = function()
            lib.hideTextUI()
            notify(Config.Notify.exit)
        end,

        inside = function()
            -- Stress dikurangi sedikit demi sedikit.
            -- Jangan langsung 100% hilang dalam sekali tick.
            relieveStress(data.JumlahStress)

            Wait(data.WaitTick)
        end,
    })

    zones[#zones + 1] = zone
end

CreateThread(function()
    if type(Config.Healing) ~= 'table' or #Config.Healing == 0 then
        print('[naufal-relaxzone] No relax zones configured.')
        return
    end

    for _, data in ipairs(Config.Healing) do
        if data.points and #data.points >= 3 then
            createRelaxZone(data)
        else
            print('[naufal-relaxzone] Skipping zone: at least 3 polygon points are required.')
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    lib.hideTextUI()

    for _, zone in ipairs(zones) do
        if zone and zone.remove then
            zone:remove()
        end
    end
end)
