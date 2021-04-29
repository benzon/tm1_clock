ESX = nil
Services = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Config.Commands.on_duty, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if #args >= 1 then
            local job = tostring(args[1])
            if Config.Jobs[job] then
                local job_player = xPlayer.job.name
                local auth = false
                for i,v in pairs(Config.Jobs[job]) do
                    if job_player == v then
                        auth = true
                    end
                end
                if auth then
                    if not isInService(source) then
                        if not Services[source] then Services[source] = {} end
                        Services[source] = {
                            time = os.time(),
                            identifier = xPlayer.identifier,
                            job = job
                        }
                        TriggerClientEvent('esx:showNotification', source, Locales.inService)
                    else
                        TriggerClientEvent('esx:showNotification', source, Locales.youAreInService)
                    end
                else
                    TriggerClientEvent('esx:showNotification', source, Locales.youCantInService)
                end
            else
                TriggerClientEvent('esx:showNotification', source, Locales.jobDontExist)
            end
        else
            TriggerClientEvent('esx:showNotification', source, Locales.putAJob)
        end
    end
end, false)

RegisterCommand(Config.Commands.off_duty, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if isInService(source) then
            local job = Services[source].job
            local actual_time = os.time()
            local difference = actual_time - Services[source].time
            Services[source] = nil
            MySQL.Async.execute('INSERT INTO services (identifier, job, time) VALUES (@identifier, @job, @time)',{   
                ['identifier'] = xPlayer.identifier, 
                ['job'] = job, 
                ['time'] = difference
            },function(affectedRows) end)
            TriggerClientEvent('esx:showNotification', source, Locales.leftService)
        else
            TriggerClientEvent('esx:showNotification', source, Locales.youArentInService)
        end
    end
end, false)

RegisterCommand(Config.Commands.hours, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if #args == 2 then
            local job = tostring(args[1])
            if Config.Jobs[job] then
                local target = tonumber(args[2])
                local xTarget = ESX.GetPlayerFromId(target)
                if xTarget then
                    if isAuth(job, xPlayer) then
                        getTimeOfDuty(xTarget.identifier, job, function(number)
                            if number > 0 then
                                TriggerClientEvent('esx:showNotification', source, xTarget.name..Locales.hadBeenInService..disp_time(number))
                            else
                                TriggerClientEvent('esx:showNotification', source, Locales.neverInService..xTarget.name)
                            end
                        end) 
                    else
                        TriggerClientEvent('esx:showNotification', source, Locales.notAuth)
                    end
                else
                    local identifier = tostring(args[2])
                    if isAuth(job, xPlayer) then
                        getTimeOfDuty(identifier, job, function(number)
                            if number > 0 then
                                TriggerClientEvent('esx:showNotification', source, identifier..Locales.hadBeenInService..disp_time(number))
                            else
                                TriggerClientEvent('esx:showNotification', source, Locales.neverInService..identifier)
                            end
                        end) 
                    else
                        TriggerClientEvent('esx:showNotification', source, Locales.notAuth)
                    end
                end
            else
                TriggerClientEvent('esx:showNotification', source, Locales.jobDontExist)
            end
        elseif #args == 1 then
            local job = tostring(args[1])
            if Config.Jobs[job] then
                getTimeOfDuty(xPlayer.identifier, job, function(number)
                    if number > 0 then
                        TriggerClientEvent('esx:showNotification', source, Locales.youHadBeenInService..disp_time(number))
                    else
                        TriggerClientEvent('esx:showNotification', source, Locales.youNeverInService)
                    end
                end)
            else
                TriggerClientEvent('esx:showNotification', source, Locales.jobDontExist)
            end
        else
            TriggerClientEvent('esx:showNotification', source, Locales.errorArguments)
        end
    end
end, false)

AddEventHandler('playerDropped', function(reason)
	local source = source
    if isInService(source) then
        local job = Services[source].job
        local identifier = Services[source].identifier
        local actual_time = os.time()
        local difference = actual_time - Services[source].time
        Services[source] = nil
        MySQL.Async.execute('INSERT INTO services (identifier, job, time) VALUES (@identifier, @job, @time)',{   
            ['identifier'] = identifier, 
            ['job'] = job, 
            ['time'] = difference
        },function(affectedRows) end)
    end
end)

function getTimeOfDuty(identifier, job, cb)
    MySQL.Async.fetchAll('SELECT * FROM services WHERE identifier = @identifier AND  job = @job', { 
        ['@identifier'] = identifier,
        ['@job'] = job,
    }, function(result)
        if result[1] then
            local time = 0
            for i,v in pairs(result) do
                time = time + v.time
            end
            print(time)
            cb(time)
        else
            print(0)
            cb(0)
        end
    end)
end

function isInService(source, job)
    if Services[source] then
        if job then
            if Config.Jobs[job] then
                if job == Services[source].job then
                    return true
                else
                    return false
                end
            else
                return false
            end
        else
            return true
        end
    end
    return false
end

function isAuth(job, xPlayer)
    for i,v in pairs(Config.JobsRanks[job]) do
        if v.name == xPlayer.job.name then
            for i1,v1 in pairs(v.ranks) do
                if v1 == xPlayer.job.grade_name then
                    return true
                end
            end
        end
    end
    return false
end

function disp_time(time)
    local days = math.floor(time/86400)
    local hours = math.floor((time % 86400)/3600)
    local minutes = math.floor((time % 3600)/60)
    local seconds = math.floor((time % 60))
    return string.format("%d:%02d:%02d:%02d",days,hours,minutes,seconds)
end